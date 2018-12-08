--Offset with fetch 
select *
from HumanResources.EmployeePayHistory
order by rate desc 
OFFSET 9 ROWS
FETCH NEXT 6 ROWS ONLY;

--Offset with fetch 
select *
from HumanResources.EmployeePayHistory
order by rate desc 
OFFSET 9 ROWS


select *
from HumanResources.EmployeePayHistory
where PayFrequency = 1
order by rate desc 
OFFSET 9 ROWS
FETCH NEXT 6 ROWS ONLY;

------------------Case Statement ------------------------
--Display all products with product line description 
select ProductID, [name], ProductLine,
	case
		when ProductLine = 'r' then 'Road'
		when ProductLine = 's' then 'Sports'
		when ProductLine = 'm' then 'Mountain'
		else 'Not Defined' 
	end as 'ProductLineDesc'
from Production.Product

select ProductID, [name], ProductLine,
	case
		when ProductLine = 'r' or ProductLine = 'rd' then 'Road'
		when ProductLine = 's' or ProductLine = 'sp' then 'Sports'
		when ProductLine = 'm' then 'Mountain'
		when ProductLine is null then 'Undefined'
		else 'Could not find a description' 
	end as 'ProductLineDesc'
from Production.Product


select ProductID, [name], ProductLine,
	case ProductLine
		when 'r' then 'Road'
		when 's' then 'Sports'
		when 'm' then 'Mountain'
		else 'Not Defined' 
	end as 'ProductLineDesc'
from Production.Product

-----------------------COALESCE-------------------------
CREATE TABLE dbo.wages
(
    emp_id        tinyint   identity,
    hourly_wage   decimal   NULL,
    salary        decimal   NULL,
    commission    decimal   NULL,
    num_sales     tinyint   NULL
)

INSERT dbo.wages (hourly_wage, salary, commission, num_sales)
VALUES
    (10.00, NULL, NULL, NULL),
    (20.00, NULL, NULL, NULL),
    (30.00, NULL, NULL, NULL),
    (40.00, NULL, NULL, NULL),
    (NULL, 10000.00, NULL, NULL),
    (NULL, 20000.00, NULL, NULL),
    (NULL, 30000.00, NULL, NULL),
    (NULL, 40000.00, NULL, NULL),
    (NULL, NULL, 15000, 3),
    (NULL, NULL, 25000, 2),
    (NULL, NULL, 20000, 6),
    (NULL, NULL, 14000, 4);


select *, COALESCE(hourly_wage * 40 * 52, salary,  commission * num_sales) 
from dbo.wages

select *, 
	case
		when hourly_wage is not null then hourly_wage * 40 * 52
		when salary is not null  then salary
		when commission is not null and num_sales is not null then commission * num_sales
		else null 
	end as 'Wages'
from dbo.wages

select *, COALESCE(hourly_wage * 40 * 52, salary + (commission * num_sales),  salary,  commission * num_sales) as 'YealySalary'
from dbo.wages

--------------------NULLIF-----------------------
select UnitPrice,LineTotal, NULLIF(UnitPrice,LineTotal) 
from Sales.SalesOrderDetail

-------------------ISDATE------------------------
select *
from sales.SalesOrderHeader 
where isdate(orderdate) = 0

select isdate('12/12/2018')

-----------------ISNUMERIC -----------------------
select *
from person.[Address]
where ISNUMERIC(postalcode) = 1

select *
from person.[Address]
where ISNUMERIC(postalcode) = 0

select *
from person.[Address]
where PostalCode like '[0-9][0-9][0-9][0-9][0-9]' 

select *
from person.[Address]
where ISNUMERIC(postalcode) = 1 and len(postalcode) = 5

select *
from person.[Address]
where  len(postalcode) = 20

select *
from person.[Address]
where PostalCode like '%[a-z]%'

select *
from person.[Address]
where PostalCode like '[a-z][0-9]%'

----------------Count ------------------------------
--count, avg, min, max, sum, abs

select count(*) as 'rec_count' 
from Production.Product
where color = 'red'

select count(distinct Title)
from HumanResources.Employee

-----Row Constructor (or Table-Valued Constructor)----
--	One limitation of the row constructor is the maximum number of rows that can be 
--	inserted, which is 1000 rows.
SELECT * 
FROM (VALUES ('USD', 'U.S. Dollar'),
             ('EUR', 'Euro'),
             ('CAD', 'Canadian Dollar'),
             ('JPY', 'Japanese Yen')
     ) AS [Currency] ( [CurrencyCode], [CurrencyName] )

------------Cast & Convert Function ----------------------
select cast(ProductID as varchar(10)) + ' - ' + [name] + ' - ' + ProductNumber
from Production.Product

select SalesOrderID, convert(varchar(20), OrderDate, 100), CustomerID 
from sales.SalesOrderHeader

select SalesOrderID, convert(date, OrderDate, 101), CustomerID 
from sales.SalesOrderHeader
--https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017



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











 

