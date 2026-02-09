/* DATA SEGMENTATION OF OUR CUSTOMERS
================================================================
1.
CUSTOMER SEGMENTATION
You’re grouping customers based on how profitable they are, how often they buy, and where they’re located.
In your sample: a San Francisco customer ordering chocolate bars.
===================================================================================================*/

WITH Csegments AS
(
SELECT
*,
DATEDIFF(Year,OrderDate,GETDATE()) AS LifeSpan,
CASE WHEN DATEDIFF(Year,OrderDate,GETDATE()) >=4 THEN 'Platinum'
	 WHEN DATEDIFF(Year,OrderDate,GETDATE()) =3 THEN 'Gold'
	 WHEN DATEDIFF(Year,OrderDate,GETDATE()) =2 THEN 'REGULAR'
	 ELSE 'New'
END AS CustomerSegments,
SUM(Sales*Units) OVER () AS TotalRevenue,
COUNT(OrderID) OVER() AS TotalOrders
FROM Gold.Fact_Sales
)
SELECT
*,
TotalRevenue/TotalOrders AS AvgOrderValue
FROM Csegments;

SELECT
CustomerID,
COUNT(OrderID) AS OrderCount,
CASE WHEN COUNT(OrderID)> 10 THEN 'HighValue'
     WHEN COUNT(OrderID) BETWEEN 5 AND 10 THEN 'MidLevel'
	 WHEN COUNT(OrderID) BETWEEN 2 AND 5 THEN 'Regular'
	 ELSE 'OneTimeBuyer'
END AS CustomerValue
FROM Customerseg
GROUP BY CustomerID;

--Region-based clusters (Pacific vs others)
SELECT
Region,
SUM(Units) as ProductSold
FROM Gold.Fact_Sales
GROUP BY Region
ORDER BY SUM(Units) DESC;


--2. Product Segmentation
--High-margin product----
SELECT
Revenue-CostOfGoodsSold AS GrossMargin,
CASE WHEN Revenue-CostOfGoodsSold >CostOfGoodsSold THEN 'HighMargin'
     WHEN Revenue-CostOfGoodsSold <CostOfGoodsSold THEN 'LowMargin'
	 ELSE 'N/A'
END AS ProductMargin
FROM
(SELECT
CustomerID,
ProductID,
ProductName,
Division,
Sales*Units AS Revenue,
Cost*Units AS CostOfGoodsSold
FROM Gold.Fact_Sales)t
