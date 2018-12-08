------------------DDL Trigger ----------------------
create trigger tr_create_table on database
for create_table, alter_table, drop_table
as
begin
	raiserror('You cannot create table in this database!!!',16,1)
	rollback transaction 
end

----------------------
create table MyTestTable
(
	col1 int
)

------------
create trigger tr_create_table on all server
for create_table, alter_table, drop_table
as
begin
	raiserror('You cannot create table in this database!!!',16,1)
	rollback transaction 
end
-----------

----------------------Instead of trigger ---------------------
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
	EmpID int not null , 
	EffectiveDate date not null,
	EndDate date,
	Payment money not null 
)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F');

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (2,'Eric', null, 'Weist', '435098976', '12/12/1980', 'M');

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (3,'Shannon', null, 'Mathews', '435098976', '12/12/1980', 'F');

insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
values (1,1,'1/1/2018',null,45000.00)

insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
values (2,3,'1/1/2018',null,56000.00)

select * from MyEmployee
select * from MyEmployeePayment
-------

create trigger tr_d_MyEmployee on MyEmployee
instead of delete
as
begin
	declare @EmpID int;
	select @EmpID = empid from deleted;

	delete from MyEmployeePayment where empid = @EmpID
	delete from MyEmployee where empid = @EmpID

end

----------------------------------------------------

--begin transaction (IMplicit/Explicit Transaction)
	--Compiler Data Validation
		--Constraint validation
			--Instead of trigger 
				--DML Activity (Insert/delete/update)
					--Fire trigger associated with Insert/delete/update
						--Commit transaction 


delete from MyEmployee where empid = 1

------------------------
select * from MyEmployee
select * from MyEmployeePayment

------
create view vw_EmployeePayment
as
	select e.EmpID,e.FirstName,e.LastName, e.MiddleName, e.SSN,e.dob,e.Gender,
		p.EffectiveDate, p.EndDate,p.Payment
	from MyEmployee e
	left outer join MyEmployeePayment p on p.EmpID = e.EmpID

select * from vw_EmployeePayment

insert into vw_EmployeePayment (EmpID,FirstName,LastName, MiddleName, SSN,dob,Gender,EffectiveDate, EndDate,Payment)
values (4,'Nisha','Patel',null,'123-45-7898','1/1/1990','F','7/1/2018',null, 89000.00)

-------------------
alter trigger tr_i_vw_EmployeePayment on vw_EmployeePayment
instead of insert
as
begin
	declare @EmpID int
	declare @FirstName varchar(50)
	declare @LastName varchar(50)
	declare @MiddleName varchar(50)
	declare @SSN varchar(11)
	declare @dob date
	declare @Gender char(1)
	declare @EffectiveDate date
	declare @EndDate date 
	declare @Payment money
	declare @PaymentID int = (select max(paymentid) + 1 from MyEmployeePayment)

	select 
		@EmpID = EmpID,
		@FirstName = FirstName,
		@LastName = LastName,
		@MiddleName = MiddleName,
		@SSN = SSN,
		@dob = dob,
		@Gender = Gender,
		@EffectiveDate = EffectiveDate,
		@EndDate = EndDate,
		@Payment = Payment
	from inserted

	if not exists(select * from MyEmployee where EmpID = @EmpID)
	begin 
		insert into MyEmployee (EmpID,FirstName,LastName, MiddleName, SSN,dob,Gender)
		values (@EmpID ,@FirstName,@LastName,@MiddleName,@SSN,@dob,@Gender)
	end

	if exists(select * from MyEmployeePayment where EmpID = @EmpID and EndDate is null)
	begin
		update MyEmployeePayment
		set EndDate = convert(varchar(100), getdate() ,101)
		where EmpID = @EmpID and EndDate is null
	end

	insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate, EndDate,Payment)
	values (@PaymentID,@EmpID, @EffectiveDate,@EndDate,@Payment);


end

insert into vw_EmployeePayment (EmpID,FirstName,LastName, MiddleName, SSN,dob,Gender,EffectiveDate, EndDate,Payment)
values (1,'Lisa','George',null,'123-45-6789','1980-01-01','F','7/1/2018',null, 89000.00)

insert into vw_EmployeePayment (EmpID,FirstName,LastName, MiddleName, SSN,dob,Gender,EffectiveDate, EndDate,Payment)
values (4,'Nisha','Patel',null,'123-45-7898','1/1/1990','F','7/1/2018',null, 89000.00)


select * from MyEmployee
select * from MyEmployeePayment

--------------Create Databases--------------
CREATE DATABASE FinDB
ON  PRIMARY 
	( NAME = N'FinDB', FILENAME = N'C:\Data2\FinDB1.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
LOG ON 
	( NAME = N'FinDB_log', FILENAME = N'C:\Data3\FinDB_Log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO

drop database FinDB
----------
--Create a database with 2 data files and 2 transaction log files. 
CREATE DATABASE [FinDB]
ON  PRIMARY 
	( NAME = N'FinDB1', FILENAME = N'C:\Data2\FinDB1.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB ),
	( NAME = N'FinDB2', FILENAME = N'C:\Data4\FinDB2.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
LOG ON 
	( NAME = N'FinDB1_log', FILENAME = N'C:\Data3\FinDB1_Log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB ), 
	( NAME = N'FinDB2_log', FILENAME = N'C:\Data5\FinDB2_Log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO

drop database FinDB
---------
--Create database with multple file and file froups. 
CREATE DATABASE [FinDB]
ON  PRIMARY 
	( NAME = N'FinDB1', FILENAME = N'C:\Data2\FinDB1.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB ), 
FILEGROUP [COLDFG] 
	( NAME = N'FinDB5', FILENAME = N'C:\Data4\FinDB5.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ), 
FILEGROUP [HOTFG] 
	( NAME = N'FinDB2', FILENAME = N'C:\Data4\FinDB2.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ),
	( NAME = N'FinDB3', FILENAME = N'C:\Data5\FinDB3.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ), 
FILEGROUP [WARMFG] 
	( NAME = N'FinDB4', FILENAME = N'C:\Data6\FinDB4.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
LOG ON 
	( NAME = N'FinDB1_Log', FILENAME = N'C:\Data3\FinDB1_Log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO




















