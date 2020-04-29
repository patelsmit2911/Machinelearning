
####################### Cutlet ########################
#load the data
cutlet<-read.csv("G:\\download_vb\\Assignement\\Hypothysis Testing\\Cutlets.csv")
attach(cutlet)
t.test(Unit.A,Unit.B,alternative = "two.sided",conf.level = 0.95,correct = TRUE,paired=FALSE,mu=0,var.equal=FALSE)#two sample T.Test



#data:  Unit.A and Unit.B
#t = 0.72287, df = 66.029, p-value = 0.4723
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  -0.09654633  0.20613490
#sample estimates:
#  mean of x mean of y 
#7.019091  6.964297 


###ploting values####
boxplot(cutlet)        # Data is normally distributed
plot(Unit.A~Unit.B, data = cutlet)

# p-value : 0.4723>0.05 accept null hypothesis. 


############################## Customer-order #############################################

LabTAT<-read.csv("G:\\download_vb\\Assignement\\Hypothysis Testing\\LabTAT.csv")
LabTaT

library(dplyr)
group_by(LabTaT, ind) %>%
  summarise(
    count = n(),
    mean = mean(values, na.rm = TRUE),
    sd = sd(values, na.rm = TRUE)
  )

LabTaT<-stack(LabTAT)
annova.summary<-anova(values~ind,data=LabTaT)
summary(annova.summary)

#> summary(annova.summary)
#Df Sum Sq Mean Sq F value Pr(>F)    
#ind           3  79979   26660   118.7 <2e-16 ***
#  Residuals   476 106905     225                   
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# so it will reject the null hypothysis as p-value is more significant
#p-value : 2e-16<0.05


##############################Customer-order #############################################


cust<-read.csv("G:/download_vb/Assignement/Hypothysis Testing/customer.csv")
attach(cust)
stacked.data<-stack(cust)
chisq.test(stacked.data$ind, stacked.data$values)

#Here p = 0.2771 > 0.05, we will accept the null hypothesis hypothesis.

############################## buyer ratio #############################################

#Null hypothesis:  proportion is equal
#Alternative Hypothesis:  proportion is not equal.


buyeratio<-read.csv("G:/download_vb/Assignement/Hypothysis Testing/BuyerRatio.csv")
stacked.buyeratio <- stack(buyeratio)
head(stacked.buyeratio)
annova.buyeratio<-aov(values~ind,data= stacked.buyeratio)
summary(annova.buyeratio)

# p-value: 0.82>0.05 so we will accept null hypothesis

############################## Faltoons #############################################

Faltoons<-read.csv("G:/download_vb/Assignement/Hypothysis Testing/Faltoons.csv")

head(Faltoons)
chisq.test(Faltoons$Weekdays,Faltoons$Weekend)

#Pearson's Chi-squared test with Yates' continuity correction

#data:  Faltoons$Weekdays and Faltoons$Weekend
#X-squared = 2.2781e-30, df = 1, p-value = 1

#Here p > 0.05, we accept the NULL hypothesis.