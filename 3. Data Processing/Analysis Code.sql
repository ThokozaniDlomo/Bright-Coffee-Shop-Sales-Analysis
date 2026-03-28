-- PART 2: ANALYSIS TO PRODUCE AGGREGATED DATA FOR BETTER INSIGHTS

SELECT
       transaction_date AS purchase_date,
       Dayname(transaction_date) AS Day_name,
       Monthname(transaction_date) AS Month_name,
       Dayofmonth(transaction_date) AS day_of_month,

       CASE
           WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
           ELSE 'Weekday'
       END AS day_classification,

       CASE
           WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
           WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
           WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN 'Evening'
       END AS time_buckets,

-- Counting of IDS
       COUNT(DISTINCT transaction_id) AS Number_of_sales,
       COUNT(DISTINCT product_id) AS number_of_products,
       COUNT(DISTINCT store_id) AS number_of_stores,

-- Calculating the Revenue
       SUM(transaction_qty * unit_price) AS revenue_per_day,

-- Creating the spend buckets 
CASE
    WHEN revenue_per_day <= 50 THEN 'Minimum Spend'
    WHEN revenue_per_day BETWEEN 51 AND 100 THEN 'Medium Spend'
    ELSE 'Maximum Spend'
END AS spend_bucket,

-- Listing Categorical columns
       store_location,
       product_category,
       product_detail

FROM workspace.default.bright_coffee_shop_analysis_case_study_1
GROUP BY transaction_date,
         Dayname(transaction_date),
         Monthname(transaction_date),
         Dayofmonth(transaction_date),

         CASE
             WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
             ELSE 'Weekday'
         END,

         CASE
             WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
             WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
             WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN 'Evening'
         END,

store_location,
product_category,
product_detail;
