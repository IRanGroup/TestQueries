USE[NikamoozDB]
GO

--Make A View
DROP VIEW IF EXISTS dbo.OrderCountYear;
GO
CREATE VIEW dbo.OrderCountYear
AS
SELECT YEAR(O.OrderDate) AS OrderYear,COUNT(O.OrderID) AS CountOrderID
FROM dbo.Orders AS O
GROUP BY YEAR(O.OrderDate)
GO
--END QUERY

--Use view and apply filters
SELECT *
FROM dbo.OrderCountYear AS OCY
WHERE OCY.OrderYear = '2014' 
--END QUERY

--Nested view To View Up
DROP VIEW IF EXISTS dbo.OrderUp100
CREATE VIEW dbo.OrderMaxCount
AS
SELECT MAX(OCY.CountOrderID) AS BigCountOrder
FROM dbo.OrderCountYear AS OCY
GO



--SCHEMABINDING
DROP VIEW IF EXISTS dbo.CustomerOrder
CREATE VIEW dbo.CustomerOrder WITH SCHEMABINDING
AS
SELECT CustomerID,COUNT(OrderID) AS NUM
FROM dbo.Orders 
GROUP BY CustomerID
GO

