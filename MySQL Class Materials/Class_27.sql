----------------Primary key and Indexes --------------------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int PRIMARY KEY , 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1),
)

--------------------------------

drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int PRIMARY KEY NONCLUSTERED, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1),
)

-----------------Unique Index---------------------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int PRIMARY KEY, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL unique, 
	DOB date,
	Gender char(1),
)

-----------------------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1),
)

create unique nonclustered index ncl_ssn on MyEmployee(SSN) 
create unique clustered index ncl_EmpID on MyEmployee(EmpID )

---------------------Covered Index-------------------------------

select * from MyAddress
select * from MyAddress where PostalCode = '02184'

select city, PostalCode
from MyAddress
where PostalCode = '02184'

DROP INDEX [ncl_PostalCode] ON [dbo].[MyAddress]

create nonclustered index ncl_PostalCode on MyAddress(PostalCode, city) 

select city, PostalCode
from MyAddress
where PostalCode = '02184'

DROP INDEX [ncl_PostalCode] ON [dbo].[MyAddress]

create nonclustered index ncl_PostalCode on MyAddress(PostalCode) 
include (city) 

select addressline1,city, PostalCode
from MyAddress
where PostalCode = '02184'

create nonclustered index ncl_PostalCode on MyAddress(PostalCode) 
include (addressline1, city) 

------------------Filtered Index-----------------------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int primary key, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1),
)

create nonclustered index ncl_dob_less_than_2000 on MyEmployee(dob)
where (dob < '1/1/2000')

create nonclustered index ncl_dob_greater_than_2000 on MyEmployee(dob)
where (dob >= '1/1/2000')

--------------Data Compression-------------------

create table testcompression (col1 int, col2 char(50))
go

insert into testcompression values (10, 'compression testing')
go 5000

select * from testcompression

-- original
exec sp_spaceused testcompression --392 KB
go


-- data_compression = row
alter table testcompression
rebuild with (data_compression = row);
go

exec sp_spaceused testcompression --200 KB
go

-- data_compression = page
alter table testcompression
rebuild with (data_compression = page);
go

exec sp_spaceused testcompression  --72 KB
go

-- data_compression = none
alter table testcompression
rebuild with (data_compression = none);
go

exec sp_spaceused testcompression  --328 KB
go

--------------------Compresed Index-------------------------------
DROP INDEX [ncl_PostalCode] ON [dbo].[MyAddress]

create nonclustered index ncl_PostalCode on MyAddress(PostalCode, city) 
WITH (DATA_COMPRESSION = ROW) 

-------------------Partitioned and compressed Index -----------------------------
--Creating a partition scheme that maps each partition to a different filegroup
CREATE PARTITION FUNCTION myRangePF1 (int)
AS RANGE LEFT FOR VALUES (10, 100, 1000);
GO

CREATE PARTITION SCHEME myRangePS1
AS PARTITION myRangePF1
TO (hotfg, warmfg, coldfg, hotfg);

---------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1),
)

CREATE NONCLUSTERED INDEX ncl_EmpID	ON MyEmployee (EmpID)
ON myRangePS1 (EmpID)

CREATE NONCLUSTERED INDEX ncl_EmpID	ON MyEmployee (EmpID)
ON myRangePS1 (EmpID)
with (DATA_COMPRESSION = PAGE ON PARTITIONS(1), DATA_COMPRESSION = ROW ON PARTITIONS (2 TO 4))


--------------------------Index Maintenance(Rebuild/Re-Organize) -------------------

------------------------------Find Index Fragmentation ---------------------
--When you perform INSERT, UPDATE, or DELETE statements, index fragmentation may occur and the information in the index 
	--can get scattered in the database. 
--Fragmented index data can cause SQL Server to perform unnecessary data reads and switching across different pages, 
	--so query performance against a heavily fragmented table can be very poor.

--There are basically two types of fragmentation: 
	--1)External fragmentation (Logical Scan Fragmentation) - 
		--External, a.k.a logical,  fragmentation occurs when an index leaf page is not in logical order, in other words 
			--it occurs when the logical ordering of the index does not match the physical ordering of the index. 
		--External fragmentation causes SQL Server to perform extra work to return ordered results. 
		--External fragmentation isn’t too big of a deal for specific searches that return very few records or queries 
			--that return result sets that do not need to be ordered.
		--For anything over 25% fragmentation, rebuild index.
		--For anything between 15% to 25% fragmentation, reorganize index.
		
	--2)Internal fragmentation - 
		--Internal fragmentation occurs when there is too much free space in the index pages. Typically, some free space 
			--is desirable, especially when the index is created or rebuilt. 
		--You can specify the Fill Factor setting when the index is created or rebuilt to indicate a percentage of how 
			--full the index pages are when created. 
		--If the index pages are too fragmented, it will cause queries to take longer (because of the extra reads 
			--required to find the dataset) and cause your indexes to grow larger than necessary. 
		--If no space is available in the index data pages, data changes (primarily inserts) will cause page splits as 
			--discussed above, which also require additional system resources to perform.
		--For anything between 60 to 80% fragmentation, reorganize index.
		--For anything less than 60% fragmentation, rebuild the index.
		
--Reorganize or Rebuild Index are the two ways to fix fragmentation. 
--The Reorganize Index is an online operation, however Rebuild Index is not an online operation until you have specified 
	--the option ONLINE=ON while performing the Rebuild. 

---------------------------Options when you create/rebuild an index --------------------
select * from MyAddress 

DROP INDEX [ncl_PostalCode] ON [dbo].[MyAddress]

create nonclustered index ncl_PostalCode 
	on MyAddress(addressid,addressline1,addressline2,city, [stateprovinceid], postalcode, rowguid, modifieddate)
WITH (FILLFACTOR=80, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, 
	DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,MAXDOP=1) 

----------------------------














