library(dplyr)
#load the data
calories<-read.csv("G:\\download_vb\\Assignement\\Simple linear Regression\\calories_consumed.csv")
head(calories)


#plotting
pairs(calories)
cor(calories)
boxplot(calories)
hist(calories$Calories.Consumed)
mean(calories$Calories.Consumed)
median(calories$Calories.Consumed)
## from above observation we can say data is right skewed because mean is somewhat higher than median   
barplot(del.time$Delivery.Time)



R.val<-list()
#fitting the model
fit.model<-lm(Weight.gained..grams.~Calories.Consumed,data=calories)
simple.linear<-summary(fit.model)

###plolynomail model
polynomialtype <- lm(Weight.gained..grams.~Calories.Consumed+I(Calories.Consumed^2)
                     +I(Calories.Consumed^3), data = calories)
poly.nomial<-summary(polynomialtype)


## log model
log.model<-lm(Weight.gained..grams.~log(Calories.Consumed),data=calories)
logarithmic<-summary(log.model)


## making list with key pair value

R.val[["simple.linear"]]<-simple.linear$r.squared
R.val[["polynomial"]]<-poly.nomial$r.squared
R.val[["log"]]<-logarithmic$r.squared

#### list of R values for different algorith

R.val

## plotting ifference between graphs
plot(calories$Weight.gained..grams.,predict(fit.model),col='blue')
plot(calories$Weight.gained..grams.,predict(polynomialtype),col='red')
plot(calories$Weight.gained..grams.,predict(log.model),col='green')


# predicting weight gained based on calories consumed for different plots 
predict(fit.model,data.frame(Calories.Consumed<-c(1700,1800,1900,2000)))
predict(polynomialtype,data.frame(Calories.Consumed<-c(1700,1800,1900,2000)))
predict(log.model,data.frame(Calories.Consumed<-c(1700,1800,1900,2000)))
