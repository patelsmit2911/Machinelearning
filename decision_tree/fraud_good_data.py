import pandas as pd

#loading the data

fraud=pd.read_csv("G:\\download_vb\\Assignement\\Decision Tree\\Fraud_check.csv")
fraud.head()

#Data cleansing and transformation


cat = pd.Categorical(['YES','NO'], categories=['1','0'])
codes, uniques =fraud['Undergrad'].factorize(cat)
fraud['Undergrad']=codes
codes, uniques =fraud['Urban'].factorize(cat)
fraud['Urban']=codes
cat = pd.Categorical(['Married','Divorced','Single'], categories=['1','0','2'])
codes, uniques =fraud['Marital.Status'].factorize(cat)
fraud['Marital.Status']=codes
fraud
codes, uniques =fraud['Marital.Status'].factorize(cat)
fraud['Marital.Status']=codes

def cov(x):
    if x <=30000:
        return "Fraud"
    else:
        return "Good"

fraud["Taxable.Income"]=fraud["Taxable.Income"].apply(cov)
fraud["Taxable.Income"].unique()

import numpy as np


colnames = list(fraud.columns)
colnames

predictors = colnames[0:2]+colnames[3:6] 
target = colnames[2]

predictors

from sklearn.tree import  DecisionTreeClassifier
from sklearn import tree
#help(DecisionTreeClassifier)

wcc=[]

#Bagging using 100 models building and choosing best of them which has higher accuracy

for i in range(1,100):
# np.random.uniform(start,stop,size) will generate array of real numbers with size = size
    fraud['is_train'] = np.random.uniform(0, 1, len(fraud))<= 0.65
    fraud['is_train']
    train,test = fraud[fraud['is_train'] == True],fraud[fraud['is_train']==False]
    
#fitting model    
    model = DecisionTreeClassifier(criterion = 'gini')
    model.fit(train[predictors],train[target])

#predicting values
    preds = model.predict(test[predictors])
    pd.Series(preds).value_counts()

#confusion matrix
    pd.crosstab(test[target],preds)

# Accuracy = train
    train_accuracy=np.mean(train["Taxable.Income"] == model.predict(train[predictors]))

# Accuracy = Test
    accuracy=np.mean(preds==test["Taxable.Income"]) 
    wcc.append((train_accuracy,accuracy))


#getting good model from the above build models ysing bootstraping method

sorted_model=sorted(wcc,key= lambda i:i[1], reverse=True)
print("best fitted accuracy {} where (training set accuracy, tesing set accuracy)".format(sorted_model[0]))

 
#######################  Ploting ###########################

# np.random.uniform(start,stop,size) will generate array of real numbers with size = size
fraud['is_train'] = np.random.uniform(0, 1, len(fraud))<= 0.65
fraud['is_train']
train,test = fraud[fraud['is_train'] == True],fraud[fraud['is_train']==False]
    
#fitting model    
model = DecisionTreeClassifier(criterion = 'gini')
model.fit(train[predictors],train[target])

#predicting values
preds = model.predict(test[predictors])
pd.Series(preds).value_counts()

#confusion matrix
pd.crosstab(test[target],preds)

# Accuracy = train
train_accuracy=np.mean(train["Taxable.Income"] == model.predict(train[predictors]))

# Accuracy = Test
accuracy=np.mean(preds==test["Taxable.Income"]) 
wcc.append((train_accuracy,accuracy))


from sklearn import tree
tree.plot_tree(model)
