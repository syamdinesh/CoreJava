--Split backup 
BACKUP DATABASE AdventureWorks
TO DISK = 'C:\Data3\AdventureWorks1.bak',
	DISK = 'C:\Data4\AdventureWorks2.bak',
	DISK = 'C:\Data5\AdventureWorks3.bak'
GO

--Mirror Backup
BACKUP DATABASE AdventureWorks
	TO DISK = 'C:\Data1\AdventureWorks.bak'
		MIRROR TO DISK = 'C:\Data2\AdventureWorks.bak'

-------------------
declare @filename varchar(100) = '';
set @filename = getdate();
set @filename = replace(replace(@filename,' ','_'),':','_')
set @filename = 'C:\Backup\adv_full_' + @filename + '.bak' 

BACKUP DATABASE [AdventureWorks] TO  DISK = @filename
WITH 
	NOFORMAT, INIT,  NAME = 'AdventureWorks-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

------------------A piecemeal restore -------------------
--(1)Create a tail log backup
BACKUP LOG XYZ TO DISK = 'c:\backup\tailLogBackup.trn' WITH   NO_TRUNCATE

--(2)Partial restore of the Primary and secondary filegroup Hotfg.
RESTORE DATABASE XYZ FILEGROUP='Primary' FROM DISK = 'c:\backup\MyDB_FULL_2AM.bak'
WITH PARTIAL, NORECOVERY
   
RESTORE DATABASE XYZ FILEGROUP='HOTFG' FROM DISK = 'c:\backup\MyDB_FULL_2AM.bak'

--(3) Online restore of filegroup WarmFG.
RESTORE DATABASE XYZ FILEGROUP='WarmFG' FROM DISK = 'c:\backup\MyDB_FULL_2AM.bak'

--(4) Online restore of filegroup ColdFG.
RESTORE DATABASE XYZ FILEGROUP='ColdFG' FROM DISK = 'c:\backup\MyDB_FULL_2AM.bak'

---------------------File Group Restore------------------------
--Step-1:Take the file offline(OPTIONAL).
ALTER DATABASE HRDB SET OFFLINE

--Step-2:Back up the currently active transaction log(Tail log backup).
BACKUP LOG HRDB TO DISK = 'e:\AdventureWorks_tail_log.TRN'  WITH NO_TRUNCATE

--Step-3:Restore the files.
RESTORE DATABASE HRDB FILE = 'MyDB_FG1_Dat1' FROM DISK = 'c:\backup\HRDB_Full.bak'
WITH NORECOVERY

--Step-4:Restore the tail-log backups.
RESTORE LOG HRDB FROM DISK = 'e:\AdventureWorks_tail_log.TRN'
WITH RECOVERY

-----------------------Page Restore-----------------------------
select * from msdb.dbo.suspect_pages 
--databaseid:fileid:pageid

--Step-1:Take the file offline(OPTIONAL).
ALTER DATABASE XYZ SET OFFLINE

--Step-2:Back up the currently active transaction log(Tail log backup).
BACKUP LOG XYZ TO DISK = 'c:\backup\tailLogBackup.trn' WITH  NO_TRUNCATE

RESTORE DATABASE XYZ PAGE='1:57, 1:202, 1:916, 1:1016' FROM DISK = 'c:\backup\MyDB_FULL_2AM.bak'
WITH NORECOVERY;

RESTORE LOG XYZ FROM DISK = 'c:\backup\tailLogBackup.trn' WITH RECOVERY


--Msg 824, Level 24, State 2, Line 1
--SQL Server detected a logical consistency-based I/O error: unable to decrypt page
-- due to missing DEK. It occurred during a read of page (3:0) in database ID 10 at
-- offset 0000000000000000 in file 'c:\del\corruption_secondary.mdf'.  Additional
-- messages in the SQL Server error log or system event log may provide more detail.
-- This is a severe error condition that threatens database integrity and must be
-- corrected immediately. Complete a full database consistency check (DBCC CHECKDB).
-- This error can be caused by many factors; for more information, see SQL Server
-- Books Online.

--Limitations of Page Restores
	--•	Only data pages can be restored
	--•	The restore sequence must start with a full, file, or filegroup backup.
	--•	The databases must be using the full or bulk-logged recovery model.
	--•	Pages in read-only filegroups cannot be restored.
	--•	A database backup and page restore cannot be run at the same time
	--•	Page restore cannot be used to restore the following:
		--o	Transaction log
		--o	Page 0 of all data files (the file boot page)
		--o	Page 1:9 (the database boot page)
		--o	Pages in read-only filegroups cannot be restored.

--------------------------Database Snapshot---------------------------------
USE master;
CREATE DATABASE AdventureWorks_7_24_2018_10_38_PM 
	ON (NAME=AdventureWorks_Data, FILENAME='C:\Data1\AdventureWorks_7_24_2018_10_38_PM.ss')
AS SNAPSHOT OF AdventureWorks;
GO

select * from myaddress --19578

delete from myaddress where addressid between 31 and 40 

select * from myaddress --19568

select * from myaddress where addressid = 31

select * from myaddress where addressid = 51


--Reverting AdventureWorks_7_24_2018_10_38_PM to AdventureWorks
RESTORE DATABASE AdventureWorks from DATABASE_SNAPSHOT = 'AdventureWorks_7_24_2018_10_38_PM';
GO




























