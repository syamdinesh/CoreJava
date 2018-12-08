--1.Inner Join
--2.Left Outer join 
--3.Right OUter Join
--4.Cross Join
--5.Self Join
--6.Full Join 

--Display all products with product review. 
select * from Production.Product
select * from Production.ProductReview

select p.ProductID, p.[name], pr.*
from Production.Product p 
inner join Production.ProductReview pr on p.ProductID = pr.ProductID
order by p.ProductID

--Display all products with out a product review. 
select * from Production.Product
select * from Production.ProductReview

select p.*
from Production.Product p 
left outer join Production.ProductReview pr on p.ProductID = pr.ProductID
where pr.ProductID is null 
order by p.ProductID

--Display all products with product review and its sales information 
select * from Production.Product
select * from Production.ProductReview
select * from sales.SalesOrderDetail

select p.ProductID, p.[name], pr.ReviewerName, pr.ReviewDate, pr.Comments, sd.* 
from Production.Product p 
inner join Production.ProductReview pr on p.ProductID = pr.ProductID
inner join sales.SalesOrderDetail sd on pr.ProductID = sd.ProductID
order by p.ProductID,sd.SalesOrderID

--Display all products with out product review and its sales information 
select p.ProductID, p.[name], 
	pr.ProductReviewID, pr.ProductID, pr.ReviewerName, pr.ReviewDate, pr.Comments, 
	sd.* 
from Production.Product p 
left outer join Production.ProductReview pr on p.ProductID = pr.ProductID
left outer join sales.SalesOrderDetail sd on sd.ProductID = pr.ProductID
where pr.ProductID is null 
order by p.ProductID,sd.SalesOrderID

select p.ProductID, p.[name], 
	pr.ProductReviewID, pr.ProductID, pr.ReviewerName, pr.ReviewDate, pr.Comments, 
	sd.* 
from Production.Product p  
left outer join Production.ProductReview pr on p.ProductID = pr.ProductID
left outer join sales.SalesOrderDetail sd on sd.ProductID = p.ProductID
where pr.ProductID is null 
order by p.ProductID,sd.SalesOrderID

--Display all customers with out an order. 
select * from sales.Customer --19185
select * from sales.SalesOrderHeader -- 31465
select * from sales.SalesTerritory

select c.CustomerID, c.AccountNumber, c.CustomerType, st.[Name] as 'TerritoryName', st.CountryRegionCode
from sales.Customer c
inner join sales.SalesTerritory st on st.TerritoryID = c.TerritoryID
left outer join sales.SalesOrderHeader sh on sh.CustomerID = c.CustomerID
where sh.CustomerID is null 

select c.CustomerID, c.AccountNumber, c.CustomerType, st.[Name] as 'TerritoryName', st.CountryRegionCode
from sales.Customer c
left outer join sales.SalesTerritory st on st.TerritoryID = c.TerritoryID
left outer join sales.SalesOrderHeader sh on sh.CustomerID = c.CustomerID
where sh.CustomerID is null 

--Display all customers with out an order in year 2002. 










--SQL Execution order
	--1.FROM
	--2.INNER
	--3.OUTER
	--4.WHERE
	--5.GROUP
	--6.HAVING
	--7.SELECT
	--8.DISTINCT
	--9.ORDER BY 
	--10.TOP - Offset/Fetch
