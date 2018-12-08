--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

begin try
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	begin transaction 
		insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
		values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F');

		insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
		values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M');

		insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
		values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'Female');

		insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
		values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F');
	commit transaction 
	SET TRANSACTION ISOLATION LEVEL read committed;
end try
begin catch
	--throw;
	declare @TryErrorNumber int = error_number();
	declare @TryErrorMessage nvarchar(2000) = error_message() ;

	print 'I am in the catch block';
	--print @@TRANCOUNT

	--if (@@TRANCOUNT > 0)
	if (XACT_STATE() = 1) 
	begin
		if (@TryErrorNumber = 8152) 
		begin
			--raiserror ('Data has been truncated',0,1);
			raiserror ('Data has been truncated',16,1);
			commit transaction
		end 
		else
		begin
			raiserror('Something went wrong in the try block. Transaction is aborted!!!', 16, 1)
			rollback transaction
		end
	end
	else 
		if XACT_STATE() = -1
			rollback transaction

	insert into MyErrorLog ([ErrorNumber],[ErrorMessage],[ErrorTimeStamp])
	values (@TryErrorNumber , @TryErrorMessage , getdate() )

	SET TRANSACTION ISOLATION LEVEL read committed;

end catch

-----------------------------
begin tran
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'Female');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F');
commit tran

---------------------------
begin tran UpDateMyEmployee
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'Female');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F');
commit tran UpDateMyEmployee

------------------------------
declare @TransactionName varchar(100) = 'UpDateMyEmployee'
begin tran @TransactionName
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'Female');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F');
commit tran @TransactionName

------------------------------
begin tran UpDateMyEmployee with mark 'This transaction insert employee record' 
	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'Female');

	insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
	values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F');
commit tran UpDateMyEmployee

-----------------Nested Transaction--------------
create table tb_transactiontest ([value] int)

-- test using 2 transactions and a both transactions commits
delete from tb_transactiontest 
begin transaction abc -- outer transaction
    print @@trancount
    insert into tb_transactiontest values (1)
    begin transaction xyz -- inner transaction
        print @@trancount
        insert into tb_transactiontest values (2)
    commit transaction xyz -- commit the inner transaction
    print @@trancount
    insert into tb_transactiontest values (3)
commit transaction abc -- commit the outer transaction
print @@trancount
select * from tb_transactiontest
go

-- test using 2 transactions and a rollback on the outer transaction
delete from tb_transactiontest 
begin transaction abc -- outer transaction
    print @@trancount
    insert into tb_transactiontest values (1)
    begin transaction xyz-- inner transaction
        print @@trancount
        insert into tb_transactiontest values (2)
    commit transaction xyz-- commit the inner transaction
    print @@trancount
    insert into tb_transactiontest values (3)
rollback transaction abc-- roll back the outer transaction
print @@trancount
select * from tb_transactiontest
go

-- test using 2 transactions and a rollback on the inner transaction
delete from tb_transactiontest 
begin transaction abc-- outer transaction
    print @@trancount
    insert into tb_transactiontest values (1)
    begin transaction xyz -- inner transaction
        print @@trancount
        insert into tb_transactiontest values (2)
    rollback transaction xyz -- roll back the inner transaction
    print @@trancount
    insert into tb_transactiontest values (3)
-- we get an error here because there is no transaction to commit.
commit transaction abc -- commit the outer transaction
print @@trancount
select * from tb_transactiontest
go


-- test using 2 transactions and a rollback both transactions
delete from tb_transactiontest 
begin transaction abc-- outer transaction
    print @@trancount
    insert into tb_transactiontest values (1)
    begin transaction xyz -- inner transaction
        print @@trancount
        insert into tb_transactiontest values (2)
    rollback transaction xyz -- roll back the inner transaction
    print @@trancount
    insert into tb_transactiontest values (3)
-- we get an error here because there is no transaction to commit.
rollback transaction abc -- commit the outer transaction
print @@trancount
select * from tb_transactiontest
go

-------------Inserted & Deleted Tables (Magic Tables) ----------------
--select *
--into MyAddress
--from person.[Address]

select * from MyAddress

delete from MyAddress 
output deleted.*
where addressid between 11 and 15 

delete from MyAddress 
output deleted.AddressID, deleted.City, deleted.PostalCode
where addressid between 16 and 20

update MyAddress 
set PostalCode = 18901
output inserted.*, deleted.PostalCode
where AddressID = 21

create table MyAddressUpdateLog
(
	AddressID int,
	PostUpdatePostalCode varchar(10),
	PreUpdatePostalCode varchar(10)
)
 
update MyAddress 
set PostalCode = 18901
output inserted.AddressID, inserted.PostalCode, deleted.PostalCode into MyAddressUpdateLog
where AddressID = 22

select * from MyAddressUpdateLog
---------------------------------





----------------Trigger---------------
--1.DML Trigger (After Trigger) - Table/View Level
--3.DDL Trigger (For Trigger) - Database/Instance Level


-----------DML Trigger-----------------
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
	EmpID int not null ,--foreign key references MyEmployee(EmpID),
	EffectiveDate date not null,
	EndDate date,
	Payment money not null 
)


--begin transaction (IMplicit/Explicit Transaction)
	--Compiler Data Validation
		--Constraint validation
			--DML Activity (Insert/delete/update)
				--Fire trigger associated with Insert/delete/update
					--Commit transaction 

alter trigger tr_i_MyEmployee on MyEmployee
after insert, update
as
begin
	declare @SSN varchar(11);
	declare @DOB varchar(10);
	declare @Gender char(1);

	select @SSN=SSN,@DOB=DOB,@Gender=Gender from inserted;

	if len(@SSN) <> 11 
	begin
		raiserror('Invalid SSN !!!',16, 1);
		rollback transaction;
	end

	--if (isdate(@DOB) = 0)
	--begin
	--	raiserror('Invalid DOB !!!',16, 1);
	--	rollback transaction;
	--end

	if not (@Gender = 'M' or @Gender='F') 
	begin
		raiserror('Invalid Gender !!!',16, 1);
		rollback transaction;
	end

	return;
end

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F');

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (2,'Eric', null, 'Weist', '435098976', '12/12/1980', 'M');

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (3,'Shannon', null, 'Mathews', '546-99-0087', '17/18/2004', 'F');

select * from MyEmployee 

--------
create trigger tr_d_MyEmployee on MyEmployee
after delete
as
begin 
	declare @EmpID int;
	select @EmpID=EmpID from deleted;

	--if exists(select * from MyEmployeePayment where empid = @EmpID)
	--begin
	--	raiserror('You cannot delete an employee while payment information is available !!!',16, 1);
	--	rollback transaction;
	--end
	
	delete from MyEmployeePayment where empid = @EmpID

end

----------
drop table MyEmployeeUpdateLog
create table MyEmployeeUpdateLog
(
	LogInfo varchar(1000), 
	EventTimeStamp datetime
)

create trigger tr_d_MyEmployee_2 on MyEmployee
after delete
as
begin
	declare @EmpID int;
	select @EmpID=EmpID from deleted;

	if exists(select * from MyEmployeePayment where empid = @EmpID)
	begin
		insert into MyEmployeeUpdateLog (LogInfo,EventTimeStamp)
		values ('Corresponding payment records are deleted.',getdate())
	end

end

----------------------
insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
values (1,1,'1/1/2018',null,45000.00)

select * from MyEmployee
select * from MyEmployeePayment

delete from MyEmployee where empid = 1

select * from MyEmployeeUpdateLog 

-----------------------------------------------------------














