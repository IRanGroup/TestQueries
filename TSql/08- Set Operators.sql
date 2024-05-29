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
UNION ALL

Table1:m
Table2:n
--------
Records: m+n
*/

SELECT State, Region, City FROM Employees
UNION ALL
SELECT State, Region, City FROM Customers;
GO

-- UNION
SELECT State, Region, City FROM Employees
UNION
SELECT State, Region, City FROM Customers;
GO

-- Set Operator نام ستون‌ها در عملیات
SELECT State AS N'استان', Region, City FROM Employees
UNION ALL
SELECT State, Region, City FROM Customers;
GO

-- Set Operator مرتب‌سازی در
SELECT State, Region, City FROM Employees
ORDER BY Region
UNION ALL
SELECT State, Region, City FROM Customers;
GO

SELECT State, Region, City FROM Employees
UNION ALL
SELECT State, Region, City FROM Customers
ORDER BY Region;
GO

-- برابری تعداد فیلدهای تمامی مجموعه‌ها ‌    
SELECT State, Region, City FROM Employees
UNION
SELECT State, Region FROM Customers;
GO

-- تطابق میان نوع‌داده فیلدهای هر یک از مجموعه‌ها
SELECT OrderDate FROM Orders
UNION
SELECT City FROM Customers AS C;
GO
--------------------------------------------------------------------

-- UNION یا UNION ALL
USE AdventureWorks2019;
GO

SELECT
	SalesOrderID,
	COUNT(SalesOrderID) AS Num 
FROM Sales.SalesOrderHeader
GROUP BY SalesOrderID
ORDER BY Num DESC;
GO

SELECT
	BusinessEntityID,
	COUNT(BusinessEntityID) AS Num 
FROM Person.Person
GROUP BY BusinessEntityID
ORDER BY Num DESC;
GO

SET STATISTICS IO ON;
GO

SELECT SalesOrderID FROM Sales.SalesOrderHeader
UNION ALL
SELECT BusinessEntityID FROM Person.Person;
GO

SELECT SalesOrderID FROM Sales.SalesOrderHeader
UNION
SELECT BusinessEntityID FROM Person.Person;
GO
--------------------------------------------------------------------

USE NikamoozDB_Programmer;
GO

-- INTERSECT
SELECT State, Region, City FROM Employees
INTERSECT
SELECT State, Region, City FROM Customers;
GO
--------------------------------------------------------------------

-- EXCEPT
SELECT State, Region, City FROM Employees
EXCEPT
SELECT State, Region, City FROM Customers;
GO
--------------------------------------------------------------------

/*
ها Set Operator اولویت

1- INTERSECT
2- EXCEPT\UNION
*/
 
SELECT State, Region, City FROM Suppliers
EXCEPT
SELECT State, Region, City FROM Employees
INTERSECT
SELECT State, Region, City FROM Customers;
GO