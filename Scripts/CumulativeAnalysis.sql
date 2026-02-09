/* PERFORM A CUMULATIVE ANALYSIS FOR OUR BUSINESS
===========================================================
Running Total Sales
Moving Average
------------------------------------------------------------
*/
-----Running Total Sales
SELECT
    OrderMonth,
    SUM(MonthlySales) OVER (ORDER BY OrderMonth) AS RunningTotal,
    SUM(AvgSales) OVER (ORDER BY OrderMonth) AS MovingAVG
FROM (
    SELECT
        DATETRUNC(month, OrderDate) AS OrderMonth,
        SUM(Sales * Units) AS MonthlySales,
        AVG(Sales * Units) AS AvgSales
    FROM Gold.Fact_Sales
    GROUP BY DATETRUNC(month, OrderDate)
) t
ORDER BY OrderMonth;

