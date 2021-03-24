import psycopg2
from faker import Faker
from random import randint
import time


def connect_to_db(dbname, user, password):
    # Connect to an existing database
    con = psycopg2.connect(f"dbname={dbname} user={user} password={password}")

    # Open a cursor to perform database operations
    cursor = con.cursor()
    return con, cursor


def close_communication(cur, num_rows):
    # Close communication with the database
    cur.close()
    conn.close()


def add_Customers(cur,num_rows):
    fake = Faker()
    for i in range(num_rows):
        random_num = randint(100000, 10000000)
        random_name = fake.first_name()
        random_last_name = fake.last_name()
        random_address = fake.address()
        random_phone = randint(100000, 10000000)
        current_row_to_insert = (random_num, random_name,random_last_name,random_address,random_phone)
        cur.execute("INSERT INTO Custumers VALUES (%s, %s,%s,%s,%s)", current_row_to_insert)

def stock_check(cur):
    cur.execute("select * from products where number_in_stock < 5")
    low_stock = cur.fetchall()
    for product in low_stock:
        id,name,desc,price,num,sup,comp = product
        print("product number " , id , "needs stock renew")

conn, cur = connect_to_db("test_database", "tester", "test_password")
add_Customers(cur,50)
conn.commit()
stock_check(cur)
conn.commit()
close_communication(cur, conn)