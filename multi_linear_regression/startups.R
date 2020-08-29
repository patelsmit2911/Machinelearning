## loading startup data
startups<-read.csv("G:\\download_vb\\Assignement\\Multi Linear Regression\\50_Startups.csv")
head(startups)
##picking only required columns
startup<-startups[,c(1,2,3,5)]
head(startup)

##finding correlation and plotting scatter plot
library(psych)
pairs.panels(startup[,1:4], 
             method = "kendall", # correlation method
             hist.col = "#00AFBB",
             density = FALSE,  # show density plots
             ellipses = FALSE # show correlation ellipses
)
#building model
strt.model<-lm(Profit~R.D.Spend+Administration+Marketing.Spend,data=startup[-c(47,50,46,20),])
# summary of model
summary(strt.model)
# finding co-linearity using VIF
library(car)
vif(strt.model)
# doing step AIC and takin that model which has low step AIC by removing insignificant features
library(MASS)
fit.model<-stepAIC(strt.model)
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



