----------------User defined function(UDF) ----------------
--1.Scalar UDF
--2.In-Line Table Valued UDF
--3.Multi-Statement Table Valued UDF

---------------------Scalar UDF-------------------------
--Create a function to display fully qualified name for contacts. 
create function udf_FullName(@intContactID int) 
returns varchar(100) 
as
begin
	declare @strFullName varchar(100) = '';

	select @strFullName = lastname + ',' + FirstName + ' ' + isnull(MiddleName,'')
	from Person.Contact
	where ContactID = @intContactID;

	--set @strFullName = (select lastname + ',' + FirstName + ' ' + isnull(MiddleName)
	--					from Person.Contact
	--					where ContactID = @intContactID
	--					);

	return @strFullName;

end

---------------------------------------------
---Method-1
declare @strFullName varchar(100) = '***'

select @strFullName = lastname + ',' + FirstName + ' ' + isnull(MiddleName,'')
	from Person.Contact
	where ContactID > 1;

print @strFullName


---Method-2
declare @strFullName varchar(100) = '***'

set @strFullName = (select lastname + ',' + FirstName + ' ' + isnull(MiddleName,'')
					from Person.Contact
					where ContactID > 1
					);

print @strFullName

------------------
---Method-1
declare @strFullName varchar(100) = '';
declare @email varchar(100) ='';

select @strFullName = lastname + ',' + FirstName + ' ' + isnull(MiddleName,''),
	@email=EmailAddress
from Person.Contact
where ContactID > 1;

print @strFullName

---Method-2
declare @strFullName varchar(100) = ''
declare @email varchar(100) = ''

set @strFullName = (select lastname + ',' + FirstName + ' ' + isnull(MiddleName,'')
					from Person.Contact
					where ContactID > 1
					);

set @email = (select EmailAddress
					from Person.Contact
					where ContactID > 1
					);

print @strFullName

------------Options with UDF-----------
alter function udf_FullName(@intContactID int) 
returns varchar(100) 
--with encryption
--with schemabinding
--with execute as 'daniel'
as
begin
	declare @strFullName varchar(100) = '';

	select @strFullName = lastname + ',' + FirstName + ' ' + isnull(MiddleName,'')
	from Person.Contact
	where ContactID = @intContactID;

	return @strFullName;

end

---------------------In-Line Table Valued UDF--------------------
create function udf_EmployeeByGender (@strGender char(1))
returns table
as
	return(select EmployeeID, title, HireDate, gender, VacationHours
			from HumanResources.Employee
			where Gender = @strGender) 

-------------Multi-Statement Table Valued UDF-------------------
alter function dbo.GetPopulationByState()
returns @Population table 
			(StateCode char(2), 
			StateName varchar(50), 
			[PopulationCount] bigint
			)
begin
	insert into @Population values ('NY','Newyork',34567543)
	insert into @Population values ('NJ','NewJery',554332113)
	insert into @Population values ('FL','Florida',338896754)
	return;
end

---------------------Cross/Outer Apply------------------------------
--Create a function which returns storage information for a product . 
select * from Production.ProductInventory

alter function dbo.udf_ProductStorage(@intProductID int,@intLocationCount int)
returns table
as
	return(
			select top(@intLocationCount) ProductID, locationid, Shelf, bin, Quantity 
			from Production.ProductInventory
			where ProductID = @intProductID
			order by Quantity  desc 
			)

select p.ProductID, p.[name], s.*
from Production.Product p 
cross apply dbo.udf_ProductStorage(p.ProductID,1) s

select p.ProductID, p.[name], s.*
from Production.Product p 
outer apply dbo.udf_ProductStorage(p.ProductID,1) s

select p.ProductID, p.[name], s.*
from Production.Product p 
outer apply dbo.udf_ProductStorage(p.ProductID,2) s
---------------------------------------






































