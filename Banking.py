#!/usr/bin/env python
# coding: utf-8

# In[339]:


import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')

#loadning data

banking=pd.read_csv("G:\\download_vb\\Assignement\\\Logistic Rgression\\bank-full.csv",sep=';')

banking.head()
banking.info()

###### plottings and observation ##########

fig, ax = plt.subplots(figsize=(40,70),ncols=2, nrows=7)

sns.countplot(x="job",data=banking,palette="hls",ax=ax[0][0])
pd.crosstab(banking.job,banking.y).plot(kind="bar",ax=ax[0][1])
plt.tight_layout()
sns.countplot(x="marital",data=banking,palette="hls",ax=ax[1][0])
pd.crosstab(banking.marital,banking.y).plot(kind="bar",ax=ax[1][1])
plt.tight_layout()
sns.countplot(x="education",data=banking,palette="hls",ax=ax[2][0])
pd.crosstab(banking.education,banking.y).plot(kind="bar",ax=ax[2][1])
plt.tight_layout()
sns.countplot(x="housing",data=banking,palette="hls",ax=ax[3][0])
pd.crosstab(banking.housing,banking.y).plot(kind="bar",ax=ax[3][1])
plt.tight_layout()
sns.countplot(x="loan",data=banking,palette="hls",ax=ax[4][0])
pd.crosstab(banking.loan,banking.y).plot(kind="bar",ax=ax[4][1])
plt.tight_layout()
sns.countplot(x="contact",data=banking,palette="hls",ax=ax[5][0])
pd.crosstab(banking.contact,banking.y).plot(kind="bar",ax=ax[5][1])
plt.tight_layout()
sns.countplot(x="month",data=banking,palette="hls",ax=ax[6][0])
pd.crosstab(banking.month,banking.y).plot(kind="bar",ax=ax[6][1])
plt.tight_layout()


# coversion to numerical factor for categorical data type


cat = pd.Categorical(["admin.","unknown","unemployed","management","housemaid","entrepreneur","student","blue-collar","self-employed","retired","technician","services"])
codes, uniques =banking['job'].factorize(cat)
banking['job']=codes
cat = pd.Categorical(["married","divorced","single"])
codes, uniques =banking['marital'].factorize(cat)
banking['marital']=codes
cat = pd.Categorical(["unknown","secondary","primary","tertiary"])
codes, uniques =banking['education'].factorize(cat)
banking['education']=codes
cat = pd.Categorical(["yes","no"])
codes, uniques =banking['default'].factorize(cat)
banking['default']=codes
cat = pd.Categorical(["yes","no"])
codes, uniques =banking['housing'].factorize(cat)
banking['housing']=codes
cat = pd.Categorical(["yes","no"])
codes, uniques =banking['loan'].factorize(cat)
banking['loan']=codes
cat = pd.Categorical(["unknown","telephone","cellular"])
codes, uniques =banking['contact'].factorize(cat)
banking['contact']=codes
cat = pd.Categorical(["jan", "feb", "mar","apr","may","jun","jul","aug","sep","oct","nov", "dec"])
codes, uniques =banking['month'].factorize(cat)
banking['month']=codes
cat = pd.Categorical([ "unknown","other","failure","success"])
codes, uniques =banking['poutcome'].factorize(cat)
banking['poutcome']=codes
cat = pd.Categorical([ "yes","no"])
codes, uniques =banking['y'].factorize(cat)
banking['y']=codes
    
banking.head()  ## data  after changing to categorical data
    
banking.describe()## data description

sns.pairplot(banking) ## pai plotting

banking.corr()  ## correlation between data

# Boxplot to check outliers and data distribution

colnames=list(banking.columns)
fig, ax = plt.subplots(figsize=(40,40),ncols=2, nrows=9)

sns.boxplot(data=banking[colnames[0]],palette="hls",ax=ax[0][0]) 
sns.boxplot(data=banking[colnames[1]],palette="hls",ax=ax[0][1])
sns.boxplot(data=banking[colnames[2]],palette="hls",ax=ax[1][0])
sns.boxplot(data=banking[colnames[3]],palette="hls",ax=ax[1][1])
sns.boxplot(data=banking[colnames[4]],palette="hls",ax=ax[2][0])
sns.boxplot(data=banking[colnames[5]],palette="hls",ax=ax[2][1])
sns.boxplot(data=banking[colnames[6]],palette="hls",ax=ax[3][0])
sns.boxplot(data=banking[colnames[7]],palette="hls",ax=ax[3][1])
sns.boxplot(data=banking[colnames[8]],palette="hls",ax=ax[4][0])
sns.boxplot(data=banking[colnames[9]],palette="hls",ax=ax[4][1])
sns.boxplot(data=banking[colnames[10]],palette="hls",ax=ax[5][0])
sns.boxplot(data=banking[colnames[11]],palette="hls",ax=ax[5][1])
sns.boxplot(data=banking[colnames[12]],palette="hls",ax=ax[6][0])
sns.boxplot(data=banking[colnames[13]],palette="hls",ax=ax[6][1])
sns.boxplot(data=banking[colnames[14]],palette="hls",ax=ax[7][0])
sns.boxplot(data=banking[colnames[15]],palette="hls",ax=ax[7][1])
sns.boxplot(data=banking[colnames[16]],palette="hls",ax=ax[8][0])

        
# To get the count of null values in the data 

banking.isnull().sum()


#importing libraries

from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split 
from sklearn.metrics import classification_report

# data splitting in training and testing set

X_train, X_test, y_train, y_test = train_test_split(banking.drop('y',axis=1), 
                                                    banking['y'], test_size=0.30, 
                                                    random_state=101)

# building model


classifier = LogisticRegression()
classifier.fit(X_train,y_train)

intercept=classifier.intercept_
coef=np.exp(classifier.coef_)



# predicting test values

predictions=classifier.predict(X_test)

# Anlysis of accuracy 

print(classification_report(y_test,predictions))

# confusion metrics

from sklearn.metrics import confusion_matrix
confusion_matrix = confusion_matrix(y_test,predictions)
print("confusion metrics \n {}".format(confusion_matrix))
sensitivity=confusion_matrix[0,0]/(confusion_matrix[0,0]+ confusion_matrix[1,0])
specificity=confusion_matrix[1,1]/(confusion_matrix[0,1]+ confusion_matrix[1,1])

print("\nsensitivity = {}".format(sensitivity))
print("specificity = {}".format(specificity))

# accuracy at training data
print( "\naccuracy at training data = {}".format(np.mean(y_train==classifier.predict(X_train)))) # 0.8864031345783171
# accracy at testing data
print( "accuracy at testing data = {}".format(np.mean(y_test==predictions))) # 0.8889708050722501

# ROC plotting

from sklearn.metrics import roc_auc_score
from sklearn.metrics import roc_curve

logit_roc_auc = roc_auc_score(y_test, classifier.predict(X_test))
fpr, tpr, thresholds = roc_curve(y_test, classifier.predict_proba(X_test)[:,1])
plt.figure()
plt.plot(fpr, tpr, label='Logistic Regression (area = %0.2f)' % logit_roc_auc)
plt.plot([0, 1], [0, 1],'r--')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic')
plt.legend(loc="lower right")
plt.savefig('Log_ROC')
plt.show()


# In[ ]:



    

            


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




