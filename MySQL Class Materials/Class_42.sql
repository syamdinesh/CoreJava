----------Transparent Data Encryption - Protect data at REST---------------
------------------------Enable TDE ------------------------------------
-- Create a database master key and a certificate in the master database.  
USE master ;  
GO  
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '*rt@40(FL&dasl1';  
GO  

CREATE CERTIFICATE TestSQLServerCert WITH SUBJECT = 'Certificate to protect TDE key'  
GO  

-- Create a backup of the server certificate in the master database. The following code stores the backup 
--of the certificate and the private key file in the default data location for this instance of SQL Server   
-- (C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA).  
BACKUP CERTIFICATE TestSQLServerCert   
TO FILE = 'TestSQLServerCert'  
WITH PRIVATE KEY   
(  
    FILE = 'SQLPrivateKeyFile',  
    ENCRYPTION BY PASSWORD = '*rt@40(FL&dasl1'  
);  
GO  

-- Create a database to be protected by TDE.  
CREATE DATABASE HRDB;  
GO  


-- Switch to the new database.  
-- Create a database encryption key, that is protected by the server certificate in the master database.   
-- Alter the new database to encrypt the database using TDE.  
USE HRDB;  
GO  

CREATE DATABASE ENCRYPTION KEY  
WITH ALGORITHM = AES_128  
ENCRYPTION BY SERVER CERTIFICATE TestSQLServerCert;  
GO  

ALTER DATABASE HRDB SET ENCRYPTION ON;  
GO  

-----------Detach Database--------------
USE [master]
GO
ALTER DATABASE [HRDB] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
EXEC master.dbo.sp_detach_db @dbname = N'HRDB'
GO


--------------Partially-contained Databases  ------------------
CREATE DATABASE [MyDevelopmentDB]  CONTAINMENT = PARTIAL
ON  PRIMARY 
( NAME = N'MyDevelopmentDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEV4000\MSSQL\DATA\MyDevelopmentDB.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyDevelopmentDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEV4000\MSSQL\DATA\MyDevelopmentDB_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO

-------------Resource Governor------------------------------------
--Create a resource pool ---------
CREATE RESOURCE POOL poolERP
WITH
    ( MIN_CPU_PERCENT =10,
     MAX_CPU_PERCENT =30,
     MIN_MEMORY_PERCENT =50 ,
     MAX_MEMORY_PERCENT =70
	 )

CREATE RESOURCE POOL poolReporting
WITH
    ( MIN_CPU_PERCENT =30,
     MAX_CPU_PERCENT =50,
     MIN_MEMORY_PERCENT =10 ,
     MAX_MEMORY_PERCENT =20)

----Create a workload group with resource pool---------
create workload group grouperp using poolerp
create workload group groupreporting using poolreporting


---------------------Classifier function----------------------------
use [master]
go

create function rgclassifier() returns sysname
with schemabinding
as
begin
	declare @grp_name as sysname

	if (app_name() = 'reporting')
		set @grp_name = ' groupreporting '
	else
		set @grp_name = ' grouperp '

	return @grp_name
end;
GO

------register the classifier function with resource governer-------
alter resource governor with (classifier_function = dbo.rgclassifier)
alter resource governor reconfigure

------------------------------------------------------------------

























