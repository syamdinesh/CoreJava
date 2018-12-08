---------------------Column Stored Index ------------------------------
--Method -1 : Create a Non clustered column stored index
CREATE TABLE AutoType
(
   AutoID INT PRIMARY KEY, 
   Make VARCHAR(20) NOT NULL,
   Model VARCHAR(20) NOT NULL,
   Color VARCHAR(15) NOT NULL,
   ModelYear SMALLINT NOT NULL
);

CREATE NONCLUSTERED COLUMNSTORE INDEX ncl_csi_AutoType ON AutoType (Make, ModelYear);


--Method -2 : Convert a heap to a clustered columnstore index
CREATE TABLE AutoType
(
   AutoID INT, 
   Make VARCHAR(20) NOT NULL,
   Model VARCHAR(20) NOT NULL,
   Color VARCHAR(15) NOT NULL,
   ModelYear SMALLINT NOT NULL
);

CREATE CLUSTERED COLUMNSTORE INDEX cl_csi_AutoType ON AutoType;

CREATE NONCLUSTERED COLUMNSTORE INDEX ncl_csi_AutoType ON AutoType (Make, ModelYear);

CREATE NONCLUSTERED INDEX ncl_AutoType ON AutoType (Make, ModelYear);

--Method – 3: Convert a clustered index to a clustered columnstore index with the same name
CREATE TABLE AutoType
(
   AutoID INT, 
   Make VARCHAR(20) NOT NULL,
   Model VARCHAR(20) NOT NULL,
   Color VARCHAR(15) NOT NULL,
   ModelYear SMALLINT NOT NULL
);

create clustered index cl_autoid on AutoType(AutoID)

CREATE CLUSTERED COLUMNSTORE INDEX cl_autoid ON AutoType
with(drop_existing=on);


------------------memory optimized table------------
CREATE DATABASE IMDB     
ON      
PRIMARY (NAME = IMDB_data, FILENAME = 'C:\HKData\IMDB_data.mdf'),      
FILEGROUP IMDB_mod_FG CONTAINS MEMORY_OPTIMIZED_DATA (NAME = IMDB_mod, FILENAME = 'C:\HKData\IMDB_mod');

--Non-durable memory-optimized table with memory-optimized non-clustered index
CREATE TABLE dbo.people 
(  
	[Name] varchar (32) not null PRIMARY KEY NONCLUSTERED,  
	[City] varchar (32) null, 
	[State_Province] varchar (32) null,   
	[LastModified] datetime not null,   
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_ONLY); 

--Durable memory-optimized table with memory-optimized non-clustered index
CREATE TABLE dbo.people 
(  
	[Name] varchar (32) not null PRIMARY KEY NONCLUSTERED,  
	[City] varchar (32) null, 
	[State_Province] varchar (32) null,   
	[LastModified] datetime not null,   
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);


--Memory Optimized Hash Index for durable and non-durable tables.  
CREATE TABLE dbo.OrderDetails 
(  
	OrderID int NOT NULL PRIMARY KEY NONCLUSTERED,  
	ProductID int NOT NULL,  
	UnitPrice money NOT NULL,  
	Quantity smallint NOT NULL,  
	Discount real NULL ,
	INDEX IX_OrderID NONCLUSTERED (ProductID) ,
	INDEX IX_UnitPrice NONCLUSTERED HASH (UnitPrice) WITH (BUCKET_COUNT = 131072)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);





--Durable memory-optimized table with clustered column stored index 
CREATE TABLE dbo.OrderDetailsBig 
(  
	OrderID int NOT NULL,  
	ProductID int NOT NULL,  
	UnitPrice money NOT NULL,  
	Quantity smallint NOT NULL,  
	Discount real NOT NULL 
	CONSTRAINT PK_Order_Details PRIMARY KEY NONCLUSTERED (OrderID, ProductID),  
	INDEX IX_OrderID NONCLUSTERED HASH (OrderID) WITH (BUCKET_COUNT = 20000000),  
	INDEX IX_ProductID NONCLUSTERED (ProductID),  
	INDEX clcsi_OrderDetailsBig CLUSTERED COLUMNSTORE WITH (COMPRESSION_DELAY = 60) 
) 
WITH ( MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);

--1.Clustered column stored index
--2.Non clustered index
--3.Non clustered hash index
--4.Non clustered column stored index














