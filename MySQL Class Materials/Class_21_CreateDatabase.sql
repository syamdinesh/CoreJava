use [findb]

create table MyEmployee 
(
	EmpID int primary key, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1),
)  on [warmfg]

create table MyEmployeePayment
(
	PaymentID int primary key,
	EmpID int not null , 
	EffectiveDate date not null,
	EndDate date,
	Payment money not null 
) on [hotfg]


----------------
SELECT o.[name], o.[type], i.[name], i.[index_id], f.[name] FROM sys.indexes i
INNER JOIN sys.filegroups f
ON i.data_space_id = f.data_space_id
INNER JOIN sys.all_objects o
ON i.[object_id] = o.[object_id] WHERE i.data_space_id = f.data_space_id
AND o.type = 'U' -- User Created Tables
GO

-----------------Partitioned table or index------------------------
--The steps for creating a partitioned table or index include the following: 
--			1.Create a partition function to specify how a table or index that uses the function can be partitioned.
--			2.Create a partition scheme to specify the placement of the partitions of a partition function on filegroups.
--			3.Create a table or index using the partition scheme.
--The primary reason for placing your partitions on separate filegroups is to make sure that you can independently perform 
	--backup operations on partitions. This is because you can perform backups on individual filegroups. 
--Computed columns that participate in a partition function must be explicitly marked PERSISTED.
--All data types that are valid for use as index columns can be used as a partitioning column, except timestamp. 


--------------------------------
--To create a partition function
--------------------------------
--Creates a function in the current database that maps the rows of a table or index into partitions based on the 
	--values of a specified column.
--Partition function names must be unique within the database 
--All data types are valid for use as partitioning columns, except text, ntext, image, xml, timestamp, varchar(max), 
	--nvarchar(max), varbinary(max),

--Creating a RANGE LEFT partition function on an int column
CREATE PARTITION FUNCTION myRangePF1 (int)
	AS RANGE LEFT FOR VALUES (10, 100, 1000);

---------------------------------
--To create a partition scheme
---------------------------------
--Creates a scheme in the current database that maps the partitions of a partitioned table or index to filegroups.

CREATE PARTITION SCHEME myRangePS1
AS PARTITION myRangePF1
TO (hotfg,warmfg,coldfg,hotfg);

---------------------------------
--To create a partition table
---------------------------------
CREATE TABLE EmpTable
(
	EmpID int, 
	EmpName varchar(100)
)
ON myRangePS1 (EmpID);


--------------------------

INSERT INTO EmpTable VALUES (9,'PQR')
INSERT INTO EmpTable VALUES (10,'DEF')
INSERT INTO EmpTable VALUES (11,'FGH')

INSERT INTO EmpTable VALUES (99,'PQR')
INSERT INTO EmpTable VALUES (100,'DEF')
INSERT INTO EmpTable VALUES (101,'FGH')

INSERT INTO EmpTable VALUES (990,'PQR')
INSERT INTO EmpTable VALUES (1000,'DEF')
INSERT INTO EmpTable VALUES (1001,'FGH')


select * from EmpTable 

SELECT * 
FROM EmpTable
WHERE $PARTITION.myRangePF1(EmpID) = 1;

SELECT * 
FROM EmpTable
WHERE $PARTITION.myRangePF1(EmpID) = 2;

SELECT * 
FROM EmpTable
WHERE $PARTITION.myRangePF1(EmpID) = 3;

SELECT * 
FROM EmpTable
WHERE $PARTITION.myRangePF1(EmpID) = 4;


select * from EmpTable where empid = 56

select * from EmpTable where EmpName = 'Lisa'

--Split the partition between boundary_values 100 and 1000
--to create two partitions between boundary_values 100 and 500
--and between boundary_values 500 and 1000.

ALTER PARTITION SCHEME MyRangePS1 NEXT USED [warmfg];

ALTER PARTITION FUNCTION myRangePF1 ()
	SPLIT RANGE (500);

--Merge the partitions between boundary_values 1 and 100
--and between boundary_values 100 and 1000 to create one partition
--between boundary_values 1 and 1000.
ALTER PARTITION FUNCTION myRangePF1 ()
	MERGE RANGE (500);


-------------------------System Table Views ----------------------------------------------------------------------
--To get information about individual partition functions 
select * from sys.partition_functions

--To get information about individual parameters of partition functions 
select * from sys.partition_parameters 

--To get information about the boundary values of a partition function 
select * from sys.partition_range_values 

--To get information about all the partition schemes in a database 
select * from sys.partition_schemes 
select * from sys.data_spaces 

--To get information about individual partition schemes 
select * from sys.destination_data_spaces 

--To get information about all the partitions in a database 
select * from sys.partitions 

--To get partitioning information about a table or index 
select distinct t.name
from sys.partitions p
inner join sys.tables t on p.object_id = t.object_id
where p.partition_number <> 1


select distinct t.name
from sys.partitions p
inner join sys.indexes t on p.object_id = t.object_id
where p.partition_number <> 1
-----------------------------------------------------------------------



