"""Скрипт для заполнения данными таблиц в БД Postgres."""

import psycopg2
import csv

emp_rows = []
customers_rows = []
order_rows = []
def read_emp_file():
    with open('north_data/employees_data.csv', newline='', encoding='UTF-8') as file:
        rows = csv.reader(file)
        for row in rows:
            row = tuple(row)
            emp_rows.append(row)


def read_customers_file():
    with open('north_data/customers_data.csv', newline='', encoding='UTF-8') as file:
        rows = csv.reader(file)
        for row in rows:
            row = tuple(row)
            customers_rows.append(row)


def read_order_file():
    with open('north_data/orders_data.csv', newline='', encoding='UTF-8') as file:
        rows = csv.reader(file)
        for row in rows:
            row = tuple(row)
            order_rows.append(row)

conn = psycopg2.connect(
    host="localhost",
    database="north",
    user="postgres",
    password='cnmeses'
)
try:
    with conn:
        with conn.cursor() as cur:
            read_emp_file()
            for row in emp_rows:
                if row[0] != 'first_name':
                    cur.execute("INSERT INTO employees (first_name, last_name, title, birth_date, notes) VALUES (%s, %s, %s, %s, %s)", row)
            print('Успех')
            conn.commit()

            read_customers_file()
            for row in customers_rows:
                if row[0] != 'customer_id':
                    cur.execute("INSERT INTO customers VALUES (%s, %s, %s)", row)
            print('Успех')
            conn.commit()

            read_order_file()
            for row in order_rows:
                if row[0] != 'order_id':
                    cur.execute('INSERT INTO "order" VALUES (%s, %s, %s, %s, %s)', row)
            print('Успех')
finally:
    conn.close()


