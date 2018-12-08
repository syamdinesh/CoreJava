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

---------------------------------------
begin try
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
end try
begin catch
	--throw;
	print 'I am in the catch block';
	rollback transaction;
end catch


select * from MyEmployee  
delete from MyEmployee  

--------------------------
select * 
from sys.messages 
where message_id = 8152
order by message_id, language_id

----------------------------
begin try
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
end try
begin catch
	--throw;

	select
        error_number() as errornumber
        ,error_severity() as errorseverity
        ,error_state() as errorstate
        ,error_procedure() as errorprocedure
        ,error_line() as errorline
        ,error_message() as errormessage;

	print 'I am in the catch block';
	rollback transaction;
end catch

---------------------------------------------
begin try
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
end try
begin catch
	--throw;

	select
        error_number() as errornumber
        ,error_severity() as errorseverity
        ,error_state() as errorstate
        ,error_procedure() as errorprocedure
        ,error_line() as errorline
        ,error_message() as errormessage;

	print 'I am in the catch block';
	rollback transaction;
end catch

---------------------------------
delete from MyEmployee
begin try
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
end try
begin catch
	--throw;
	declare @TryErrorNumber int = error_number() 

	print 'I am in the catch block';

	if (@TryErrorNumber = 8152)
	begin
		commit transaction
	end 
	else
	begin
		rollback transaction
	end

end catch

