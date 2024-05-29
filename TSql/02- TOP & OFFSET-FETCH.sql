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
--------------------------------------------------------------------

/*
TOP
*/

-- فهرست آخرین 10 سفارش ثبت‌شده
SELECT 
	TOP (10) OrderID, OrderDate
FROM Orders
ORDER BY OrderDate DESC;
GO

-- فهرست 10 درصد از آخرین سفارشات ثبت‌شده
SELECT 
	TOP (10) PERCENT OrderID, OrderDate
FROM Orders
ORDER BY OrderDate;
GO

--  فهرست 10 سفارش ثبت‌شده اخیر با درنظر گرفتن سایر مقادیر برابر
SELECT 
	TOP (10) WITH TIES OrderID, OrderDate
FROM Orders
ORDER BY OrderDate DESC;
GO

-- ORDER BY بدون TOP عملکرد
SELECT 
	TOP (10) OrderID, OrderDate
FROM Orders;
GO
--------------------------------------------------------------------

/*
OFFSET [integer_constant | offset_row_count_expression] { ROW | ROWS } 
FETCH { FIRST|NEXT } [integer_constant | offset_row_count_expression] { ROW|ROWS } ONLY
*/

-- فهرست آخرین 10 سفارش ثبت‌شده
SELECT
	OrderID, OrderDate, CustomerID, EmployeeID
FROM Orders
ORDER BY OrderDate DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
GO

-- فهرست جدیدترین 5 سفارش پس از 10 سفارش اخیر
SELECT 
	OrderID, OrderDate, CustomerID, EmployeeID
FROM Orders
ORDER BY OrderDate DESC
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;
GO

-- FETCH بدون OFFSET
SELECT 
	OrderID, OrderDate, CustomerID, EmployeeID
FROM Orders
ORDER BY OrderDate DESC
OFFSET 10 ROWS;
GO

-- !قابل اجرا نیست OFFSET بدون FETCH
SELECT 
	OrderID, OrderDate, CustomerID, EmployeeID
FROM Orders
ORDER BY OrderDate DESC
FETCH NEXT 5 ROWS ONLY;
GO

