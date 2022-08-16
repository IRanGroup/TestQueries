USE[NikamoozDB]
GO

--The lowest number of orders from Tehrani customers
SELECT TOP(1) WITH TIES
		O.CustomerID,
		COUNT(O.OrderID) AS NUM
FROM dbo.Orders AS O
INNER JOIN Customers AS C
	ON O.CustomerID = C.CustomerID
WHERE C.State IN(N'تهران')
GROUP BY O.CustomerID
ORDER BY COUNT(O.OrderID)  
GO
--END QUERY 




--The number of orange juice orders from Tehran and Kerman province customers
SELECT O.CustomerID,C.State,SUM(Qty)
FROM OrderDetails AS OD
INNER JOIN Orders AS O 
	ON OD.OrderID = O.OrderID
INNER JOIN Customers AS C
	ON O.CustomerID = C.CustomerID
INNER JOIN Products AS P
	ON OD.ProductID = P.ProductID
WHERE C.State IN(N'تهران',N'کرمان') AND 
	  P.ProductName IN(N'آب پرتقال')
GROUP BY O.CustomerID,C.State
GO
--END QUERY



--How many days have passed since the last order and the oldest customer order
SELECT C.CustomerID,DATEDIFF(DAY,MIN(O.OrderDate),MAX(O.ORDERDATE)) AS DIFFER
FROM Orders AS O
INNER JOIN Customers AS C
	ON O.CustomerID = C.CustomerID
WHERE C.State IN(N'اصفهان')
GROUP BY C.CustomerID
GO
--END QUERY



--A customer who has not registered her orders and whose province is null

SELECT C.CustomerID
FROM Customers AS C
WHERE C.State IS NULL
EXCEPT
SELECT O.CustomerID
FROM Orders AS O
GO
--It can be done in two ways
SELECT C.CustomerID,O.OrderID
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
WHERE C.State IS NULL AND OrderID IS NULL
GO
--END QUERY



--Zanjan customers who have placed an order
SELECT C.CustomerID,COUNT(O.OrderID)
FROM Customers AS C
LEFT JOIN Orders AS O 
	ON C.CustomerID = O.CustomerID
WHERE C.State IN (N'زنجان')
GROUP BY C.CustomerID
GO
--END QUERY