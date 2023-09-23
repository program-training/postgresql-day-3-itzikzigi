--1
WITH counter AS (SELECT COUNT(order_id) AS count_orders, customer_id 
FROM orders
GROUP BY customer_id)
SELECT contact_name, count_orders
FROM CUSTOMERS , counter
WHERE counter.count_orders = 0 
AND counter.customer_id = customers.customer_id

--2
WITH order_count AS (SELECT COUNT(customer_id) AS counter, customer_id 
FROM orders
GROUP BY customer_id)
SELECT contact_name , counter
FROM customers 
JOIN order_count 
ON customers.customer_id = order_count.customer_id
WHERE counter > 10
ORDER BY contact_name 

--3
WITH avg_price AS (SELECT AVG(unit_price) AS average FROM products)
SELECT product_name, unit_price
FROM products, avg_price
WHERE unit_price > avg_price.average
ORDER BY unit_price

--4
SELECT product_name, count(order_details.product_id) AS counter
FROM products JOIN order_details
ON products.product_id = order_details.product_id
JOIN orders 
ON orders.order_id  = order_details.order_id
GROUP BY product_name
HAVING COUNT(order_details.product_id) = 0 

--5
WITH country_count AS (SELECT COUNT(country) AS counter,country FROM customers GROUP BY country)
SELECT country, counter
FROM country_count 
WHERE counter > 5
ORDER BY counter

--6 
WITH order_count AS (SELECT customer_id, order_date,order_id 
FROM orders WHERE EXTRACT(YEAR FROM order_date)= '1998')
SELECT contact_name, customers.customer_id
FROM customers , order_count
WHERE customers.customer_id = order_count.customer_id
AND customers.customer_id NOT IN (order_count.customer_id)


--7
SELECT company_name, country 
FROM customers 
WHERE country = 'Germany'
AND customer_id NOT IN 
(SELECT customer_id 
 FROM orders
 WHERE order_date>'1998-01-01')

--8
WITH order_count AS 
(SELECT COUNT(order_id) AS counter ,customer_id
 FROM orders 
 GROUP BY customer_id)
SELECT contact_name, counter
FROM customers JOIN order_count 
ON customers.customer_id = order_count.customer_id
WHERE counter  = 3

--9
SELECT MAX(product_id)
FROM products

--10
SELECT company_name 
FROM suppliers
WHERE country = 'USA'
AND supplier_id IN 
(SELECT supplier_id 
 FROM products 
 GROUP BY supplier_id 
 HAVING COUNT(supplier_id)>1)