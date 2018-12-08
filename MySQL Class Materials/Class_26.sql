--1.Clustered Index
--2.Non Clustered Index
--3.Unique Index (Clustered/NonClustered)
--4.Partitioned Index(NonClustered)
--5.XML Index Clustered/NonClustered)
--6.Spatial Index
--7.Filtered Index(NonClustered)
--8.Hash index(NonClustered)
--9.Covered Index(NonClustered)
--10.Column Stored Index

---------------Heap Table-------------------
--Table scan 
--RID Value

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

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (3,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (1,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F')

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')

select * from MyEmployee

---
select *
into MyAddress
from Person.[Address]

select * from MyAddress where PostalCode = '91502'

-----------------Clustered Index----------------

---------------------------------------------Clustered Index---------------------------------------------
--A clustered table, however, has it's data pages linked, making sequential scans a bit faster. 
--Clustered indexes sort and store the data rows in the table based on their key values. 
--There can only be one clustered index per table, because the data rows themselves can only be sorted in one order. 
--When you create a PRIMARY KEY constraint, a unique clustered index on the column or columns is automatically created 
	--if a clustered index on the table does not already exist and you do not specify a unique nonclustered index. 
--When you create a UNIQUE constraint, a unique nonclustered index is created to enforce a UNIQUE constraint by default. 
	--You can specify a unique clustered index if a clustered index on the table does not already exist. 
--An index created as part of the constraint is automatically given the same name as the constraint name. 
--You can create a clustered index on a column other than primary key column if a nonclustered primary key constraint 
	--was specified. 
--If a clustered index is created/Rebuild on a heap with several existing nonclustered indexes, all the nonclustered 
	--indexes must be rebuilt so that they contain the clustering key value instead of the row identifier (RID). 
--The preferred way to build indexes on large tables is to start with the clustered index and then build any 
	--nonclustered indexes. 
--Consider using a clustered index for queries that do the following: 
			--Return a range of values by using operators such as BETWEEN, >, >=, <, and <=.
			--Return large result sets. 
			--Use JOIN clauses; typically these are foreign key columns.
			--Use ORDER BY, or GROUP BY clauses. An index on the columns specified in the ORDER BY or GROUP BY 
				--clause may remove the need for the Database Engine to sort the data, because the rows are 
				--already sorted. 
--Consider using following columns for clustered Index
			--Unique or contain many distinct values. ie, less selectivity
			--Can be accessed sequentially
			--Defined as IDENTITY because the column is guaranteed to be unique within the table.
			--Used frequently to sort the data retrieved from a table.
--Clustered indexes are not a good choice for the following attributes:
			--Columns that undergo frequent changes
			--Wide keys
--Inserting a row into a clustered index never causes the entire table to be reordered, it simply maintains the page 
	--pointers on split pages so that the page chain remains in sorted order.  What it does not do is attemtpt to 
	--maintain the pages in contiguous physical order on disk

-------------
create clustered index cl_addressid on MyAddress(addressid) 

select * from MyAddress

------------

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

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (3,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M')

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (1,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F') 

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')

select * from MyEmployee

--create clustered index cl_EmpID on MyEmployee(EmpID) 
create clustered index cl_EmpID on MyEmployee(EmpID desc) 

select * from MyEmployee

-----------------Non-Clustered Index -----------------
drop table if exists MyAddress
select *
into MyAddress
from Person.[Address]

select * from MyAddress

create nonclustered index ncl_PostalCode on MyAddress(PostalCode) 

select * from MyAddress

select * from MyAddress where PostalCode = '02184'

create clustered index cl_addressid on MyAddress(addressid) 

select * from MyAddress where PostalCode = '02184'

--------------------------------------------------------






















