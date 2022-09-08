USE[NikamoozDB]
GO

--How many customers have we had each year
WITH CustPerYear
AS
(
	SELECT
		YEAR(OrderDate) AS OrderYear,
		CustomerID
	FROM dbo.Orders
)
SELECT
	CY.OrderYear,
	COUNT(DISTINCT CY.CustomerID) AS Customers_Num
FROM CustPerYear AS CY
GROUP BY CY.OrderYear;
GO
--END QUERY