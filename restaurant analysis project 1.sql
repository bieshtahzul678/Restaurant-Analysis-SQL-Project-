 -- Restaurant Analysis Project 
USE restaurant_db;

-- Objective 1: Explore Menu table
-- 1. View the menu_items table.
SELECT *
FROM menu_items;

--- 2. Find the number of items in the table. 
SELECT COUNT(*) FROM menu_items;

-- 3. What are the least and most expensive items on the menu?
SELECT * FROM menu_items
ORDER BY price;

SELECT * FROM menu_items 
ORDER BY price DESC;

-- 4. How many Italian dishes are on the menu?
SELECT COUNT(*)
FROM menu_items 
WHERE category = 'Italian';

-- 5. What are the least and most expensive Italian dishes on the menu?
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price;

SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;

-- 6. How many dishes are in each category?
SELECT category, COUNT(menu_item_id) AS dishes_per_category
FROM menu_items
GROUP BY category; 

-- 7. What is the average dish price within each category?
SELECT category, ROUND(AVG(price), 2) AS avg_price
FROM menu_items
GROUP BY category; 

-- Objective 2: Explore orders table

-- 1. View the orders table. 
SELECT * 
FROM order_details; 

-- 2. What is the date range of the table. 
SELECT Min(order_date), MAX(order_date)
FROM order_details 
ORDER BY order_date;

-- 3. How Many orders were made within this date range?
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM order_details;

-- 4. How many items were ordered within this date range"
SELECT COUNT(*) 
FROM order_details;

-- 5. Which order had the most number of items?
SELECT order_id, COUNT(item_id) AS num_items 
FROM order_details 
GROUP BY order_id
ORDER BY num_items DESC;

-- 6. How many orders had more than 12 items?
SELECT COUNT(*)  FROM 

(SELECT order_id, COUNT(item_id) AS num_items 
FROM order_details 
GROUP BY order_id
HAVING num_items > 12) AS num_orders;

-- Objective 3: Analyze Customer Behavior 
-- 1. Combine the menu_items and order_details table into a single table. 
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT * 
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? What categories were they in?
SELECT item_name, category, COUNT(order_id) AS num_purchases
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases;

-- 3. What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price) AS total_spent
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spent DESC
LIMIT 5;

-- 4. View the details of the highest spend order. 
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN ( 440, 2075, 1957, 330, 2675)
GROUP BY order_id, category
ORDER BY category;




