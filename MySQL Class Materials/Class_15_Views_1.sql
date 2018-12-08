----------------------Views--------------------------
--1.Normal View
--2.Indexed Views

create view vw_SalesDetail
as
	select sh.*, sd.SalesOrderDetailID, sd.ProductID, sd.OrderQty, sd.UnitPrice
	from sales.SalesOrderHeader sh
	inner join sales.SalesOrderDetail sd on sh.SalesOrderID = sd.SalesOrderID

alter view vw_SalesDetail
as
	select sh.*, sd.SalesOrderDetailID, sd.ProductID, sd.OrderQty, sd.UnitPrice
	from sales.SalesOrderHeader sh
	inner join sales.SalesOrderDetail sd on sh.SalesOrderID = sd.SalesOrderID
	order by sh.SalesOrderID

--The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions.

alter view vw_SalesDetail
with encryption 
as
	select sh.*, sd.SalesOrderDetailID, sd.ProductID, sd.OrderQty, sd.UnitPrice
	from sales.SalesOrderHeader sh
	inner join sales.SalesOrderDetail sd on sh.SalesOrderID = sd.SalesOrderID

----------------Updatable(update/insert/delete) Views--------------------------
create view vw_SalesOrderHeader
as
SELECT SalesOrderID
      ,RevisionNumber
      ,OrderDate
      ,DueDate
      ,ShipDate
      ,[Status]
      ,OnlineOrderFlag
      ,SalesOrderNumber
      ,PurchaseOrderNumber
      ,AccountNumber
      ,CustomerID
      ,ContactID
      ,SalesPersonID
      ,TerritoryID
      ,BillToAddressID
      ,ShipToAddressID
      ,ShipMethodID
      ,CurrencyRateID
      ,SubTotal
      ,TaxAmt
      ,Freight
      ,TotalDue
      ,Comment
      ,rowguid
      ,ModifiedDate
  FROM Sales.SalesOrderHeader

-----------------------Transaction----------------------------

drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int primary key, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1),
)

drop table if exists MyEmployeePayment
create table MyEmployeePayment
(
	PaymentID int primary key,
	EmpID int not null foreign key references MyEmployee(EmpID),
	EffectiveDate date not null,
	EndDate date,
	Payment money not null 
)

--Implicit Transaction 
insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'Female')

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')

delete from MyEmployee 

--Explicit Transaction
begin transaction 
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'Female')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')
commit transaction 

-----------------------

begin transaction 
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '7/8/2004', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')
commit transaction

-----------
begin transaction 

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')

	insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
	values (1,300,'1/1/2018', '2/15/2018', 56000.00)

	insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
	values (2,3,'2/16/2018', null, 60000.00) 

Commit transaction 

------------------

begin transaction 
	insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
	values (3,2,'6/1/2018', null, 90000.00)

	delete from MyEmployee where empid = 3

	insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
	values (4,4,'6/15/2018', null, 100000.00)
	
Commit transaction 

select * from MyEmployee
select * from MyEmployeePayment  

------------------------------xact_abort ------------------------------
set xact_abort on
set xact_abort off

--Explicit Transaction
begin transaction 
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'Female')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')
commit transaction

--------------Rollback/Savepoint------------------
delete from MyEmployee

begin transaction 
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')
rollback transaction

select * from MyEmployee
-----------------------

delete from MyEmployee

begin transaction 
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')

	rollback transaction

commit transaction 

select * from MyEmployee

------------------------------------
delete from MyEmployee

begin transaction 
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F');

	save transaction abc;

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M');

	save transaction xyz;

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F');

	--rollback transaction abc;
	rollback transaction xyz;

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F');
commit transaction

select * from MyEmployee

------------------------
delete from MyEmployee

begin transaction 
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F')

	rollback transaction

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')

commit transaction 

select * from MyEmployee

-------------------------------------------------------------














