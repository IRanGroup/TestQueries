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

-- SELECT * بررسی معایب
SELECT * FROM OrderDetails;
GO

SELECT OrderID, ProductID, Qty FROM OrderDetails;
GO

-- Alias
SELECT * FROM OrderDetails AS OD;
GO

SELECT
	E.FirstName + E.LastName AS FullName
FROM Employees AS E;
GO
--------------------------------------------------------------------

-- WHERE
SELECT
	CustomerID, EmployeeID, OrderDate, OrderID
FROM Orders
	WHERE CustomerID = 70;
GO

SELECT
	CustomerID, EmployeeID, OrderDate, OrderID
FROM Orders
	WHERE CustomerID = 70
	AND OrderID > 10300;
GO

SELECT
	CustomerID, EmployeeID, OrderDate, OrderID
FROM Orders
	WHERE CustomerID = 70
	OR CustomerID = 80
	OR CustomerID = 90;
GO
--------------------------------------------------------------------

-- IN
SELECT
	CustomerID, EmployeeID, OrderDate, OrderID
FROM Orders
	WHERE CustomerID IN (70, 80, 90);
GO

-- NOT IN
SELECT
	CustomerID, EmployeeID, OrderDate, OrderID
FROM Orders
	WHERE CustomerID NOT IN (70, 80, 90);
GO
--------------------------------------------------------------------

-- BETWEEN
SELECT
	CustomerID, EmployeeID, OrderDate , OrderID
FROM Orders
	WHERE EmployeeID BETWEEN 5 AND 7;
GO

-- IN و BETWEEN مقایسه
USE AdventureWorksDW2019;
GO

SET STATISTICS IO ON;
GO

SELECT
	ProductKey, MovementDate, UnitCost
FROM FactProductInventory
	WHERE ProductKey IN (1, 2, 3, 4, 5);

SELECT
	ProductKey, MovementDate, UnitCost
FROM FactProductInventory
	WHERE ProductKey BETWEEN 1 AND 5;
GO
--------------------------------------------------------------------

USE NikamoozDB_Programmer;
GO

/*
[NOT] LIKE Pattern [ESCAPE escape_character]

% : Any string of zero or more characters.
_ (underscore) : Any single character.
[ ] : Any single character within the specified range ([a-f]) or set ([abcdef]).
[^] : Any single character not within the specified range ([^a-f]) or set ([^abcdef]). 
*/

-- .کارمندانی که نام‌خانوادگی‌شان با حرف ت شروع می‌شود
SELECT * FROM Employees
	WHERE LastName LIKE N'ت%';
GO

-- .کارمندانی که نام‌خانوادگی‌شان با حرف ت شروع نمی‌شود
SELECT * FROM Employees
	WHERE LastName NOT LIKE N'ت%';
GO
SELECT * FROM Employees
	WHERE LastName LIKE N'[^ت]%';
GO

-- .کارمندانی که نام‌خانوادگی‌شان به حرف ی ختم می‌شود
SELECT * FROM Employees
	WHERE LastName LIKE N'%ی';
GO

-- .کارمندانی که نام‌خانوادگی‌شان با یکی از حرف الف تا پ شروع می‌شود
SELECT * FROM Employees
	WHERE LastName LIKE N'[ا-پ]%';
GO

-- .کارمندانی که نام‌ آن‌ها سه کاراکتری است و با حرف س شروع می‌شود
SELECT * FROM Employees
	WHERE FirstName LIKE N'س__';
GO

CREATE TABLE #Temp_Tbl
(
	Col1 VARCHAR(100)
);
GO

INSERT INTO #Temp_Tbl
	VALUES	('Test With [ Value'),
			('Test With _ Value'),
			('Test % Value');
GO

SELECT * FROM #Temp_Tbl
	WHERE Col1 LIKE '%[%';
GO

SELECT * FROM #Temp_Tbl
	WHERE Col1 LIKE '%[[]%';
GO

SELECT * FROM #Temp_Tbl
	WHERE Col1 LIKE '%*[%' ESCAPE'*';
GO
--------------------------------------------------------------------

/*
Arithmetic Operators:
	+   –   *   /   % 
*/

-- محاسبه تخفیف کل
SELECT 
	OrderID, productid, qty, unitprice, discount,
	Qty * UnitPrice * (1 - Discount) AS val
FROM OrderDetails;
GO
--------------------------------------------------------------------

/*
اولویت اجرای اپراتورها

1. ( ) (Parentheses)
2. * (Multiplication), / (Division), % (Modulo)
3. + (Positive), – (Negative), + (Addition), + (Concatenation), – (Subtraction)
4. =, >, <, >=, <=, <>, !=, !>, !< (Comparison operators)
5. NOT
6. AND
7. BETWEEN, IN, LIKE, OR
8. = (Assignment)
*/
--------------------------------------------------------------------

-- ORDER BY
SELECT 
	EmployeeID, YEAR(OrderDate) AS Order_Year
FROM dbo.Orders
	WHERE CustomerID = 80;
GO

SELECT
	EmployeeID, YEAR(OrderDate) AS Order_Year
FROM dbo.Orders
	WHERE CustomerID = 80
ORDER BY EmployeeID DESC; -- Default: ASC
GO


-- ORDER BY در SELECT استفاده از اسامی مستعار بخش
SELECT
	EmployeeID, YEAR(OrderDate) AS Order_Year
FROM dbo.Orders
	WHERE CustomerID = 71
ORDER BY  Order_Year;
GO

-- مرتب‌سازی بر روی بیش از یک ستون
SELECT 
	EmployeeID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders
	WHERE CustomerID = 71
ORDER BY  EmployeeID DESC, OrderYear;
GO
--------------------------------------------------------------------

-- DISTINCT
SELECT 
	DISTINCT EmployeeID, YEAR(OrderDate) AS Order_Year
FROM Orders
	WHERE CustomerID = 80
ORDER BY EmployeeID;
GO

-- ORDER BY و DISTINCT چالش
SELECT 
	 DISTINCT State
FROM Employees
ORDER BY EmployeeID;
GO