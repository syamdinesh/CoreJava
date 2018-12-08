USE [master]
RESTORE DATABASE [AdventureWorks] FROM  DISK = N'C:\Backup\Adv_Full.bak' 
WITH  FILE = 1,  
	MOVE N'AdventureWorks_Data' TO N'C:\Data2\AdventureWorks_Data.mdf',  
	MOVE N'AdventureWorks_Log' TO N'C:\Data2\AdventureWorks_log.ldf',  
	NOUNLOAD,  REPLACE,  STATS = 5

GO

-----------------Orphaned User -----------------
--Method-1
select * from sys.database_principals --0xB19ADA7ECEAA7E479243ABAA7914A1E0
select * from sys.server_principals

exec sp_change_users_login @Action='Report'

--0xB19ADA7ECEAA7E479243ABAA7914A1E0
--0xE98BC5848DF841429F1400C2F7515317

EXEC sp_change_users_login @Action='update_one', @UserNamePattern='UserLisa',   @LoginName='LoginLisa';

--0xE98BC5848DF841429F1400C2F7515317
--0xE98BC5848DF841429F1400C2F7515317

--Method-2
EXEC sp_change_users_login 'Auto_Fix', 'George', null, 'asdf';

-----------------------------------------------------












