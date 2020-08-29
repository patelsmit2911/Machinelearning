#Data load
crimes<-read.csv("G:/download_vb/Assignement/Clustering/crime_data.csv")
crimes
km <- kmeans(crimes[,2:4],4) # initially using 4 clusters 
summary(km)

##finding clusters and centres 

km$cluster
km$centers

#######scaling######
scaling<-function (x){
  return((x-min(x))/(max(x)-min(x)))
}
crimes<-sapply(crimes[,2:4],scaling)
crimes


library(animation)
windows()
km <- kmeans.ani(crimes, 4)

wss<-c()
for (i in 2:15) wss[i]<-sum(kmeans(crimes,centers =i)$withinss) 
plot(1:15,wss,type = "b", xlab = "No of clusters",ylab = "Avg distance")

### As per elbow method we can say 5 will be the optimum cluster size 

library(animation)
windows()
km <- kmeans.ani(crimes,5)


