#####Support Vector Machines -------------------
##  forest size recogization ----
forest<-read.csv("G:\\download_vb\\Assignement\\SVM\\forestfires.csv")


### Data cleansing an transformation with some analysis
forest$size_category<-factor(forest$size_category,levels=c("small","large"),labels = c(1,2))
forest<-forest[,-c(1,2)]


boxplot(forest)
hist(forest$DC) ##Data is left skewed as we can see from Histogram and boxplot
boxplot(forest$ISI) # Data is normally ditributed
mean(forest$ISI)
median(forest$ISI)
boxplot(forest$temp) # Data is normally ditributed
mean(forest$temp)
median(forest$temp)


# divide into training and test data with 70 % training data an 30 % testing data
set.seed(1234)
train <- sample(nrow(forest), 0.7*nrow(forest))
forest.train <- forest[train,]
forest.validate <- forest[-train,]
table(forest.train$size_category)
table(forest.validate$size_category)


##Training a model on the data ----
# begin by training a simple linear SVM
library(kernlab)
size_classifier <- ksvm(size_category ~ ., data = forest.train,
                          kernel = "vanilladot")
summary(size_classifier)


## Evaluating model performance ----
# predictions on testing dataset


size_prediction<-predict(size_classifier,forest.validate)  # prediction of test size
head(size_prediction)
table(size_prediction,forest.validate$size_category,dnn = c("Actual","predicted"),deparse.level = 2)

siz <- size_prediction == forest.validate$size_category
table(siz)
prop.table(table(siz))


## Improving model performance  using RBF ----
size_classifier_rbf <- ksvm(size_category ~ ., data = forest.train,kernel = "rbfdot")
size_predictions_rbf <- predict(size_classifier_rbf,forest.validate)
table(size_predictions_rbf, forest.validate$size_category)

siz <- size_predictions_rbf == forest.validate$size_category
table(siz)
prop.table(table(siz))


############################# Tuning ##############
library(e1071)
tuned <- tune.svm(size_category~., data=forest.train,
                  gamma=c(1,0.1,0.01,0.001,0.0001),
                  cost=c(0.1,1, 10, 100, 1000))

tuned$best.performance
tuned$best.parameters

###### notes an analysis from the tuning

### 1.)here we are getting 1000 as cost function for best fitting but as cost function increases
  #  the overfitting of data chanses also increases as cost to make error value set as 1 as 
  #  default 2.)gamma value depicts te information regarding support vectors with mulyiple layers
  #  which set default as 1/(predictor features) gamma value shoul not be higher.

