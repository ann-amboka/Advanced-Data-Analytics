/* PERFORM A CHANGE OVER TIME ANALYSIS OF OUR BUSINESS
=====================================================
Get the Total Sales Over the Years
Average Costs
Total Orders
Number of customers over the years */

SELECT
Year(OrderDate) AS OrderYear,
SUM(Sales*Units) AS TotalSales,
SUM(GrossProfit*Units) AS TotalGross,
AVG(Cost) AS AvgCost,
COUNT(DISTINCT CustomerID) AS TotalCustomers,
COUNT(OrderID) AS TotalOrders
FROM Gold.Fact_Sales
GROUP BY Year(OrderDate)
ORDER BY Year(OrderDate)
