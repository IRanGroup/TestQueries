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

-- Accept TRUE
SELECT 
	CustomerID, State, Region, City
FROM Customers -- 91 Record
	WHERE Region = N'جنوب';
GO

SELECT
	CustomerID, State, Region, City
FROM Customers
	WHERE Region <> N'جنوب'; -- 91 Record - 1 Record  = 90 Record
GO

-- .ارزیابی می‌شود UNKNOWN به صورت NULL = NULL عبارت
SELECT 
	CustomerID, State, Region, City
FROM Customers
	WHERE Region = NULL;
GO

-- UNKNOWN بر روی مقادیر NOT عدم تاثیر
SELECT 
	CustomerID, State, Region, City
FROM Customers
	WHERE NOT (Region) = NULL;
GO

-- NULL نمایش رکوردها با مقادیر
SELECT 
	CustomerID, State, Region, City
FROM Customers
	WHERE Region IS NULL;
GO

-- NULL نمایش رکوردها با مقادیر غیر
SELECT 
	CustomerID, State, Region, City
FROM Customers
	WHERE Region IS NOT NULL;
GO

-- NULL نمایش تمامی رکوردها که از منطقه جنوب نباشد حتی با مقادیر
SELECT 
	CustomerID, State, Region, City
FROM Customers
	WHERE Region <> N'جنوب'
	OR Region IS NULL;
GO

-- NULL نمایش تمامی رکوردها که از منطقه جنوب نباشد حتی با مقادیر
SELECT 
	CustomerID, State, Region, City
FROM Customers
	WHERE ISNULL(Region,'') <> N'جنوب';
GO
--------------------------------------------------------------------

-- Reject False
DROP TABLE IF EXISTS ChkConstraint;
GO

CREATE TABLE ChkConstraint
	(
		ID INT NOT NULL IDENTITY,
		Family NVARCHAR(100),
		Score INT CONSTRAINT CHK_Positive CHECK(Score >= 0)
	);
GO

-- TRUE پذیرش مقدار
INSERT INTO ChkConstraint(Family,Score)  
	VALUES (N'داوری', 100);
GO

-- NULL پذیرش مقدار
INSERT INTO ChkConstraint(Family)  
	VALUES (N'شهسواری');
GO

-- FALSE عدم پذیرش مقدار
INSERT INTO ChkConstraint(Family,Score)  
	VALUES (N'جمالیان', -10);
GO

SELECT * FROM ChkConstraint;
GO