USE[NikamoozDB]
GO

-- Number of customers per year
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

-- ON Query top with change in section
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

-- JOIN solving exercises using
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

-- CTE solving exercises using
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

-- Derived Table Solves Practice Using
SELECT
	Current_Year.OrderYear,
	Current_Year.Cust_Num AS Cust_Num,
	ISNULL(Previous_Year.Cust_Num, 0) AS Previous_Cust_Num,
	Current_Year.Cust_Num - ISNULL(Previous_Year.Cust_Num, 0) AS Growth
FROM (SELECT
		YEAR(OrderDate) AS OrderYear,
		COUNT(DISTINCT CustomerID) AS Cust_Num
	  FROM dbo.Orders
	  GROUP BY YEAR(OrderDate)) AS Current_Year -- Drifed Tibel Evelyn
	  LEFT JOIN (SELECT 
					YEAR(OrderDate) AS OrderYear,
					COUNT(DISTINCT CustomerID) AS Cust_Num 
				 FROM dbo.Orders 
			     GROUP BY YEAR(OrderDate)) AS Previous_Year -- First Derived Table Repeat
		ON Current_Year.OrderYear = Previous_Year.OrderYear + 1;
GO

-- Subquery solving exercises using
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

--END QUERY

-- Total invoice of Tehran customers with three methods
--CTE
WITH Cusetomer_Tehran
AS
(
	SELECT CustomerID FROM Customers
	WHERE State = N'تهران'
),
Customer_Order
AS
(
	SELECT O.CustomerID,O.Freight FROM Orders AS O
	JOIN Cusetomer_Tehran AS CT
	ON O.CustomerID = CT.CustomerID
)
SELECT CustomerID, SUM(Freight) AS TotalPrice
FROM Customer_Order
GROUP BY CustomerID

--END QUERY

-- JOIN
SELECT O.CustomerID, SUM(O.Freight) AS TotalPrice
FROM Customers AS C
JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
WHERE C.State = N'تهران'
GROUP BY O.CustomerID

--END QUERY

--SUB QUERY
SELECT C.CustomerID ,
	(SELECT SUM(O.Freight) FROM Orders AS O
	WHERE C.CustomerID = O.CustomerID) AS TotalPrice
FROM Customers AS C WHERE State = N'تهران'

--END QUERY 

--Derived Table
SELECT TEHRAN_CUSTOMER.CustomerID,
	  SUM(TEHRAN_CUSTOMER.Freight)
FROM (SELECT O.CustomerID,O.Freight 
	  FROM Orders AS O
	 JOIN Customers AS CT
	ON O.CustomerID = CT.CustomerID AND CT.State = N'تهران' )
	AS TEHRAN_CUSTOMER
GROUP BY TEHRAN_CUSTOMER.CustomerID
--END QUERY
-----------------------------------------------------------------