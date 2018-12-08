CREATE TABLE REVENUE
(
	[DepartmentID] int,
	[Revenue] int,
	[Year] int
);

insert into REVENUE
values (1,10030,1998),(2,20000,1998),(3,40000,1998),
 (1,20000,1999),(2,60000,1999),(3,50000,1999),
 (1,40000,2000),(2,40000,2000),(3,60000,2000),
 (1,30000,2001),(2,30000,2001),(3,70000,2001),
 (1,90000,2002),(2,20000,2002),(3,80000,2002),
 (1,10300,2003),(2,1000,2003), (3,90000,2003),
 (1,10000,2004),(2,10000,2004),(3,10000,2004),
 (1,20000,2005),(2,20000,2005),(3,20000,2005),
 (1,40000,2006),(2,30000,2006),(3,30000,2006),
 (1,70000,2007),(2,40000,2007),(3,40000,2007),
 (1,50000,2008),(2,50000,2008),(3,50000,2008),
 (1,20000,2009),(2,60000,2009),(3,60000,2009),
 (1,30000,2010),(2,70000,2010),(3,70000,2010),
 (1,80000,2011),(2,80000,2011),(3,80000,2011),
 (1,10000,2012),(2,90000,2012),(3,90000,2012);

select * from REVENUE

--Display current year revenue and previous year revenue for each year. 
select DepartmentID, [year], 
	Revenue as 'CurrentYearRevenue',
	LAG(Revenue) OVER (ORDER BY Year) as 'LastYearRevenue',
	LEAD(Revenue) OVER (ORDER BY Year) as 'NextYearRevenue',
	LAG(Revenue,2) OVER (ORDER BY Year) as '2YearPriorRevenue',
	LEAD(Revenue,2) OVER (ORDER BY Year) as '2YearForwardRevenue'
from REVENUE
where DepartmentID = 1
order by [year]


--Display current year revenue and revenue diff between previous year and next year. 
select DepartmentID, [year], 
	Revenue as 'CurrentYearRevenue',
	Revenue - LAG(Revenue) OVER (PARTITION BY DepartmentID ORDER BY Year) as 'RevenueDiffFromPreviousYear',
	Revenue - LEAD(Revenue) OVER (PARTITION BY DepartmentID ORDER BY Year) as 'RevenueDiff from NextYear'
from REVENUE
order by DepartmentID, [year]

-------------------------PIVOT -------------------------------
select * from Purchasing.Vendor
select * from Purchasing.ProductVendor
select * from Production.Product

--List number of purchases made by each employee with each vendor
select * from Purchasing.PurchaseOrderHeader

select EmployeeID, VendorID, count(*) as 'TotalPurchaseNumber'
from Purchasing.PurchaseOrderHeader
group by EmployeeID, VendorID
order by EmployeeID, VendorID

select pvt2.VendorID, pvt2.[164], pvt2.[198], pvt2.[223], pvt2.[231], pvt2.[233]
from (
	select EmployeeID, VendorID, purchaseorderid 
	from Purchasing.PurchaseOrderHeader 
	) pvt1
PIVOT(count(purchaseorderid) for EmployeeID in ([164], [198], [223], [231], [233])) pvt2
order by pvt2.VendorID

--Display total purchase amount for each employee with eah vendor 
select pvt2.VendorID, pvt2.[164], pvt2.[198], pvt2.[223], pvt2.[231], pvt2.[233]
from (
	select EmployeeID, VendorID, totaldue 
	from Purchasing.PurchaseOrderHeader 
	) pvt1
PIVOT(sum(totaldue) for EmployeeID in ([164], [198], [223], [231], [233])) pvt2
order by pvt2.VendorID

--Display total purchase amount for each employee with eah vendor , for each year. 
select pvt2.VendorID, pvt2.OrderYear, pvt2.[164], pvt2.[198], pvt2.[223], pvt2.[231], pvt2.[233]
from (
	select EmployeeID, VendorID, totaldue, year(orderdate) 'OrderYear'
	from Purchasing.PurchaseOrderHeader 
	) pvt1
PIVOT(sum(totaldue) for EmployeeID in ([164], [198], [223], [231], [233])) pvt2
order by pvt2.VendorID,pvt2.OrderYear

----
select pvt2.VendorID, pvt2.OrderYear,pvt2.OrderMonth, pvt2.[164], pvt2.[198], pvt2.[223], pvt2.[231], pvt2.[233]
from (
	select EmployeeID, VendorID, totaldue, year(orderdate) 'OrderYear',month(orderdate) 'OrderMonth'
	from Purchasing.PurchaseOrderHeader 
	) pvt1
PIVOT(sum(totaldue) for EmployeeID in ([164], [198], [223], [231], [233])) pvt2
order by pvt2.VendorID,pvt2.OrderYear, pvt2.OrderMonth



 --https://docs.microsoft.com/en-us/sql/t-sql/queries/from-using-pivot-and-unpivot?view=sql-server-2017
--SELECT <non-pivoted column>,  
--    [first pivoted column] AS <column name>,  
--    [second pivoted column] AS <column name>,  
--    ...  
--    [last pivoted column] AS <column name>  
--FROM  
--    (<SELECT query that produces the data>)   
--    AS <alias for the source query>  
--PIVOT  
--(  
--    <aggregation function>(<column being aggregated>)  
--FOR   
--[<column that contains the values that will become column headers>]   
--    IN ( [first pivoted column], [second pivoted column],  
--    ... [last pivoted column])  
--) AS <alias for the pivot table>  
--<optional ORDER BY clause>;  


--------------------------------------------------------------------
create table MyEmployee 
(
	EmpID int not null, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money
)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F', 80000.00) 

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (2,'Eric', null, null, '435-09-8976', '12/12/1980', 'M', 60000.00) 

insert into MyEmployee (EmpID,FirstName,MiddleName,SSN,DOB,Gender,Salary)
values (2,'Eric', null,  '435-09-8976', '12/12/1980', 'M', 60000.00) 

select * from MyEmployee

------------------------------------------------------------------
--if OBJECT_ID('MyEmployee', 'u') is not null 
--begin
--	drop table MyEmployee
--end

--if exists(select * from sys.tables where [name] = 'MyEmployee') 
--begin
--	drop table MyEmployee
--end


drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int not null, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money
)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F', 80000.00),
	 (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M', 60000.00) 

insert into MyEmployee
values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F', 70000.00)

insert into MyEmployee (EmpID,FirstName,LastName,SSN,DOB,Gender,Salary)
values (4,'Muhamad', 'Alam', '449-89-0876', '11/24/1980', 'M', 80000.00)

select * from MyEmployee

-----------------------------------------------------






