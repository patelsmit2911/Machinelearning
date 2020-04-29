library(readxl)
#Data load
airlines<-read_excel("G:/download_vb/Assignement/Clustering/EastWestAirlines.xlsx",sheet="data")
airlines
km <- kmeans(airlines[,2:11],3) # initially using 3 clusters ##ignore 1st column
summary(km)

##finding clusters and centres 

km$cluster
km$centers

#scaling the data#

scaling<-function (x){
  return((x-min(x))/(max(x)-min(x)))
}

airline<-sapply(airlines[,2:11],scaling)
airline
##################### Animation ###############
library(animation)
windows()
km <- kmeans.ani(airline, 3)

wss<-c()
for (i in 2:15) wss[i]<-sum(kmeans(airline,centers =i)$withinss) 
plot(1:15,wss,type = "b", xlab = "No of clusters",ylab = "Avg distance")

### As per elbow method we can say 9 will be the optimum cluster size 

library(animation)
windows()
km <- kmeans.ani(airline, 9)

  
