USE[NikamoozDB]
GO


------------------------------
--BRING COMMONALITIES ! INTERSECT

SELECT E.City,E.Region,E.State
FROM Employees AS E
INTERSECT 
SELECT C.City,C.Region,C.State
FROM Customers AS C
-----------------------------
--ABOVE QUERY USING INNERR JOIN 

SELECT E.City,E.Region,E.State
FROM Employees AS E
INNER JOIN Customers AS C
		ON E.City = C.City 
		AND E.Region = C.Region
		AND E.State = C.State
GROUP BY E.City,E.Region,E.State

-------------------------------------
--IT SHOULD BE IN THE FIRST RESULT,BUT NOT IN THE SECOND

SELECT City,Region,State
FROM Employees
EXCEPT
SELECT City,Region,State
FROM Customers