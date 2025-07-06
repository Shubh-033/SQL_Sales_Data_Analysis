-- 1. View All Data
SELECT * FROM sales;

-- 2. Find Total Revenue
SELECT SUM(`Total Amount`) AS Total_Revenue FROM sales;

-- 3. List Unique Product Categories
SELECT DISTINCT `Product Category` FROM sales;

-- 4. Top 5 Best-Selling Products
SELECT `Product Category`, SUM(Quantity) AS Total_Sold
FROM sales
GROUP BY `Product Category`
ORDER BY Total_Sold DESC
LIMIT 5;

-- 5. Monthly Sales Trends
SELECT DATE_FORMAT(Date, '%Y-%m') AS Sales_Month, SUM(`Total Amount`) AS Monthly_Sales
FROM sales
GROUP BY Sales_Month
ORDER BY Sales_Month;

-- 6. Gender-Wise Revenue
SELECT Gender, SUM(`Total Amount`) AS gender_Revenue
FROM sales
GROUP BY gender
ORDER BY gender_Revenue DESC;

-- 7. Top 5 Customers by Purchase Value
SELECT `Customer ID`, SUM(`Total Amount`) AS Total_Purchase
FROM sales
GROUP BY `Customer ID`
ORDER BY Total_Purchase DESC
LIMIT 5;

-- 8. Repeat Customers
SELECT `Customer ID`, COUNT(`Transaction ID`) AS Total_Orders
FROM sales
GROUP BY `Customer ID`
HAVING Total_Orders > 1
ORDER BY Total_Orders DESC;

-- 9. Average Order Value per Customer
SELECT `Customer ID`, AVG(`Total Amount`) AS Average_Order_Value
FROM sales
GROUP BY `Customer ID`
ORDER BY Average_Order_Value DESC;

-- 10. Month-over-Month Sales Growth
SELECT
    Sales_Month,
    Monthly_Sales,
    LAG(Monthly_Sales, 1) OVER (ORDER BY Sales_Month) AS Previous_Month_Sales,
    ROUND(((Monthly_Sales - LAG(Monthly_Sales, 1) OVER (ORDER BY Sales_Month)) / LAG(Monthly_Sales, 1) OVER (ORDER BY Sales_Month)) * 100, 2) AS MoM_Growth_Percentage
FROM (
    SELECT DATE_FORMAT(Date, '%Y-%m') AS Sales_Month, SUM(`Total Amount`) AS Monthly_Sales
    FROM sales
    GROUP BY Sales_Month
) AS Monthly_Data;

