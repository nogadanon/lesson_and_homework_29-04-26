CREATE TABLE sales (
  id        INTEGER PRIMARY KEY,
  rep_name  TEXT    NOT NULL,
  region    TEXT    NOT NULL,
  product   TEXT    NOT NULL,
  amount    REAL,
  sale_date TEXT    NOT NULL
);

INSERT INTO sales (id, rep_name, region, product, amount, sale_date) VALUES
  (1,  'Dana', 'North', 'Laptop', 1200.00, '2026-01-10'),
  (2,  'Omar', 'South', 'Phone',   650.00,  '2026-01-12'),
  (3,  'Dana', 'North', 'Tablet', NULL,     '2026-01-15'),
  (4,  'Noa',  'East',  'Laptop', 1350.00, '2026-01-18'),
  (5,  'Omar', 'South', 'Laptop', 1100.00, '2026-01-20'),
  (6,  'Dana', 'North', 'Phone',   720.00,  '2026-01-22'),
  (7,  'Noa',  'East',  'Phone',   690.00,  '2026-01-25'),
  (8,  'Liam', 'West',  'Tablet', 480.00,  '2026-01-28'),
  (9,  'Liam', 'West',  'Laptop', 1050.00, '2026-02-01'),
  (10, 'Omar', 'South', 'Tablet', NULL,     '2026-02-03');

---------- COUNT, SUM / AVE / MIN / MAX

-- Count how many distinct products are sold in the South region
		SELECT 
		COUNT(DISTINCT product)
		FROM sales
		WHERE region LIKE 'South';
		
		-- How many different products did Dana sell?
		SELECT 
		COUNT(DISTINCT product)
		FROM sales
		WHERE rep_name LIKE 'dana';
		
		-- How many laptops have been sold?
		SELECT 
		COUNT('---laptop---')
		FROM sales
		WHERE product LIKE 'laptop';
		
		-- Bonus: in one query show total_rows, rows_with_amount, and missing_amount side by side	
				SELECT
		COUNT(*) AS total_rows,
		COUNT(amount) AS rows_with_amount,
		COUNT(*) - COUNT(amount) AS missing_amount
		FROM sales;
		
		-- Find the total revenue for the North region only
		SELECT 
		SUM(amount) as total_revenue_for_the_North_region_only
		FROM sales
		WHERE region LIKE 'north';
		
		-- Find the most expensive Laptop sold
		SELECT
		MAX(amount) AS most_expensive_laptop
		FROM sales
		WHERE product LIKE 'laptop';
		
		-- Find the average sale treating NULLs as zero (use SUM / COUNT(*))
		SELECT
		SUM(amount) / COUNT(*) AS average_sale
		FROM sales;

		-- mistake :
		SELECT
		AVG(amount) AS average_sale
		FROM sales;


---------- GROUP BY

-- Show total revenue per region, sorted highest first
SELECT 
region,
SUM(amount) AS total_revenu
FROM sales
GROUP BY region
ORDER BY amount;

-- Show the number of sales and average amount per product
SELECT 
product,
COUNT() AS number_of_sales,
avg(amount) AS average_amount
FROM sales
GROUP BY product;

-- Show revenue per rep_name, sorted by revenue descending — use an alias in ORDER BY
SELECT
rep_name,
SUM(amount) AS revenue_per_rep_name
FROM sales
GROUP BY rep_name 
ORDER BY revenue_per_rep_name DESC;

-- Show COUNT and SUM grouped by both region and rep_name
SELECT
region, rep_name,
COUNT() AS sales_per_rep_name,
SUM(amount) AS revenue
FROM sales
GROUP BY region, rep_name;

-- Bonus: find which rep sold the most Laptops (GROUP BY rep_name with WHERE product = 'Laptop')
SELECT
rep_name, product,
COUNT(product) AS amount_of_laptops
FROM sales
WHERE product LIKE 'laptop'
GROUP BY rep_name
ORDER BY amount_of_laptops DESC;
LIMIT 1;


---------- HAVING 

-- Find regions where total revenue is above 1500
SELECT
region,
SUM(amount) AS total_revenue_in_region
FROM sales
GROUP BY region
HAVING total_revenue_in_region > 1500;

-- Find products sold 3 or more times (use HAVING COUNT(*) >= 3)
SELECT
product,
COUNT(product) AS amount_product
FROM sales
GROUP BY product
HAVING COUNT() >= 3;

-- Find reps whose average sale is above 900 (only count non-NULL amounts)
SELECT
rep_name, 
SUM(amount) AS total_sales_per_rep
FROM sales
GROUP BY rep_name
HAVING SUM(amount) > 900;

-- Combine: among Laptop and Phone rows only, find reps with more than 1 sale
SELECT
rep_name, 
COUNT(product) AS amount_laptop_and_phone
FROM sales
WHERE product LIKE 'laptop' OR product LIKE 'phone'
GROUP BY rep_name
HAVING amount_laptop_and_phone > 1;

