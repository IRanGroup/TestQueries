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
--The city that registered the least order ! Inner Join

SELECT TOP(1) WITH TIES
	C.City,
	COUNT(O.OrderID) AS Num
FROM  Orders AS O
INNER JOIN Customers AS C
	ON O.CustomerID = C.CustomerID
GROUP BY City
ORDER BY Num;
--------------------------------------



-------------------------------------
--The products that sell the most ! Inner Join

SELECT TOP(3) WITH TIES
	P.ProductName,
	SUM(OD.Qty) AS Quntitys
FROM Products AS P 
INNER JOIN OrderDetails AS OD
	ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
ORDER BY Quntitys DESC

--------------------------------------




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


