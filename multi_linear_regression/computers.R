## loading computers data
Computers_data<-read.csv("G:\\download_vb\\Assignement\\Multi Linear Regression\\Computer_Data.csv")
head(Computers_data)
##picking only required columns
Computers_data<-Computers_data[,c(2:11)]
library(dummies)
dummy.comp <- dummy.data.frame(Computers_data, names = c("cd","multi","premium") )
dummy.comp<-dummy.comp[,c(1,2,3,4,5,7,9,11,12,13)]
names(dummy.comp)[c(6,7,8)]<-c("cd","multi","premium")
##finding correlation and plotting scatter plot
pairs(dummy.comp)
cor(dummy.comp)
#building model
comp.model<-lm(price~speed+hd+ram+screen+cd+multi+premium+ads+trend,data=dummy.comp[-c(1441,1701,594,5961),])
# summary of model
summary(comp.model)
# finding co-linearity using VIF
library(car)
vif(comp.model)
# doing step AIC and takin that model which has low step AIC by removing insignificant features
library(MASS)
fit.model<-stepAIC(comp.model)
summary(fit.model)
## different ploting to check linearity
avPlots(fit.model)
qqPlot(fit.model)

##Ploting influenceIndexPlot to remove outliers using cook distance method
influenceIndexPlot(fit.model)

## picking up R-Squared and adjusted values in table
R.val<-summary(fit.model)
Collection_R<-data.frame(R.val$r.squared,R.val$adj.r.squared)
Collection_R



