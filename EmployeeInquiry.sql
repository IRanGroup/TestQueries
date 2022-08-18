USE[NikamoozDB]
GO

--Employees older than 50 years old who have registered more than 100 orders
SELECT LastName,
	   COUNT(O.OrderID)
FROM Employees AS E
INNER JOIN Orders AS O
	ON E.EmployeeID = O.EmployeeID
WHERE DATEDIFF(YEAR,Birthdate,GETDATE()) > 50 
GROUP BY LastName
HAVING COUNT(O.OrderID) >100
GO
--END QURY


--Employees who have not had an order registration since the year on
SELECT EmployeeID,FirstName,LastName
FROM Employees
EXCEPT
SELECT E.EmployeeID,FirstName,LastName
FROM Employees AS E
RIGHT JOIN Orders AS O
	ON E.EmployeeID = O.EmployeeID
WHERE O.OrderDate  > '20160501' 
GROUP BY E.EmployeeID,E.FirstName,E.LastName
GO
--END QUERY




--Initial display of the second cable in two ways
CREATE TABLE Tbl1 
(
 ID INT,
 Code INT);
GO
CREATE TABLE Tbl2 
(
 ID INT,
 Code INT
);
GO
INSERT INTO Tbl1 
VALUES (2,22),(1,11),(3,33),(100,1000);
GO
INSERT INTO Tbl2 
VALUES (20,200),(10,100),(30,300);
GO

(SELECT
   ID, Code ,CASE WHEN ID IS NOT NULL THEN 1 END AS N
FROM Tbl1 
UNION ALL
SELECT
 ID, Code ,CASE WHEN ID IS NOT NULL THEN 0 END AS N
FROM Tbl2)
ORDER BY N
GO

(SELECT
   ID, Code ,1 AS N
FROM Tbl1 
UNION ALL
SELECT
 ID, Code ,0 AS N
FROM Tbl2)
ORDER BY N
GO
--END QUERY