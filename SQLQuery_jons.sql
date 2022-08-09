USE[NikamoozDB]
GO

-------------------------------------
-- City and order number !Inner Join

SELECT 
	 City,
	 COUNT(OrderID) AS NUM
FROM dbo.Orders AS O
INNER JOIN dbo.Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY City
HAVING COUNT(OrderID) > 50

-------------------------------------



-------------------------------------
--Products in their different states ! Self Join

SELECT 
	P1.ProductID,
	P1.ProductName,
	P2.ProductID,
	P2.ProductName
FROM dbo.Products AS P1
CROSS JOIN dbo.Products AS P2
--------------------------------------




--------------------------------------
--Combination of customer and employee cities ! CRoss Join

SELECT 
	C.City,
	E.City
FROM dbo.Customers AS C
CROSS JOIN dbo.Employees AS E

---------------------------------------


--News Databse
USE[AdventureWorks2019]

--The name of the products that have been ordered
SELECT SD.SalesOrderID,
	   PR.Name
FROM [Sales].[SalesOrderDetail] AS SD
INNER JOIN [Production].[Product] AS PR
ON SD.ProductID = PR.ProductID

------------------------------------------


