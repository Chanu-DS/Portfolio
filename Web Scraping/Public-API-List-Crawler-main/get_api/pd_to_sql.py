import pyodbc
import pandas

def transfer_to_DB(df):
    
    server = 'CHANUKYA\SQLEXPRESS' 
    database = 'SQLServerDB' 

    conn = pyodbc.connect('Driver={ODBC Driver 17 for SQL Server};'
                        'Server=CHANUKYA\SQLEXPRESS;'
                        'Database=SQLServerDB;'
                        'Trusted_Connection=yes;')


    cursor = conn.cursor()

    cursor.execute('''
            
            DROP TABLE IF EXISTS API_COLLECTION;
            
            CREATE TABLE API_COLLECTION(
            API_Name NVARCHAR(255) NOT NULL,
            Link NVARCHAR(255) NOT NULL,
            Description NVARCHAR(255) NOT NULL,
            Auth VARCHAR(50) not null,
            HTTPS VARCHAR(50) NOT NULL);
    ''')

    conn.commit()
    
    for index,row in df.iterrows():
        cursor.execute("INSERT INTO dbo.API_COLLECTION([API_Name],[Link],[Description],[Auth],[HTTPS]) values (?, ?, ?, ?, ?)", row['API_Name'], row['Link'],row['Description'],row['Auth'],row['HTTPS']) 
        conn.commit()
    cursor.close()
    conn.close()
    print('\n')
    print("Data successfully transefered to SQL database locally in Microsoft SQL Server 2019")
