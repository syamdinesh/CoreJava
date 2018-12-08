---------------Logins ----------------
--Create a windows login
CREATE LOGIN [LAPTOP-M5VEFTIG\ag_daniel_hp] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO

--Create SQL Server Login 
CREATE LOGIN [LoginLisa] WITH PASSWORD='ASDF', DEFAULT_DATABASE=[master]
GO

--Server roles
ALTER SERVER ROLE [sysadmin] ADD MEMBER [LoginLisa]
GO

ALTER SERVER ROLE [sysadmin] DROP MEMBER [LoginLisa]
GO

--https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/server-level-roles?view=sql-server-2017

--Create a new server role
USE [master]
CREATE SERVER ROLE [MyServerRole1]
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [MyServerRole1]
ALTER SERVER ROLE [dbcreator] ADD MEMBER [MyServerRole1]
ALTER SERVER ROLE [diskadmin] ADD MEMBER [MyServerRole1]

----Securables -----------------------
ALTER SERVER ROLE [sysadmin] ADD MEMBER [LoginLisa]
GO
DENY SHUTDOWN TO [LoginLisa]
GO

-----
GRANT CREATE ANY DATABASE TO [LoginLisa]

-----
select * from sys.server_principals

-----------------------Users -------------------------------------
USE [AdventureWorks]
GO
CREATE USER [UserLisa] FOR LOGIN [LoginLisa]
GO


------Database Role ------
USE [AdventureWorks]
GO
ALTER ROLE [db_owner] ADD MEMBER [UserLisa]
GO

USE [AdventureWorks]
GO
ALTER ROLE [db_owner] DROP MEMBER [UserLisa]
GO

-------Securables @ database level ----------
use [AdventureWorks]
GO
DENY SELECT ON [Sales].[SalesOrderHeader] TO [UserLisa]
GO

use [AdventureWorks]
GO
REVOKE SELECT ON [Sales].[SalesOrderHeader] TO [UserLisa] AS [dbo]
GO

--------

use [AdventureWorks]
GO
DENY SELECT ON [Sales].[SalesOrderHeader] ([CreditCardID]) TO [UserLisa]
GO
use [AdventureWorks]
GO
DENY SELECT ON [Sales].[SalesOrderHeader] ([CreditCardApprovalCode]) TO [UserLisa]
GO


select * from sales.SalesOrderHeader

--------------------------------------------------------------
select * from sys.server_principals
select * from sys.database_principals

--0xB19ADA7ECEAA7E479243ABAA7914A1E0
--0xB19ADA7ECEAA7E479243ABAA7914A1E0
------------------







------















