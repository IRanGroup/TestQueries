USE[NikamoozDB]
GO


--Number of customers ordering and obtaining the date of the newest order and the lowest order
SELECT EmployeeID,
	   COUNT(OrderID) AS OrderTotal,
	 (SELECT MAX(OrderDate) FROM Orders) AS MaxDate,
	 (SELECT MIN(OrderDate) FROM Orders) AS MinDate
FROM Orders
GROUP BY EmployeeID
GO
--END QURY



--Employees who had order registration and started with the letter P AND T
--P
SELECT OrderID
FROM Orders
WHERE EmployeeID = (SELECT EmployeeID
FROM Employees AS E
WHERE E.LastName LIKE N'پ%')
GO
--T
--Output of more than one record of IN is used
SELECT OrderID
FROM Orders
WHERE EmployeeID IN (SELECT EmployeeID
FROM Employees AS E
WHERE E.LastName LIKE N'ت%')

GO
--END QURY


--Customers who have not registered an order 
SELECT C.CustomerID,O.OrderID
FROM Customers AS C
LEFT JOIN Orders AS O
	ON O.CustomerID = C.CustomerID
WHERE O.OrderID IS NULL
GO
--SUb QUERY method
SELECT CustomerID
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders)
GO
--END QURY


--Customers who did not just register an order on '2016-05-05' 
SELECT C.CustomerID, C.CompanyName
FROM Customers AS C 
WHERE C.CustomerID NOT IN (SELECT O.CustomerID
						   FROM Orders AS O
						  WHERE O.OrderDate = '2016-05-05')
ORDER BY C.CustomerID
GO
--END QURY 



USE[AdventureWorks2019]
GO
--Black products ordered
SELECT OD.*
FROM [Sales].[SalesOrderDetail] AS OD
INNER JOIN [Production].[Product] AS P
	ON OD.ProductID = P.ProductID
WHERE P.Color = 'Black' 
GO

SELECT OD.*
FROM [Sales].[SalesOrderDetail] AS OD
WHERE OD.ProductID  IN (SELECT ProductID 
			FROM [Production].[Product] WHERE Color = 'Black')
GO
--END QURY