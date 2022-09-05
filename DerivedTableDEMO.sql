USE[NikamoozDB]
GO

--Customers who have registered 5 orders per invoice 

--Join method
SELECT DISTINCT C.CustomerID,COUNT(OD.OrderID) AS NUM
FROM Orders AS O
JOIN OrderDetails AS OD
	ON O.OrderID = OD.OrderID
JOIN Customers AS C
	ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID,OD.OrderID
HAVING COUNT(OD.OrderID) > 5
GO


--SUBQUERY method
SELECT DISTINCT
	(SELECT O.CustomerID FROM Orders AS O
	 WHERE OD.OrderID = O.OrderID) AS CustomerID,
	 COUNT(OD.OrderID) AS NUM
FROM OrderDetails AS OD
GROUP BY OD.OrderID
HAVING COUNT(OD.OrderID) >5
GO


--derived table method
SELECT DISTINCT * 
FROM (SELECT O.CustomerID,COUNT(OD.OrderID) AS NUM FROM OrderDetails AS OD
	  JOIN Orders AS O ON OD.OrderID = O.OrderID
	 GROUP BY OD.OrderID,O.CustomerID) AS RES
WHERE RES.NUM > 5
GO
--END QUERY
