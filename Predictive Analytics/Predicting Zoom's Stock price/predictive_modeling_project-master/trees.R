##############################
###         Setup          ###
##############################

# read data
data = read.csv("Final_file_updated.csv")

# pick vars
df=data[2:197,2:dim(data)[2]]

# convert df from str to flt
options(digits=5)
df$Zoom.Open.Price..on.next.day. = as.double(df$Zoom.Open.Price..on.next.day.)

# read desired date data
predf= data[199,2:dim(data)[2]]
true = as.double(data$Zoom.Open.Price..on.next.day.[199])

# split to train and test
set.seed(1) # set seed
tr = sample(1:196, #The values that will be sampled
            size = 150, #The size of the sample
            replace = FALSE) #without replacement

train = df[tr,] #the rows of train will be the ones sampled
test = df[-tr,] #and test will be everything else (thus, out-of-sample)


##############################
###      Tree Model        ###
##############################

# import trees
library(rpart)

#Grow big tree first
big.tree = rpart(Zoom.Open.Price..on.next.day.~.,
                 method="anova", #split maximizes the sum-of-squares between the new partitions
                 data=train, #data frame
                 control=rpart.control(minsplit=5, #the minimum number of obs in each leaf
                                       cp=.0001)) #complexity parameter (see rpart.control help)
nbig = length(unique(big.tree$where))
cat('Number of leaf nodes: ',nbig,'\n')

#Fit on train, predict on val for vector of cp.
cpvec = big.tree$cptable[,"CP"] #cp values to try
ntree = length(cpvec) #number of cv values = number of trees fit.
iltree = rep(0,ntree) #in-sample loss
oltree = rep(0,ntree) #out-of-sample loss
sztree = rep(0,ntree) #size of each tree
for(i in 1:ntree) {
  if((i %% 10)==0) cat('tree i: ',i, "out of", ntree, '\n')
  temptree = prune(big.tree,cp=cpvec[i]) #Pruned tree by cp
  sztree[i] = length(unique(temptree$where)) #Number of leaves
  iltree[i] = sum((test$Zoom.Open.Price..on.next.day.-predict(temptree))^2) #in-sample loss
  ofit = predict(temptree,test) #Validation prediction
  oltree[i] = sum((test$Zoom.Open.Price..on.next.day.-ofit)^2) #out-of-sample loss
}

oltree= sqrt(oltree/nrow(test)) #RMSE out-of-sample
iltree = sqrt(iltree/nrow(train)) #RMSE in-sample

#Plot losses
rgl = range(c(iltree,oltree)) #Range of the values for the plot
plot(range(sztree),rgl,
     type='n', #Type = n removes points from plot
     xlab='Number of Leaves',ylab='RMSE')
#points(sztree,iltree,
#       pch=15, #Type of point
#       col='red')
points(sztree,oltree,
       pch=16, #Type of point
       col='blue')
legend("right", #Position of the legend
       legend= 'out-of-sample',#c('in-sample','out-of-sample'), #Text in the legend
       pch=16, #c(15,16), #Types of points
       col='blue') #c('red','blue')) #Color of points

# print results
rest = cbind(sztree,oltree,iltree)
print(rest)
print("The best parameter model is:")
print(rest[which.min(rest[,2]),])


##############################
###     Random Forest      ###
##############################

# import library
library(randomForest)

#p set parameters
p=ncol(train)-1 #Number of covariates (-1 because one column is the response)
mtryv = c(p:sqrt(p)) #Number of candidate variables for each split
ntreev = c(10:100) #Number of trees
parmrf = expand.grid(mtryv,ntreev) #Expanding grids of different models
colnames(parmrf)=c('mtry','ntree')
print(parmrf)

nset = nrow(parmrf) #Number of models
olrf = rep(0,nset) #Out-of-sample loss
ilrf = rep(0,nset) #In-sample loss
rffitv = vector('list',nset) #List of the estimated models

for(i in 1:nset) {
  cat('Model ',i,' out of ',nset,'\n')
  temprf = randomForest(Zoom.Open.Price..on.next.day.~., #Formula
                        data=train, #Data frame
                        mtry=parmrf[i,1], #Number of candidate variables for each split
                        ntree=parmrf[i,2], #Number of trees
                        maxnodes = 15) #Maximum number of leaves (takes too much time if too big)
  ifit = predict(temprf) #In-sample prediction
  ofit=predict(temprf,newdata=test) #Out-of-sample prediction
  olrf[i] = sum((test$Zoom.Open.Price..on.next.day.-ofit)^2) #Out-of-sample loss
  ilrf[i] = sum((train$Zoom.Open.Price..on.next.day.-ifit)^2) #In-sample loss
  rffitv[[i]]=temprf #Saving the model
}
ilrf = round(sqrt(ilrf/nrow(train)),3) #In-sample RMSE
olrf = round(sqrt(olrf/nrow(test)),3) #Out-of-sample RMSE

# print results
resrf = cbind(parmrf,olrf,ilrf)
print("The best parameter model is:")
print(resrf[which.min(resrf$olrf),])


##############################
###       Boosting         ###
##############################

# import boosting library
library(gbm)

# set parameters
idv = c(4,6,8,10,12,14,16) #tree depth
ntv = c(1000,2000,3000,4000,5000) #number of trees
lamv=c(.001,.2) #Learning rates
parmb = expand.grid(idv,ntv,lamv) #Expand the values to get different models
colnames(parmb) = c('tdepth','ntree','lam')
print(parmb)

nset = nrow(parmb) #Number of models
olb = rep(0,nset) #Out-of-sample loss
ilb = rep(0,nset) #In-sample loss
bfitv = vector('list',nset) #List of the estimated models

for(i in 1:nset) {
  cat('Model ',i,'out of',nset,'\n')
  tempboost = gbm(Zoom.Open.Price..on.next.day.~.,#Formula
                  data=train, #Data frame  <- need train df
                  distribution='gaussian',
                  interaction.depth=parmb[i,1], #Maximum depth of each tree
                  n.trees=parmb[i,2], #Number of trees
                  shrinkage=parmb[i,3]) #Learning rate
  ifit = predict(tempboost,n.trees=parmb[i,2]) #In-sample fit
  ofit=predict(tempboost,newdata=test,n.trees=parmb[i,2]) #Out-of-sample fit
  olb[i] = sum((test$Zoom.Open.Price..on.next.day.-ofit)^2) #Oout-of-sample loss
  ilb[i] = sum((train$Zoom.Open.Price..on.next.day.-ifit)^2) #In-sample loss
  bfitv[[i]]=tempboost #Saving the model
}
ilb = round(sqrt(ilb/nrow(train)),3) #Out-of-sample RMSE
olb = round(sqrt(olb/nrow(test)),3) #In-sample RMSE

# print results
resb = cbind(parmb,olb,ilb)
print(resb)
print("The best parameter model is:")
print(resb[which.min(resb$olb),])


##############################
###       Predictions      ###
##############################

# best tree model
big.tree = rpart(Zoom.Open.Price..on.next.day.~.,
                 method="anova", #split maximizes the sum-of-squares between the new partitions
                 data=df, #data frame
                 control=rpart.control(minsplit=5, #the minimum number of obs in each leaf
                                       cp=.0001)) #complexity parameter (see rpart.control help)
i = which.min(rest[,2])
best.tree = prune(big.tree,cp=cpvec[i]) #Pruned tree by best cp

# plot best tree
library(partykit)
rparty.tree <- as.party(best.tree)
plot(rparty.tree)

# best random forest model
i = which.min(resrf$olrf)
temprf = randomForest(Zoom.Open.Price..on.next.day.~., #Formula
                      data=df, #Data frame
                      mtry=parmrf[i,1], #Number of candidate variables for each split
                      ntree=parmrf[i,2], #Number of trees
                      maxnodes = 15,
                      importance = TRUE)

# variable importance plot
varImpPlot(temprf)
summary(temprf)

# best boosting model
i = which.min(resb$olb)
tempboost = gbm(Zoom.Open.Price..on.next.day.~.,#Formula
                data=df, #Data frame  <- need train df
                distribution='gaussian',
                interaction.depth=parmb[i,1], #Maximum depth of each tree
                n.trees=parmb[i,2], #Number of trees
                shrinkage=parmb[i,3]) #Learning rate

par(mfrow=c(1,1)) #Plot window: 1 row, 1 column
p=ncol(df)-1 #Number of covariates (-1 because one column is the response)
vsum=summary(tempboost,plotit=FALSE) #This will have the variable importance info
row.names(vsum)=NULL #Drop variable names from rows.

#Plot variable importance
plot(vsum$rel.inf,axes=F,pch=16,col='red')
axis(1,labels=vsum$var,at=1:p)
axis(2)
for(i in 1:p){
  lines(c(i,i),c(0,vsum$rel.inf[i]),lwd=4,col='blue')
}

# get actual ranks
vsum

# predict values
predt = predict(temptree,newdata=predf)
predrf = predict(temprf,newdata=predf)
predb = predict(tempboost,newdata=predf,n.trees=parmb[i,2])
pred = c(predt, predrf, predb)
diff = pred - true

# error of predictions
errt = sqrt(sum((true-predt)^2)/nrow(df))
errrf = sqrt(sum((true-predrf)^2)/nrow(df))
errb = sqrt(sum((true-predb)^2)/nrow(df))
err = c(errt, errrf, errb)

# build final data frame
fin = matrix(c(pred, true, true, true, diff, err),nrow=4,ncol=3,byrow = TRUE)  
dimnames(fin) = list(c("Predicted Value", "True", "Diffrence", "RMSE"), 
                     c('Tree','Random Forest', 'Boosting'))
print(fin)
