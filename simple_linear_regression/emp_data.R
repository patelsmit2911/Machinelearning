#load the data
emp.data<-read.csv("G:\\download_vb\\Assignement\\Simple linear Regression\\emp_data.csv")
head(emp.data)


library(e1071)
#plotting
pairs(emp.data)
cor(emp.data)
boxplot(emp.data)
hist(emp.data$Salary_hike)
mean(emp.data$Salary_hike)
median(emp.data$Salary_hike)
kurtosis(emp.data$Salary_hike)
## from above observation we can say data is right skewed because mean is somewhat higher than median   
barplot(emp.data$Salary_hike)


R.val<-list()
#fitting the model
fit.model<-lm(Churn_out_rate~Salary_hike,data=emp.data)
summary(fit.model)

###plolynomial model
polynomialtype <- lm(Churn_out_rate~Salary_hike+I(Salary_hike^2)
                     +I(Salary_hike^3), data = emp.data)
poly.nomial<-summary(polynomialtype)


## log model
log.model<-lm(Churn_out_rate~log(Salary_hike),data=emp.data)
logarithmic<-summary(log.model)


## making list with key pair value

R.val[["simple.linear"]]<-simple.linear$r.squared
R.val[["polynomial"]]<-poly.nomial$r.squared
R.val[["log"]]<-logarithmic$r.squared

#### list of R values for different algorith

R.val

## plotting ifference between graphs
plot(emp.data$Churn_out_rate,predict(fit.model),col='blue')
plot(emp.data$Churn_out_rate,predict(polynomialtype),col='red')
plot(emp.data$Churn_out_rate,predict(log.model),col='green')


# predicting Churn_out_rate based on salary hike  
predict(fit.model,data.frame(Salary_hike<-c(1850,1450,1500)))
predict(polynomialtype,data.frame(Salary_hike<-c(1850,1450,1500)))
predict(log.model,data.frame(Salary_hike<-c(1850,1450,1500)))












