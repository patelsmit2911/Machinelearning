import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
%matplotlib inline

#loading the data
company=pd.read_csv("G:\\download_vb\\Assignement\\Decision Tree\\Company_Data.csv")
company.head()


###### plotings and observation ##########

fig, ax = plt.subplots(figsize=(10,5), ncols=2, nrows=3)

sns.boxplot(x="Sales",data=company, palette="Set3",ax=ax[0][0])
sns.distplot(company["Sales"],ax=ax[0][1])        #### data is normally distributed

sns.boxplot(x="Price",data=company, palette="Set2",ax=ax[1][0])
sns.distplot(company["Price"],ax=ax[1][1])       #### data is normaly distributed

sns.boxplot(x="Population",data=company, palette="Set2",ax=ax[2][0])
sns.distplot(company["Population"],ax=ax[2][1])   ####negative kurtosis we can find here


#data cleansing and transformation

cat = pd.Categorical(['Bad','Good','Medium'], categories=[0,1,2])
codes, uniques =company['ShelveLoc'].factorize(cat)
company['ShelveLoc']=codes
cat = pd.Categorical(['Yes','No'], categories=[0,1])
codes, uniques =company['Urban'].factorize(cat)
company['Urban']=codes
cat = pd.Categorical(['Yes','No'], categories=[0,1])
codes, uniques =company['US'].factorize(cat)
company['US']=codes


company.describe()  ### to check which limit should be taken to define range for sales

#Converting Sales as category type

def cov(x):
    if x <=9 and x>4:
        return "average"
    elif(x>9):
        return "higher"
    else:
        return "lower"
        
company['Sales']=company['Sales'].apply(cov)


import numpy as np

colnames = list(company.columns)
print(colnames)
predictors=colnames[1:]
target=colnames[0]
print("pedictors:{}".format(predictors))
print("target:{}".format(target))

from sklearn.tree import DecisionTreeClassifier
from sklearn import tree


company['is_train']=np.random.uniform(0,1,len(company))<=0.65
train,test=company[company['is_train']==True],company[company['is_train']==False]
    
print('training data {}'.format(train['Sales'].count()))
print('testing data {}' .format(test['Sales'].count()))
    
#fitting model    
model = DecisionTreeClassifier(criterion = 'entropy')
model.fit(train[predictors],train[target])

#predicting values
preds = model.predict(test[predictors])
pd.Series(preds).value_counts()

#confusion matrix
pd.crosstab(test[target],preds)

# Accuracy = train
train_accuracy=np.mean(train[target]==model.predict(train[predictors]))

# Accuracy = Test
test_accuracy=np.mean(test[target]==preds)

# Accuracy = Test
accuracy=np.mean(preds==test["Sales"]) 
wcc.append((train_accuracy,test_accuracy))

#ploting

from sklearn import tree
tree.plot_tree(model) 


################################################ multiple run using bagging method ###################

wcc=[]

for i in range(1,100):

    company['is_train']=np.random.uniform(0,1,len(company))<=0.65
    train,test=company[company['is_train']==True],company[company['is_train']==False]
    
    #print('training data {}'.format(train['Sales'].count()))
    #print('testing data {}' .format(test['Sales'].count()))
    
#fitting model    
    model = DecisionTreeClassifier(criterion = 'entropy')
    model.fit(train[predictors],train[target])
#predicting values
    preds = model.predict(test[predictors])
    pd.Series(preds).value_counts()
#confusion matrix
    pd.crosstab(test[target],preds)
# Accuracy = train
    train_accuracy=np.mean(train[target]==model.predict(train[predictors]))
# Accuracy = Test
    test_accuracy=np.mean(test[target]==preds)
# Accuracy = Test
    accuracy=np.mean(preds==test["Sales"]) 
    wcc.append((train_accuracy,test_accuracy))

sorted_model=sorted(wcc,key= lambda i:i[1], reverse=True)
print("best fitted accuracy {} where (training set accuracy, tesing set accuracy)".format(sorted_model[0]))



