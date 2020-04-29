## loading toyotacorolla data
toyota<-read.csv("G:\\download_vb\\Assignement\\Multi Linear Regression\\ToyotaCorolla.csv")
head(toyota)
##picking only required columns
Toyota<-toyota[,c("Price","Age_08_04","KM","HP","cc","Doors","Gears","Quarterly_Tax","Weight")]
head(Toyota)
library(psych)
##finding correlation and plotting scatter plot
pairs.panels(Toyota[,1:8], 
             method = "kendall", # correlation method
             hist.col = "#00AFBB",
             density = FALSE,  # show density plots
             ellipses = FALSE # show correlation ellipses
)
#building model
tyt.model<-lm(Price~Age_08_04+KM+HP+cc+Doors+Gears+Weight,data=Toyota[-c(222,81,961,602,655),])
# summary of model
summary(tyt.model)
# finding co-linearity using VIF
library(car)
vif(tyt.model)
# doing step AIC and takin that model which has low step AIC by removing insignificant features
library(MASS)
fit.model<-stepAIC(tyt.model)
summary(fit.model)
## different ploting to check linearity
avPlots(fit.model)
qqPlot(fit.model)

##Ploting influenceIndexPlot to remove outliers using cook distance method
influenceIndexPlot(fit.model)
summary(fit.model)