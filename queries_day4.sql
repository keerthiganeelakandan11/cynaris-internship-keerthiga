USE CynarisPracticeDB;


GO
-- 1. NON-CORRELATED SUBQUERY
-- Find sales above the average revenue of all sales.
SELECT   sale_id,
         sale_date,
         region,
         product,
         revenue
FROM     sales
WHERE    revenue > (SELECT AVG(revenue)
                    FROM   sales)
ORDER BY revenue DESC;


GO
-- 2. CORRELATED SUBQUERY
-- Find the highest-revenue sale in each region.
-- If multiple sales tie for the highest revenue,
-- all tied sales are returned.
SELECT   s.sale_id,
         s.region,
         s.product,
         s.revenue
FROM     sales AS s
WHERE    s.revenue = (SELECT MAX(s2.revenue)
                      FROM   sales AS s2
                      WHERE  s2.region = s.region)
ORDER BY s.region;


GO
-- 3. REWRITE A SUBQUERY USING A CTE
-- Calculate average revenue and find above-average sales.
WITH     AverageSales
AS       (SELECT AVG(revenue) AS avg_revenue
          FROM   sales)
SELECT   s.sale_id,
         s.product,
         s.revenue,
         a.avg_revenue
FROM     sales AS s
         CROSS JOIN AverageSales AS a
WHERE    s.revenue > a.avg_revenue
ORDER BY s.revenue DESC;


GO
-- 4. CHAIN TWO CTEs
-- First calculate revenue by region.
-- Then find regions whose total revenue exceeds 100000.
WITH     RegionRevenue
AS       (SELECT   region,
                   SUM(revenue) AS total_revenue
          FROM     sales
          GROUP BY region),
         HighRevenueRegions
AS       (SELECT region,
                 total_revenue
          FROM   RegionRevenue
          WHERE  total_revenue > 100000)
SELECT   region,
         total_revenue
FROM     HighRevenueRegions
ORDER BY total_revenue DESC;


GO
-- 5. EXISTS EXAMPLE
-- Find sales belonging to regions with at least
-- one sale above 50000.
SELECT   s.sale_id,
         s.region,
         s.product,
         s.revenue
FROM     sales AS s
WHERE    EXISTS (SELECT 1
                 FROM   sales AS s2
                 WHERE  s2.region = s.region
                        AND s2.revenue > 50000)
ORDER BY s.region, s.revenue DESC;