--Stored Procedure advantages are.....
	--Precompiled execution plan
	--Reduced client/server traffic
	--Efficient reuse of code and programming abstraction
	--Enhanced security controls.

--Type of stored procedure
--------------------------
--(1)User-Defined stored procedures :- They are created and stored in the current database.
--(2)System stored procedures :- They have names prefixed with sp_. These primarily support various 
--	administrative tasks that help manage the SQL SERVER.System stored procedures are stored in 
--	the system database and are accessible to the users of all the database.
--(3)Temporary stored procedures:- It has names prefixed with the #symbol .They are stored in tempdb 
--	database and are automatically dropped when the connection terminates.
--(4)Remote stored procedures :- They are the procedures that are created and stored in databases on 
--	remote servers. These can be accessed from various servers,provided user has appropriate permissions.
--(5)Extended stored procedures:- These are dlls that are executed outside the SQL Server environment. 

create procedure usp_GetEmployeeInfo
as
begin
	select EmployeeID, title, gender, HireDate
	from HumanResources.Employee
end

create procedure usp_GetEmployeeInfoByTitleGender (@title varchar(100), @gender char(1))
as
begin
	select EmployeeID, title, gender, HireDate
	from HumanResources.Employee
	where Title = @title and Gender = @gender
end

--Create a new payment record for an employee
select * from HumanResources.Employee
select * from HumanResources.EmployeePayHistory

create procedure usp_UpdateEmployeePayment 
(
	@EmployeeID int, 
	@Payment money,
	@EffectiveDate date, 
	@PayFrequency int
)
as
begin
	
	begin try
		begin transaction 

			if exists (select * from HumanResources.Employee where EmployeeID = @EmployeeID) 
			begin
				--Close any current payment records. 
				update HumanResources.EmployeePayHistory
				set enddate = getdate()
				where EmployeeID = @EmployeeID and enddate is null 

				--Insert new payment record 
				insert into HumanResources.EmployeePayHistory (EmployeeID, RateChangeDate, rate, PayFrequency, ModifiedDate, EndDate)
				values (@EmployeeID, @EffectiveDate, @Payment, @PayFrequency, getdate(), null) 
			end

		commit transaction 
	end try
	begin catch 
		
		raiserror('Something went wrong. Employee salary cannot be upated!!!',16,1);
		
		if XACT_STATE() > 0 
			rollback transaction;

	end catch


end


-----------------------

--Create a new payment record for an employee
drop procedure if exists usp_UpdateEmployeePayment
go
create procedure usp_UpdateEmployeePayment 
(
	@EmployeeID int, 
	@Payment money,
	@EffectiveDate date, 
	@PayFrequency int,
	@UpdateStatus char(1) output,
	@UpdateMessage varchar(100) output
)
as
begin
	
	begin try
		begin transaction 

			if exists (select * from HumanResources.Employee where EmployeeID = @EmployeeID) 
			begin
				--Close any current payment records. 
				update HumanResources.EmployeePayHistory
				set enddate = getdate()
				where EmployeeID = @EmployeeID and enddate is null 

				--Insert new payment record 
				insert into HumanResources.EmployeePayHistory (EmployeeID, RateChangeDate, rate, PayFrequency, ModifiedDate, EndDate)
				values (@EmployeeID, @EffectiveDate, @Payment, @PayFrequency, getdate(), null) 
			end
			else
			begin 
				set @UpdateStatus = 'F'
				set @UpdateMessage = 'Could not find and employee with employeeID = ' + cast(@EmployeeID as varchar(5))
				commit transaction 
				return; 
			end

		commit transaction 

		set @UpdateStatus = 'S'
		set @UpdateMessage = 'Payment update is sucessful'

	end try
	begin catch 
		throw;

		raiserror('Something went wrong. Employee salary cannot be upated!!!',16,1);
		
		if XACT_STATE() > 0 
			rollback transaction;

		set @UpdateStatus = 'F'
		set @UpdateMessage = 'Payment update is a failure'

	end catch


end


-------------------

--Create a new payment record for an employee
drop procedure if exists usp_UpdateEmployeePayment
go
create procedure usp_UpdateEmployeePayment 
(
	@EmployeeID int, 
	@Payment money,
	@EffectiveDate date, 
	@PayFrequency int,
	@UpdateMessage varchar(100) output
)
as
begin
	set nocount on

	begin try
		begin transaction 

			if exists (select * from HumanResources.Employee where EmployeeID = @EmployeeID) 
			begin
				--Close any current payment records. 
				update HumanResources.EmployeePayHistory
				set enddate = getdate()
				where EmployeeID = @EmployeeID and enddate is null 

				--Insert new payment record 
				insert into HumanResources.EmployeePayHistory (EmployeeID, RateChangeDate, rate, PayFrequency, ModifiedDate, EndDate)
				values (@EmployeeID, @EffectiveDate, @Payment, @PayFrequency, getdate(), null) 
			end
			else
			begin 
				set @UpdateMessage = 'Could not find and employee with employeeID = ' + cast(@EmployeeID as varchar(5))
				commit transaction 
				return 0; 
			end

		commit transaction 

		set @UpdateMessage = 'Payment update is sucessful'
		return 1; 

	end try
	begin catch 

		raiserror('Something went wrong. Employee salary cannot be upated!!!',16,1);
		
		if XACT_STATE() > 0 
			rollback transaction;

		set @UpdateMessage = 'Payment update is a failure'
		return 0; 

	end catch


end

-------------------

--Create a new payment record for an employee
drop procedure if exists usp_UpdateEmployeePayment
go
create procedure usp_UpdateEmployeePayment 
(
	@EmployeeID int, 
	@Payment money,
	@EffectiveDate date, 
	@PayFrequency int,
	@UpdateMessage varchar(100) output
)
with recompile
as
begin
	set nocount on

	begin try
		begin transaction 

			if exists (select * from HumanResources.Employee where EmployeeID = @EmployeeID) 
			begin
				--Close any current payment records. 
				update HumanResources.EmployeePayHistory
				set enddate = getdate()
				where EmployeeID = @EmployeeID and enddate is null 

				--Insert new payment record 
				insert into HumanResources.EmployeePayHistory (EmployeeID, RateChangeDate, rate, PayFrequency, ModifiedDate, EndDate)
				values (@EmployeeID, @EffectiveDate, @Payment, @PayFrequency, getdate(), null) 
			end
			else
			begin 
				set @UpdateMessage = 'Could not find and employee with employeeID = ' + cast(@EmployeeID as varchar(5))
				commit transaction 
				return 0; 
			end

		commit transaction 

		set @UpdateMessage = 'Payment update is sucessful'
		return 1; 

	end try
	begin catch 

		raiserror('Something went wrong. Employee salary cannot be upated!!!',16,1);
		
		if XACT_STATE() > 0 
			rollback transaction;

		set @UpdateMessage = 'Payment update is a failure'
		return 0; 

	end catch


end

-----------------Create a stored proc to insert record in to employee table -------------------
select * from HumanResources.Employee

create procedure usp_InsertEmployeeRecords
(
	@NationalIDNumber nvarchar(15) ,
	@ContactID int,
	@LoginID nvarchar(256) ,
	@ManagerID int,
	@Title nvarchar(50) ,
	@BirthDate datetime ,
	@MaritalStatus nchar(1) ,
	@Gender nchar(1) ,
	@HireDate datetime ,
	@SalariedFlag dbo.Flag ,
	@VacationHours smallint ,
	@SickLeaveHours smallint ,
	@CurrentFlag dbo.Flag NOT NULL,
	@rowguid uniqueidentifier,
	@ModifiedDate datetime 
)
as
begin
	declare @IsError bit = 0

	begin try
		
		--Gender validation
		if @gender <> 'M' and @gender <> 'F'
		begin 
			raiserror('Invalid value in gender parameter',16,1) 
			set @IsError = 1
		end

		--Manager validation
		if not exists(select * from HumanResources.Employee where EmployeeID = @ManagerID)
		begin 
			raiserror('Invalid manager id',16,1) 
			set @IsError = 1
		end

		if (year(getdate()) -  year(@BirthDate)) < 18
		begin 
			raiserror('Employee is uner aged for an employement',16,1) 
			set @IsError = 1
		end

		if (@IsError = 1)
			return 1

		begin transaction
			
			INSERT INTO HumanResources.Employee
			   (
			   NationalIDNumber
			   ,ContactID
			   ,LoginID
			   ,ManagerID
			   ,Title
			   ,BirthDate
			   ,MaritalStatus
			   ,Gender
			   ,HireDate
			   ,SalariedFlag
			   ,VacationHours
			   ,SickLeaveHours
			   ,CurrentFlag
			   ,rowguid
			   ,ModifiedDate
			   )
			VALUES
			   (
			   @NationalIDNumber ,
				@ContactID,
				@LoginID,
				@ManagerID,
				@Title ,
				@BirthDate,
				@MaritalStatus,
				@Gender,
				@HireDate,
				@SalariedFlag,
				@VacationHours,
				@SickLeaveHours,
				@CurrentFlag,
				@rowguid,
				@ModifiedDate
			   )

		commit transaction 

	end try
	begin catch

		rollback transaction 

	end catch

end




