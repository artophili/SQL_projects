--SQL retail analysis
CREATE DATABASE retail_data_analysis;

--Creating table
CREATE TABLE retail_sales(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(25), 	
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,	
		total_sale FLOAT
);

SELECT * FROM retail_sales;

--Data exploration and cleaning
SELECT COUNT(*) FROM retail_sales;;;

--To count distinct customers in dataset
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

--Distinct product categories
SELECT COUNT(DISTINCT category) FROM retail_sales;

--Checking for null values
SELECT * FROM retail_sales
WHERE 
	sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

--Dropping null values
DELETE FROM retail_sales WHERE 
WHERE 
	sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

--Analysis and findings
--sales made on '2022-11-05'
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
--Total sale on '2022-11-05'
SELECT SUM(total_sale) FROM retail_sales WHERE sale_date = '2022-11-05';

--all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantiy>=4;

--Total sales and average sale of NOV-2022
SELECT SUM(total_sale) FROM retail_sales WHERE TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
SELECT AVG(total_sale) FROM retail_sales WHERE TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

--calculate the total sales (total_sale) for each category
SELECT category, SUM(total_sale) AS net_sale, COUNT(transactions_id) AS order_count FROM retail_sales GROUP BY category;

