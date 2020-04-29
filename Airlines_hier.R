library(readxl)
#Data load
airlines<-read_excel("G:/download_vb/Assignement/Clustering/EastWestAirlines.xlsx",sheet="data")
airlines


airline <- scale(airlines[,2:11])   ## ignored 1st column
airline
d <- dist(airline, method = "euclidean") #Computing the distance matrix
d


fit <- hclust(d, method="average") # Building the algorithm 
plot(fit) 

fit <- hclust(d, method = "centroid")
plot(fit)



groups <- cutree(fit, k=8) # cut tree into 8 clusters
groups

# draw dendogram with red borders around the 8 clusters 
rect.hclust(fit, k=8, border="red")

#Attach the cluster numbers agains Id
clusters=data.frame('ID.'=airlines[,1],'Cluster' =groups)

# only accessing ids which are in cluster 2
clusters$ID.[clusters$Cluster==2]
#[1]    9  202  230  386  398  568  804  951 1161 1283 1397 1403 1542 1556 1808
#[16] 1935 1993 2023 2064 2183 2296 2335 2440 2576 2694 2763 2928 2989 3000 3177
#[31] 3213 3225 3382 3390 3510 3634 3785 3802 3811 3860 3874 3982


