USE CynarisPracticeDB;


GO
CREATE TABLE sales (
    sale_id      INT             PRIMARY KEY,
    sale_date    DATE           ,
    region       VARCHAR (50)   ,
    category     VARCHAR (50)   ,
    product_name VARCHAR (100)  ,
    quantity     INT            ,
    revenue      DECIMAL (12, 2)
);


GO
INSERT  INTO sales (
    sale_id,
    sale_date,
    region,
    category,
    product_name,
    quantity,
    revenue
)
VALUES             (1, '2026-01-05', 'South', 'Electronics', 'Laptop', 2, 100000),
                   (2, '2026-01-10', 'North', 'Furniture', 'Chair', 5, 10000),
                   (3, '2026-01-15', 'South', 'Electronics', 'Phone', 4, 80000),
                   (4, '2026-02-02', 'East', 'Furniture', 'Table', 2, 30000),
                   (5, '2026-02-10', 'West', 'Clothing', 'Shirt', 10, 10000),
                   (6, '2026-02-18', 'North', 'Electronics', 'Laptop', 1, 50000),
                   (7, '2026-03-03', 'South', 'Clothing', 'Shirt', 6, 6000),
                   (8, '2026-03-12', 'East', 'Electronics', 'Phone', 3, 45000);


GO
SELECT *
FROM   sales;


GO
SELECT SUM(revenue) AS total_revenue
FROM   sales;

SELECT AVG(revenue) AS average_revenue
FROM   sales;

SELECT MAX(revenue) AS highest_sale
FROM   sales;

SELECT MIN(revenue) AS lowest_sale
FROM   sales;

SELECT   region,
         SUM(revenue) AS total_revenue
FROM     sales
GROUP BY region;

SELECT   category,
         SUM(revenue) AS total_revenue
FROM     sales
GROUP BY category;

SELECT   region,
         SUM(revenue) AS total_revenue
FROM     sales
GROUP BY region
HAVING   SUM(revenue) > 100000;

SELECT   sale_id,
         sale_date,
         revenue,
         SUM(revenue) OVER (ORDER BY sale_date, sale_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_revenue
FROM     sales
ORDER BY sale_date, sale_id;

SELECT   YEAR(sale_date) AS sales_year,
         MONTH(sale_date) AS sales_month,
         SUM(revenue) AS monthly_revenue
FROM     sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sales_year, sales_month;

SELECT   sale_id,
         sale_date,
         revenue,
         SUM(revenue) OVER (ORDER BY sale_date, sale_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_revenue
FROM     sales
ORDER BY sale_date, sale_id;