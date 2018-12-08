USE [AdventureWorks]
GO
CREATE SCHEMA [MySchema1]
GO

-------------
CREATE TABLE MySchema1.MyEmployee
(
	[EmpID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](20) NULL,
	[LastName] [varchar](50) NOT NULL,
	[SSN] [varchar](11) NOT NULL,
	[DOB] [date] NULL,
	[Gender] [char](1) NULL
)

-------------
CREATE TABLE MyEmployee
(
	[EmpID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](20) NULL,
	[LastName] [varchar](50) NOT NULL,
	[SSN] [varchar](11) NOT NULL,
	[DOB] [date] NULL,
	[Gender] [char](1) NULL
)

------------
use [AdventureWorks]
GO
GRANT DELETE ON SCHEMA::[MySchema1] TO [UserLisa]
GO
use [AdventureWorks]
GO
GRANT INSERT ON SCHEMA::[MySchema1] TO [UserLisa]
GO
use [AdventureWorks]
GO
GRANT UPDATE ON SCHEMA::[MySchema1] TO [UserLisa]
GO
-------------

BACKUP DATABASE [AdventureWorks] TO  DISK = N'C:\Backup\Adv_Full.bak' WITH NOFORMAT, INIT,  NAME = N'AdventureWorks-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

------------















