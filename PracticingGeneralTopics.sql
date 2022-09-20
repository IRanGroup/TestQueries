USE[NikamoozDB]
GO

--Total number of customer orders in Tehran, Shiraz and Isfahan

--INNER JOIN
SELECT C.City,COUNT(O.OrderID) AS NUM
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
WHERE City IN (N'تهران',N'شیراز',N'اصفهان')
GROUP BY C.City
GO
--END QUERY


--SUB QUERY
SELECT C.City,
	(SELECT COUNT(O.OrderID) FROM Orders AS O
	 WHERE EXISTS(SELECT 1 FROM Customers AS C1
				  WHERE C1.CustomerID = O.CustomerID
				  AND C.City = C1.City)) AS NUM
FROM Customers AS C
WHERE City IN (N'تهران',N'شیراز',N'اصفهان')
GROUP BY C.City
GO
--END QUERY

--DRIVED TABLE
SELECT TMP.City,SUM(TMP.NUM) AS NUM
FROM (SELECT C.City,
	  (SELECT COUNT(O.OrderID) FROM Orders AS O
	   WHERE C.CustomerID = O.CustomerID) AS NUM
	  FROM Customers AS C
	  WHERE City IN (N'تهران',N'شیراز',N'اصفهان')) AS TMP
GROUP BY TMP.City
GO
--END QUERY

--CTE
WITH CustomerTEH
AS 
(
	SELECT C.City,
		(SELECT COUNT(O.OrderID) FROM Orders AS O
			WHERE C.CustomerID = O.CustomerID) AS NUM
	FROM Customers AS C
	WHERE C.City IN (N'تهران',N'شیراز',N'اصفهان')
	GROUP BY C.City,C.CustomerID
)
SELECT CT.City,SUM(CT.NUM) AS NUM
FROM CustomerTEH AS CT
GROUP BY CT.City
GO
--END QURY

--New Practice QUERY analysis. Rewriting with CTE

--JOIN
SELECT
	E.EmployeeID, OE.NumOrders, OE.MaxDate
	,OM.Employeeid, OM.NumOrders, OM.MaxDate
FROM dbo.Employees AS E
JOIN
(SELECT
	EmployeeID, COUNT(*) AS NumOrders, MAX(OrderDate) AS MaxDate
 FROM dbo.Orders
 GROUP BY EmployeeID) AS OE
	ON E.EmployeeID = OE.EmployeeID
LEFT JOIN
(SELECT
	EmployeeID, COUNT(*) AS NumOrders, MAX(OrderDate) AS MaxDate
 FROM dbo.Orders
 GROUP BY EmployeeID) AS OM
	ON E.mgrid = OM.EmployeeID;
GO
--END QUERY

--CTE
WITH Emp_Cnt_Max
AS
(
	SELECT
		EmployeeID, COUNT(*) AS NumOrders, MAX(OrderDate) AS MaxDate
	FROM dbo.Orders
	GROUP BY EmployeeID
)
SELECT
	ECM1.EmployeeID, ECM1.NumOrders, ECM1.MaxDate,
	ECM2.EmployeeID, ECM2.NumOrders, ECM2.MaxDate
FROM Emp_Cnt_Max AS ECM1
JOIN dbo.Employees AS E
	ON E.EmployeeID = ECM1.EmployeeID
LEFT JOIN Emp_Cnt_Max AS ECM2
	ON E.mgrid = ECM2.EmployeeID;
GO

--CTE ME
WITH EmployesCTE
AS
(
	SELECT EmployeeID,
			(SELECT mgrid
			FROM Employees AS E1 WHERE E1.EmployeeID =O.EmployeeID) AS Mgid,
			MAX(O.OrderDate) AS MaxDate,
			COUNT(*) AS NumOrder
	FROM Orders AS O
	GROUP BY EmployeeID
)
SELECT EC.EmployeeID,EC.NumOrder,EC.MaxDate,
	   E12.EmployeeID,E12.NumOrder,E12.MaxDate
FROM EmployesCTE AS EC
LEFT JOIN  EmployesCTE E12
	ON EC.Mgid = E12.EmployeeID
GO
--END QUERY


WITH MannagerEM
AS
(
   SELECT E1.EmployeeID, E1.mgrid, E1.FirstName, E1.LastName
   FROM Employees AS E1
   WHERE E1.EmployeeID = 9

   UNION ALL

   SELECT E.EmployeeID, E.mgrid, E.FirstName,E.LastName
   FROM MannagerEM AS CTE
   JOIN Employees AS E 
   ON E.EmployeeID = CTE.mgrid
)
SELECT * FROM MannagerEM









