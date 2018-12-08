use [AdventureWorks]

--Display all departments in my office
select * from HumanResources.Department

--Display all employees in my office
select * from HumanResources.Employee

--Display all employees and their empid, title, gender, dob, hiredate, vacation
select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee

select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
order by Title

select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
order by Title desc 

select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
order by Title, Gender desc

select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
order by Title desc, Gender desc

--Display all employees and their empid, title, gender, dob, hiredate, vacation
select EmployeeID AS 'empid',Title, Gender,BirthDate AS 'DOB',HireDate,VacationHours  
from HumanResources.Employee

select EmployeeID 'empid',Title, Gender,BirthDate 'DOB',HireDate,VacationHours  
from HumanResources.Employee

select EmployeeID empid,Title, Gender,BirthDate DOB,HireDate,VacationHours  
from HumanResources.Employee

select empid=EmployeeID,Title, Gender,DOB=BirthDate,HireDate,VacationHours  
from HumanResources.Employee

select EmployeeID AS 'empid',Title, Gender,BirthDate AS 'DOB',HireDate,VacationHours  
from HumanResources.Employee
order by BirthDate

select EmployeeID AS 'empid',Title, Gender,BirthDate AS 'DOB',HireDate,VacationHours  
from HumanResources.Employee
order by DOB

--Display all female employees in my office
select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f'
order by BirthDate desc

--Display all female employees in my office with vacation more than 75 hours
select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f' and VacationHours > 75
order by BirthDate desc

--------AND-----------
--true and false = false
--false and true = false
--false and false = false
--true and true = true

--Display all female employees in my office with vacation more than 75 hours or vacation is 42 hours
select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f' and (VacationHours > 75 or VacationHours = 42)
order by BirthDate desc

--------OR-----------
--true and false = true
--false and true = true
--false and false = false
--true and true = true

--Display all female employees in my office with vacation hours 96,42, 89
select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f' and (VacationHours = 96 or VacationHours = 42 or VacationHours = 89)
order by BirthDate desc

----------IN ---------------------------------
--Display all female employees in my office with vacation hours 96,42, 89
select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f' and VacationHours IN (96,42,89) 
order by BirthDate desc

select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f' and VacationHours NOT IN (96,42,89) 
order by BirthDate desc

select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f' and VacationHours >= 50 and VacationHours <= 100
order by BirthDate desc

---------------Between ------------------------
--Display all female employees in my office with vacation hours  between 50 and 100
select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f' and VacationHours >= 50 and VacationHours <= 100
order by BirthDate desc

select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f' and VacationHours between 50 and 100 
order by BirthDate desc

--Display all female employees in my office with birth year 1975 to 1980
select EmployeeID,Title, Gender,BirthDate,HireDate,VacationHours  
from HumanResources.Employee
where Gender = 'f' and BirthDate between '1/1/1975' and '12/31/1980'

--------------------NULL--------------------------
--Display all products with no defined color. 
select * 
from Production.Product
where color is null

select * 
from Production.Product
where color is not null

update Production.Product
set color = ''
where ProductID = 316

--Display all products with no defined color or color is blank. 
select * 
from Production.Product
where color is null or color = ''

---------------ISNULL ----------------------------------
--display all products with productid, color, listing price. If color is null then replace it with blank value . 
select ProductID, color, ListPrice, isnull(color,'White') as DisplayedColor
from Production.Product






















