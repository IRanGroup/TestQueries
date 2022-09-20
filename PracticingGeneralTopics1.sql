USE[NikamoozDB]
GO


WITH Employees_CTE
AS
(
	SELECT
	EmployeeID, Mgrid, Firstname, Lastname, 1 AS EmployeeLevel
	FROM dbo.Employees
	WHERE EmployeeID = 2 -- Anchor_Member

	UNION ALL

	SELECT
	E.EmployeeID, E.Mgrid, E.Firstname, E.Lastname, Emp_CTE.EmployeeLevel+1
	FROM Employees_CTE AS Emp_CTE
	JOIN dbo.Employees AS E
	ON E.Mgrid = Emp_CTE.EmployeeID -- Recursive_Member
)
SELECT
EmployeeID, Mgrid, Firstname, Lastname, EmployeeLevel
FROM Employees_CTE;
GO
--END QUERY

--VIEW
CREATE VIEW EmployeeOrderS
AS
SELECT O.EmployeeID,YEAR(O.OrderDate) AS OrderYear,SUM(OD.Qty) AS Quntity
FROM Orders AS  O
JOIN OrderDetails AS OD
	ON O.OrderID = OD.OrderID
GROUP BY O.EmployeeID,YEAR(O.OrderDate)
GO

