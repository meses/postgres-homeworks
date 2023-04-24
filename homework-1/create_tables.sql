-- SQL-команды для создания таблиц


--Создание БД
CREATE DATABASE north
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

--Создание последовательности для генерации id сотрудников
CREATE SEQUENCE public.employees_emp_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

--Создание таблицы employees
CREATE TABLE public.employees (
	emp_id serial NOT NULL,
	first_name varchar NOT NULL,
	last_name varchar NULL,
	title varchar NULL,
	birth_date date NULL,
	notes text NULL,
	CONSTRAINT employees_pk PRIMARY KEY (emp_id)
);
COMMENT ON TABLE public.employees IS 'Сотрудник';

-- Column comments

COMMENT ON COLUMN public.employees.emp_id IS 'Идентификатор';
COMMENT ON COLUMN public.employees.first_name IS 'Имя';
COMMENT ON COLUMN public.employees.last_name IS 'Фамилия';
COMMENT ON COLUMN public.employees.birth_date IS 'Дата рождения';
COMMENT ON COLUMN public.employees.notes IS 'Заметки';

--Создание таблицы customers
CREATE TABLE public.customers (
	customer_id serial NOT NULL,
	company_name varchar NULL,
	contact_name varchar NULL,
	CONSTRAINT customers_pk PRIMARY KEY (customer_id)
);

-- Column comments

COMMENT ON COLUMN public.customers.customer_id IS 'Идентификатор';
COMMENT ON COLUMN public.customers.company_name IS 'Название компании';
COMMENT ON COLUMN public.customers.contact_name IS 'Имя контактного лица';

--Создание таблицы order
CREATE TABLE public."order" (
	order_id int NOT NULL,
	customer_id varchar NOT NULL,
	employee_id int NULL,
	order_date date NULL,
	ship_city varchar NULL,
	CONSTRAINT order_pk PRIMARY KEY (order_id),
	CONSTRAINT customer_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id),
	CONSTRAINT emp_id_fk FOREIGN KEY (employee_id) REFERENCES public.employees(emp_id)
);
COMMENT ON TABLE public."order" IS 'Заказ';

-- Column comments

COMMENT ON COLUMN public."order".order_id IS 'Идентификатор';
COMMENT ON COLUMN public."order".customer_id IS 'Заказчик';
COMMENT ON COLUMN public."order".employee_id IS 'Сотрудник';
COMMENT ON COLUMN public."order".order_date IS 'Дата заказа';
COMMENT ON COLUMN public."order".ship_city IS 'Город доставки';
