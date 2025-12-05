/* PERFORM A CUMULATIVE ANALYSIS FOR OUR BUSINESS
===========================================================
Running Total Sales
Moving Average
------------------------------------------------------------
*/
-----Running Total Sales
SELECT
OrderDate,
TotalSales,
SUM(TotalSales) OVER (PARTITION BY OrderDate  ORDER BY OrderDate) AS RunningTotal
FROM
(
SELECT
DATETRUNC(Month,OrderDate) AS OrderDate,
SUM(Sales*Units) AS TotalSales,
AVG(Sales*Units) AS AVGSales
FROM Gold.Fact_Sales
GROUP BY DATETRUNC(Month,OrderDate)
)t

