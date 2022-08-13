USE[NikamoozDB]
GO

-------------------------------------
--NON Equal
SELECT EM1.EmployeeID,EM1.FirstName,EM1.LastName,
	   EM2.EmployeeID,EM2.FirstName,EM2.LastName	
FROM dbo.Employees AS EM1
INNER JOIN dbo.Employees EM2
	  ON EM1.EmployeeID <> EM2.EmployeeID
ORDER BY EM1.EmployeeID

--------------------------------------
--MULTY JOIN
SELECT C.CustomerId,
	   C.CompanyName,
	   O.OrderID,
	   SUM(OD.Qty)
FROM dbo.Customers AS C
INNER JOIN dbo.Orders AS O
	  ON C.CustomerID = O.CustomerID
INNER JOIN dbo.OrderDetails AS OD
	  ON O.OrderID = OD.OrderID
WHERE C.State IN(N'تهران')
GROUP BY C.CustomerId,
	   C.CompanyName,
	   O.OrderID
ORDER BY CustomerID

---------------------------------------

SELECT C.CustomerID,
	   C.CompanyName,
	   COUNT(DISTINCT O.OrderID) AS NUM,
	   SUM(OD.Qty)
FROM dbo.Customers AS C
INNER JOIN dbo.Orders AS O
	   ON C.CustomerID = O.CustomerID
INNER JOIN dbo.OrderDetails AS OD
	ON O.OrderID = OD.OrderID
WHERE C.State IN(N'تهران')
GROUP BY C.CustomerID,C.CompanyName

--------------------------------------

SELECT *
FROM dbo.Tests1 AS T1
INNER JOIN dbo.Tests2 AS T2
	   ON T1.TestId = T2.TestId AND
	    T1.TestGuId = T2.TestGuId