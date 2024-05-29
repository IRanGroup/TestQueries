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

-- لیست تمامی محصولات
SELECT
	ProductID, ProductName, CategoryID
FROM Products;
GO

-- Simple CASE
SELECT 
	ProductID, ProductName, CategoryID,
	CASE CategoryID
		WHEN 1 THEN N'نوشیدنی'
		WHEN 2 THEN N'ادویه‌جات'
		WHEN 3 THEN N'مرباجات'
		WHEN 4 THEN N'محصولات لبنی'
		WHEN 5 THEN N'حبوبات'
		WHEN 6 THEN N'گوشت و مرغ'
		WHEN 7 THEN N'ارگانیک'
		WHEN 8 THEN N'دریایی'
		ELSE N'متفرقه'
	END AS CategoryName
FROM Products
ORDER BY CategoryName;
GO
--------------------------------------------------------------------

-- Searched CASE
SELECT ProductID, UnitPrice,
	CASE
		WHEN UnitPrice < 50 THEN N'کمتر از 50'
		WHEN UnitPrice BETWEEN 50 AND 100 THEN N'بین 50 تا 100'
		WHEN UnitPrice > 100 THEN N'بیشتر از 100'
	ELSE N'نامشخص'
	END AS UnitPriceCategory
FROM OrderDetails
ORDER BY UnitPrice;
GO
--------------------------------------------------------------------

--  NULL رفع مشکل مرتب‌سازی و مقادیر 
SELECT 
	CustomerID, Region
FROM Sales.Customers 
ORDER BY Region;
GO

SELECT 
	CustomerID, Region
FROM Sales.Customers 
ORDER BY Region DESC;
GO

SELECT
	CustomerID, Region
FROM Sales.Customers
ORDER BY 
	CASE
		WHEN Region IS NULL THEN 1
		ELSE 0 
	END;
GO