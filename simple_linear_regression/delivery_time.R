#load the data
del.time<-read.csv("G:\\download_vb\\Assignement\\Simple linear Regression\\delivery_time.csv")
head(del.time)



#plotting
pairs(del.time)
cor(del.time)
boxplot(del.time)
hist(del.time$Delivery.Time)
mean(del.time$Delivery.Time)
median(del.time$Delivery.Time)
## from above observation we can say data is normally istributed as mean an medial are almost same   
barplot(del.time$Delivery.Time)


R.val<-list()
#fitting the model
fit.model<-lm(Delivery.Time~Sorting.Time,data=del.time)
summary(fit.model)

###plolynomial model
polynomialtype <- lm(Delivery.Time~Sorting.Time+I(Sorting.Time^2)
                     +I(Sorting.Time^3), data = del.time)
poly.nomial<-summary(polynomialtype)


## log model
log.model<-lm(Delivery.Time~log(Sorting.Time),data=del.time)
logarithmic<-summary(log.model)


## making list with key pair value

R.val[["simple.linear"]]<-simple.linear$r.squared
R.val[["polynomial"]]<-poly.nomial$r.squared
R.val[["log"]]<-logarithmic$r.squared

#### list of R values for different algorith

R.val

## plotting ifference between graphs
plot(del.time$Delivery.Time,predict(fit.model),col='blue')
plot(del.time$Delivery.Time,predict(polynomialtype),col='red')
plot(del.time$Delivery.Time,predict(log.model),col='green')


# predicting Delivery.Time based on Sorting.Time for different plots 
predict(fit.model,data.frame(Sorting.Time<-c(11,20,35,30)))
predict(polynomialtype,data.frame(Sorting.Time<-c(11,20,35,30)))
predict(log.model,data.frame(Sorting.Time<-c(11,20,35,30)))












