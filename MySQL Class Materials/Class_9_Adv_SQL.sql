---------------------Rank Functions -----------------------
--row_number, rank, dense_rank, ntile
--Display all sales person with a rank based on their sales YTD. 
SELECT 
	c.FirstName, 
	c.LastName,
	s.SalesYTD, 
    a.PostalCode,
    ROW_NUMBER() OVER (ORDER BY s.SalesYTD desc) AS 'Row Number'
FROM Sales.SalesPerson s 
INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
INNER JOIN Person.Address a ON a.AddressID = c.ContactID
--order by s.SalesYTD desc 

SELECT 
	c.FirstName, 
	c.LastName,
	s.SalesYTD, 
    a.PostalCode,
    ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS 'Row Number'
    ,RANK() OVER (ORDER BY a.PostalCode) AS 'Rank'
    ,DENSE_RANK() OVER (ORDER BY a.PostalCode) AS 'Dense Rank'
    ,NTILE(4) OVER (ORDER BY a.PostalCode) AS 'tile'
FROM Sales.SalesPerson s 
INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
INNER JOIN Person.Address a ON a.AddressID = c.ContactID

--Display all sales person with a rank based on their sales YTD. 
SELECT 
	c.FirstName, 
	c.LastName,
	s.SalesYTD, 
    a.PostalCode,
    ROW_NUMBER() OVER (ORDER BY s.SalesYTD desc) AS 'Row Number'
FROM Sales.SalesPerson s 
INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
INNER JOIN Person.Address a ON a.AddressID = c.ContactID

--Rank sales person at their territory . 
SELECT s.SalesPersonID,c.FirstName, c.LastName,s.SalesYTD,s.TerritoryID,
	ROW_NUMBER() OVER (PARTITION BY s.TerritoryID ORDER BY s.SalesYTD desc) AS 'SalespersonRank'
FROM Sales.SalesPerson s 
INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID

-------------------------Derived Table ----------------
--Find #1 sales person in each Territory
SELECT *
FROM (
	SELECT s.SalesPersonID,c.FirstName, c.LastName,s.SalesYTD,s.TerritoryID,
		ROW_NUMBER() OVER (PARTITION BY s.TerritoryID ORDER BY s.SalesYTD desc) AS 'SalesPersonRank'
	FROM Sales.SalesPerson s 
	INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
	)  t1
where t1.SalesPersonRank = 1

--Find #1 sales person in each Territory, and display all sales generated by them. 
SELECT sh.*
FROM (
	SELECT s.SalesPersonID,c.FirstName, c.LastName,s.SalesYTD,s.TerritoryID,
		ROW_NUMBER() OVER (PARTITION BY s.TerritoryID ORDER BY s.SalesYTD desc) AS 'SalesPersonRank'
	FROM Sales.SalesPerson s 
	INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
	)  t1
inner join sales.SalesOrderHeader sh on sh.SalesPersonID = t1.SalesPersonID
where t1.SalesPersonRank = 1


SELECT sh.*, t1.TerritoryID,  st.[Name], t1.SalesYTD
FROM (
	SELECT s.SalesPersonID,c.FirstName, c.LastName,s.SalesYTD,s.TerritoryID,
		ROW_NUMBER() OVER (PARTITION BY s.TerritoryID ORDER BY s.SalesYTD desc) AS 'SalesPersonRank'
	FROM Sales.SalesPerson s 
	INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
	)  t1
inner join sales.SalesOrderHeader sh on sh.SalesPersonID = t1.SalesPersonID
								and t1.SalesPersonRank = 1
inner join sales.SalesTerritory st on st.TerritoryID = t1.TerritoryID

--Find #1 sales person in each Territory, and display all sales generated by them including line items. 
SELECT sh.*, sd.* 
FROM (
	SELECT s.SalesPersonID,c.FirstName, c.LastName,s.SalesYTD,s.TerritoryID,
		ROW_NUMBER() OVER (PARTITION BY s.TerritoryID ORDER BY s.SalesYTD desc) AS 'SalesPersonRank'
	FROM Sales.SalesPerson s 
	INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
	)  t1
inner join sales.SalesOrderHeader sh on sh.SalesPersonID = t1.SalesPersonID
inner join sales.SalesOrderDetail sd on sh.SalesOrderID = sd.SalesOrderID
where t1.SalesPersonRank = 1


SELECT t1.*, salesinfo.* 
FROM (
	SELECT s.SalesPersonID,c.FirstName, c.LastName,s.SalesYTD,s.TerritoryID,
		ROW_NUMBER() OVER (PARTITION BY s.TerritoryID ORDER BY s.SalesYTD desc) AS 'SalesPersonRank'
	FROM Sales.SalesPerson s 
	INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
	)  t1
inner join (
			select sh.*, sd.ProductID, sd.OrderQty, sd.LineTotal, sd.SpecialOfferID
			from sales.SalesOrderHeader sh 
			inner join sales.SalesOrderDetail sd on sh.SalesOrderID = sd.SalesOrderID
			) salesinfo on t1.SalesPersonID = salesinfo.SalesPersonID
where t1.SalesPersonRank = 1

-----------------------------------------------------
--Display all product and product model with corresponding sales information 
select * from Production.Product
select * from Production.ProductModel
select * from sales.SalesOrderHeader
select * from sales.SalesOrderDetail

select *
from (
	select p.ProductID, p.[name] as 'ProductName', pm.* 
	from Production.Product p 
	left outer join Production.ProductModel pm on p.ProductModelID = pm.ProductModelID
	) prd
left outer join  (
				select sh.*, sd.ProductID, sd.OrderQty, sd.LineTotal, sd.SpecialOfferID
				from sales.SalesOrderHeader sh
				inner join sales.SalesOrderDetail sd on sh.SalesOrderID = sd.SalesOrderID
				) salesinfo on salesinfo.ProductID = prd.ProductID

---------------------------CTE --------------------------------
--Find #1 sales person in each Territory
with
	cte_salesperson (SalesPersonID,FirstName, LastName,SalesYTD,TerritoryID,SalesPersonRank)
	as (
		SELECT s.SalesPersonID,c.FirstName, c.LastName,s.SalesYTD,s.TerritoryID,
			ROW_NUMBER() OVER (PARTITION BY s.TerritoryID ORDER BY s.SalesYTD desc) AS 'SalesPersonRank'
		FROM Sales.SalesPerson s 
		INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
		) 
		 
select * from cte_salesperson where SalesPersonRank = 1

--Find #1 sales person in each Territory, and display all sales generated by them including line items. 
with
	cte_salesperson (SalesPersonID,FirstName, LastName,SalesYTD,TerritoryID,SalesPersonRank)
	as (
		SELECT s.SalesPersonID,c.FirstName, c.LastName,s.SalesYTD,s.TerritoryID,
			ROW_NUMBER() OVER (PARTITION BY s.TerritoryID ORDER BY s.SalesYTD desc) AS 'SalesPersonRank'
		FROM Sales.SalesPerson s 
		INNER JOIN Person.Contact c ON s.SalesPersonID = c.ContactID
		),
	cte_salesinfo (SalesOrderID, OrderDate, SalesPersonID, ProductID, OrderQty, LineTotal, SpecialOfferID) 
	as (
		select sh.SalesOrderID, sh.OrderDate, sh.SalesPersonID, sd.ProductID, sd.OrderQty, sd.LineTotal, sd.SpecialOfferID
		from sales.SalesOrderHeader sh 
		inner join sales.SalesOrderDetail sd on sh.SalesOrderID = sd.SalesOrderID
		)
		 
select * 
from cte_salesperson
inner join  cte_salesinfo on cte_salesinfo.SalesPersonID = cte_salesperson.SalesPersonID
where cte_salesperson.SalesPersonRank = 1

--------------------Grouping Set------------------
select * from Person.[Address]
select * from person.StateProvince 

--Display total number of addresses at state level and state/city level 
select s.[name] as 'StateName',a.city, count(*) as 'TotalAddress' 
from Person.[Address] a 
inner join person.StateProvince s on a.StateProvinceID = s.StateProvinceID
group by 
	grouping sets
		(
			(s.[name],a.city) ,
			(s.[name]),
			()
		)












