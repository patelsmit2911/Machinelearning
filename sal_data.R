#load the data
sal.data<-read.csv("G:\\download_vb\\Assignement\\Simple linear Regression\\Salary_Data.csv")
head(sal.data)


###plotings
pairs(sal.data)
cor(sal.data)
boxplot(sal.data)
hist(sal.data$Salary)  
mean(sal.data$Salary)
median(sal.data$Salary)
## from above observation we can say data is right skewed for salary     
barplot(sal.data$Salary)




R.val<-list()
#fitting the model
fit.model<-lm(Salary~YearsExperience,data=sal.data)
model.summary<-summary(fit.model)

###plolynomial model
polynomialtype <- lm(Salary~YearsExperience+I(YearsExperience^2)
                     +I(YearsExperience^3), data = sal.data)
poly.nomial<-summary(polynomialtype)


## log model
log.model<-lm(Salary~log(YearsExperience),data=sal.data)
logarithmic<-summary(log.model)


## making list with key pair value

R.val[["simple.linear"]]<-simple.linear$r.squared
R.val[["polynomial"]]<-poly.nomial$r.squared
R.val[["log"]]<-logarithmic$r.squared

#### list of R values for different algorith

R.val

## plotting ifference between graphs
plot(sal.data$Salary,predict(fit.model),col='blue')
plot(sal.data$Salary,predict(polynomialtype),col='red')
plot(sal.data$Salary,predict(log.model),col='green')


# predicting Salary based on YearsExperience for different plots 
predict(fit.model,data.frame(YearsExperience<-c(1,2.4,4.2,6.4,11)))
predict(polynomialtype,data.frame(YearsExperience<-c(1,2.4,4.2,6.4,11)))
predict(log.model,data.frame(YearsExperience<-c(1,2.4,4.2,6.4,11)))







