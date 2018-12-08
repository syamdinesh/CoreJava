--Execute Dynamic SQL commands in SQL Server

--SQL Server offers a few ways of running a dynamically built SQL statement. These ways are:
--1.	Writing a query with parameters 
--2.	Using EXEC
--3.	Using sp_executesql 


--1.Writing a query with parameters
DECLARE @city varchar(75)
SET @city = 'Bothell'
SELECT * FROM person.Address WHERE City = @city
go

--2. Using EXEC
DECLARE @sqlCommand varchar(1000)
DECLARE @columnList varchar(75)
DECLARE @city varchar(75)

SET @columnList = 'addressline1,city,postalcode'
SET @city = '''Bothell'''
SET @sqlCommand = 'SELECT ' + @columnList + ' FROM person.Address WHERE City = ' + @city

EXEC (@sqlCommand)
go

--3. sp_exectesql
DECLARE @sqlCommand nvarchar(1000)
DECLARE @columnList varchar(75)
DECLARE @city varchar(75)

SET @columnList = 'addressline1,city,postalcode'
SET @city = 'Bothell'
SET @sqlCommand = 'SELECT ' + @columnList + ' FROM person.Address WHERE City = @city'

EXECUTE sp_executesql @sqlCommand, N'@city nvarchar(75)', @city = @city

---------------Hint--------
--1.Join Hints
--2.Table Hint
--3.Query Hint

SELECT p.Name, pr.ProductReviewID
FROM Production.Product p
LEFT OUTER HASH JOIN Production.ProductReview pr ON p.ProductID = pr.ProductID
ORDER BY ProductReviewID DESC;

SELECT p.Name, pr.ProductReviewID
FROM Production.Product p
LEFT OUTER LOOP JOIN Production.ProductReview pr ON p.ProductID = pr.ProductID
ORDER BY ProductReviewID DESC;

SELECT poh.PurchaseOrderID, poh.OrderDate, pod.ProductID, pod.DueDate, poh.VendorID 
FROM Purchasing.PurchaseOrderHeader AS poh
INNER MERGE JOIN Purchasing.PurchaseOrderDetail AS pod ON poh.PurchaseOrderID = pod.PurchaseOrderID;

SELECT poh.PurchaseOrderID, poh.OrderDate, pod.ProductID, pod.DueDate, poh.VendorID 
FROM SERV1.Purchasing.PurchaseOrderHeader AS poh
INNER REMOTE JOIN SERV2.Purchasing.PurchaseOrderDetail AS pod ON poh.PurchaseOrderID = pod.PurchaseOrderID;



--When to use Hash Join?
-------------------------
--Inner table: Non Indexed
--Outer table: Optional
--Pre sorted: No
--Optimal condition: Small outer table,large inner table
--Table Size:Any
--Join Clause:Equi Join



--When to use Merge Join?
-------------------------
--Inner table: Indexed
--Outer table: Indexed
--Pre sorted: Yes
--Optimal condition: Clustered or covered index on both tables. 
--Table Size:Large
--Join Clause:Equi Join



--When to use Loop join?
-------------------------
--Inner table: Indexed
--Outer table: Preferable
--Optimal condition: Small tables
--Table Size:Small
--Join Clause:Any

----------------Table Hints----------------------
--Table Hints
--1.	FORCESCAN
--2.	FORCESEEK
--3.	HOLDLOCK 
--4.	NOLOCK 
--5.	NOWAIT
--6.	PAGLOCK 
--7.	READCOMMITTED 
--8.	READCOMMITTEDLOCK 
--9.	READPAST 
--10.	READUNCOMMITTED 
--11.	REPEATABLEREAD 
--12.	ROWLOCK 
--13.	SERIALIZABLE 
--14.	TABLOCK 
--15.	TABLOCKX 
--16.	UPDLOCK 
--17.	XLOCK

--RID Lock--> Page Lock--> Extent Lock --> Table Lock -->  Database Lock

select *
from sales.SalesOrderDetail d with(nolock) 
inner join sales.SalesOrderHeader h with(nolock) on h.SalesOrderID = d.SalesOrderDetailID

select *
from sales.SalesOrderDetail d with(tablock) 
inner join sales.SalesOrderHeader h with(nolock) on h.SalesOrderID = d.SalesOrderDetailID

--------------------Query Hints---------------------------------
--1.	{ HASH | ORDER } GROUP 
--2.	{ CONCAT | HASH | MERGE } UNION 
--3.	EXPAND VIEWS 
--4.	FAST number_rows 
--5.	FORCE ORDER 
--6.	IGNORE_NONCLUSTERED_COLUMNSTORE_INDEX
--7.	KEEP PLAN 
--8.	KEEPFIXED PLAN
--9.	MAXDOP number_of_processors 
--10.	MAXRECURSION number 
--11.	RECOMPILE



select *
from sales.SalesOrderDetail d  
inner join sales.SalesOrderHeader h on h.SalesOrderID = d.SalesOrderDetailID
option(nolock,FAST 10,KEEP PLAN,MAXDOP 3,RECOMPILE)


-----------------------Indexed View-----------------------
drop view Sales.vOrders
CREATE VIEW Sales.vOrders
WITH SCHEMABINDING
AS
    SELECT SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS Revenue,
        OrderDate, ProductID, COUNT_BIG(*) AS COUNT
    FROM Sales.SalesOrderDetail AS od, Sales.SalesOrderHeader AS o
    WHERE od.SalesOrderID = o.SalesOrderID
    GROUP BY OrderDate, ProductID;
GO

--Create an index on the view.
CREATE UNIQUE CLUSTERED INDEX IDX_V1 ON Sales.vOrders (OrderDate, ProductID);
GO

select * from Sales.vOrders

-------------------Partitioned View---------------------
CREATE TABLE Jan2010sales
   (OrderID INT,
   CustomerID INT NOT NULL,
   OrderDate DATETIME  NULL CHECK (DATEPART(yy, OrderDate) = 2010),
   OrderMonth INT  CHECK (OrderMonth = 1),
   DeliveryDate  DATETIME NULL CHECK(DATEPART(mm, DeliveryDate) = 1)
   CONSTRAINT OrderIDMonth PRIMARY KEY(OrderID, OrderMonth)
   )
GO

CREATE TABLE Feb2010sales
   (OrderID INT,
   CustomerID INT NOT NULL,
   OrderDate DATETIME  NULL CHECK (DATEPART(yy, OrderDate) = 2010),
   OrderMonth INT  CHECK (OrderMonth = 2),
   DeliveryDate  DATETIME NULL CHECK(DATEPART(mm, DeliveryDate) = 2)
   CONSTRAINT OrderIDMonth2 PRIMARY KEY(OrderID, OrderMonth)
   )
GO

CREATE TABLE Mar2010sales
   (OrderID INT,
   CustomerID INT NOT NULL,
   OrderDate DATETIME  NULL CHECK (DATEPART(yy, OrderDate) = 2010),
   OrderMonth INT  CHECK (OrderMonth = 3),
   DeliveryDate  DATETIME NULL CHECK(DATEPART(mm, DeliveryDate) = 3)
   CONSTRAINT OrderIDMonth3 PRIMARY KEY(OrderID, OrderMonth)
   )
GO

 
CREATE VIEW Year2010Sales
--WITH ENCRYPTION
AS
	select * from Jan2010sales
	union all
	select * from Feb2010sales
	union all
	select * from Mar2010sales
go

--The SQL Server query optimizer recognizes that the search condition in this SELECT statement references 
--only rows in the May2010Sales and Jun2010Sales tables. Therefore, it limits its search to those tables.
SELECT *
FROM Year2010Sales
WHERE OrderMonth in (2,3)

















