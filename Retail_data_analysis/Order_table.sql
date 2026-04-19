CREATE TABLE orders_table (
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO orders_table (order_id, order_date, amount) VALUES
(1, '2024-03-01', 500),
(2, '2024-03-01', 300),
(3, '2024-03-02', 700),
(4, '2024-03-04', 400),
(5, '2024-03-04', 200),
(6, '2024-03-04', 300),
(7, '2024-03-06', 450),
(8, '2024-03-07', 500),
(9, '2024-03-07', 300),
(10, '2024-03-10', 600);

SELECT * FROM orders_table;

SELECT order_date, COUNT(order_id) AS total_orders, SUM(amount) AS revenue FROM orders_table GROUP BY 1 ORDER BY 1;

WITH calender AS(
SELECT generate_series(
DATE '2024-03-01',
DATE '2024-03-10',
INTERVAL '1 DAY'
)::date AS day
)
SELECT
	c.day,
	COUNT(o.order_id) AS orders,
	COALESCE(SUM(o.amount),0) AS revenue
FROM calender c
LEFT JOIN orders_table o
	ON c.day = o.order_date
GROUP BY c.day
ORDER BY c.day;

CREATE TABLE orders_t (
    order_id INT PRIMARY KEY,
	customer_id INT,
	category VARCHAR(25),
    order_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO orders_t (order_id,customer_id,category,order_date, amount) VALUES
(1,11,'Cosmetic','2024-03-01',500),
(2,12,'Electronic','2024-03-01', 300),
(3,13,'Electronic','2024-03-02', 700),
(4,14,'Furniture','2024-03-04', 400),
(5,15,'Cosmetic','2024-03-04', 200),
(6,16,'Grocery','2024-03-04', 300),
(7,17,'Electronic','2024-03-06', 450),
(8,13,'Furniture','2024-03-07', 500),
(9,12,'Decoration','2024-03-07', 300),
(10,12,'Electronic','2024-03-10', 600);

SELECT * FROM orders_t;

SELECT customer_id,category, SUM(amount), RANK() OVER (PARTITION BY category ORDER BY customer_id) AS rnk FROM orders_t GROUP BY 1,2 ORDER BY SUM(amount) LIMIT 3;

SELECT customer_id, category, SUM(amount) AS total_spent, RANK() OVER (PARTITION BY category) FROM orders_t GROUP BY 1,2 ORDER BY SUM(amount) DESC LIMIT 3;

