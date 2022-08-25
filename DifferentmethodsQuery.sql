USE[NikamoozDB]
GO

--Customers with more than 10 orders
--Different methods

SELECT C.CompanyName,C.CustomerID
FROM Customers AS C
INNER JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName,C.CustomerID
HAVING COUNT(O.OrderID) > 10
GO

SELECT C.CompanyName,C.CustomerID 
FROM Customers AS C
WHERE (SELECT COUNT(O.OrderID) FROM Orders AS O
		WHERE C.CustomerID = O.CustomerID) > 10
GO

SELECT C.CompanyName,C.CustomerID
FROM Customers AS C
WHERE C.CustomerID = (SELECT O.CustomerID
					  FROM Orders AS O
					  WHERE C.CustomerID = O.CustomerID
					  GROUP BY O.CustomerID 
					  HAVING COUNT(O.OrderID) > 10)
GO

SELECT C.CompanyName,C.CustomerID
FROM Customers AS C
WHERE EXISTS (SELECT 1
			  FROM Orders AS O
			  WHERE C.CustomerID = O.CustomerID
					  HAVING COUNT(O.OrderID) > 10)
GO

SELECT C.CompanyName,
	   (SELECT O.CustomerID
	   FROM Orders AS O
	   WHERE C.CustomerID = O.CustomerID
	   GROUP BY O.CustomerID
		HAVING COUNT(O.OrderID) > 10) AS CUSTOMERIDSDSS
FROM Customers AS C
GO

SELECT O.CustomerID,
		(SELECT C.CompanyName FROM Customers AS C
		 WHERE C.CustomerID = O.CustomerID) AS CUSM
FROM Orders AS O
GROUP BY O.CustomerID
HAVING COUNT(O.OrderID) > 10
GO


--END QURY 
----------------------------------------------------------------

--Number of customers ordering in Zanjan

SELECT C.CompanyName,COUNT(O.ORderID) AS NUM
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
WHERE C.State = N'زنجان'
GROUP BY C.CompanyName 
GO

SELECT C.CompanyName,
	   (SELECT COUNT(O.OrderID) FROM Orders AS O
	    WHERE O.CustomerID = C.CustomerID)
FROM Customers AS C 
WHERE C.State = N'زنجان'
GO

--END QURY