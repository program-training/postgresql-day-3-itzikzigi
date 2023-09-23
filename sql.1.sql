-- Active: 1694679804202@@127.0.0.1@5432@northwind
--1
SELECT first_name || last_name AS employee_name ,COUNT (*) 
FROM employees JOIN orders 
ON employees.employee_id = orders.employee_id
GROUP BY employee_name

--2 
SELECT category_name ,COUNT(*) AS total_sales
FROM categories JOIN products
ON categories.category_id = products.category_id
JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY category_name

--3
WITH sum_of AS (SELECT SUM(unit_price*(1-discount)*quantity) AS res, order_id 
FROM order_details 
GROUP BY order_id)
SELECT contact_name AS customer_name , ROUND(AVG(sum_of.res)) AS average
FROM customers JOIN orders
ON customers.customer_id = orders.customer_id
JOIN sum_of
ON orders.order_id = sum_of.order_id
GROUP BY customer_name
ORDER BY average DESC



--4
SELECT contact_name , ROUND(SUM(unit_price*(1-discount)*quantity)) AS total_spending
FROM customers JOIN orders
ON customers.customer_id = orders.customer_id
JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY customers.customer_id
ORDER BY total_spending DESC
LIMIT 10

--5
SELECT ROUND(SUM(unit_price*(1-discount)*quantity)) AS total_per_month, EXTRACT(MONTH FROM order_date) AS month
FROM order_details JOIN orders 
ON orders.order_id = order_details.order_id
GROUP BY month
ORDER BY month

--6
SELECT product_name ,  units_in_stock 
FROM products
WHERE units_in_stock < 10
ORDER BY units_in_stock DESC

--7
SELECT contact_name , SUM(quantity) AS order_amount
FROM order_details JOIN orders 
ON order_details.order_id = orders.order_id
JOIN customers 
ON orders.customer_id = customers.customer_id
GROUP BY contact_name
ORDER BY order_amount DESC
LIMIT 1

--8
SELECT ship_country AS country, ROUND(SUM(unit_price*(1-discount)*quantity))AS revenue
FROM orders JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY country
ORDER BY country

--9
SELECT company_name, COUNT(ship_via) AS total
FROM shippers JOIN orders
ON shippers.shipper_id = orders.ship_via
GROUP BY company_name
ORDER BY total DESC 
LIMIT 1

--10
SELECT product_name ,COUNT (order_id) AS total 
FROM products RIGHT OUTER JOIN order_details
ON products.product_id = order_details.product_id
WHERE(SELECT COUNT(order_id) FROM order_details)=0
GROUP BY product_name
ORDER BY total


