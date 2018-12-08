delete from MyAddress

-----------------Kill all user connection to a database--------------
declare @db_name varchar(50)
declare @my_spid char(6)

set @db_name = 'adventureworks'

declare curPID cursor for
	select spid from master.dbo.sysprocesses
	where dbid = (select dbid from master.dbo.sysdatabases 
		where name=@db_name)

open curPID
fetch next from curPID into @my_spid

while @@fetch_status = 0
begin
	exec('kill ' + @my_spid )
	print 'killed spid ' + @my_spid
	fetch next from curPID into @my_spid
end

close curPID
deallocate curPID
----------------------------------------
go

--Create a taillog backup and put the database in a restoring state. 
BACKUP LOG [AdventureWorks] TO  DISK = 'C:\Backup\Adv_TailLog_7_23_2018_09_08_pm.trn' 
WITH  NO_TRUNCATE 
	, NOFORMAT, INIT,  NAME = N'AdventureWorks-TailLogDatabase Backup', 
	SKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 10
GO

--Restore the full backup ------------------
RESTORE DATABASE [AdventureWorks] FROM  DISK = 'C:\Backup\Adv_Full_7_22_2018_10_31_pm.bak' 
WITH  RESTRICTED_USER,  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5

--restore database AdventureWorks with recovery 

--Restore the 2nd diff backup ------------------
RESTORE DATABASE [AdventureWorks] FROM  DISK = 'C:\Backup\Adv_Diff_7_22_2018_10_47_pm.bak' 
WITH  RESTRICTED_USER,  FILE = 1,  NOUNLOAD,  STATS = 5, NORECOVERY

--ALTER DATABASE [AdventureWorks] SET  MULTI_USER --WITH NO_WAIT


--Restore transaction log - 1
RESTORE LOG [AdventureWorks] FROM  DISK = 'C:\Backup\Adv_Tran_7_22_2018_10_53_pm.trn' 
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

--Restore transaction log - 2
RESTORE LOG [AdventureWorks] FROM  DISK = 'C:\Backup\Adv_Tran_7_22_2018_10_54_pm.trn' 
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

--Read data from transaction log backup -----------------
SELECT [Current LSN], [Transaction ID], [Transaction Name], [Operation], [Begin Time], [PartitionID], [TRANSACTION SID]
FROM fn_dump_dblog (
        NULL, NULL, N'DISK', 1, N'C:\Backup\Adv_TailLog_7_23_2018_09_08_pm.trn',
		DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
		DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
		DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
		DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
		DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT)
WHERE Operation = 'LOP_BEGIN_XACT'--'LOP_DELETE_ROWS'
GO

--2018/07/23 21:06:40:887

--Restore tail log backup prior to DELETE statement (2018/07/23 21:06:40:887)
RESTORE LOG [AdventureWorks] FROM  DISK = N'C:\Backup\Adv_TailLog_7_23_2018_09_08_pm.trn' 
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = N'2018-07-23T21:06:30'
GO

restore database AdventureWorks with recovery 

select * from MyAddress 

----------------------Restore with standby mode ----------------------
--Restore full backup 
USE [master]
RESTORE DATABASE [AdventureWorks] FROM  DISK = N'C:\Backup\Adv_Full_7_22_2018_10_31_pm.bak' 
WITH  FILE = 1,  
	STANDBY = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEV4000\MSSQL\Backup\AdventureWorks_RollbackUndo_2018-07-23_22-12-44.bak',  
	NOUNLOAD,  REPLACE,  STATS = 5

GO

--Restoring 2nd diff backup 
RESTORE DATABASE [AdventureWorks] FROM  DISK = N'C:\Backup\Adv_Diff_7_22_2018_10_47_pm.bak' 
WITH  FILE = 1,  
	STANDBY = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEV4000\MSSQL\Backup\AdventureWorks_RollbackUndo_2018-07-23_22-12-44.bak',  
	NOUNLOAD,  STATS = 5

GO

--Restore first transaction log backup 
RESTORE LOG [AdventureWorks] FROM  DISK = 'C:\Backup\Adv_Tran_7_22_2018_10_53_pm.trn' 
WITH  FILE = 1,  
	STANDBY = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEV4000\MSSQL\Backup\AdventureWorks_RollbackUndo_2018-07-23_22-12-44.bak',  
	NOUNLOAD,  STATS = 10
GO

--Restore 2nd transaction log backup 
RESTORE LOG [AdventureWorks] FROM  DISK = 'C:\Backup\Adv_Tran_7_22_2018_10_54_pm.trn' 
WITH  FILE = 1,  
	STANDBY = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEV4000\MSSQL\Backup\AdventureWorks_RollbackUndo_2018-07-23_22-12-44.bak',  
	NOUNLOAD,  STATS = 10
GO

restore database AdventureWorks with recovery 

select * from [dbo].[MyAddress] --19614--19598--19588--19578

---------------Create a file and file group backup ------------
BACKUP DATABASE [FinDB] FILE = N'FinDB3',  FILEGROUP = N'PRIMARY',  FILEGROUP = N'WARMFG' TO  DISK = N'C:\Backup\FinDB.bak' 
--WITH NOFORMAT, INIT,  NAME = N'FinDB-Full Database Backup', 
--	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-------------Partial Backup -----------------------------------
BACKUP DATABASE [FinDB] read_write_filegroup TO  DISK = N'C:\Backup\FinDB.bak'

------------------Copy Only Backup----------------------------
BACKUP DATABASE [AdventureWorks] TO  DISK = N'C:\Backup\adv_copy_only.bak' 
WITH  COPY_ONLY 
--	NOFORMAT, INIT,  NAME = N'AdventureWorks-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
--GO










 































