----------String Functions -------------
--ascii function
--http://ee.hawaii.edu/~tep/EE160/Book/chap4/subsection2.1.1.1.html
select ascii('b') 

select [name], ascii([name]) 
from Production.Product

--char function
select char(65)  

select FirstName + CHAR(9) + isnull(middlename,'') + CHAR(9) + lastname 
from person.Contact

--Replace function 
select replace('sdfabcdhrtgsabcdkkoie', 'abcd', '***') 

select [name], replace([name], 'bolt', '----') as 'ModifiedName' 
from Production.Product
--where [name]  like '%bolt%'

--Stuff function 
select stuff('sdfabcdhrtgsabcdkkoie', 3,5,'***') 

select [name], stuff([name], 2,4,'---') as 'ModifiedName' 
from Production.Product

--PATINDEX function 
select documentid, DocumentSummary,
	patindex('%ensure%', DocumentSummary)
from production.Document

select documentid, DocumentSummary,
	stuff(DocumentSummary, patindex('%[ea]nsure%', DocumentSummary), 6,'ensure') 
from production.Document

--CHARINDEX
select documentid, DocumentSummary,
	charindex('ensure', DocumentSummary)
from production.Document

--SPACE Function 
select FirstName + space(3) + isnull(middlename,'') + space(3) + lastname 
from person.Contact

--LEFT/RIGHT Function
select ProductNumber, left(ProductNumber,2), right(ProductNumber,4)
from Production.Product

--LEN Function 
select [name], len([name]) 
from Production.Product

--REPLICATE
select REPLICATE('0',5) 

--display product in 5 digits
select *
from Production.Product

select ProductID, right(replicate('0',5)  + cast(productid as varchar(10)), 5)
from Production.Product
order by ProductID

select ProductID, replicate('0',5-len(productid)) + cast(productid as varchar(10))
from Production.Product
order by ProductID

--UPPER/LOWER Function 
select [name], upper([name]), lower([name]) 
from Production.Product

--SUBSTRING Function 
select substring('dgkjkgkSgkhg',3,5) 

select [name], substring([name], 3,5) 
from Production.Product

select [name], substring([name], 3,len([name])) 
from Production.Product

--------------Sub Query / Co-Related Sub Query--------------------
--Display sales related to all red color products
select *
from sales.SalesOrderDetail 
where ProductID in (select ProductID from Production.Product 
					where color = 'red') 

select *
from sales.SalesOrderDetail sd
inner join Production.Product p on p.ProductID = sd.ProductID
					and p.color = 'red'

---Co-Related Sub Query
select *
from sales.SalesOrderDetail sd
where exists (select ProductID 
					from Production.Product p
					where p.ProductID = sd.ProductID and color = 'red') 

select p.ProductID, p.[name], 
	(select sum(linetotal) from sales.SalesOrderDetail sd where p.ProductID = sd.ProductID)
from Production.Product p

----------------SELECT INTO ------------------------------
drop table if exists HumanResources.Employee_6_20_2018

select EmployeeID, title 
into HumanResources.Employee_6_20_2018
from HumanResources.Employee 

select * from HumanResources.Employee_6_20_2018

-------------------Union/Union All---------------------------
select *
into MyEmployee1
from HumanResources.Employee
where EmployeeID between 1 and 10 

select *
into MyEmployee2
from HumanResources.Employee
where EmployeeID between 11 and 20 

select *
into MyEmployee3
from HumanResources.Employee
where EmployeeID between 15 and 25

select * from MyEmployee1
select * from MyEmployee2
select * from MyEmployee3

select * from MyEmployee1
union all
select * from MyEmployee2
union all
select * from MyEmployee3

----
select * from MyEmployee1
union
select * from MyEmployee2
union
select * from MyEmployee3

--Number of columns should be the same
--Columns should have compatable data type
--Column name could be different. 

select EmployeeID,title, BirthDate, VacationHours from MyEmployee1
union
select EmployeeID,title, BirthDate, VacationHours from MyEmployee2
union
select EmployeeID,title, BirthDate, VacationHours from MyEmployee3

select EmployeeID,title, BirthDate, VacationHours from MyEmployee1
union
select VacationHours,title, BirthDate, EmployeeID from MyEmployee2
union
select EmployeeID,title, BirthDate, VacationHours from MyEmployee3

----
select EmployeeID,title, BirthDate, VacationHours from MyEmployee1
union
select title, EmployeeID, BirthDate, VacationHours from MyEmployee2
union
select EmployeeID,title, BirthDate, VacationHours from MyEmployee3

---intersect -------------------
select * from MyEmployee2
intersect
select * from MyEmployee3

---except-------------------
select * from MyEmployee2
except
select * from MyEmployee3






























