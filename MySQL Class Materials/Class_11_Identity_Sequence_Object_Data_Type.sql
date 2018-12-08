create table MyEmployee123
(
	EmpID int not null, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL
)

insert into MyEmployee123
select EmpID,FirstName,MiddleName,LastName,SSN from MyEmployee

select * from MyEmployee123

select * from AEDemo.dbo.Demo_Always_Encrypted

-------------------Identity column-------------------------------

drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int not null identity(1,1), 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money
)

insert into MyEmployee (FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F', 80000.00)

insert into MyEmployee (FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M', 60000.00) 

insert into MyEmployee(FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F', 70000.00)

select * from MyEmployee
-----------------------------------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int not null identity(5,10), 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money
)

insert into MyEmployee (FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F', 80000.00)

insert into MyEmployee (FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M', 60000.00) 

insert into MyEmployee(FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F', 70000.00)

select * from MyEmployee

--------------DBCC CHECKIDENT-----------------

drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int not null identity(1,1), 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money
)

insert into MyEmployee (FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F', 80000.00)

insert into MyEmployee (FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M', 60000.00) 

insert into MyEmployee(FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F', 70000.00)

--insert into MyEmployee(FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
--values ('Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F', 70000.00)

delete from MyEmployee where empid= 2

DBCC CHECKIDENT ('MyEmployee', RESEED, 1);

insert into MyEmployee (FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M', 60000.00) 

DBCC CHECKIDENT ('MyEmployee', RESEED, 3);

insert into MyEmployee(FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F', 70000.00)

select * from MyEmployee

---------------------------------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int not null identity(1,1), 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money
)

insert into MyEmployee (FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F', 80000.00)

insert into MyEmployee (FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M', 60000.00) 

insert into MyEmployee(FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F', 70000.00)

delete from MyEmployee where empid= 2

SET IDENTITY_INSERT MyEmployee ON;  

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M', 60000.00) 

SET IDENTITY_INSERT MyEmployee OFF; 

insert into MyEmployee(FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values ('Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F', 70000.00)

select * from MyEmployee

-----------------------Sequence Object-----------------------
--Sequence:  Generating a sequence number, a.k.a. auto number, is a common task in an 
--enterprise application. For a single table, you can specify identity field. But, 
--if you want to have database wide sequential number, then you must devise something 
--by yourself before SQL Server 2012. One solution to this problem is to create 
--a table that has a numeric field can be used to store sequential number, then 
--use SQL to increase it every time used one. In SQL Server 2012, we have a new 
--solution - use Sequence.

CREATE SEQUENCE MySeq1 as int
    START WITH 1
    INCREMENT BY 1
    --MAXVALUE 200
;

SELECT NEXT VALUE FOR MySeq1


drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int not null, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money
)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (NEXT VALUE FOR MySeq1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F', 80000.00)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (NEXT VALUE FOR MySeq1,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M', 60000.00) 

insert into MyEmployee(EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (NEXT VALUE FOR MySeq1,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F', 70000.00)

select * from MyEmployee 

------------------
SELECT * 
FROM sys.sequences
WHERE name = 'MySeq1' ;

------------------------Data Types ------------------------------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID smallint not null, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN CHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary decimal(9,2) --9999999.99
)

1 Byte = 8 bit

---------------------------------TINYINT, SMALLINT, INT and BIGINT data types --------------------
--Type			Minimum_Value							Maximum_Value							Storage_Size 
-------------------------------------------------------------------------------------------------------------
--tinyint		0										255										1 byte 
--smallint		-2^15 (-32,768)							2^15 - 1 (32,767)						2 bytes 
--int			-2^31 (-2,147,483,648)					2^31 - 1 (2,147,483,647)				4 bytes 
--bigint		-2^63 (-9,223,372,036,854,775,808)		2^63 - 1 (9,223,372,036,854,775,807)	8 bytes 

---------------------------------NUMERIC and DECIMAL data types ----------------------------
--There is no difference between NUMERIC and DECIMAL data types.  They are synonymous to each 
--other and either one can be used.  DECIMAL/NUMERIC data types are numeric data types with 
--fixed precision and scale.

--DECIMAL (p [, s ])
--NUMERIC (p [, s ])

--In declaring a DECIMAL or NUMERIC data type, p, which is the precision, specifies the maximum 
--total number of decimal digits that can be stored, both to the left and to the right of the 
--decimal point.  The precision must be a value from 1 through the maximum precision of 38.  The 
--s is the scale and it specifies the maximum number of decimal digits that can be stored to the 
--right of the decimal point.  Scale, which defaults to 0 if not specified, must be a value from 
--0 to the precision value.

--The following table specifies the storage size required based on the precision specified for 
--the NUMERIC or DECIMAL data type:

--Precision		Storage 
-----------		-------
--1-9			5 bytes 
--10-19			9 bytes 
--20-28			13 bytes 
--29-38			17 bytes 

-------------------------SMALLDATETIME and DATETIME data types -----------------------------------
--Type				Minimum				Maximum				TimeAccuracy						Size 
--------			-------				-------				------------						-------
--smalldatetime		January 1, 1900		June 6, 2079		up to a minute						4 bytes 
--datetime			January 1, 1753		December 31, 9999	one three-hundredth of a second		8 bytes 

--A DATETIME data type is stored internally in SQL Server as two 4-byte integers. The first 
--4 bytes store the number of days before or after the base date of January 1, 1900. The other 
--4 bytes store the time of day represented as the number of milliseconds after midnight.

--A SMALLDATETIME data type is stored internally in SQL Server as two 2-byte integers. The first 
--2 bytes store the number of days before or after the base date of January 1, 1900. The other 2 
--bytes store the number of minutes since midnight

--------------------------SMALLMONEY and MONEY data types ---------------------------------------
--Type			Minimum								Maximum									Size 
------			-------								-------									----
--smallmoney	-214,748.3648						214,748.3647							4 bytes 
--money			-2^63 (-922,337,203,685,477.5808)	2^63 - 1 (+922,337,203,685,477.5807)	8 bytes 

-------------------------CHAR and VARCHAR data types ----------------------------------------
--CHAR and VARCHAR data types are both non-Unicode character data types with a maximum length 
--of 8,000 characters.  The main difference between these 2 data types is that a CHAR data 
--type is fixed-length while a VARCHAR is variable-length.  If the number of characters entered 
--in a CHAR data type column is less than the declared column length, spaces are appended to it 
--to fill up the whole length.

------------------nchar vs char / nvarchar vs varchar -------------------------
--1 Byte = 8 bit

1 bit = 2
2 bit = 4
3 bit = 8 

--							CHAR(n)			NCHAR(n) 
--							------			--------
--Character Data Type		Non-Unicode		Data Unicode Data 
--Maximum Length			8,000			4,000 
--Character Size			1 byte			2 bytes 
--Storage Size				n bytes			2 times n bytes 


