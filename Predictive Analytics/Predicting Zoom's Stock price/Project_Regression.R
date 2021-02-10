library(dplyr)

zoom = read.csv('Final_file_updated.csv',na.strings = c("","NA","#N/A"))
zoom = select(zoom,-1)

######################linear model without model selection################
m_d_world = lm(Zoom.Open.Price..on.next.day.~Daily.Cases.World,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~Daily.Cases.World,data = zoom)) 

m_d_us = lm(Zoom.Open.Price..on.next.day.~Daily.Cases.USA,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~Daily.Cases.USA,data = zoom))

m_dths_world = lm(Zoom.Open.Price..on.next.day.~Daily.Deaths.World,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~Daily.Deaths.World,data = zoom))

m_dths_us = lm(Zoom.Open.Price..on.next.day.~Daily.deaths.USA,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~Daily.deaths.USA,data = zoom))

m_vix = lm(Zoom.Open.Price..on.next.day.~Vix,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~Vix,data = zoom))

m_cisco = lm(Zoom.Open.Price..on.next.day.~Cisco.Open.Price,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~Cisco.Open.Price,data = zoom)) #p > 0.05

m_t10yr = lm(Zoom.Open.Price..on.next.day.~Treasury.Yield.10.Yrs,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~Treasury.Yield.10.Yrs,data = zoom))

m_nasdaq = lm(Zoom.Open.Price..on.next.day.~NASDAQ.Index,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~NASDAQ.Index,data = zoom))

m_t3mo = lm(Zoom.Open.Price..on.next.day.~Treasury.Yield.13.week,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~Treasury.Yield.13.week,data = zoom))

m_sp500 = lm(Zoom.Open.Price..on.next.day.~S.P.500,data = zoom)
summary(lm(Zoom.Open.Price..on.next.day.~S.P.500,data = zoom)) #p > 0.05


#### Check for non-linear relationship.
summary(lm(Zoom.Open.Price..on.next.day.~poly(Daily.Cases.World,3),data = zoom)) #^2 P>0.05
summary(lm(Zoom.Open.Price..on.next.day.~poly(Daily.Cases.USA,3),data = zoom)) #^2 P>0.05
summary(lm(Zoom.Open.Price..on.next.day.~poly(Daily.Deaths.World,3),data = zoom)) 
summary(lm(Zoom.Open.Price..on.next.day.~poly(Daily.deaths.USA,3),data = zoom))
summary(lm(Zoom.Open.Price..on.next.day.~poly(Vix,3),data = zoom))
summary(lm(Zoom.Open.Price..on.next.day.~poly(Treasury.Yield.10.Yrs,3),data = zoom)) # ^2 ^3 p > 0.05
summary(lm(Zoom.Open.Price..on.next.day.~poly(NASDAQ.Index,3),data = zoom))
summary(lm(Zoom.Open.Price..on.next.day.~poly(Treasury.Yield.13.week,3),data = zoom))

### drop the predictors that have either P > 0.05 or non-linear realtionship with response
zoom = select(zoom,-1,-2,-7,-8,-11)

m_multi = lm(Zoom.Open.Price..on.next.day.~.,data = zoom)
summary(m_multi)
predict(m_multi)  
##########     model selection   ###############

rm(list=ls()) #Removes every object from your environment

#Read data
zoom = read.csv('Final_file_updated.csv',na.strings = c("","NA","#N/A"))

zoom_p = zoom$Zoom.Open.Price..on.next.day.

zoom <- zoom[,-c(1,6)] # lose date and zoom price
n = dim(zoom)[1] #Sample size
tr = sample(1:n, #Sample indices do be used in training
            size = 198, #Sample will have 198 observation
            replace = FALSE) #Without replacement


#Create a full matrix of interactions (only necessary for linear model)
#Do the normalization only for main variables.
XXzoom <- model.matrix(~., data=data.frame(scale(zoom)))[,-1]
zoomdata = data.frame(zoom_p,XXzoom)

#Two models initially
null = lm(zoom_p~1, data=zoomdata[tr,]) #only has an intercept
full = glm(zoom_p~., data=zoomdata[tr,]) #Has all the selected variables

#Let us select models by stepwise
regForward = step(null, #The most simple model
                  scope=formula(full),#Let us analyze all models until the full model
                  direction="forward", #Adding variables
                  k=log(length(tr))) #This is BIC
regBack = step(full, #Starting with the full model
               direction="backward", #And deleting variables
               k=log(length(tr))) #This is BIC
hybrid = step(null, #The most simple model
              scope=formula(full), #The most complicated model
              direction="both", #Add or delete variables
              k=log(length(tr))) #This is BIC
predict(regForward)
predict(regBack)
predict(hybrid)
