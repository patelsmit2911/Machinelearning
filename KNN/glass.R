##### Type prediction using KNN algorith#########

#loading the data
glass<-read.csv("G:\\download_vb\\Assignement\\KNN\\glass.csv")
options(max.print=1000000)
head(glass)

boxplot(glass$RI)
hist(glass$RI)# though we have outliers but data looks normally distributed if we remove it
boxplot(glass$Na)
hist(glass$Na) # though we have outliers but data looks normally distributed if we remove it
boxplot(glass$Mg) # Data is left looks left skewed
hist(glass$Mg)
boxplot(glass$Al)
hist(glass$Al)  # though we have outliers but data looks normally distributed if we remove it


#############we can use below using sample ##########

library(caTools)
set.seed(123)   #  set seed to ensure you always have same random numbers generated
sample = sample.split(glass,SplitRatio = 0.75) # splits the data in the ratio mentioned in SplitRatio.
glass.train =subset(glass,sample ==TRUE) 
glass.test=subset(glass, sample==FALSE)


glass_train_labels <- glass.train[,10]
glass_test_labels <- glass.test[,10]

glass_train_labels
glass_test_labels

optimal.K.possible<-floor(sqrt(length(glass.test)))


#---- Training a model on the data ----

# load the "class" library
library(class)

glass_test_pred <- knn(train = glass.train, test = glass.test,cl = glass_train_labels, k=3)

# load the "gmodels" library
library(gmodels)

# Create the cross tabulation of predicted vs. actual
table<-CrossTable(x = glass_test_labels, y = glass_test_pred,
                  prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)
#accuracy:87.5


glass_test_pred <- knn(train = glass.train, test = glass.test,cl = glass_train_labels, k=4)
# Create the cross tabulation of predicted vs. actual
table<-CrossTable(x = glass_test_labels, y = glass_test_pred,
                  prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)
#accuracy:87.5

glass_test_pred <- knn(train = glass.train, test = glass.test,cl = glass_train_labels, k=5)
# Create the cross tabulation of predicted vs. actual
table<-CrossTable(x = glass_test_labels, y = glass_test_pred,
                  prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)
#accuracy:87.5


glass_test_pred <- knn(train = glass.train, test = glass.test,cl = glass_train_labels, k=6)
# Create the cross tabulation of predicted vs. actual
table<-CrossTable(x = glass_test_labels, y = glass_test_pred,
                  prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)
#accuracy:87.5

