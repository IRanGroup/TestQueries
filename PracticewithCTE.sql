USE[NikamoozDB]
GO

-- تعداد مشتریان به‌ازای هر سال
SELECT
	YEAR(O1.OrderDate) AS OrderYear,
	COUNT(DISTINCT O1.CustomerID) AS Cust_Num
FROM dbo.Orders AS O1
GROUP BY YEAR(O1.OrderDate);
GO

SELECT
	YEAR(O1.OrderDate) AS OrderYear,
	COUNT(DISTINCT O1.CustomerID) AS Cust_Num,
	YEAR(O2.OrderDate) AS OrderYear,
	COUNT(DISTINCT O2.CustomerID) AS Cust_Num
FROM dbo.Orders AS O1
JOIN dbo.Orders AS O2
	ON YEAR(O1.OrderDate) = YEAR(O2.OrderDate)
GROUP BY YEAR(O1.OrderDate), YEAR(O2.OrderDate);
GO

-- ON کوئری بالا با تغییر در بخش
SELECT
	YEAR(O1.OrderDate) AS OrderYear,
	COUNT(DISTINCT O1.CustomerID) AS Cust_Num,
	YEAR(O2.OrderDate) AS OrderYear,
	COUNT(DISTINCT O2.CustomerID) AS Cust_Num
FROM dbo.Orders AS O1
JOIN dbo.Orders AS O2
	ON YEAR(O1.OrderDate) = YEAR(O2.OrderDate) + 1
GROUP BY YEAR(O1.OrderDate), YEAR(O2.OrderDate);
GO

-- JOIN حل تمرین با استفاده از
SELECT
	YEAR(O1.OrderDate) AS OrderYear,
	COUNT(DISTINCT O1.CustomerID) AS Cust_Num,
	COUNT(DISTINCT O2.CustomerID) AS Previous_Cust_Num,
	COUNT(DISTINCT O1.CustomerID) - COUNT(DISTINCT O2.CustomerID) AS Growth
FROM dbo.Orders AS O1
LEFT JOIN dbo.Orders AS O2
	ON YEAR(O1.OrderDate) = YEAR(O2.OrderDate) + 1
GROUP BY YEAR(O1.OrderDate), YEAR(O2.OrderDate);
GO

-- CTE حل تمرین با استفاده از
WITH Customers_Per_Year
AS
(
	SELECT
		YEAR(O1.OrderDate) AS OrderYear,
		COUNT(DISTINCT O1.CustomerID) AS Cust_Num
	FROM dbo.Orders AS O1
	GROUP BY YEAR(O1.OrderDate)
)
SELECT
	C.OrderYear,
	C.Cust_Num AS Cust_Num,
	ISNULL(P.Cust_Num, 0) AS Previous_Cust_Num,
	C.Cust_Num - ISNULL(P.Cust_Num, 0) AS Growth
FROM Customers_Per_Year AS C
LEFT JOIN Customers_Per_Year AS P
	ON C.OrderYear = P.OrderYear + 1;
GO

-- Derived Table حل تمرین با استفاده از
SELECT
	Current_Year.OrderYear,
	Current_Year.Cust_Num AS Cust_Num,
	ISNULL(Previous_Year.Cust_Num, 0) AS Previous_Cust_Num,
	Current_Year.Cust_Num - ISNULL(Previous_Year.Cust_Num, 0) AS Growth
FROM (SELECT
		YEAR(OrderDate) AS OrderYear,
		COUNT(DISTINCT CustomerID) AS Cust_Num
	  FROM dbo.Orders
	  GROUP BY YEAR(OrderDate)) AS Current_Year -- Derived Table اولین
	  LEFT JOIN (SELECT 
					YEAR(OrderDate) AS OrderYear,
					COUNT(DISTINCT CustomerID) AS Cust_Num 
				 FROM dbo.Orders 
			     GROUP BY YEAR(OrderDate)) AS Previous_Year -- اول Derived Table تکرار مجدد
		ON Current_Year.OrderYear = Previous_Year.OrderYear + 1;
GO

-- Subquery حل تمرین با استفاده از
SELECT
	YEAR(Current_Year.OrderDate) AS OrderYear,
	COUNT(DISTINCT Current_Year.CustomerID) AS Cust_Num,
	ISNULL((SELECT COUNT(DISTINCT O.CustomerID) FROM dbo.Orders AS O
				WHERE YEAR(Current_Year.OrderDate) = YEAR(O.OrderDate) + 1
			GROUP BY YEAR(O.OrderDate)), 0) AS Previous_Cust_Num,
	COUNT(DISTINCT Current_Year.CustomerID) -
	ISNULL((SELECT COUNT(DISTINCT O.CustomerID) FROM dbo.Orders AS O
				WHERE YEAR(Current_Year.OrderDate) = YEAR(O.OrderDate) + 1
			GROUP BY YEAR(O.OrderDate)), 0) AS Growth
FROM dbo.Orders AS Current_Year
GROUP BY YEAR(Current_Year.OrderDate);
GO