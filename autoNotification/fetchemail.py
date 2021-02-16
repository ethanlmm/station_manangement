
import mysql.connector

conn = mysql.connector.connect(host='13.57.100.115', database='sensormanangement', user='root',
                               password='2147483647')
if conn.is_connected(): print("success")
cursor = conn.cursor()


def fetch_email(station_id):
    cursor.execute("select email from administrator where station_id ="+str(station_id))
    for row in cursor.fetchall():
        print(row[0])

