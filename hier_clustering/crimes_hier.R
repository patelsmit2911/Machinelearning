#Data load
crimes<-read.csv("G:/download_vb/Assignement/Clustering/crime_data.csv")
crimes

################################
crime <- scale(crimes[,2:4])    ## ignore 1st column
crime
d <- dist(crime, method = "euclidean") #Computing the distance natrix
d
fit <- hclust(d, method="average") # Building the algorithm 
plot(fit) # display dendogram


fit <- hclust(d, method="centroid") # Building the algorithm 
plot(fit) # display dendogram



groups <- cutree(fit, k=4) # cut tree into 4 clusters
groups

# draw dendogram with red borders around the 4 clusters 
rect.hclust(fit, k=4, border="red")

#Attach the cluster numbers agains Id
clusters=data.frame("city_name"=crimes[,1],'Cluster' =groups)
clusters

# only accessing cities which are in cluster 1
clusters$city_name[clusters$Cluster==1]
#[1] Alabama        Alaska         Arkansas       Georgia        Louisiana     
#[6] Mississippi    North Carolina South Carolina Tennessee 
clusters$city_name[clusters$Cluster==2]
#[1] Arizona    California Florida    Illinois   Maryland   Michigan   Nevada    
#[8] New Mexico New York   Texas
clusters$city_name[clusters$Cluster==3]
#[1] Colorado      Connecticut   Delaware      Hawaii        Indiana      
#[6] Kansas        Massachusetts Missouri      New Jersey    Ohio         
#[11] Oklahoma      Oregon        Pennsylvania  Rhode Island  Utah         
#[16] Virginia      Washington    Wyoming 
clusters$city_name[clusters$Cluster==4]
#[1] Idaho         Iowa          Kentucky      Maine         Minnesota    
#[6] Montana       Nebraska      New Hampshire North Dakota  South Dakota 
#[11] Vermont       West Virginia Wisconsin   
