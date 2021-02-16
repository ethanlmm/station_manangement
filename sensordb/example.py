# Insert from dataframe to table in SQL Server
import time
import pandas as pd
import pyodbc

# create timer
start_time = time.time()
from sqlalchemy import create_engine


df = pd.read_csv("C:\\your_path_here\\CSV1.csv")

conn_str = (
    r'DRIVER={SQL Server Native Client 11.0};'
    r'SERVER=Excel-Your_Server_Name;'
    r'DATABASE=NORTHWND;'
    r'Trusted_Connection=yes;'
)
cnxn = pyodbc.connect(conn_str)

cursor = cnxn.cursor()

for index,row in df.iterrows():
    cursor.execute('INSERT INTO dbo.Table_1([Name],[Address],[Age],[Work]) values (?,?,?,?)',
                    row['Name'],
                    row['Address'],
                    row['Age'],
                    row['Work'])
    cnxn.commit()
cursor.close()
cnxn.close()