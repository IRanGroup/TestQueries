USE[AdventureWorks2019]

------------------------------------

--Query based on desired groupings
SELECT SalesOrderID,
	   ProductID,
	   YEAR(ModifiedDate) AS Dates,
	   CASE GROUPING_ID(SalesOrderID,ProductID,YEAR(ModifiedDate))
			WHEN 4 THEN N'محصول و تاریخ'
			WHEN 2 THEN N'سفارش و تاریخ'
			WHEN 1 THEN N'سفارش و محصول'
			END AS Groupcharacteristic
FROM [Sales].[SalesOrderDetail]
GROUP BY GROUPING SETS 
	(
		(SalesOrderID,ProductID),
		(SalesOrderID,YEAR(ModifiedDate)),
		(ProductID,YEAR(ModifiedDate))
	)

 -------------------------------------------

 --Solving the problem of sorting NULLs
 SELECT [AddressID],[AddressLine1],
 ISNULL(AddressLine2,N'فاقد آدرس') AS Addres2,
 [City],[StateProvinceID], 
 [PostalCode], [SpatialLocation],
 [rowguid], FORMAT([ModifiedDate],'yyy') ModifiedDateYear
 FROM [Person].[Address]
 ORDER BY 
	CASE 
	WHEN AddressLine2 IS NOT NULL THEN 1 
	ELSE 2
	END
	
-----------------------------------
