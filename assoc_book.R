library("arules")
library("arulesViz")

#loading dataset book

book<-read.csv("G:\\download_vb\\Assignement\\Association rules\\book.csv")
View(book)

# finding if we have any null values in  book data frame

is.null(book)

#convert data into categorical using factor in for loop for all columns
for(i in 1:ncol(book)){
  
  book[,i] <- as.factor(book[,i])
  
}


#simple use of apriori

rules<-apriori(book)
summary(rules)
arules::inspect(rules)

#Sorting based on lift

rules.sorted<-sort(rules,by="lift")
arules::inspect(rules.sorted)

#confidence and support for Consequent=[ChildBks=1] and Antecendent=[YouthBks=1] by Conf= (A/C)/A and support= (A/C)/T as well as plottings

rules<-apriori(book,parameter = list(supp=0.01,conf=0.1),
               appearance = list(rhs=c("ChildBks=1"),lhs=c("YouthBks=1")),control = list(verbose=F))
arules::inspect(rules)
windows()
plot(rules,method = "scatterplot")
plot(rules,method = "grouped")
plot(rules,method = "graph")



# Manual finding confidence for Consequent=[ChildBks=1] and Antecendent=[YouthBks=1] by Conf= (A/C)/A
book.finding<-book$ChildBks==1 & book$YouthBks==1
book.finding
A.C=xtabs(~book.finding)
A=xtabs(~book$YouthBks)
confi=(A.C)/A
confi
#output--->0.6666667

# Manual finding support for Consequent=[ChildBks=1] and Antecendent=[YouthBks=1] by support= (A/C)/T

supp=(A.C)/2000
supp
#output---->0.165

##confidence and support for Consequent=["GeogBks=1"] and Antecendent=[default all of the columns] by Conf= (A/C)/A and support= (A/C)/T as well as plottings

rules<-apriori(book,parameter = list(supp=0.2,conf=0.1,minlen=3),
               appearance = list(rhs=c("GeogBks=1"),default="lhs"),control = list(verbose=F))
rules.sorted<-sort(rules,by="lift")
arules::inspect(rules.sorted)

windows()
plot(rules,method = "scatterplot")
plot(rules,method = "grouped")
plot(rules,method = "graph")

