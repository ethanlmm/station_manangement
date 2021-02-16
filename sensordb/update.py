from time import sleep

import mysql.connector
from commands import *
from util import *

uploadtimer=timer(timedelta(minutes=10))
import datetime
conn=mysql.connector.connect(host='localhost',database='test',user='root',password='2147483647')
if conn.is_connected(): print("success")
cursor =conn.cursor()



while True:
    val1 = ( datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),"0000000001",)
    cursor.execute(update_status, val1)
    val2 = (datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),"0000000002")
    cursor.execute(update_status, val2)
    val3 = (datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),"0000000003")
    cursor.execute(update_status, val3)

    conn.commit()
    print(cursor.rowcount, "record inserted.")



print(cursor.rowcount, "record inserted.")