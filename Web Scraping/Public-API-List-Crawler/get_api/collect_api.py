import install_required_packages
from datetime import datetime
import time
import requests
import json
import pandas as pd
import pd_to_sql

class get_api:
  def __init__(self):
    self.initial=datetime.now()
    self.start_time=0
    self.cat_count=0
    self.flag=1
  def cat_fetch(self,tok,page):
    categories_list=[]
    payload={}
    headers = {'Authorization': 'Bearer '+tok}

    category_link=f'https://public-apis-api.herokuapp.com/api/v1/apis/categories?page={page}'
          
    response=requests.get(category_link,headers=headers,data=payload).json()
    if self.flag==1:
      self.cat_count=response['count']
      self.flag=self.flag-1
    if len(response['categories'])==0:
      return
    for i in response['categories']:
      categories_list.append(i)
      
    return categories_list

  def get_token(self):
    
    api_url="https://public-apis-api.herokuapp.com/api/v1/auth/token"
    self.token=requests.get(api_url).text[10:-2]
    self.start_time=datetime.now()
    return self.token 
  def get_timediff(self):
    return (datetime.now()-self.start_time).total_seconds()


  def api_run(self):
    payload={}
    headers = {'Authorization': 'Bearer '+self.get_token()}
    name=[]
    link=[]

    j=1
    while j<=10:
      
      for cat in self.cat_fetch(self.token,j):
        request_count=0

        if self.cat_count==0:
          break
        time.sleep(6)

        count=0
        items_added=0

        k=1
        while k<=10:      
          if self.get_timediff()<295:
            url = f"https://public-apis-api.herokuapp.com/api/v1/apis/entry?page={k}&category={cat}"

            response = requests.request("GET", url, headers=headers, data=payload).json()
          
            count=response['count']
            
            for i in response['categories']:         
              
              name.append(i['API'])

              link.append(i['Link'])
              print('.',end=' ')
              
            items_added+=len(response['categories'])
            request_count+=1
            if count==items_added:
              print(f'Total item Count in [{cat}]: {count}= items added: {items_added}')
              break      
            time.sleep(6)
            k+=1
            
          else:
            headers = {'Authorization': 'Bearer '+self.get_token()}
          #------------------------------------------------------------------
        print(f'[{cat}] STORED | ITEMS:{count} | TOTAL REQUESTS:{request_count} | TOTAL ITEMS added ={len(name)} | Time left for token[to expire]={300-self.get_timediff()}')
        print('\n')
        self.cat_count-=1
        #---------------------------------------------------------------------
      if self.cat_count==0:
          break
      j+=1
            
    name_link_df=pd.DataFrame({'API_Name':name,'Link':link})
    print(f'Total time taken for this Operation :{(datetime.now()-self.initial).total_seconds()} seconds')
    print(name_link_df)
    return name_link_df

  
api_collector=get_api()
api_dataframe=api_collector.api_run()
pd_to_sql.transfer_to_DB(api_dataframe)
