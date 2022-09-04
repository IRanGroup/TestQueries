USE[NikamoozDB]
GO

--The employee who had the lowest order
SELECT E.EmployeeID, E.FirstName ,LastName
FROM Employees AS E
WHERE E.EmployeeID = (SELECT TOP(1) O.EmployeeID
						FROM Orders AS O
						GROUP BY O.EmployeeID
						ORDER BY COUNT(O.OrderDate))

GO

SELECT TOP(1) WITH TIES E.EmployeeID,
			E.FirstName,E.LastName
FROM Employees AS E
ORDER BY (SELECT COUNT(O.OrderID) FROM Orders AS O
			WHERE E.EmployeeID = O.EmployeeID)

GO
--END QUERY


--Customer who ordered in 2015 but did not have one in 2016
(SELECT C.CustomerID, C.CompanyName
FROM Customers AS C
WHERE C.CustomerID IN (SELECT O.CustomerID
					   FROM Orders AS O
					   WHERE C.CustomerID = O.CustomerID
					   GROUP BY O.CustomerID, O.OrderDate
					   HAVING YEAR(O.OrderDate) = '2015'))

EXCEPT
(SELECT C.CustomerID, C.CompanyName
FROM Customers AS C
WHERE C.CustomerID IN (SELECT O.CustomerID
					   FROM Orders AS O
					   WHERE C.CustomerID = O.CustomerID
					   GROUP BY O.CustomerID, O.OrderDate
					   HAVING YEAR(O.OrderDate) = '2016'))
GO

SELECT C.CustomerID, C.CompanyName
FROM Customers AS C
WHERE EXISTS (SELECT 1 FROM Orders AS O
			  WHERE C.CustomerID = O.CustomerID
			  AND YEAR(O.OrderDate) = '2015')
			 AND NOT EXISTS (SELECT 1 FROM Orders AS O
			  WHERE C.CustomerID = O.CustomerID
			  AND YEAR(O.OrderDate) = '2016')
GO

--END QUERY


--There's the first one in Nice.
DROP TABLE IF EXISTS A,B;
GO
CREATE TABLE A
(
ID TINYINT
);
GO
CREATE TABLE B
(
ID TINYINT
);
GO
INSERT INTO A
VALUES (1),(2),(3),(4);
GO
INSERT INTO B
VALUES (2),(NULL);
GO

SELECT A1.ID
FROM A AS A1
WHERE A1.ID NOT IN (SELECT B1.ID FROM B AS B1 WHERE B1.ID IS NOT NULL)

--GO