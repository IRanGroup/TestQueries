USE[NikamoozDB]

SELECT C.CustomerID,C.CompanyName,
	   O.OrderID,OD.ProductID,OD.Qty
FROM Customers AS C
LEFT JOIN Orders AS O
	   ON C.CustomerID = O.CustomerID
LEFT JOIN OrderDetails AS OD 
	   ON O.OrderID = OD.OrderID
ORDER BY C.CustomerID

-------------------------------------------------
USE[AdventureWorks2019]

SELECT P.Name,OD.SalesOrderDetailID
FROM [Production].[Product] AS P
LEFT JOIN [Sales].[SalesOrderDetail] AS OD
		ON P.ProductID = OD.ProductID
LEFT JOIN [Sales].[SalesOrderHeader] AS O
	    ON OD.SalesOrderID = O.SalesOrderID
ORDER BY CASE 
WHEN OD.SalesOrderDetailID IS NULL THEN 0 ELSE 1 END
DESC
 
 ---------------------------------------
 --Query above in another way
SELECT P.Name,OD.SalesOrderDetailID
FROM [Sales].[SalesOrderDetail] AS OD
RIGHT JOIN [Production].[Product] AS P
		ON P.ProductID = OD.ProductID
LEFT JOIN [Sales].[SalesOrderHeader] AS O
	    ON OD.SalesOrderID = O.SalesOrderID
ORDER BY CASE 
WHEN OD.SalesOrderDetailID IS NULL THEN 0 ELSE 1 END
DESC