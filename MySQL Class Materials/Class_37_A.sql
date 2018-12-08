--1.Create an endpoint on the principal server instance 
CREATE ENDPOINT Endpoint_Mirroring
    STATE=STARTED 
    AS TCP (LISTENER_PORT=7022) 
    FOR DATABASE_MIRRORING (ROLE=PARTNER)
GO
--------------------------------------------------

--On the principal server instance
ALTER DATABASE AdventureWorks SET AUTO_CLOSE OFF

-----------------------------------------------------

--Create a full backup 
BACKUP DATABASE [AdventureWorks] TO  DISK = N'C:\Backup\AdvFull.bak' WITH NOFORMAT, INIT,  NAME = N'AdventureWorks-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Create a transaction log backup
BACKUP LOG [AdventureWorks] TO  DISK = N'C:\Backup\AdvTran.trn' WITH NOFORMAT, INIT,  NAME = N'AdventureWorks-Tran Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--------------------------------------------------------------
--On the principal server instance set mirror as partner
ALTER DATABASE AdventureWorks SET PARTNER = 'TCP://LAPTOP-M5VEFTIG:7024'
GO

--On the principal server instance set witness as partner
ALTER DATABASE AdventureWorks SET witness = 'TCP://LAPTOP-M5VEFTIG:7023'
GO







