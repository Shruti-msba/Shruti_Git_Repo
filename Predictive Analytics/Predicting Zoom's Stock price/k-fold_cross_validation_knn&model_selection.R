
#######################################################
##################  Model Selection  ##################
#######################################################

set.seed(12345) #Seed to guarantee same results

#Read the CSV file
dataset = read.csv("Final_file_updated.csv") 

date = dataset$Date
zoom = dataset$Zoom.Open.Price..on.next.day.
covid_world_cases = dataset$Daily.Cases.World
covid_world_deaths = dataset$Daily.Deaths.World
covid_us_cases = dataset$Daily.Cases.USA
covid_us_deaths = dataset$Daily.deaths.USA
vix = dataset$Vix
cisco = dataset$Cisco.Open.Price
tsy_3mo = dataset$Treasury.Yield.13.week
tsy_10yr = dataset$Treasury.Yield.10.Yrs
sp = dataset$S.P.500
nasdaq = dataset$NASDAQ.Index
tsy_10yr_3mo_spread = tsy_10yr-tsy_3mo

#Dimension returns the dimensions of a df
#The first number is the number of rows, and the second number is the number of columns
n=dim(dataset)[1]

data_df = data.frame(zoom, covid_world_cases,covid_world_deaths,covid_us_cases,covid_us_deaths,vix,cisco,sp,nasdaq,tsy_10yr_3mo_spread)

#Let us scale our model matrix
scale_data_df = scale(data_df)

n = dim(data_df)[1] #Sample size
tr = sample(1:n, #Sample indices do be used in training
            size = 196, #Sample will have 5000 observation
            replace = FALSE) #Without replacement

#Create a full matrix of interactions (only necessary for linear model)
null = lm(zoom~1, data=data_df[tr,]) #only has an intercept
full = lm(zoom~., data=data_df[tr,]) #Has all the selected variables

#Let us select models by stepwise
regForward = step(null, #The most simple model
                  scope=formula(full),#Let us analyze all models until the full model
                  direction="forward", #Adding variables
                  k=log(length(tr))) #This is BIC
print("Summary using forward method:")
summary(regForward)
regBack = step(full, #Starting with the full model
               direction="backward", #And deleting variables
               k=log(length(tr))) #This is BIC
print("Summary using backward method:")
summary(regBack)
stepwise = step(null, #The most simple model
                scope=formula(full), #The most complicated model
                direction="both", #Add or delete variables
                k=log(length(tr))) #This is BIC
print("Summary using stepwise method:")
summary(stepwise)

library(glmnet)

#Another way of choosing variables: LASSO and RIDGE
Lasso.Fit = glmnet(scale_data_df[tr,],zoom[tr],alpha=1)
Ridge.Fit = glmnet(scale_data_df[tr,],zoom[tr],alpha=0)

par(mfrow=c(1,2)) #Plot window: 1 row, 2 columns

#Evaluating LASSO and RIDGE
plot(Lasso.Fit)
plot(Ridge.Fit)

#Let us do a 10-fold cv for selecting our parameter lambda
CV.L = cv.glmnet(scale_data_df[tr,], zoom[tr],alpha=1) #For Lasso
CV.R = cv.glmnet(scale_data_df[tr,], zoom[tr],alpha=0) #For Ridge

#Values of lambda (see help for more details)
LamR = CV.R$lambda.1se
LamL = CV.L$lambda.1se


par(mfrow=c(1,2))#Plot window: 1 row, 2 columns
#For Ridge
plot(log(CV.R$lambda),sqrt(CV.R$cvm),#Scatterplot
     main="Ridge CV (k=10)",
     xlab="log(lambda)",
     ylab = "RMSE",
     col=4,#Color of points
     cex.lab=1.2) #Size o lab
abline(v=log(LamR),lty=2,col=2,lwd=2) #selected lambda vs RMSE

#For LASSO
plot(log(CV.L$lambda),sqrt(CV.L$cvm),
     main="LASSO CV (k=10)",xlab="log(lambda)",
     ylab = "RMSE",col=4,type="b",cex.lab=1.2)
abline(v=log(LamL),lty=2,col=2,lwd=2)

#Now we can check the coefs of each selected model
coef.R = predict(CV.R,type="coefficients",s=LamR)
coef.L = predict(CV.L,type="coefficients",s=LamL)

par(mfrow=c(1,1))#Plot window: 1 row, 1 column
#Comparing the coefs of the two models
plot(abs(coef.R[2:20]),abs(coef.L[2:20]),
     ylim=c(0,1),xlim=c(0,1))
abline(0,1)


#######################################
#### k-fold cross validation (knn) ####
#######################################

set.seed(12345) #Seed to guarantee same results

#Read the CSV file
dataset = read.csv("Final_file_updated.csv") 

date = dataset$Date
zoom = dataset$Zoom.Open.Price..on.next.day.
covid_world_cases = dataset$Daily.Cases.World
covid_world_deaths = dataset$Daily.Deaths.World
covid_us_cases = dataset$Daily.Cases.USA
covid_us_deaths = dataset$Daily.deaths.USA
vix = dataset$Vix
cisco = dataset$Cisco.Open.Price
tsy_3mo = dataset$Treasury.Yield.13.week
tsy_10yr = dataset$Treasury.Yield.10.Yrs
sp = dataset$S.P.500
nasdaq = dataset$NASDAQ.Index
tsy_10yr_3mo_spread = tsy_10yr-tsy_3mo


#Dimension returns the dimensions of a df
#The first number is the number of rows, and the second number is the number of columns
n=dim(dataset)[1]

#Sample 100 indices among the n available
ind = sample(1:n, #Data that can be sampled
             size = 100, #Sample size
             replace = FALSE) #Without replacement

Y = zoom #Selecting the only the sampled observations
sample_data = dataset[ind,] #And the sampled lines from the df

#Create data frame for test and train
train = data.frame(Y, covid_world_cases,covid_us_cases,cisco,nasdaq,vix,sp)
test = data.frame(Y, covid_world_cases,covid_us_cases,cisco,nasdaq,vix,sp)

library(kknn)
#Fitting a knn
near = kknn(Y~., #Formula
            train = train, #Train matrix/df
            test = test, #Test matrix/df
            k=10, #Number of neighbors
            kernel = "rectangular") #Type of kernel (see help section for more)

#Calculate the residuals
res = Y - near$fitted

#Now, let us repeat the example using k-fold cv
kcv = 10 #number of folds
n0 = round(n/kcv,0) #Size of each fold

#Different values of neighbors
kk <- 1:100

#MSE matrix
out_MSE = matrix(0,
                 nrow = kcv, #number of rows
                 ncol = length(kk)) #number of columns

#Vector of indices that have already been used inside the for
used = NULL

#The set of indices not used (will be updated removing the used)
set = 1:n

for(j in 1:kcv){
  
  if(n0<length(set)){ #If the set of 'not used' is > than the size of the fold
    val = sample(set, size = n0) #then sample indices from the set
  }
  
  if(n0>=length(set)){ #If the set of 'not used' is <= than the size of the fold
    val=set #then use all of the remaining indices as the sample
  }
  
  #Create the train and test matrices
  train_i = train[-val,] #Every observation except the ones whose indices were sampled
  test_i = test[val,] #The observations whose indices sampled
  
  for(i in kk){
    
    #The current model
    near = kknn(Y ~ ., #The formula
                train = train_i, #The train matrix/df
                test = test_i, #The test matrix/df
                k=i, #Number of neighbors
                kernel = "rectangular") #Type of kernel (see help for more)
    
    #Calculating the MSE of current model
    aux = mean((test_i[,1]-near$fitted)^2)
    
    #Store the current MSE
    out_MSE[j,i] = aux
  }
  
  #The union of the indices used currently and previously
  used = union(used,val)
  
  #The set of indices not used is updated
  set = (1:n)[-used]
  
  #Printing on the console the information that you want
  #Useful to keep track of the progress of your loop
  cat(j,"folds out of",kcv,'\n')
}


#Calculate the mean of MSE for each k
mMSE = apply(out_MSE, #Receive a matrix
             2, #Takes its columns (it would take its rows if this argument was 1)
             mean) #And for each column, calculate the mean

par(mfrow=c(1,1)) #Redimension plot window to 1 row, 1 column

#Complexity x RMSE graph
plot(log(1/kk),sqrt(mMSE), #the values
     xlab="Complexity (log(1/k))",
     ylab="out-of-sample RMSE",
     main = "K-Fold Cross Validation (knn)",
     col=4, #Color of line
     lwd=2, #Line width
     type="l", #Type of graph = line
     cex.lab=1.2) #Size of labs

#Find the index of the minimum value of mMSE
best = which.min(mMSE)
best
#Inclusing text at specific coordinates of the graph
text(log(1/kk[best]),sqrt(mMSE[best])+0.01, #Coordinates
     paste("k=",kk[best]),#The actual text
     col=2, #Color of the text
     cex=1.2) #Size of the text
text(log(1/100)+1,sqrt(mMSE[100]),"k=100")
text(log(1/1)-0.5,sqrt(mMSE[1])+0.001,"k=1")