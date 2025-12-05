--Compare The Best Years
--How are our sales over the years


SELECT
FS.CustomerID,
FS.ProductID,
SUM(FS.Sales*FS.Units)AS TotalSales,
FS.Region,
T.Division,
CASE 
	WHEN T.Division = 'Chocolate' AND SUM(FS.Sales*FS.Units) >= 27000 THEN 'TargetMet'
	WHEN T. Division = 'Sugar' AND SUM(FS.Sales*FS.Units) >= 15000 THEN 'TargetMet'
	WHEN T.Division = 'Other' AND SUM(FS.Sales*FS.Units) >= 3000 THEN 'TargetMet'
	ELSE 'Not Met'
END AS TargetStatus,
T.Target,
P.ProductName,
P.Factory, 
FS.Country
FROM Gold.Fact_Sales AS FS
LEFT JOIN Gold.Dim_Products AS P
ON FS.ProductID = P.ProductID
LEFT JOIN Silver.Candy_Targets as T
ON FS.Division = T.Division
GROUP BY FS.CustomerID,
	FS.ProductID,
	FS.Region,
	T.Division,
	T.Target,
	P.ProductName,
	P.Factory,
	FS.Country
;
---Performance Over the Years(YEAR OF YEAR ANALYSIS)
SELECT
Year(OrderDate) AS OrderDateYear,
SUM(Sales*Units) AS CurrentTotalSales,
LAG(SUM(Sales*Units)) OVER (ORDER BY Year(OrderDate)) AS PreviousYearSales,
SUM(Sales*Units)-LAG(SUM(Sales*Units)) OVER (ORDER BY Year(OrderDate)) AS DifferenceInSales,
CASE 
	WHEN SUM(Sales*Units)-LAG(SUM(Sales*Units)) OVER (ORDER BY Year(OrderDate)) > 0 THEN 'Increasing'
	WHEN SUM(Sales*Units)-LAG(SUM(Sales*Units)) OVER (ORDER BY Year(OrderDate)) < 0 THEN 'Decreasing'
	ELSE'No Change'
END AS PreviousYearChange
FROM Gold.Fact_Sales
GROUP BY Year(OrderDate) 
ORDER BY Year(OrderDate) 
----Sales Increased all through the Years
