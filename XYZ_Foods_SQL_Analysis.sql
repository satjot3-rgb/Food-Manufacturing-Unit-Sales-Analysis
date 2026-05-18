-- ============================================================
--   XYZ Foods — SQL BUSINESS ANALYSIS
--   Tool     : Microsoft SQL Server
--   Author   : Satjot Singh Bhatia
--   Dataset  : 2 Years Daily Sales Data (2022-2023)
-- ============================================================


-- ============================================================
-- STEP 1 — CREATE DATABASE & TABLE
-- ============================================================

CREATE DATABASE XYZFoods;

USE XYZFoods;


CREATE TABLE SalesData (
    SaleID              INT IDENTITY(1,1) PRIMARY KEY,
    Date                DATE,
    Month               VARCHAR(20),
    Year                INT,
    Quarter             VARCHAR(5),
    Day_of_Week         VARCHAR(15),
    Product             VARCHAR(20),
    Units_Produced      INT,
    Units_Sold          INT,
    Wastage_Units       INT,
    Raw_Material_Cost   DECIMAL(10,2),
    Revenue             DECIMAL(10,2),
    Profit              DECIMAL(10,2),
    Profit_Margin_Pct   DECIMAL(6,2)
);

-- ============================================================
-- STEP 2 — IMPORT DATA
-- ============================================================
-- In SQL Server Management Studio (SSMS):
-- Right-click XYZFoods → Tasks → Import Flat File
-- Select XYZ_Foods_sales_data.csv
-- Map columns to the table above
-- ============================================================


-- ============================================================
-- STEP 3 — VERIFY DATA LOADED CORRECTLY
-- ============================================================

SELECT TOP 10 * FROM SalesData;

SELECT 
    COUNT(*)            AS Total_Rows,
    MIN(Date)           AS Start_Date,
    MAX(Date)           AS End_Date,
    COUNT(DISTINCT Product) AS Products
FROM SalesData;


-- ============================================================
-- BUSINESS QUESTION 1
-- What is the total revenue, profit and cost for each year?
-- ============================================================

SELECT
    Year,
    ROUND(SUM(Revenue), 0)              AS Total_Revenue_INR,
    ROUND(SUM(Profit), 0)               AS Total_Profit_INR,
    ROUND(SUM(Raw_Material_Cost), 0)    AS Total_Cost_INR,
    ROUND(AVG(Profit_Margin_Pct), 2)    AS Avg_Profit_Margin_Pct
FROM SalesData
GROUP BY Year
ORDER BY Year;


-- ============================================================
-- BUSINESS QUESTION 2
-- Which product generates the most revenue and profit?
-- ============================================================

SELECT
    Product,
    ROUND(SUM(Revenue), 0)              AS Total_Revenue_INR,
    ROUND(SUM(Profit), 0)               AS Total_Profit_INR,
    ROUND(AVG(Profit_Margin_Pct), 2)    AS Avg_Profit_Margin_Pct,
    SUM(Units_Sold)                     AS Total_Units_Sold
FROM SalesData
GROUP BY Product
ORDER BY Total_Revenue_INR DESC;


-- ============================================================
-- BUSINESS QUESTION 3
-- What are the top 5 best performing months by revenue?
-- ============================================================

SELECT TOP 5
    Year,
    Month,
    ROUND(SUM(Revenue), 0)      AS Monthly_Revenue,
    ROUND(SUM(Profit), 0)       AS Monthly_Profit
FROM SalesData
GROUP BY Year, Month
ORDER BY Monthly_Revenue DESC;


-- ============================================================
-- BUSINESS QUESTION 4
-- What are the 5 worst performing months by revenue?
-- ============================================================

SELECT TOP 5
    Year,
    Month,
    ROUND(SUM(Revenue), 0)      AS Monthly_Revenue,
    ROUND(SUM(Profit), 0)       AS Monthly_Profit
FROM SalesData
GROUP BY Year, Month
ORDER BY Monthly_Revenue ASC;


-- ============================================================
-- BUSINESS QUESTION 5
-- Which day of the week has the highest average revenue?
-- ============================================================

SELECT
    Day_of_Week,
    ROUND(AVG(Revenue), 2)          AS Avg_Daily_Revenue,
    ROUND(AVG(Profit_Margin_Pct), 2) AS Avg_Profit_Margin_Pct,
    ROUND(AVG(CAST(Units_Sold AS FLOAT)), 1) AS Avg_Units_Sold
FROM SalesData
GROUP BY Day_of_Week
ORDER BY Avg_Daily_Revenue DESC;


-- ============================================================
-- BUSINESS QUESTION 6
-- What is the wastage rate per product and total cost of waste?
-- ============================================================

SELECT
    Product,
    SUM(Units_Produced)                                         AS Total_Produced,
    SUM(Wastage_Units)                                          AS Total_Wastage,
    ROUND(SUM(Wastage_Units) * 100.0 / SUM(Units_Produced), 2) AS Wastage_Rate_Pct,
    -- Estimated cost of wastage = wastage units * cost per unit produced
    ROUND(SUM(Wastage_Units * (Raw_Material_Cost / NULLIF(Units_Produced,0))), 0)
                                                                AS Est_Wastage_Cost_INR
FROM SalesData
GROUP BY Product
ORDER BY Wastage_Rate_Pct DESC;


-- ============================================================
-- BUSINESS QUESTION 7
-- How does revenue compare quarter by quarter?
-- ============================================================

SELECT
    Year,
    Quarter,
    ROUND(SUM(Revenue), 0)              AS Quarterly_Revenue,
    ROUND(SUM(Profit), 0)               AS Quarterly_Profit,
    ROUND(AVG(Profit_Margin_Pct), 2)    AS Avg_Margin_Pct
FROM SalesData
GROUP BY Year, Quarter
ORDER BY Year, Quarter;


-- ============================================================
-- BUSINESS QUESTION 8
-- Year on year revenue growth by product
-- ============================================================

SELECT
    Product,
    ROUND(SUM(CASE WHEN Year = 2022 THEN Revenue ELSE 0 END), 0) AS Revenue_2022,
    ROUND(SUM(CASE WHEN Year = 2023 THEN Revenue ELSE 0 END), 0) AS Revenue_2023,
    ROUND(
        (SUM(CASE WHEN Year = 2023 THEN Revenue ELSE 0 END) -
         SUM(CASE WHEN Year = 2022 THEN Revenue ELSE 0 END)) * 100.0 /
         NULLIF(SUM(CASE WHEN Year = 2022 THEN Revenue ELSE 0 END), 0)
    , 2)                                                          AS YoY_Growth_Pct
FROM SalesData
GROUP BY Product
ORDER BY YoY_Growth_Pct DESC;


-- ============================================================
-- BUSINESS QUESTION 9
-- What are the top 10 single best sales days overall?
-- ============================================================

SELECT TOP 10
    Date,
    Day_of_Week,
    Month,
    Year,
    ROUND(SUM(Revenue), 0)  AS Daily_Total_Revenue,
    ROUND(SUM(Profit), 0)   AS Daily_Total_Profit
FROM SalesData
GROUP BY Date, Day_of_Week, Month, Year
ORDER BY Daily_Total_Revenue DESC;


-- ============================================================
-- BUSINESS QUESTION 10
-- Rolling 30-day average revenue trend (window function)
-- ============================================================

WITH DailyRevenue AS (
    SELECT
        Date,
        SUM(Revenue) AS Daily_Revenue
    FROM SalesData
    GROUP BY Date
)
SELECT
    Date,
    ROUND(Daily_Revenue, 0) AS Daily_Revenue,
    ROUND(AVG(Daily_Revenue) OVER (
        ORDER BY Date
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ), 0)                   AS Rolling_30Day_Avg
FROM DailyRevenue
ORDER BY Date;


-- ============================================================
-- BONUS — STORED PROCEDURE
-- Get full performance summary for any given month/year
-- ============================================================

CREATE PROCEDURE GetMonthlyReport
    @Month VARCHAR(20),
    @Year  INT
AS
BEGIN
    SELECT
        Product,
        SUM(Units_Produced)                 AS Units_Produced,
        SUM(Units_Sold)                     AS Units_Sold,
        SUM(Wastage_Units)                  AS Wastage_Units,
        ROUND(SUM(Revenue), 0)              AS Revenue_INR,
        ROUND(SUM(Profit), 0)               AS Profit_INR,
        ROUND(AVG(Profit_Margin_Pct), 2)    AS Avg_Margin_Pct
    FROM SalesData
    WHERE Month = @Month AND Year = @Year
    GROUP BY Product
    ORDER BY Revenue_INR DESC;
END;
GO

-- Usage example:
EXEC GetMonthlyReport @Month = 'January', @Year = 2022;
GO
