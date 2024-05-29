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

-- Aggregate Function
DROP TABLE IF EXISTS GroupTable;
GO

CREATE TABLE GroupTable
	(
		Score INT
	);
GO

INSERT INTO GroupTable
	VALUES (2),(3),(4),(10),(NULL);
GO

SELECT
	COUNT(Score) AS Num,
	SUM(Score) AS Total ,
	MAX(Score) AS MaxVal,
	MIN(Score) MinVal,
	AVG(Score * 1.00) AS AvgVal
FROM GroupTable;
GO

-- NULL بر رو مقادیر COUNT(*) تاثیر
SELECT
	COUNT(Score) AS Num
FROM GroupTable;
GO

SELECT
	COUNT(*) AS Num
FROM GroupTable;
GO
--------------------------------------------------------------------

-- GROUP BY Query

-- .سفارشات هر کارمند به تفکیک سال که شامل تعداد کل سفارش و مجموع کرایه‌های ثبت شده باشد
SELECT
	EmployeeID, YEAR(OrderDate) AS Order_Year,
	COUNT (OrderID) AS Num,
	SUM (Freight) AS TotalFreight
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate)
ORDER BY Order_Year;
GO

-- .تعداد سفارشات بالای 70 قلم و سفارشاتی که توسط کارمند شماره 9 ثبت نشده است
SELECT
	EmployeeID,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE EmployeeID <> 9
	AND COUNT(OrderID) > 70
GROUP BY EmployeeID;
GO

SELECT
	EmployeeID,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE EmployeeID <> 9
GROUP BY EmployeeID
	HAVING COUNT(OrderID) > 70;
GO
--------------------------------------------------------------------

-- GROUP BY ALL
SELECT 
	EmployeeID, 
	COUNT(OrderID) AS Num
FROM Orders
	WHERE EmployeeID BETWEEN 1 AND 3
GROUP BY ALL EmployeeID
ORDER BY EmployeeID;
GO

SELECT 
	EmployeeID, 
	COUNT(OrderID) AS Num
FROM Orders
	WHERE EmployeeID BETWEEN 1 AND 3
GROUP BY ALL EmployeeID
	HAVING COUNT(OrderID) > 100
ORDER BY EmployeeID;
GO