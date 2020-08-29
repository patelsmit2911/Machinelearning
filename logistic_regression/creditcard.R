#data loading
creditcard<-read.csv("G:\\download_vb\\Assignement\\Logistic Rgression\\creditcard.csv")
head(creditcard)

#data preprocessing

creditcard<-creditcard[,-c(1)]
creditcard
creditcard$card<-factor(creditcard$card,levels=c("yes","no"),labels=c(1,2))
creditcard$owner<-factor(creditcard$owner,levels=c("yes","no"),labels=c(1,2))
creditcard$selfemp<-factor(creditcard$selfemp,levels=c("yes","no"),labels=c(1,2))

#EDA
library(psych)
pairs.panels(creditcard[,1:12], 
             method = "kendall", # correlation method
             hist.col = "#00AFBB",
             density = FALSE,  # show density plots
             ellipses = FALSE # show correlation ellipses
)
library(ggplot2)
ggplot(creditcard, aes(card)) + geom_bar() ## to check howmany cards accepted
plot(creditcard$age,creditcard$income) ## to check relation between age and income
plot(creditcard$card,creditcard$owner,xlab="card",ylab="owner")
hist(creditcard$age)
boxplot(creditcard$age)


#building model

mylogit<-glm(card ~ reports+age+income+share+expenditure+owner+selfemp+dependents+months+majorcards+active,data=creditcard,family="binomial")
summary(mylogit)
prob<-predict(mylogit,creditcard,type="response")
prob
confusion<-table(prob>0.5,creditcard$card)
confusion

#finding acuracy

accuracy<-sum(diag(confusion)/sum(confusion))
accuracy
sensitivity<-confusion[1,1]/sum(confusion[1,1],confusion[2,1])
specificity<-confusion[1,2]/sum(confusion[1,2],confusion[2,2])
plot(sensitivity,specificity)

#ROC creation

library(pROC)
plot(roc(creditcard$card, predict(mylogit, creditcard, type = "response")))


