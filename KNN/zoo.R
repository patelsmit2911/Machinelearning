##### Type prediction using KNN algorith#########

#loading the data
zoo<-read.csv("G:\\download_vb\\Assignement\\KNN\\Zoo.csv")
# removing unnecessary column
zoo<-zoo[,-c(1)]
options(max.print=1000000)
head(zoo)



#############we can use below using sample ##########

#library(caTools)
#set.seed(123)   #  set seed to ensure you always have same random numbers generated
#sample = sample.split(zoo,SplitRatio = 0.6) # splits the data in the ratio mentioned in SplitRatio.
#zoo.train =subset(zoo,sample ==TRUE) 
#zoo.test=subset(zoo, sample==FALSE)

zoo.train<-zoo[1:70,]
zoo.train
zoo.test<-zoo[71:101,]
zoo.test

zoo_train_labels <- zoo[1:70,17]
zoo_test_labels <- zoo[71:101,17]

zoo_train_labels
zoo_test_labels

optimal.K.possible<-floor(sqrt(length(zoo.test)))


#---- Training a model on the data ----

# load the "class" library
library(class)

zoo_test_pred <- knn(train = zoo.train, test = zoo.test,cl = zoo_train_labels, k=4)

# load the "gmodels" library
library(gmodels)

# Create the cross tabulation of predicted vs. actual
table<-CrossTable(x = zoo_test_labels, y = zoo_test_pred,
           prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)
#accuracy:77.41


zoo_test_pred <- knn(train = zoo.train, test = zoo.test,cl = zoo_train_labels, k=5)
# Create the cross tabulation of predicted vs. actual
table<-CrossTable(x = zoo_test_labels, y = zoo_test_pred,
                  prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)

#accuracy:77.41


zoo_test_pred <- knn(train = zoo.train, test = zoo.test,cl = zoo_train_labels, k=6)
# Create the cross tabulation of predicted vs. actual
table<-CrossTable(x = zoo_test_labels, y = zoo_test_pred,
                  prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)


#accuracy:74.19

zoo_test_pred <- knn(train = zoo.train, test = zoo.test,cl = zoo_train_labels, k=3)
# Create the cross tabulation of predicted vs. actual
table<-CrossTable(x = zoo_test_labels, y = zoo_test_pred,
                  prop.chisq=FALSE,prop.c = FALSE, prop.r = FALSE)
#accuracy:77.41


#   Here we have used square root of features to get probable optimal K value
#   to predict test data type but we do not have much training data for type 3 to predict
#   that is why it is not predicting type 3 class easily.
#   Though as per optimal way at cluster size 3,4,5 we are getting good accuracy
