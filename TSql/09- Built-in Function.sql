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
String Functions
*/

/*
LEN (string_expression)
DATALENGTH (expression)
طول رشته و تعداد بایت‌های تخصیص داده‌شده به رشته 
*/
-- تفاوت عملکرد با رشته‌های یونیکدی
SELECT LEN(N'سلام');
SELECT DATALENGTH(N'سلام');

SELECT LEN('A');
SELECT DATALENGTH('A');
GO

-- پس از رشته Blank مقادیر
SELECT LEN(N'My String   ');
SELECT DATALENGTH(N'My String   ');
GO

/*
LOWER (character_expression)
UPPER (character_expression)
کوچک و بزرگ کردن کاراکترهای یک رشته
*/
SELECT UPPER('my sTRing');
SELECT LOWER('my sTRing');
GO

/*
RTRIM (character_expression)
LTRIM (character_expression)
حذف فضای خالی از ابتدا یا انتهای رشته
*/
SELECT RTRIM(' str '), LEN(RTRIM(' str '));
SELECT LTRIM(' str '), LEN(LTRIM(' str '));
SELECT RTRIM(LTRIM(' str ')), LEN(RTRIM(LTRIM(' str ')));
GO

/*
LEFT (character_expression,integer_expression) 
RIGHT (character_expression,integer_expression) 
استخراج بخشی از یک رشته از سمت راست یا چپ آن رشته
*/
SELECT LEFT(N'علی رضا',3);
SELECT RIGHT(N'علی رضا',3);

SELECT LEFT(N'علیرضا',3);
SELECT RIGHT(N'علیرضا',3);
GO

SELECT LEFT(N'محمد رضا',4);
GO

/*
SUBSTRING (expression,start,length)
استخراج بخشی از یک رشته
*/
SELECT SUBSTRING('My String',1,2);
GO

SELECT SUBSTRING(N'علی رضا',1,3);
GO

/*
CHARINDEX (expressionToFind,expressionToSearch [,start_location ])
 اولین موقعیتِ کاراکترِ یک عبارت در رشته
*/
SELECT CHARINDEX(' ',N'امیر حسین سعیدی');
GO

SELECT CHARINDEX(N'ین',N'امین حسینی');
GO

SELECT CHARINDEX(N'یک',N'امیر حسین سعیدی');
GO

/*
PATINDEX ('%pattern%',expression)  
 اولین موقعیتِ الگو در رشته
*/
SELECT PATINDEX('%[0-9]%','ab12cd34ef56gh');
GO

/*
REPLACE (string_expression,string_pattern,string_replacement)
جایگزین کردن بخشی از رشته با رشته موردنظر
*/
SELECT REPLACE('my-string    is-simple!','-',' ');
GO

/*
REPLICATE (string_expression,integer_expression)
تکرار یک رشته
*/
SELECT REPLICATE('0',3) + '12345';
GO

/*
STUFF (character_expression,start,length,replaceWith_expression) 
حذف بخشی از رشته و جایگزین کردن رشته موردنظر
*/
SELECT STUFF('Test',2,1,N'***');
GO

DECLARE @MyStr VARCHAR(30);
SET @MyStr= 'SQL Server Management Studio';
SELECT STUFF(@MyStr,1,LEN(@mystr),'SSMS');
GO

/*
REVERSE (string_expression) 
معکوس کردن کاراکترهای یک رشته
*/
SELECT
	FirstName, REVERSE(FirstName) AS Reverse_Val
FROM Employees;
GO

SELECT REVERSE(1234) AS Reversed ;  
GO 

/*
CHOOSE (index, val_1, val_2 [, val_n ])
بازگرداندن یکی از آیتم‌های موجود در یک لیست
*/
SELECT CHOOSE(1,N'مرد',N'زن') AS Result;
SELECT CHOOSE(3,'Group1','Group2','Group3','Group4') AS Result;
SELECT CHOOSE(5,'Group1','Group2','Group3','Group4') AS Result;
GO

/*
ASCII (character_expression)
به‌ازای اولین کاراکتر ASCII ارائه مقدار معادل
*/
SELECT
	ASCII('A') AS A, ASCII('B') AS B,   
	ASCII('a') AS a, ASCII('b') AS b,  
	ASCII(1) AS [1], ASCII(2) AS [2];
GO

SELECT ASCII('Ali') AS Ascii_Code;
GO

SELECT ASCII('ن'), ASCII(N'ن') AS Ascii_Code;
GO

/*
CHAR (integer_expression)
به کاراکتر ASCII تبدیل کد
*/
SELECT
	CHAR(65) AS [65], CHAR(66) AS [66],   
	CHAR(97) AS [97], CHAR(98) AS [98],   
	CHAR(49) AS [49], CHAR(50) AS [50];
GO

SELECT CHAR(63);
GO

/*
UNICODE ('ncharacter_expression')
به‌ازای اولین کاراکتر Unicode ارائه مقدار معادل
*/
SELECT
	UNICODE(N'ي') AS [ي], UNICODE(N'ی') AS [ی],
	UNICODE(N'ك') AS [ك], UNICODE(N'ک') AS [ک];
GO

SELECT UNICODE('ي');
GO

/*
NCHAR (integer_expression)
به کاراکتر Unicode تبدیل کد
*/
SELECT
	NCHAR(1610) AS [1610], NCHAR(1740) AS [1740],
	NCHAR(1603) AS [1603], NCHAR(1705) AS [1705];
GO

/*
Concatenation عملیات
*/
-- + با استفاده از Concatenation عملیات
SELECT 
	EmployeeID, FirstName + N' ' + LastName AS FullName
FROM Employees;
GO

/*
CONCAT با استفاده از تابع Concatenation عملیات
CONCAT (string_value1,string_value2 [,string_valueN ])
*/
SELECT CONCAT('my',',','String',',','is' ,',' ,'simple','!');
GO

SELECT 
	CustomerID, State, Region, City,
CONCAT(State, '*', Region, '*', City) AS Cust_location
FROM Customers;
GO

-- + بازنویسی کوئری بالا با 
SELECT 
	CustomerID, State, Region, City,
	ISNULL(State,'') + '*' + ISNULL(Region,'') + '*' + ISNULL(City,'') AS Cust_location
FROM Customers;
GO

/*
SPACE (integer_expression)
به تعداد عدد ورودی Space افزودن کاراکتر
*/
DECLARE @X VARCHAR(100)='my string'
SELECT @X + ',' + SPACE(10) + @x;  
GO
--------------------------------------------------------------------

/*
Date & Time Functions
*/

/*
GETDATE()
دسترسی به تاریخ جاری
*/
SELECT GETDATE();
GO

/*
YEAR/MONTH/DAY/TIME
تفکیک بخش‌های مختلف یک نوع‌داده از جنس تاریخ
*/
SELECT 
	YEAR('20210803') AS N'سال',
	MONTH('20210803') AS N'ماه',
	DAY('20210803') AS N'روز';
GO

/*
DATENAME
دسترسی به عناوین بخش‌های مختلف تاریخ
*/
SELECT 
	DATENAME(YEAR,'20210815') AS N' سال میلادی',
	DATENAME(MONTH,'20210815') AS N'ماه میلادی',
	DATENAME(DAY,'20210815') AS N'چندمین روز از ماه',
	DATENAME(DAYOFYEAR,'20210815') AS N'چندمین روز از سال',
	DATENAME(WEEKDAY,'20210815')AS N'عنوان روز هفته';
GO

/*
DATEPART
دسترسی به بخش‌های مختلف تاریخ
DATEPART (datepart,date) 
*/
SELECT
	DATEPART(YEAR,'20210815') AS N' سال میلادی',
	DATEPART(MONTH,'20210815') AS N'ماه میلادی',
	DATEPART(DAY,'20210815') AS N'چندمین روز از ماه',
	DATEPART(DAYOFYEAR,'20210815') AS N'چندمین روز از سال',
	DATEPART(WEEKDAY,'20210815')AS N'چندمین روز هفته';
GO

/*
DATEADD()
دست‌کاری بخش‌های مختلف تاریخ موردنظر
DATEADD (datepart,number,date)
*/
SELECT 
	DATEADD(YEAR,1,'2021-08-15') AS N'افزایش سال',
	DATEADD(YEAR,-1,'2021-08-15') AS N'کاهش سال',
	DATEADD(MONTH,1,'2021-08-15') AS N'افزایش ماه',
	DATEADD(MONTH,-1,'2021-08-15') AS N'کاهش ماه',
	DATEADD(DAY,1,'2021-08-15') AS N'افزایش روز',
	DATEADD(DAY,-1,'2021-08-15') AS N'کاهش روز';
GO

/*
DATEDIFF()
DATEDIFF (datepart,startdate,enddate)  
محاسبه اختلاف میان دو تاریخ
*/
SELECT DATEDIFF(DAY,'20130101',GETDATE());
GO

-- از شروع جنگ جهانی اول تا به امروز چند ثانیه گذشته است؟
SELECT DATEDIFF(SECOND,'19140628',GETDATE());
GO

-- SQL Server 2016 تابع جدید در
SELECT DATEDIFF_BIG(SECOND,'19140628',GETDATE());
GO

/*
ISDATE()
تشخیص معتبر بودن تاریخ
DATE/TIME/DATETIME : صرفا برای انواع داده
*/
SELECT ISDATE('20210212'), ISDATE('2000212');
GO

/*
DATEFROMPARTS (year,month,day)
DATETIMEFROMPARTS (year,month,day,hour,minute,seconds,milliseconds)
DATETIME2FROMPARTS (year,month,day,hour minute,seconds,fractions,precision)
تبدیل مقادیر به نوع تاریخ یا زمان
*/
SELECT DATEFROMPARTS(2021,8,13) AS Result;
SELECT TIMEFROMPARTS(17,25,41,0,0) AS Result;
SELECT DATETIME2FROMPARTS (2021,8,13,17,25,41,0,0) AS Result;
GO
--------------------------------------------------------------------

/*
CAST (expression AS data_type [(length)])  
  
CONVERT (data_type [(length)],expression [,style] )  
*/

SELECT
	LastName + ' // ' + CAST(Hiredate AS NCHAR(12))
FROM Employees;
GO

SELECT
	LastName + ' // ' + CONVERT(NCHAR(12),Hiredate)
FROM Employees;
GO

SELECT
	LastName + ' // ' + CONVERT(NCHAR(10),Hiredate,126)
FROM Employees;
GO

/*
TRY_CAST (expression AS data_type [(length)])
TRY_CONVERT (data_type [(length)],expression [,style]) 
تبدیل یک نوع داده به نوع داده دیگر
.می‌شود Null در صورت عدم تبدیل، خروجی
*/
SELECT CAST('1234A' AS INT) AS Result;
GO

SELECT TRY_CAST('123A' AS INT) AS Result;
SELECT TRY_CAST('123' AS INT) AS Result;
GO

SELECT TRY_CONVERT(INT,'123A') AS Result;
SELECT TRY_CONVERT(INT,'123') AS Result;
GO