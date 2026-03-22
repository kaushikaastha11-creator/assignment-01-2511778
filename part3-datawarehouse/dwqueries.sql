-- =============================================
-- Part 3.2 - Analytical Queries
-- =============================================

-- Q1: Total sales revenue by product category for each month
SELECT 
    dd.year,
    dd.month_name,
    dd.month_num,
    dp.category,
    SUM(fs.total_revenue) AS total_revenue
FROM fact_sales fs
JOIN dim_date    dd ON fs.date_id    = dd.date_id
JOIN dim_product dp ON fs.product_id = dp.product_id
GROUP BY dd.year, dd.month_num, dd.month_name, dp.category
ORDER BY dd.year, dd.month_num, dp.category;

-- Q2: Top 2 performing stores by total revenue
SELECT 
    ds.store_id,
    ds.store_name,
    ds.store_city,
    SUM(fs.total_revenue) AS total_revenue
FROM fact_sales fs
JOIN dim_store ds ON fs.store_id = ds.store_id
GROUP BY ds.store_id, ds.store_name, ds.store_city
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT 
    dd.year,
    dd.month_num,
    dd.month_name,
    SUM(fs.total_revenue) AS monthly_revenue,
    LAG(SUM(fs.total_revenue)) OVER (ORDER BY dd.year, dd.month_num) AS prev_month_revenue,
    ROUND(
        (SUM(fs.total_revenue) - LAG(SUM(fs.total_revenue)) OVER (ORDER BY dd.year, dd.month_num))
        / LAG(SUM(fs.total_revenue)) OVER (ORDER BY dd.year, dd.month_num) * 100,
    2) AS mom_growth_percent
FROM fact_sales fs
JOIN dim_date dd ON fs.date_id = dd.date_id
GROUP BY dd.year, dd.month_num, dd.month_name
ORDER BY dd.year, dd.month_num;