--Detach data/log file froma database. 
ALTER DATABASE [ABCD] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
EXEC master.dbo.sp_detach_db @dbname = N'ABCD'

--Detach database 
USE [master]
GO
CREATE DATABASE [ABCD] 
ON 
( FILENAME = N'C:\Data1\ABCD.mdf' ),
( FILENAME = N'C:\Data1\ABCD_log.ldf' )
 FOR ATTACH
GO
----------------------------------------

-- Create a database master key on the destination instance of SQL Server.   
USE master;  
GO  
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '*rt@40(FL&dasl1';  
GO  

-- Recreate the server certificate by using the original server certificate backup file.   
-- The password must be the same as the password that was used when the backup was created.  
CREATE CERTIFICATE TestSQLServerCert   
FROM FILE = 'TestSQLServerCert'  
WITH PRIVATE KEY   
(  
    FILE = 'SQLPrivateKeyFile',  
    DECRYPTION BY PASSWORD = '*rt@40(FL&dasl1'  
);  
GO  


------------  Attch database to DEV 5000 --------------------------------
USE [master]
GO
CREATE DATABASE [HRDB] ON 
( FILENAME = N'C:\Data1\HRDB.mdf' ),
( FILENAME = N'C:\Data1\HRDB_log.ldf' )
 FOR ATTACH
GO









