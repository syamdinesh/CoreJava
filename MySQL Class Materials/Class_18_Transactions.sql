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
	declare @TryErrorNumber int = error_number();
	declare @TryErrorMessage nvarchar(2000) = error_message() ;

	print 'I am in the catch block';

	if (@TryErrorNumber = 8152)
	begin
		commit transaction
	end 
	else
	begin
		rollback transaction
	end

	insert into MyErrorLog ([ErrorNumber],[ErrorMessage],[ErrorTimeStamp])
	values (@TryErrorNumber , @TryErrorMessage , getdate() )

end catch

select * from MyEmployee 
select * from MyErrorLog

--------------------------------------------
set xact_abort on
--set xact_abort off

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
	declare @TryErrorNumber int = error_number();
	declare @TryErrorMessage nvarchar(2000) = error_message() ;

	print 'I am in the catch block';
	print @@TRANCOUNT

	--if (@@TRANCOUNT > 0)
	if (XACT_STATE() = 1) 
	begin
		if (@TryErrorNumber = 8152) 
		begin
			commit transaction
		end 
		else
		begin
			rollback transaction
		end
	end
	else 
		if XACT_STATE() = -1
			rollback transaction

	insert into MyErrorLog ([ErrorNumber],[ErrorMessage],[ErrorTimeStamp])
	values (@TryErrorNumber , @TryErrorMessage , getdate() )

end catch


-- Test XACT_STATE:
    -- If 1, the transaction is committable.
    -- If -1, the transaction is uncommittable and should be rolled back.
    -- XACT_STATE = 0 means that there is no transaction and a commit or rollback operation would generate an error.

------------------------------------------------
go

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

end catch

-----------------------------Raiserror ------------------------
raiserror ('Data has been truncated',16,1)
------------
declare @MyErrorMessage varchar(100) = 'My error message';
raiserror (@MyErrorMessage,16,1)
------------
select * from sys.messages
exec sp_addmessage @msgnum = 50005, @severity = 16, @msgtext = 'My sample error message!!!';
exec sp_dropmessage @msgnum = 50005;

raiserror (50005,16,1)
-------------
raiserror (50005,0,1)
raiserror (50005,1,1)
raiserror (50005,10,1)
raiserror (50005,16,1)
raiserror (50005,20,1) with log 
raiserror (50005,20,1) with nowait

----------------
raiserror (50005,16,1) with nowait;
raiserror (50005,16,1) with nowait;
WAITFOR DELAY '00:00:05';
raiserror (50005,16,1) with nowait;

---------------ACID Properties------------------------
--Transaction Properties (ACID)

--Atomicity - All the transactions in a database must follow an ‘all or nothing’ rule. This means that if any 
--	part of the transaction fails, the entire transaction should roll-back. The database should be restored 
--	to the original state before the transaction occurred.

--Consistency – All transactions that occur in the database must follow the integrity constraints and must 
--	leave the database in a consistent state. 

--Isolation - Transactions occurring at the same time in the database must be isolated from each other. 

--Durability – All transactions committed to the database will not be lost.

-----------------Isolation Level ----------------------
--The isolation level 
--	1 = ReadUncomitted 
--	2 = ReadCommitted 
--	3 = Repeatable Read
--	4 = Serializable 
--	5 = Snapshot

--READ UNCOMMITTED
--	Specifies that statements can read rows that have been modified by other transactions but 
--	not yet committed.
--READ COMMITTED
--	Specifies that statements cannot read data that has been modified but not committed by 
--	other transactions. This prevents dirty reads. Data can be changed by other transactions 
--	between individual statements within the current transaction, resulting in nonrepeatable 
--	reads or phantom data. This option is the SQL Server default.
--REPEATABLE READ
--	Specifies that statements cannot read data that has been modified but not yet committed 
--	by other transactions and that no other transactions can modify data that has been read 
--	by the current transaction until the current transaction completes.
--SNAPSHOT
--	Specifies that data read by any statement in a transaction will be the transactionally 
--	consistent version of the data that existed at the start of the transaction. The transaction
--	can only recognize data modifications that were committed before the start of the transaction. 
--SERIALIZABLE
--	Statements cannot read data that has been modified but not yet committed by other transactions.
--	No other transactions can modify data that has been read by the current transaction until the current transaction completes.
--	No other transactions cannot insert new rows that has been read by the current transaction until the current transaction completes.

--Isolation level			Dirty read		Nonrepeatable read		Phantom Rows
----------------			----------		------------------		-------
--Read uncommitted			Yes				Yes						Yes
--Read committed (default)	No				Yes						Yes
--Repeatable read			No				No						Yes
--Snapshot/Serializable		No				No						No

--------------------------------------------------------






 











