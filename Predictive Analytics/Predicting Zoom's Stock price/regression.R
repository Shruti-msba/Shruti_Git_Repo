#################################################
# Regression                                    #
#################################################

rm(list=ls())

Data = read.csv("C:/Users/dhruv/Desktop/Predictive Modeling project/predictive_modeling_project/Final_file_20.csv")
attach(Data)

modelCovid = lm(Stock_Open ~ Covid_Cases)
modelVix = lm(Stock_Open ~ Vix)

# Summary of the models
summary(modelCovid)
summary(modelVix)

# Scatterplot for each model and OLS curve
plot(Covid_Cases,Stock_Open, # Data
     pch=19, # Type of point
     xlab="Covid Cases",
     ylab = "Stock Open")

abline(modelCovid$coef[1],modelCovid$coef[2], # OLS curve using coefs
       col=2, # Line color
       lwd=2) # Linew width

plot(Vix,Stock_Open,pch=19,xlab="Vix",ylab = "Stock Open")
abline(modelVix$coef[1],modelVix$coef[2],col=2,lwd=2)

# Covid Cases
# Confidence interval for coefficients
confint(modelCovid) # Default is 95%
confint(modelCovid,level=0.99) # Change the level of confidence

# Creating data frame for prediction
# Covid_Cases from 0 to 8
Xfuture <- data.frame(Covid_Cases=seq(0,120000,by=100))

# Calculating 95% and 99% prediction interval
Future1 = predict(modelCovid, Xfuture,
                  interval = "prediction",se.fit=T)
Future2 = predict(modelCovid, Xfuture,
                  interval = "prediction",se.fit=T,level=0.99)

# Plotting the model
plot(Covid_Cases,Stock_Open, # Data
     xlim=c(0,120000), # The range of predicted X
     ylim=range(Future1$fit), # Range of fit
     pch=19, # Type of point
     cex.lab=1.3) # Size of lab
abline(lsfit(Covid_Cases,Stock_Open),
       lwd=2, # Line width
       col=2) # Line color
lines(Xfuture$Covid_Cases,Future1$fit[,2], # lines of 95% prediction interval
      col=4, # Color of line
      lwd=2, # Line width
      lty=2) # Line type
lines(Xfuture$Covid_Cases,Future1$fit[,3], # lines of 95% prediction interval
      col=4,lwd=2,lty=2)
lines(Xfuture$Covid_Cases,Future2$fit[,2], # lines of 99% prediction interval
      col=5,lwd=2,lty=2)
lines(Xfuture$Covid_Cases,Future2$fit[,3], # lines of 99% prediction interval
      col=5,lwd=2,lty=2)

# Vix
# Confidence interval for coefficients
confint(modelVix) # Default is 95%
confint(modelVix,level=0.99) # Change the level of confidence

# Creating data frame for prediction
# Covid_Cases from 0 to 8
Xfuture <- data.frame(Vix=seq(0,200,by=0.1))

#Calculating 95% and 99% prediction interval
Future1 = predict(modelVix, Xfuture,
                  interval = "prediction",se.fit=T)
Future2 = predict(modelVix, Xfuture,
                  interval = "prediction",se.fit=T,level=0.99)

#Plotting the model
plot(Vix,Stock_Open, # data
     xlim=c(0,200), # the range of predicted X
     ylim=range(Future1$fit), # range of fit
     pch=19, # type of point
     cex.lab=1.3) # size of lab
abline(lsfit(Vix,Stock_Open), #lsfit can be used instead of lm()
       lwd=2, #Line width
       col=2) #Line color
lines(Xfuture$Vix,Future1$fit[,2], #Lines of 95% prediction interval
      col=4, #Color of line
      lwd=2, #Line width
      lty=2) #Line type
lines(Xfuture$Vix,Future1$fit[,3], #Lines of 95% prediction interval
      col=4,lwd=2,lty=2)
lines(Xfuture$Vix,Future2$fit[,2], #Lines of 99% prediction interval
      col=5,lwd=2,lty=2)
lines(Xfuture$Vix,Future2$fit[,3], #Lines of 99% prediction interval
      col=5,lwd=2,lty=2)

