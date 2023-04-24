-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select c.company_name, CONCAT(first_name, ' ', last_name) as emp_name from customers c
join orders o on c.customer_id = o.customer_id
join employees e on o.employee_id = e.employee_id
join shippers s on s.shipper_id = o.ship_via
where s.company_name = 'United Package' and e.city = 'London' and c.city = 'London'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select product_name, units_in_stock, s.contact_name, s.phone from products p
join suppliers s on p.supplier_id = s.supplier_id
join categories c on p.category_id = c.category_id
where p.discontinued = 0 and units_in_stock < 25 and c.category_name in ('Dairy Products', 'Condiments')
order by units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name from customers c
where c.customer_id not in (select distinct customer_id from orders o)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select distinct p.product_name from products p
join order_details od on p.product_id = od.product_id
where od.quantity = 10