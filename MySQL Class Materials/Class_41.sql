--Enabling Change Data Capture on a Database
SELECT [name], database_id, is_cdc_enabled  
FROM sys.databases   

--Enable CDC at database level
USE AdventureWorks 
GO 
EXEC sys.sp_cdc_enable_db 
GO  

--Find tables with CDC enabled.
USE AdventureWorks 
GO 
SELECT [name], is_tracked_by_cdc  
FROM sys.tables 
GO  

-- Enable CDC at table level
select * from HumanResources.[shift]

USE AdventureWorks 
GO 
EXEC sys.sp_cdc_enable_table 
	@source_schema = N'HumanResources', 
	@source_name   = N'Shift', 
	@role_name     = NULL

--
select * from [cdc].[HumanResources_Shift_CT]

--Insert a new reord in to shift table. 
USE AdventureWorks 
GO 
insert into [humanresources].[shift] ([name],[starttime],[endtime],[modifieddate]) 
values ('Tracked Shift',getdate(), getdate(), getdate()) 

--Update a record in shift table. 
update HumanResources.[shift]
set [name] = 'Updated Tracked Shift'
where shiftid = 4

select * from HumanResources.[shift]

select * from [cdc].[HumanResources_Shift_CT]

--Delete a record from shift table. 
delete from HumanResources.[shift] 
where shiftid = 4

select * from HumanResources.[shift]

select * from [cdc].[HumanResources_Shift_CT]
------------------------------------------------------------------
USE AdventureWorks;
GO
EXECUTE sys.sp_cdc_disable_table
    @source_schema = N'HumanResources',
    @source_name = N'Shift',
    @capture_instance = N'HumanResources_Shift';
GO

USE AdventureWorks 
GO 
EXEC sys.sp_cdc_disable_db 
GO

-------------------------Temporal Tables----------------------------
CREATE TABLE dbo.tblEmployee
(
	EmpID int primary key
	,EmpName varchar(100)
	,salary money
	,SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
	,SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime)
) 
WITH(SYSTEM_VERSIONING = ON);

select * from dbo.tblEmployee
select * from [dbo].[MSSQL_TemporalHistoryFor_1709249144]

-- Initial Load
INSERT INTO dbo.tblEmployee(EmpID, EmpName, salary)
VALUES (1,'Lisa George',45000.00),
	 (2,'Eric Weist',55000.00),
	 (3,'Shannon Deco',75000.00)

update dbo.tblEmployee
set salary = 50000.00
where empid = 1

update dbo.tblEmployee
set salary = 67000.00
where empid = 1

delete from dbo.tblEmployee where empid = 1

select * from dbo.tblEmployee
select * from [dbo].[MSSQL_TemporalHistoryFor_1709249144]

--------
ALTER TABLE dbo.tblEmployee SET (SYSTEM_VERSIONING = OFF);
ALTER TABLE TestTemporal SET (SYSTEM_VERSIONING = OFF);


----------------------SQL Server Audit------------------
USE [master]

GO

CREATE SERVER AUDIT [MyAudit001]
TO FILE 
(	FILEPATH = N'C:\New folder'
	,MAXSIZE = 0 MB
	,MAX_FILES = 1
	,RESERVE_DISK_SPACE = OFF
)
WITH
(	QUEUE_DELAY = 1000
	,ON_FAILURE = CONTINUE
)

GO


-------------Create a server audit specification ------------------
USE [master]

GO

CREATE SERVER AUDIT SPECIFICATION [ServerAuditSpecification-001]
FOR SERVER AUDIT [MyAudit001]
ADD (FAILED_LOGIN_GROUP),
ADD (USER_CHANGE_PASSWORD_GROUP),
ADD (DATABASE_OBJECT_CHANGE_GROUP),
ADD (SERVER_ROLE_MEMBER_CHANGE_GROUP)

GO

-------------------
SELECT * FROM sys.fn_get_audit_file('C:\New folder\MyAudit001_3D4C890C-032A-4CCE-889C-408CBD1EEA07_0_131781688382200000.sqlaudit', null, null)
GO

---Create database audit specification 
USE [AdventureWorks]

GO

CREATE DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification001]
FOR SERVER AUDIT [MyAudit001]
ADD (UPDATE ON OBJECT::[dbo].[Employee] BY [dbo]),
ADD (INSERT ON OBJECT::[dbo].[Employee] BY [dbo]),
ADD (DATABASE_OBJECT_CHANGE_GROUP)

GO

------------------------

select * from Employee

update Employee
set emp_name = 'LISA'
WHERE EMP_NAME = 'George' 

SELECT * FROM sys.fn_get_audit_file('C:\New folder\MyAudit001_19D41EA9-3ECA-41CA-8677-F29036982B5F_0_131781699433390000.sqlaudit', null, null)
GO

---------------------------------------------------------------------


























    
