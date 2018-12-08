------------Transaction Log Maintenance -------------------------
--1.Truncate
--2.Shrink 

--------Truncate
ALTER DATABASE [HRDB] SET RECOVERY SIMPLE  
ALTER DATABASE [HRDB] SET RECOVERY FULL

--Fullback of the database or Issue a checkpoint.

------Shrink 
USE [HRDB]
GO
DBCC SHRINKFILE ('HRDB_log' , 50000, TRUNCATEONLY)
GO


------------------------------------------------------------------------
EXEC sys.sp_configure 'show advanced options', '1'  RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure 'max server memory (MB)', '3000'
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure 'show advanced options', '0'  RECONFIGURE WITH OVERRIDE
GO

-------------------COLLATION---------------
CREATE TABLE dbo.MyTable  
(
	ID   int PRIMARY KEY,  
	HireDate varchar(10) COLLATE Latin1_General_CS_AS NOT NULL  
);  
GO  

ALTER TABLE dbo.MyTable ALTER COLUMN HireDate varchar(10) COLLATE Latin1_General_CS_AS NOT NULL;  
GO  
--------------------------------------------



