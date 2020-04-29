# data loading
wine<-read.csv("G:\\download_vb\\Assignement\\PCA\\wine.csv")
head(wine)

# finding principal component
PCA.comp<-princomp(wine[,1:14],cor=TRUE,scores = TRUE,covmat = NULL)
PCA.comp
summary(PCA.comp)

# finding scores and loading part

PCA.comp$scores
PCA.comp$loadings

#plotting
plot(PCA.comp$scores[,1:3],col='Blue',pch=81,cex=0.3,lwd=3)

# for the 3 components it will only understood 67.70% data at 7 components it will
# give 90% of understanding of data

############# Hier clustring using normal way ###########

wine.hier<- scale(wine[,1:14])   # scaling the data

d <- dist(wine.hier, method = "euclidean") #Computing the distance matrix
d

# uing centroid method on finding of data to build model and ploting dendogram
fit <- hclust(d, method="centroid") # Building the algorithm 
plot(fit) 

#cutting tree based on cluster size 
groups <- cutree(fit,12)
groups

#     1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
#[26]  2  1  1  1  1  1  1  1  1  1  1  1  1  1  3  1  1  1  1  1  1  1  1  1  1
#[51]  4  1  1  1  1  1  1  1  1  5  1  1  1  1  1  1  6  1  1  1  1  1  1  7  1
#[76]  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  8  1  1  1
#[101]  1  1  1  1  1  1  1  1  1  1  9  1  1  1  1 10  1  1  1  1  1 11  1  1  1
#[126]  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
#[151]  1  1  1  1  1  1  1  1 12 12  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
#[176]  1  1  

# draw dendogram with red borders around the 12 clusters 
rect.hclust(fit, k=12, border="red")

############### hier clustring using PCA ############



d <- dist(PCA.comp$scores[,1:3], method = "euclidean") #Computing the distance matrix


# uing centroid method on finding of data to build model and ploting dendogram
fit <- hclust(d, method="centroid") # Building the algorithm 
plot(fit) 

#cutting tree based on cluster size 
groups <- cutree(fit,12)
groups

#[1]  1  1  1  1  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
#[26]  3  1  4  1  1  1  1  1  1  1  1  1  1  4  1  1  1  1  1  1  1  1  1  1  1
#[51]  1  1  1  1  1  1  1  1  1  5  4  6  4  4  4  4  4  4  6  4  4  4  4  3  4
#[76]  4  4  4  4  4  4  4  4  7  4  4  4  8  4  4  4  4  4  4  4  1  9  4  4  4
#[101]  4  4  4  4  4  4  4  4  4  4  4  4  9  4  4 10  4  4  6  4  4 11  9  4  4
#[126]  4  4  9  4  4  6  7  7  7  6  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7
#[151]  7  7  7  7  7  7  7  7 12  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7
#[176]  7  7  7 

# draw dendogram with red borders around the 12 clusters 
rect.hclust(fit, k=12, border="red")


###################  summary #####################

#We have taken only 3 PCA which clarifies around 67% data due to which
#we are not getting same cluster structure as normal high dimensional data
#if we try with 7 components it will give better idea whci will give impotance around
#90% data

#######################  K- Means clustering using normal way##########################


km <- kmeans(wine[,1:14],3) # initially using 3 clusters
summary(km)

##finding clusters and centres 

km$cluster
km$centers

#scaling the data#

scaling<-function (x){
  return((x-min(x))/(max(x)-min(x)))
}

wine<-sapply(wine[,2:11],scaling)
wine
##################### Animation ###############
library(animation)
windows()
km <- kmeans.ani(wine, 3)

# elbow method to find optimal value of cluster
wss<-c()
for (i in 2:30) wss[i]<-sum(kmeans(wine,centers=i)$withinss) 
plot(1:30,wss,type = "b", xlab = "No of clusters",ylab = "Avg distance")


#######################  K- Means clustering using PCA ##########################


km <- kmeans(PCA.comp$scores[,1:3],3) # initially using 3 clusters
summary(km)

##finding clusters and centres 

km$cluster
km$centers


##################### Animation ###############
library(animation)
windows()
km <- kmeans.ani(PCA.comp$scores[,1:3], 3)

# elbow method to find optimal value of cluster

wss<-c()
for (i in 2:10) wss[i]<-sum(kmeans(PCA.comp$scores[,1:3],centers=i)$withinss) 
plot(1:10,wss,type = "b", xlab = "No of clusters",ylab = "Avg distance")

####### here in k-means using PCA Components will give us optimal values of K
# arround 3 or 4 which can be explained using elbow method
