library("arules")
library("arulesViz")

#loading dataset book

groceries<-read.transactions("G:\\download_vb\\Assignement\\Association rules\\groceries.csv",sep=",")
head(groceries)
tData<-as(groceries,"transactions")

#simple use of apriori

rules<-apriori(groceries)
summary(rules)
arules::inspect(rules)

#Sorting based on lift

rules.sorted<-sort(rules,by="lift")
arules::inspect(rules.sorted)



rules <- apriori (groceries, parameter = list(supp = 0.001, conf = 0.5))
arules::inspect(rules)

#confidence and support for Consequent=[yogurt] and Antecendent=[whole milk] by Conf= (A/C)/A and support= (A/C)/T as well as plottings

rules<-apriori(groceries,parameter = list(supp=0.001,conf=0.1,minlen=2),
               appearance = list(rhs="yogurt",lhs="whole milk"),control =list(verbose=F))
arules::inspect(rules)
windows()
plot(rules,method = "scatterplot")
plot(rules,method = "grouped")
plot(rules,method = "graph")


##confidence and support for Consequent=["GeogBks=1"] and Antecendent=[default all of the columns] by Conf= (A/C)/A and support= (A/C)/T as well as plottings

rules<-apriori(groceries,parameter = list(supp=0.001,conf=0.5,maxlen=3),
               appearance = list(rhs="yogurt",default="lhs"),control = list(verbose=F))
rules.sorted<-sort(rules,by="lift")
arules::inspect(rules.sorted)

windows()
plot(rules,method = "scatterplot")
plot(rules,method = "grouped")
plot(rules,method = "graph")

