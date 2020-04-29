library("arules")
library("arulesViz")

#loading dataset book

movies<-read.csv("G:\\download_vb\\Assignement\\Association rules\\my_movies.csv")
movies<-movies[,6:15]
head(movies)


#convert data into categorical using factor in for loop for all columns
for(i in 1:ncol(movies)){
  
  movies[,i] <- as.factor(movies[,i])
  
}


#simple use of apriori

rules<-apriori(movies)
summary(rules)
arules::inspect(rules)

#Sorting based on lift ratio

rules.sorted<-sort(rules,by="lift")
arules::inspect(rules.sorted)

#confidence and support for Consequent=[Gladiator=1] and Antecendent=[Patriot=1] by Conf= (A/C)/A and support= (A/C)/T as well as plottings

rules<-apriori(movies,parameter = list(supp=0.5,conf=0.1),
               appearance = list(rhs=c("Gladiator=1"),lhs=c("Patriot=1")),control = list(verbose=F))
arules::inspect(rules)
windows()
plot(rules,method = "scatterplot")
plot(rules,method = "grouped")
plot(rules,method = "graph")



# Manual finding confidence for Consequent=[Gladiator=1] and Antecendent=[Patriot=1] by Conf= (A/C)/A
movies.finding<-movies$Gladiator==1 & movies$Patriot==1
movies.finding
A.C=xtabs(~movies.finding)
A=xtabs(~movies$Patriot)
confi=(A.C)/A
confi
#output--->1

# Manual finding support for Consequent=[Gladiator=1] and Antecendent=[Patriot=1] by support= (A/C)/T

supp=(A.C)/10
supp
#output---->0.6

##confidence and support for Consequent=["Gladiator=1"] and Antecendent=[default all of the columns] by Conf= (A/C)/A and support= (A/C)/T as well as plottings

rules<-apriori(movies,parameter = list(supp=0.5,conf=0.9,minlen=4),
               appearance = list(rhs=c("Gladiator=1"),default="lhs"),control = list(verbose=F))
rules.sorted<-sort(rules,by="lift")
arules::inspect(rules.sorted)

windows()
plot(rules,method = "scatterplot")
plot(rules,method = "grouped")
plot(rules,method = "graph")



#######################################################################################
# Using only names in dataset
#######################################################################################

library("arules")
library("arulesViz")

#loading dataset book

movies<-read.csv("G:\\download_vb\\Assignement\\Association rules\\my_movies.csv")
movies<-movies[,1:5]
head(movies)


#simple use of apriori

rules<-apriori(movies)
summary(rules)
arules::inspect(rules)

#Sorting based on lift ratio

rules.sorted<-sort(rules,by="lift")
arules::inspect(rules.sorted)


##confidence and support for Consequent=["V1=Gladiator"] and Antecendent=[default all of the columns] by Conf= (A/C)/A and support= (A/C)/T as well as plottings

rules<-apriori(movies,parameter = list(supp=0.5,conf=0.9,minlen=2),
               appearance = list(rhs=c("V1=Gladiator"),default="lhs"),control = list(verbose=F))
rules.sorted<-sort(rules,by="lift")
arules::inspect(rules.sorted)

windows()
plot(rules,method = "scatterplot")
plot(rules,method = "grouped")
plot(rules,method = "graph")
