------------Like -------------------
--List all products with name starts with S
select * 
from Production.Product
where [name] like 'S%'

--List all products with name ends with S
select * 
from Production.Product
where [name] like '%S'

--List all products with name contains "Mountain"
select * 
from Production.Product
where [name] like '%Mountain%'

--List all products with name does not contains "Mountain"
select * 
from Production.Product
where [name] not like '%Mountain%'

select * 
from Production.Product
where [name] like '_a%'

select * 
from Production.Product
where [name] like '__a%'

select * 
from Production.Product
where [name] like 'a%' or [name] like 'b%' 

select * 
from Production.Product
where [name] like '[abs]%'  

select * 
from Production.Product
where [name] like '[abs]%'  

select * 
from Production.Product
where [name] not like 'a%'  

select * 
from Production.Product
where [name] like '[^a]%' 

-------------Computed Columns ------------------
select * from sales.SalesOrderHeader
select * from sales.SalesOrderDetail

select SalesOrderID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount, 
	OrderQty*UnitPrice as 'LineTotal'
from sales.SalesOrderDetail

----- String concatination-----
--Display all products with productid and combination of name and productnumber
select ProductID, [name] + ' - ' + ProductNumber
from Production.Product

select cast(ProductID as varchar(10)) + ' - ' + [name] + ' - ' + ProductNumber
from Production.Product

select ProductNumber, color, ProductNumber + ' - ' + isnull(Color,'')
from Production.Product

select ProductNumber, color, ProductNumber + isnull(' - ' + Color,'')
from Production.Product

select ProductID,SafetyStockLevel, 
	cast(ProductID as varchar(100)) + '-' + cast(SafetyStockLevel as varchar(10))
		as 'ProductID-SafetyStockLevel'
from Production.Product

------------Distinct ---------------------
--List all employee titles in my office 
select distinct Title 
from HumanResources.Employee
order by title 

select distinct gender, Title 
from HumanResources.Employee
order by gender,title 

-----------Top ------------------------
--Display 10 oldest employees in my office 
select top 10 *
from HumanResources.Employee
order by BirthDate 

select top 10 *
from HumanResources.Employee
order by BirthDate desc 

--Display 10 percent oldest employees in my office 
select top 10 percent *
from HumanResources.Employee
order by BirthDate 

--Display 10 youngest female employees in my office 
select top 10 *
from HumanResources.Employee
order by gender, BirthDate desc 

select top 10 *
from HumanResources.Employee
where gender = 'F'
order by BirthDate desc

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
	--10.TOP
  
--Display top 10 pay rate in my office
select top 10 with ties *
from HumanResources.EmployeePayHistory
order by rate desc 

select top 9 with ties *
from HumanResources.EmployeePayHistory
order by rate desc 

select  * 
from HumanResources.EmployeePayHistory
order by rate desc 
















 


