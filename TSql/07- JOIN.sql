--------------------------------------------------------------------
/*
ویژه برنامه نویسان SQL Server دوره آموزشی 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Mehdi Shishebori
*/
--------------------------------------------------------------------

USE NikamoozDB_Programmer;
GO

/*
CROSS JOIN: ANSI SQL-92
SELECT 
	<SELECT list>
FROM <table1>
CROSS JOIN <table2>;


CROSS JOIN: ANSI SQL-89
SELECT 
	<SELECT list>
FROM <table1>, <table2>;
*/

-- CROSS JOIN: ANSI SQL-92
SELECT
	C.CustomerID, O.EmployeeID
FROM Customers AS C
CROSS JOIN Orders AS O;
GO

-- CROSS JOIN: ANSI SQL-89
SELECT
	C.CustomerID, O.EmployeeID
FROM Customers AS C, Orders AS O;
GO
--------------------------------------------------------------------

-- SELF JOIN
SELECT
	E1.EmployeeID, E1.FirstName, E1.LastName,
	E2.EmployeeID, E2.FirstName, E2.LastName
FROM Employees AS E1
CROSS JOIN Employees AS E2
ORDER BY E1.FirstName, E1.LastName;
GO
--------------------------------------------------------------------

/*
INNER JOIN: ANSI SQL-92
SELECT 
	<SELECT list>
FROM <table1>
[INNER] JOIN <table2>
ON ...

INNER JOIN: ANSI SQL-89
SELECT 
	<SELECT list>
FROM <table1>, <table2>
	WHERE ...
*/

-- INNER JOIN: ANSI SQL-92
SELECT
	E.EmployeeID, E.FirstName, E.LastName, O.orderid
FROM Employees AS E
JOIN Orders AS O
	ON E.EmployeeID = O.EmployeeID
	WHERE E.LastName LIKE N'[^ا]%'
ORDER BY E.LastName;
GO

-- INNER JOIN: ANSI SQL-89
SELECT
	E.EmployeeID, E.FirstName, E.LastName, O.orderid
FROM Employees AS E, Orders AS O
	WHERE E.EmployeeID = O.EmployeeID
	AND E.LastName LIKE N'[^ا]%'
ORDER BY E.LastName;
GO

-- Composite Join
DROP TABLE IF EXISTS Composite1, Composite2;
GO

CREATE TABLE Composite1
	(
		ID1 INT,
		ID2 INT,
		Family NVARCHAR(50)
	);
GO

CREATE TABLE Composite2
	(
		ID1 INT,
		ID2 INT,
		Serial INT IDENTITY,
		CheckedDate CHAR(10) DEFAULT GETDATE()
	);
GO

INSERT INTO Composite1
	VALUES	(1, 10, N'مشکاتیان'),
			(1, 20, N'رضوانی'),
			(2, 10, N'شفیعی'),
			(2, 20, N'پورمند');
GO

INSERT INTO Composite2(ID1,ID2)
	VALUES	(1,10),(1,10),(1,20),(1,20),
			(2,10),(1,10),(1,10),(2,10);
GO

SELECT * FROM Composite1;
SELECT * FROM Composite2;
GO

SELECT C1.Family, C2.Serial
FROM Composite1 AS C1
JOIN Composite2 AS C2
	ON C1.ID1 = C2.ID1
	AND C1.ID2 = C2.ID2;
GO

SELECT C1.Family, C2.Serial
FROM Composite1 AS C1
JOIN Composite2 AS C2
	ON C1.ID1 = C2.ID1;
GO

-- Non-Equi Join
SELECT
	E1.EmployeeID, E1.FirstName, E1.LastName,
	E2.EmployeeID, E2.FirstName, E2.LastName
FROM Employees AS E1
JOIN Employees AS E2
	ON E1.EmployeeID < E2.EmployeeID
ORDER BY E1.EmployeeID;
GO
--------------------------------------------------------------------

/*
OUTER JOIN: ANSI SQL-92

SELECT 
	<SELECT list>
FROM <table1>
LEFT | RIGHT | FULL [OUTER] JOIN <table2>
*/

-- .فهرست سفارش تمامی مشتریان حتی آن‌هایی که سفارش نداشته‌اند
SELECT
	C.CustomerID, C.CompanyName, O.OrderID
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
ORDER BY C.CustomerID;
GO

-- .فهرست سفارش تمامی مشتریان حتی آن‌هایی که سفارش نداشته‌اند
SELECT
	C.CustomerID, C.CompanyName, O.OrderID
FROM Orders AS O
RIGHT JOIN Customers AS C
	ON C.CustomerID = O.CustomerID
ORDER BY C.CustomerID;
GO

-- .فهرست مشتریانی که سفارش نداشته‌اند
SELECT
	C.CustomerID ,C.CompanyName , O.OrderID
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
	WHERE O.OrderID IS NULL
ORDER BY C.CustomerID;
GO

-- مقایسه با کوئری بالایی
SELECT
	C.CustomerID ,C.CompanyName , O.OrderID
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
	AND O.OrderID IS NULL
ORDER BY C.CustomerID;
GO

-- فهرست جزئیات سفارش تمامی مشتریان حتی آن‌هایی که سفارش هم نداشته‌اند به سه روش و مقایسه آن‌ها 
SELECT 
	C.CustomerID,
	O.OrderID,
	OD.ProductID, OD.Qty
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
	ON C.CustomerID = O.CustomerID
LEFT JOIN Sales.OrderDetails AS OD
	ON O.OrderID = OD.OrderID;
GO

SELECT
	C.CustomerID,
	O.OrderID,
	OD.ProductID,
	OD.Qty
FROM Sales.Orders AS O
JOIN Sales.OrderDetails AS OD
	ON O.OrderID = OD.OrderID
RIGHT JOIN Sales.Customers AS C
	ON O.CustomerID = C.CustomerID;
GO

SELECT
	C.CustomerID,
	O.OrderID,
	OD.ProductID,
	OD.Qty
FROM Sales.Customers AS C
LEFT JOIN
	(Sales.Orders AS O
		JOIN Sales.OrderDetails AS OD
			ON O.OrderID = OD.OrderID)
	ON C.CustomerID = O.CustomerID;
GO