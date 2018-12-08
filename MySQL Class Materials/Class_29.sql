----------------------------Backups ---------------------
--1.Full Back up
--2.Diff Backup
--3.Transaction Log Backup 
--4.Tail Log Backup
--5.File and File group backup 
--6.Copy Only Backup
--7.Partial Backup 
--8.Mirrored Backup
--9.Striped Backup 

-------------------------Restore --------------------------
--1.Full Restore 
--2.Peicemeal restore, 
--3.File and FileGroup restore
--4.Page Restore

-------------------------------------------------------------
select * from MyAddress

--Create a fill back of adventureworks database. 
BACKUP DATABASE [AdventureWorks] TO  DISK = 'C:\Backup\Adv_Full_7_22_2018_10_31_pm.bak' 
WITH NOFORMAT, INIT,  NAME = 'AdventureWorks-Full Database Backup', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

delete from MyAddress where AddressID between 1 and 10

--Create a Diff Backup(1st one) of adventureworks database. 
BACKUP DATABASE [AdventureWorks] TO  DISK = 'C:\Backup\Adv_Diff_7_22_2018_10_43_pm.bak' 
WITH  DIFFERENTIAL 
	, NOFORMAT, INIT,  NAME = 'AdventureWorks-Diff Database Backup _1', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

delete from MyAddress where AddressID between 32515 and 32520

--Create a Diff Backup(2nd one) of adventureworks database. 
BACKUP DATABASE [AdventureWorks] TO  DISK = 'C:\Backup\Adv_Diff_7_22_2018_10_47_pm.bak' 
WITH  DIFFERENTIAL 
	, NOFORMAT, INIT,  NAME = 'AdventureWorks-Diff Database Backup _2', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

delete from MyAddress where AddressID between 11 and 20

--Create a transaction log backup (1st one) 
BACKUP LOG [AdventureWorks] TO  DISK = N'C:\Backup\Adv_Tran_7_22_2018_10_53_pm.trn' 
WITH NOFORMAT, INIT,  NAME = N'AdventureWorks-Tran Database Backup-1', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

delete from MyAddress where AddressID between 21 and 30

--Create a transaction log backup (1st one) 
BACKUP LOG [AdventureWorks] TO  DISK = N'C:\Backup\Adv_Tran_7_22_2018_10_54_pm.trn' 
WITH NOFORMAT, INIT,  NAME = N'AdventureWorks-Tran Database Backup-2', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO



 




