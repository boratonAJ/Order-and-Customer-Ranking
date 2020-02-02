import pandas as pd
import numpy as np
import seaborn as sns
import scipy.stats as stats
import matplotlib.pyplot as plt
import pandas.io.sql
import pyodbc
import csv
import xlrd
import click
import os
from xlsx2csv import Xlsx2csv

# ======================== Functions Defined Here ======================

# ===========================================================
'''Convert a Excel file with multiple sheets to several file with one sheet.'''
def getsheets(filepath):
    # !pip install xlsx2csv
    Xlsx2csv(filepath, outputencoding="utf-8").convert("Orders.csv")
    Xlsx2csv(filepath, outputencoding="utf-8").convert("Orders_rank.csv")
    data = 'Orders.csv' # Checking the CSV content
    csv_data = pd.read_csv(data, delimiter = ',')
    for row in csv_data:
        print(row)
        
# ===========================================================
def test_connection(connection):
    # create Connection and Cursor objects
    try:                                 
        if connection.open:
            db_Info = connection.get_server_info()
            print("Connected to MySQL Server version ", db_Info)
            cursor = connection.cursor()
            cursor.execute("select database();")
            record = cursor.fetchone()
            print("You're connected to database: ", record)

    except Error as e:
        print("Error while connecting to MySQL", e)
    finally:
        if connection.open:
            cursor.close()
            connection.close()
            print("MySQL connection is closed")
    print("Connection established successfully")

# ===========================================================
def create_table (create_table_1, create_table_2, con):
    try:
    connection = con
    cursor = connection.cursor()
    cursor.execute(create_table_1)
    cursor.execute(create_table_2)
    print("Table created successfully ")
    
    except pymysql.Error as error:
        print("Failed to create table in MySQL: {}".format(error))
    finally:
        if (connection.open):
            cursor.close()
            connection.close()
            print("MySQL connection is closed")
    print("Table creation established successfully")

# ===========================================================
def get_file_path(filename):
    currentdirpath = os.getcwd()  
    # get current working directory path
    filepath = os.path.join(currentdirpath, filename)
    return filepath

# ===========================================================
def read_customer_order_CSV(filepath, connection):
   with open(filepath, 'rb') as csvfile:
    reader = csv.DictReader(csvfile, delimiter = ',')
    for row in reader:
         # insert into the customer order table the 1st, 2nd column etc of the CSV file into a set called customer order table
        conn = connection 
        sql_statement = """
                            INSERT INTO customer_orders_tb (
                               createdat,
                                orderid,
                                restaurantstatus,
                                paymentmethod,
                                subtotal,
                                customerid,
                                restaurantname,
                                customeraddressprovince,
                                restaurantacceptedat,
                                foodpreparedpromised,
                                podactual
                            ) 
                            VALUES (%s, %s, %s, %s, %s, %s, %s,  %s, %s, %s, %s)
                            """
        cur = conn.cursor()
        cur.executemany(sql_statement,[(str(row['createdat']), str(row['orderid']), str(row['restaurantstatus']),
                                        str(row['paymentmethod']), str(row['subtotal']), str(row['customerid']),
                                        str(row['restaurantname']), str(row['customeraddressprovince']), str(row['restaurantacceptedat']),
                                        str(row['foodpreparedpromised']), str(row['podactual'])
                                       )])
        conn.escape_string(sql_statement)
        conn.commit()
    print(cursor.rowcount, "Inserting into the table are successfully")

# ===========================================================
def read_order_rank_CSV(filepath, connection):
   with open(filepath, 'rb') as csvfile:
    reader = csv.DictReader(csvfile, delimiter = ',')
    for row in reader:
        # print(row['customerid']), str(row['orderid'])
        # insert
        conn = connection 
        sql_statement =  """
                            INSERT INTO customer_orders_rank_tb (
                            customerid,
                            orderid,
                            rank_id) 
                            VALUES (%s, %s, %s)
                            """

        cur = conn.cursor()
        cur.executemany(sql_statement,[(str(row['customerid']), str(row['orderid']), str(row['rank_id']))])
        conn.escape_string(sql_statement)
        conn.commit()
    print(cursor.rowcount, "Inserting into table successfully")
# ===========================================================
    
# ======================= main program =======================================

if __name__ == "__main__":
    sheet_path = get_file_path("tables.xlsx")
    getsheets(sheet_path)
    connection = pymysql.connect(host='127.0.0.1',database='inventory_db',user='XXXXXXXX',password='XXXXXXXX')
    test_connection(connection) # established connection to Database server
    table1 = """  
    CREATE TABLE IF NOT EXISTS customer_orders_rank_tb (
      customerid INT(11) NOT NULL,
      orderid INT(11) NOT NULL,
      rank_id INT(11) NOT NULL,
      PRIMARY KEY (orderid)
      )
    """
    table2 = """
            CREATE TABLE IF NOT EXISTS customer_orders_tb (
              createdat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
              orderid INT(11) NOT NULL,
              restaurantstatus VARCHAR(45),
              paymentmethod VARCHAR(45),
              subtotal DECIMAL(45),
              customerid INT(11) NOT NULL,
              restaurantname VARCHAR(150) ,
              customeraddressprovince VARCHAR(45),
              restaurantacceptedat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
              foodpreparedpromised TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
              podactual TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
              PRIMARY KEY (orderid)
              )
             """
    create_table (table1,table2, connection) # Create the two tables i.e. Orders and Orders_rank
    path_to_customer_orders_csv = get_file_path('Orders.csv') # get path
    path_to_Orders_rank_csv = get_file_path('Orders_rank.csv') # get path
    read_customer_order_CSV(path_to_customer_orders_csv, connection) # read the input file and insert data into customer order table
    read_order_rank_CSV(path_to_Orders_rank_csv, connection) # read the input file and insert into the order rank table
    
    # Refereces
    # 1. https://stackoverflow.com/questions/45800460/how-to-use-mysqldb-is-connected-to-check-an-active-mysql-connection-using-pyth
    # 2. https://stackoverflow.com/questions/51268991/importing-data-from-an-excel-file-using-python-into-sql-server
    # 3. https://pynative.com/install-mysql-connector-python/
# ===========================================================

