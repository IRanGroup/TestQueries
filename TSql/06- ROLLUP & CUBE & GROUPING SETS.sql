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
ROLLUP (A,B,C):
(A,B,C)
(A,B)
(A)
()
*/
SELECT
	CustomerID,
	COUNT(OrderID) AS Num
FROM Orders
GROUP BY ROLLUP (CustomerID); -- GROUP BY CustomerID WITH ROLLUP
GO

SELECT
	EmployeeID,
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE EmployeeID IN (1,2)
GROUP BY ROLLUP(EmployeeID, YEAR(OrderDate), MONTH(OrderDate)); -- GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate) WITH ROLLUP
GO
--------------------------------------------------------------------

/*
CUBE (A,B,C):
(A,B,C)
(A,B)
(A,C)
(B,C)
(A)
(B)
(C)
()
*/
SELECT
	EmployeeID,
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	COUNT(OrderID) AS Num
FROM Orders
GROUP BY CUBE (EmployeeID, YEAR(OrderDate), MONTH(OrderDate)); -- GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate) WITH CUBE
GO

/*
GROUPING Function
تشخیص فیلدهای غایب در گروه‌بندی
CUBE و ROLLUP قابل استفاده در
*/
SELECT
	EmployeeID,
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	COUNT(OrderID) AS Num,
	GROUPING (EmployeeID) AS GROUPING_EmployeeID,
	GROUPING (YEAR(OrderDate)) AS GROUPING_Year,
	GROUPING (MONTH(OrderDate)) AS GROUPING_Month
FROM Orders
GROUP BY CUBE(EmployeeID, YEAR(OrderDate), MONTH(OrderDate));
GO
--------------------------------------------------------------------

/*
GROUPING SETS
*/

-- تمامی سفارشات درخواست‌شده از مشتری 1 یا 2 به‌تفکیک هر کارمند-مشتری
SELECT
	EmployeeID,
	CustomerID,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY EmployeeID, CustomerID;
GO

-- تمامی سفارشات مشتری 1 یا 2 به‌تفکیک هر سال
SELECT
	CustomerID, 
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1
	OR CustomerID = 2
GROUP BY CustomerID, YEAR(OrderDate);
GO

-- تمامی سفارشات ثبت‌شده توسط هر کارمند با مشتری 1 یا 2 و به تفکیک هر سال
SELECT
	EmployeeID, 
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY EmployeeID, YEAR(OrderDate);
GO

SELECT 	
	EmployeeID,
	CustomerID,
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID=1 
	OR CustomerID=2
GROUP BY GROUPING SETS 
	(
		(EmployeeID,CustomerID),
		(EmployeeID,YEAR(OrderDate)),
		(CustomerID,YEAR(OrderDate))
	);
GO
/*
:تذکر مهم
(Aggregate Columns) آمده‌اند به‌جز SELECT تمامی فیلدهایی که جلو
.شرکت داشته باشند GROUPING SETS می‌بایست به‌نوعی در ترکیب
*/

/*
Grouping_ID
با استفاده از این تابع می توان فهمید که گروه‌بندی به‌ازای
.کدامیک از ستون ها انجام شده و چه فیلدی در نتیجه ‌نهایی غایب است

-- ارزش بیتی 
GROUPING_ID(EmployeeID, CustomerID, YEAR(OrderDate))
				2^2		   2^1			 2^0
*/

SELECT 	
	EmployeeID,
	CustomerID,
	YEAR(OrderDate) AS OrderYear,
	GROUPING_ID(EmployeeID, CustomerID, YEAR(OrderDate)) AS GROUPING_ID_Field
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY GROUPING SETS 
	(
		(EmployeeID,CustomerID),
		(EmployeeID,YEAR(OrderDate)),
		(CustomerID,YEAR(OrderDate))
	);
GO

SELECT 	
	EmployeeID,
	CustomerID,
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1 
	   OR CustomerID = 2
GROUP BY GROUPING SETS 
	(
		(EmployeeID,CustomerID),
		(EmployeeID,YEAR(OrderDate)),
		(CustomerID,YEAR(OrderDate))
	)
ORDER BY
	CASE
		WHEN YEAR(OrderDate) IS NULL THEN 1
		WHEN EmployeeID IS NULL THEN 2
		WHEN CustomerID IS NULL THEN 3
	END;
GO
