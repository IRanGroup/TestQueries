USE[NikamoozDB]
GO

--Counting numbers
WITH TABLE1
AS
(
	SELECT 1 AS NUM
	UNION ALL
	SELECT T1.NUM + 1 FROM TABLE1 AS T1
	WHERE T1.NUM < 100
)
SELECT * FROM TABLE1
GO
--END QUERY


--Employee Subset
WITH Mannager
AS 
(
	SELECT
	EmployeeID,FirstName,LastName,mgrid
	FROM Employees
	WHERE EmployeeID = 4

	UNION ALL

	SELECT 
	E.EmployeeID,E.FirstName,E.LastName,E.mgrid
	FROM Mannager AS M
	JOIN Employees AS E
		ON M.mgrid = E.EmployeeID
	
)
SELECT * FROM Mannager
--END QUERY