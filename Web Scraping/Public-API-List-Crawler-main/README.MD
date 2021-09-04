# Public-API-List-Crawler

## Steps to run the code:
Download the repository  

- Run [collect_api.py](https://github.com/Chanu-DS/Public-API-List-Crawler/blob/main/get_api/collect_api.py)  

and That's it!!  
Everything is exceuted - from requesting API for a token to storing in Database


### Dependencies
- Microsoft SQL Server 2019
- Python 3.9.6
- Python libraries -[requirements](https://github.com/Chanu-DS/Public-API-List-Crawler/blob/main/get_api/requirements.txt)

## Details of Code:
##### [collect_api.py](https://github.com/Chanu-DS/Public-API-List-Crawler/blob/main/get_api/collect_api.py)-- Need to run only this script.
- executes the api requests and handles the rate limit, time limit of token and crawls all API into a dataframe.  
##### [pd_to_sql.py](https://github.com/Chanu-DS/Public-API-List-Crawler/blob/main/get_api/pd_to_sql.py)  
- takes the dataframe generated and stores it in SQL Server Database with the help of [pyodbc](https://pypi.org/project/pyodbc/) module.  
##### [intsall_required_packages.py](https://github.com/Chanu-DS/Public-API-List-Crawler/blob/main/get_api/install_required_packages.py)
- installs whatever packages listed in -[requirements](https://github.com/Chanu-DS/Public-API-List-Crawler/blob/main/get_api/requirements.txt)



## Details of stored table

One table is stored in SQLServer in the Database called "SQLServerDB" locally.  
Table Name - API_COLLECTION  
No.of Attributes - 5 : API,Link,Description,Auth,HTTPS  

## Goals achieved:
1. Code is implemented using OOPS concepts
2. Handling authentication and token expiration
3. Handling rate limit od accessing the Public API
4. Handling the pagination
5. Crawling all APIs for all categories and storing in a Database

## Number of entries of the table: 525

## If given more time,
- Could've learned more about docker and present a docker image.
    - I've learned about docker and how it works with containers and images in the past few days but getting many errors and there are less resources to understand and solve those errors  
    - Due to the placement time I could not invest more time on this task to work more on docker and could've worked on docker if given more days.
- Try for a much efficient code to reduce the total time taken for execution.
