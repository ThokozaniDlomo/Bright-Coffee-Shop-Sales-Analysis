-- PART 1: EXPLORATORY DATA ANALYSIS (EDA)
-- GETTING TO UNDERSTAND DATA CHARACTERISTICS AND WHAT IS CONTAINED

-- Retrieving ALL the columns
SELECT*
FROM workspace.default.bright_coffee_shop_analysis_case_study_1
LIMIT 5;

-- Checking the date Range 
SELECT MIN(transaction_date) AS start_date
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

SELECT MAX(transaction_date) AS end_date
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

-- Retrieving unique store locations 
SELECT DISTINCT store_location
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

-- Checking products category, type and detail across all the stores
SELECT DISTINCT product_category AS category,
       product_type,
       product_detail AS product_name
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;


-- Checking product price Range
SELECT MIN(unit_price) AS cheapest_price,
       MAX(unit_price) AS expensive_price
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;


-- Looking number of rows, unique ID's of the sold products
SELECT COUNT(*) AS number_of_rows,
       COUNT(DISTINCT transaction_id) AS number_of_sales,
       COUNT(DISTINCT product_id) AS number_of_products,
       COUNT(DISTINCT store_id) AS number_of_stores
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;


-- Finding actual days, months of the transactions that took place
SELECT transaction_id,
       transaction_date,
       Dayname(transaction_date) AS Day_name,
       Monthname(transaction_date) AS Month_name,
       transaction_qty * unit_price AS revenue_per_transaction
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;


-- Aggregating data transactions 
SELECT 
       transaction_date,
       Dayname(transaction_date) AS Day_name,
       Monthname(transaction_date) AS Month_name,
       COUNT(DISTINCT transaction_id) AS Number_of_sales,
       SUM(transaction_qty * unit_price) AS revenue_per_day
FROM workspace.default.bright_coffee_shop_analysis_case_study_1
GROUP BY transaction_date,
         Day_name,
         Month_name;
