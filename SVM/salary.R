#loading the data
Data_Train <- read.csv("G:\\download_vb\\Assignement\\SVM\\SalaryData_Train(1).csv")
Data_Test <- read_csv("G:\\download_vb\\Assignement\\SVM\\SalaryData_Test(1).csv")


#pre-processing the data 
library(dummies)
library(tidyverse)
## For train data
salary_train <- dummy.data.frame(Data_Train[,-c(14)])
sal <- factor(Data_Train$Salary, levels = c("<=50K", ">50K"), labels =  c("0","1"))
sal
salary_train <- cbind(salary_train, sal)
salary_train
salary_train <- cbind(salary_train, Data_Train$age,Data_Train$educationno,
                      Data_Train$capitalgain,Data_Train$capitalloss, 
                      Data_Train$hoursperweek)


boxplot(salary_train$sal)
hist(salary_train$sal)
cor(salary_train)


## For test data
salary_test <- dummy.data.frame(Data_Test[,-c(14)])
sal <- factor(Data_Test$Salary, levels = c("<=50K", ">50K"), labels =  c("0","1"))
salary_test <- cbind(salary_test, sal)

salary_test <- cbind(salary_test,Data_Test$age, Data_Test$educationno,
                     Data_Test$capitalgain,Data_Test$capitalloss,
                     Data_Test$hoursperweek)


#Training the model
library(kernlab)
sal_svm <- ksvm(sal ~ ., data= salary_train, kernal = "vanilladot")
sal_svm

#predicting for test data
sal_prediction <- predict(sal_svm, salary_test)
head(sal_prediction)

#checcking accuracy of model
agreement <- salary_test$sal == sal_prediction
table(agreement)
mean(salary_test$sal == sal_prediction) * 100    #85.33865
prop.table(table(agreement))


#using different versions of kernels
sal_svm <- ksvm(sal ~ ., data= salary_train, kernal = "rbfdot")
sal_svm

sal_prediction <- predict(sal_svm, salary_test)
head(sal_prediction)

agreement <- salary_test$sal == sal_prediction
table(agreement)
mean(salary_test$sal == sal_prediction) * 100    #85.34529
prop.table(table(agreement))


sal_svm <- ksvm(sal ~ ., data= salary_train, kernal = "polydot")
sal_svm

sal_prediction <- predict(sal_svm, salary_test)
head(sal_prediction)

agreement <- salary_test$sal == sal_prediction
table(agreement)
mean(salary_test$sal == sal_prediction) * 100    #85.32537
prop.table(table(agreement))


### Results look like same here in accuracy beacure we couldn't have to adjust
#  our support vector more to fit the data so we are having same type of accuracy 
#  at RBF and linear kernel.
