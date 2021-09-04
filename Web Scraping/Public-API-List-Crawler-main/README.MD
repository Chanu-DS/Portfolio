# Public-API-List-Crawler
This is a Web Scraping Project without actually parsing HTML files with libraries such as BeautifulSoup in Python.  
Rather, it uses the Public API -[Documentation Link](https://documenter.getpostman.com/view/4796420/SzmZczsh?version=latest) to request for the Data of various Public APIs available - [Link](https://github.com/public-apis/public-apis)  

In this project, I crawled out all the API links available [in this repository](https://github.com/public-apis/public-apis) of Public APIs and Stored it in a Local DataBase.  

You can use this code with a few changes in the [pd_to_sql.py](https://github.com/Chanu-DS/Portfolio/blob/main/Web%20Scraping/Public-API-List-Crawler-main/get_api/pd_to_sql.py) file:  
- Changing the Server Name, Database name, Driver Name(which server you would use)  

Then you're ready to run this and crawl all the APIs Links into your local database.  
This kind of projects are so helpful in making us understand the real world data engineering and apply the same skills in future projects.  


## Steps to run the code:
Download the repository  

- Run [collect_api.py](https://github.com/Chanu-DS/Portfolio/blob/main/Web%20Scraping/Public-API-List-Crawler-main/get_api/collect_api.py)  

and That's it!!  
Everything is exceuted - from requesting API for a token to storing in Database


### Dependencies
- Microsoft SQL Server 2019
- Python 3.9.6
- Python libraries -[requirements](https://github.com/Chanu-DS/Portfolio/blob/main/Web%20Scraping/Public-API-List-Crawler-main/get_api/requirements.txt)

## Details of Code:
##### [collect_api.py](https://github.com/Chanu-DS/Portfolio/blob/main/Web%20Scraping/Public-API-List-Crawler-main/get_api/collect_api.py)-- Need to run only this script.
- executes the api requests and handles the rate limit, time limit of token and crawls all API into a dataframe.  
##### [pd_to_sql.py](https://github.com/Chanu-DS/Portfolio/blob/main/Web%20Scraping/Public-API-List-Crawler-main/get_api/pd_to_sql.py)  
- takes the dataframe generated and stores it in SQL Server Database with the help of [pyodbc](https://pypi.org/project/pyodbc/) module.  
##### [intsall_required_packages.py](https://github.com/Chanu-DS/Portfolio/blob/main/Web%20Scraping/Public-API-List-Crawler-main/get_api/install_required_packages.py)
- installs whatever packages listed in -[requirements](https://github.com/Chanu-DS/Portfolio/blob/main/Web%20Scraping/Public-API-List-Crawler-main/get_api/requirements.txt)



## Details of stored table

One table is stored in SQLServer in the Database called "SQLServerDB" locally.  
Table Name - API_COLLECTION  
No.of Attributes - 5 : API,Link,Description,Auth,HTTPS  


