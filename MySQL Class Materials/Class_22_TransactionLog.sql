select * from sys.databases

select db_name(5)
select db_id('adventureworks')

select * from sys.database_files

--databaseid:fileid:pageid
--6:3:822
--6:3:832
--6:3:842
--6:3:852

------

-------------------Check Point	----------------------------------------
--1.Manual - checkpoint 120
--2.Automatic/Indirect --Database Recovery  = REDO + UNDO 
--3.Internal checkpoints
----https://docs.microsoft.com/en-us/sql/relational-databases/logs/database-checkpoints-sql-server?view=sql-server-2017

--Recovery Interval(Property @instance level) 
--Recovery Interval / Recovery Model / Recovery State

---------------Transaction Log ------------------
--1.Database Recovery  = REDO + UNDO 
--2.RollBack
--3.Point in time recovery
--4.Recovery lost data

CREATE TABLE [Location]
(
    [Sr.No] INT IDENTITY,
    [Date] DATETIME DEFAULT GETDATE (),
    [City] CHAR (25) DEFAULT 'NewYork'
);
-------------
--Read transaction log using   fn_dblog(null,null)
select * 
	  --[Current LSN],
   --    [Operation],
   --    [Transaction Name],
   --    [Transaction ID],
   --    [Transaction SID],
   --    [SPID],
   --    [Begin Time]
FROM   fn_dblog(null,null)
-----------
INSERT INTO [Location] DEFAULT VALUES ;
GO 2
-----------
select * from [Location]
--------
select * 
	  --[Current LSN],
   --    [Operation],
   --    [Transaction Name],
   --    [Transaction ID],
   --    [Transaction SID],
   --    [SPID],
   --    [Begin Time]
FROM   fn_dblog(null,null)
WHERE Operation IN 
   ('LOP_INSERT_ROWS','LOP_MODIFY_ROW','LOP_DELETE_ROWS','LOP_BEGIN_XACT','LOP_COMMIT_XACT') 

--virtual logs 
DBCC LOGINFO

--Show all databases and its log file size 
DBCC SQLPERF(logspace)

------------Transaction Log Maintenance -------------------------
--1.Truncate
--2.Shrink 


-----------------------Recovery Model  ----------------------
ALTER DATABASE [HRDB] SET RECOVERY BULK_LOGGED --WITH NO_WAIT
ALTER DATABASE [HRDB] SET RECOVERY FULL















