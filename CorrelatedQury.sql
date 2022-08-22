USE[NikamoozDB]



--Customers whose order registration code is individual
SELECT C.CompanyName, C.CustomerID
FROM Customers AS C
WHERE CustomerID NOT IN (SELECT	CustomerID
						 FROM Orders 
						WHERE OrderID % 2 =0)
GO
--END QURY



--Number of order registrations of companies and companies that have not registered an order
SELECT C.CustomerID, C.CompanyName,
		(SELECT COUNT(*) FROM Orders AS O
		 WHERE C.CustomerID = O.CustomerID)
FROM Customers AS C
GO
--LEFT JOIN method 
SELECT C.CustomerID, C.CompanyName,
	   COUNT(O.OrderID)
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
GO
--END QURY



--Date of last order registration of companies
SELECT C.CustomerID, C.CompanyName,
	   (SELECT MAX(O.OrderDate) FROM Orders AS O
	   WHERE O.CustomerID = C.CustomerID)
FROM Customers AS  C

--END QURY 




--Customers who have ever registered an order
SELECT * 
FROM Customers AS C
	WHERE EXISTS (SELECT 1 FROM Orders AS O
			  WHERE C.CustomerID = O.CustomerID)
GO
--END QURY



--Name of employees who have ordered 18 orders with customers   
SELECT E.FirstName, E.LastName
FROM Employees AS E
WHERE  E.EmployeeID IN (SELECT O.EmployeeID
	   FROM Orders AS O
	   WHERE CustomerID = 18)
GO

SELECT E.FirstName, E.LastName
FROM Employees AS E
WHERE  EXISTS (SELECT 1
	   FROM Orders AS O
	   WHERE CustomerID = 18
	   AND E.EmployeeID = O.EmployeeID)
GO
--END QURY