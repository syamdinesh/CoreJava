--2.Create an endpoint on the mirror server instance 
CREATE ENDPOINT Endpoint_Mirroring
    STATE=STARTED 
    AS TCP (LISTENER_PORT=7024) 
    FOR DATABASE_MIRRORING (ROLE=ALL)
GO
---------------------------------------------------------

--Restore Database with no recovery
USE [master]
RESTORE DATABASE [AdventureWorks] FROM  DISK = N'C:\Backup\AdvFull.bak' 
WITH  FILE = 1,  
	MOVE N'AdventureWorks_Data' TO N'C:\Data2\AdventureWorks_Data.mdf',  
	MOVE N'AdventureWorks_Log' TO N'C:\Data2\AdventureWorks_log.ldf',  
	NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5

GO

--Restore transaction log backup with no recovery 
RESTORE LOG [AdventureWorks] FROM  DISK = N'C:\Backup\AdvTran.trn' 
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

----------------------------------------
--On the mirror server instance set principle as partner
ALTER DATABASE AdventureWorks SET PARTNER = 'TCP://LAPTOP-M5VEFTIG:7022'
GO



