library(dplyr)
set.seed(1)

zoom = read.csv('Final_file_updated.csv',na.strings = c("","NA","#N/A"))
zoom = select(zoom,-1)


n = dim(zoom)[1] #Sample size
tr = sample(1:n, #Sample indices do be used in training
            size = 100, #Sample will have 198 observation
            replace = FALSE) #Without replacement

zoom_train = zoom[tr,]
zoom_test = zoom[-tr,]

######################linear model without model selection################
m_d_world = lm(Zoom.Open.Price..on.next.day.~Daily.Cases.World,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~Daily.Cases.World,data = zoom_train)) 
pred_wc = predict(m_d_world,newdata = zoom_test)
MSE_m_d_world = mean((pred_wc - zoom_test$Zoom.Open.Price..on.next.day.)^2)
RMSE_w_c = sqrt(MSE_m_d_world)

m_d_us = lm(Zoom.Open.Price..on.next.day.~Daily.Cases.USA,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~Daily.Cases.USA,data = zoom_train))
pred_usc = predict(m_d_us,newdata = zoom_test)
MSE_m_d_us = mean((pred_usc - zoom_test$Zoom.Open.Price..on.next.day.)^2)
RMSE_us_c = sqrt(MSE_m_d_us)

m_dths_world = lm(Zoom.Open.Price..on.next.day.~Daily.Deaths.World,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~Daily.Deaths.World,data = zoom_train))
pred_dths_w = predict(m_dths_world,newdata = zoom_test)
MSE_dths_w = mean((pred_dths_w - zoom_test$Zoom.Open.Price..on.next.day.)^2)
RMSE_dths_w = sqrt(MSE_dths_w)


m_dths_us = lm(Zoom.Open.Price..on.next.day.~Daily.deaths.USA,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~Daily.deaths.USA,data = zoom_train))
pred_dths_us = predict(m_dths_us,newdata = zoom_test)
MSE_dths_us = mean((pred_dths_us - zoom_test$Zoom.Open.Price..on.next.day.)^2)
RMSE_dths_us = sqrt(MSE_dths_us)



m_vix = lm(Zoom.Open.Price..on.next.day.~Vix,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~Vix,data = zoom_train))
pred_vix = predict(m_vix,newdata = zoom_test)
MSE_vix = mean((pred_vix - zoom_test$Zoom.Open.Price..on.next.day.)^2)
RMSE_vix = sqrt(MSE_vix)


m_cisco = lm(Zoom.Open.Price..on.next.day.~Cisco.Open.Price,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~Cisco.Open.Price,data = zoom_train)) #p > 0.05

m_t10yr = lm(Zoom.Open.Price..on.next.day.~Treasury.Yield.10.Yrs,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~Treasury.Yield.10.Yrs,data = zoom_train))
pred_t10yr = predict(m_t10yr,newdata = zoom_test)
MSE_t10yr = mean((pred_t10yr - zoom_test$Zoom.Open.Price..on.next.day.)^2)
RMSE_t10yr = sqrt(MSE_t10yr)




m_nasdaq = lm(Zoom.Open.Price..on.next.day.~NASDAQ.Index,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~NASDAQ.Index,data = zoom_train))
pred_nasdaq = predict(m_nasdaq,newdata = zoom_test)
MSE_nasdaq = mean((pred_nasdaq - zoom_test$Zoom.Open.Price..on.next.day.)^2)
RMSE_nasdaq = sqrt(MSE_nasdaq)


m_t3mo = lm(Zoom.Open.Price..on.next.day.~Treasury.Yield.13.week,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~Treasury.Yield.13.week,data = zoom_train))
pred_t3mo = predict(m_t3mo,newdata = zoom_test)
MSE_t3mo = mean((pred_t3mo - zoom_test$Zoom.Open.Price..on.next.day.)^2)
RMSE_t3mo = sqrt(MSE_t3mo)


m_sp500 = lm(Zoom.Open.Price..on.next.day.~S.P.500,data = zoom_train)
summary(lm(Zoom.Open.Price..on.next.day.~S.P.500,data = zoom_train)) #p > 0.05


#### Check for non-linear relationship.
summary(lm(Zoom.Open.Price..on.next.day.~poly(Daily.Cases.World,3),data = zoom_train)) #^2 P>0.05
summary(lm(Zoom.Open.Price..on.next.day.~poly(Daily.Cases.USA,3),data = zoom_train)) 
summary(lm(Zoom.Open.Price..on.next.day.~poly(Daily.Deaths.World,3),data = zoom_train)) #^3 
summary(lm(Zoom.Open.Price..on.next.day.~poly(Daily.deaths.USA,3),data = zoom_train))
summary(lm(Zoom.Open.Price..on.next.day.~poly(Vix,3),data = zoom_train))
summary(lm(Zoom.Open.Price..on.next.day.~poly(Treasury.Yield.10.Yrs,3),data = zoom_train)) #^2 # ^2 ^3 p > 0.05
summary(lm(Zoom.Open.Price..on.next.day.~poly(NASDAQ.Index,3),data = zoom_train))
summary(lm(Zoom.Open.Price..on.next.day.~poly(Treasury.Yield.13.week,3),data = zoom_train)) #^3

### drop the predictors that have either P > 0.05 or non-linear realtionship with response
zoom = select(zoom,-1,-3,-8,-10,-11,-7)


n = dim(zoom)[1] #Sample size
tr = sample(1:n, #Sample indices do be used in training
            size = 100, #Sample will have 198 observation
            replace = FALSE) #Without replacement

zoom_train = zoom[tr,]
zoom_test = zoom[-tr,]


m_multi = lm(Zoom.Open.Price..on.next.day.~.,data = zoom_train)
summary(m_multi)
pred_multi = predict(m_multi,newdata = zoom_test)
MSE_multi = mean((pred_multi - zoom_test$Zoom.Open.Price..on.next.day.)^2)
RMSE_multi = sqrt(MSE_multi)







##########     model selection   ###############
rm(list=ls()) #Removes every object from your environment

#Read data
zoom = read.csv('Final_file_updated.csv',na.strings = c("","NA","#N/A"))

zoom_p = zoom$Zoom.Open.Price..on.next.day.

n = dim(zoom)[1] #Sample size
tr = sample(1:n, #Sample indices do be used in training
            size = 199, #Sample will have 198 observation
            replace = FALSE) #Without replacement
zoom_p_test = as.data.frame(zoom_p)
zoom_p_test = zoom_p_test[tr,]
zoom <- zoom[,-c(1,6)] # lose date and zoom price

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

pred_forward = predict(regForward)
MSE_forward = mean((pred_forward-zoom_p_test)^2)
RMSE_forward = sqrt(MSE_forward)


pred_back = predict(regBack)
MSE_back = mean((pred_back-zoom_p_test)^2)
RMSE_back = sqrt(MSE_back)

pred_hybrid = predict(hybrid)
MSE_hybrid = mean((pred_hybrid-zoom_p_test)^2)
RMSE_hybrid = sqrt(MSE_hybrid)

