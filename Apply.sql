USE[NikamoozDB]
GO

--Newest customer orders To Drived Table
SELECT C.CustomerID,C.CompanyName,TEMP.OrderID
FROM Customers AS C
CROSS APPLY
	(SELECT TOP(3) O.OrderID FROM Orders AS O
	WHERE C.CustomerID = O.CustomerID) AS TEMP
GO
--Newest customer orders even NULL's
SELECT C.CustomerID,C.CompanyName,TEMP.OrderID
FROM Customers AS C
OUTER APPLY
	(SELECT TOP(3) O.OrderID FROM Orders AS O
	WHERE C.CustomerID = O.CustomerID) AS TEMP

GO
--END QUERY

--Newest customer orders To Tvf
DROP FUNCTION IF EXISTS dbo.Top_Orders
GO
CREATE FUNCTION Top_Orders(@CodCustomer INT,@TopNum INT)
RETURNS TABLE 
	AS
RETURN SELECT TOP(@TopNum) O.OrderID
	 FROM Orders AS O
	 WHERE O.CustomerID = @CodCustomer
GO

SELECT C.CustomerID,C.CompanyName,O.OrderID
FROM Customers AS C
OUTER APPLY dbo.Top_Orders(C.CustomerID,3) AS O
GO
--END QUERY