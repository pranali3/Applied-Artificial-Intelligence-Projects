
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import datetime
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_absolute_error
import multiprocessing
import joblib 


# In[2]:


n_cores = multiprocessing.cpu_count() - 1

train16 = pd.read_csv(r'C:/Users/parbhakar loke/Desktop/kaggle/train_2016_v2.csv', parse_dates=['transactiondate'])   
train17 = pd.read_csv(r'C:/Users/parbhakar loke/Desktop/kaggle/train_2017.csv', parse_dates=['transactiondate'])   
props = pd.read_csv(r'C:/Users/parbhakar loke/Desktop/kaggle/properties_2017.csv')  
samp = pd.read_csv(r'C:/Users/parbhakar loke/Desktop/kaggle/sample_submission.csv')


# In[3]:


props.fillna(-1,inplace=True)

props.loc[props.hashottuborspa != 0, 'hashottuborspa'] = 1 
props.loc[props.fireplaceflag != 0, 'fireplaceflag'] = 1
props.loc[props.taxdelinquencyflag != 0, 'taxdelinquencyflag'] = 1

props['hashottuborspa'] = props['hashottuborspa'].astype(int)
props['fireplaceflag'] = props['fireplaceflag'].astype(int)
props['taxdelinquencyflag'] = props['taxdelinquencyflag'].astype(int)


# In[4]:


for column in props.select_dtypes([object]).columns:
    lbl = LabelEncoder() 
    lbl.fit(list(props[column].values))
    props[column] = lbl.transform(list(props[column].values))


# In[5]:


train_x = pd.concat([train16,train17])
train_x = train_x[train_x.logerror > -0.2] 
train_x = train_x[train_x.logerror < 0.2]


# In[6]:


train_x = train_x.merge(props,how='left',on='parcelid') 
train_x['transaction_year'] = train_x['transactiondate'].dt.year
train_x['transaction_month'] = train_x['transactiondate'].dt.month
train_y = train_x['logerror']
train_x.drop(['parcelid','logerror','transactiondate'],axis=1,inplace=True)
features_used = train_x.columns 


# In[7]:


xtrain, xtest, ytrain, ytest = train_test_split(train_x, train_y, test_size=0.2, random_state=1)

model = GradientBoostingRegressor() 
model.fit(xtrain,ytrain)
ypred = model.predict(xtest)
mean_absolute_error(ytest, ypred)


# In[8]:


submission_df = samp
test = samp.merge(props,how='left',left_on='ParcelId',right_on='parcelid')
test_x = test


# In[9]:


joblib.dump(model, "Zillow.joblib.dat")
#loaded_model = joblib.load("Zillow.joblib.dat")


# In[ ]:


for c in samp.columns[samp.columns != 'ParcelId']:
    date = pd.to_datetime(str(c), format='%Y%m')
    test_x["transaction_year"] = date.year
    test_x["transaction_month"] = date.month
    x_pred = test_x[features_used]
    predict_y = model.predict(x_pred)
    submission_df[c] = predict_y


# In[11]:


submission_df.to_csv('submission.csv', index=False, float_format='%.5g')

