--SQL Constraints
-----------------
--Constraints are used to limit the type of data that can go into a table.
--Constraints can be specified when a table is created (with the CREATE TABLE statement) or after the table is created (with the ALTER TABLE statement).
--Following is the list of constarins 
	--NOT NULL
	--UNIQUE
	--PRIMARY KEY
	--FOREIGN KEY
	--CHECK
	--DEFAULT

--NOT NULL
----------
--The NOT NULL constraint enforces a column to NOT accept NULL values. 
--The NOT NULL constraint enforces a field to always contain a value. This 
--	means that you cannot insert a new record, or update a record without adding 
--	a value to this field.

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

--PRIMARY KEY
-------------
--The PRIMARY KEY constraint uniquely identifies each record in a database table.
--Primary keys must contain unique values.
--A primary key column cannot contain NULL values.
--Each table should have a primary key, and each table can have only one primary key.
--All columns defined within a PRIMARY KEY constraint must be defined as NOT NULL.
--Maximum columns per Primary Key is 16.

drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int primary key, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money
)

--------------
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

alter table MyEmployee add constraint pk_MyEmployee_EmpID primary key (EmpID)

----------------------
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
	Salary money,
	constraint pk_MyEmployee_EmpID primary key (EmpID)
)

-------Multi Column Primary Key -----------------

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

alter table MyEmployee add constraint pk_MyEmployee_FirstName_LastName primary key (FirstName,LastName)

--------
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
	Salary money,
	constraint pk_MyEmployee_FirstName_LastName primary key (FirstName,LastName)
)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F', 80000.00)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (2,'Lisa', null, 'Mathews', '435-09-8976', '12/12/1980', 'M', 60000.00) 

-------------UNIQUE ------------------------------
--The UNIQUE constraint uniquely identifies each record in a database table.
--The UNIQUE and PRIMARY KEY constraints both provide a guarantee for uniqueness for a column or set of columns.
--A PRIMARY KEY constraint automatically has a UNIQUE constraint defined on it.
--You can have many UNIQUE constraints per table, but only one PRIMARY KEY constraint per table.


drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int primary key, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL unique, 
	DOB date,
	Gender char(1) ,
	Salary money
)

---------------

drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money,
	constraint pk_MyEmployee_EmpID primary key (EmpID),
	constraint uq_MyEmployee_SSN unique (ssn) 
)

-------Multi Column Unique Constraint -----------------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money,
	constraint pk_MyEmployee_EmpID primary key (EmpID),
	constraint uq_MyEmployee_SSN unique (ssn) ,
	constraint uq_MyEmployee_FirstName_MiddleName_LastName unique (FirstName,MiddleName,LastName)

)

--Primary Key = unique + not null?

------------CHECK Comstraint---------------------
--The CHECK constraint is used to limit the value range that can be placed in a column.
--If you define a CHECK constraint on a single column it allows only certain values for this column.
--If you define a CHECK constraint on a table it can limit the values in certain columns based on values in other columns in the row.
--A column can have any number of CHECK constraints, and the condition can include multiple logical expressions combined with AND and OR

drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) check(Gender = 'M' or Gender = 'F'),
	Salary money check(Salary >= 40000.00) ,
	constraint pk_MyEmployee_EmpID primary key (EmpID),
	constraint uq_MyEmployee_SSN unique (ssn) ,
	constraint uq_MyEmployee_FirstName_MiddleName_LastName unique (FirstName,MiddleName,LastName)

)

------
drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) check(Gender = 'M' or Gender = 'F'),
	Salary money ,
	constraint pk_MyEmployee_EmpID primary key (EmpID),
	constraint uq_MyEmployee_SSN unique (ssn) ,
	constraint uq_MyEmployee_FirstName_MiddleName_LastName unique (FirstName,MiddleName,LastName),
	constraint chk_MyEmployee_Salary check (Salary >= 40000.00 and DOB >= '1/1/1990') 
)


-------------------------------Default Constraint -----------------------
--The DEFAULT constraint is used to insert a default value into a column.
--The default value will be added to all new records, if no other value is specified.
--DEFAULT definitions cannot be created on columns with a timestamp data type or columns with an IDENTITY property.

drop table if exists MyEmployee

create table MyEmployee 
(
	EmpID int, 
	FirstName varchar(50) not null,
	MiddleName varchar(20),
	LastName varchar(50) not null, 
	SSN VARCHAR(11) NOT NULL, 
	DOB date,
	Gender char(1) ,
	Salary money not null default 40000.00
)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F')

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender,Salary)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F',null)

select * from MyEmployee

------------------FOREIGN KEY Constraint --------------------
--A FOREIGN KEY in one table points to a PRIMARY KEY in another table.
--A table can contain a maximum of 999 FOREIGN KEY constraints.
--FOREIGN KEY constraints can reference only columns in PRIMARY KEY or UNIQUE constraints in the referenced table or in a UNIQUE INDEX on the referenced table.
--The FOREIGN KEY constraint is used to prevent actions that would destroy link between tables.
--The FOREIGN KEY constraint also prevents that invalid data is inserted into the foreign key column, 
--	because it has to be one of the values contained in the table it points to.
--Cross-database referential integrity must be implemented through triggers.
--FOREIGN KEY constraints are not enforced on temporary tables.
--FOREIGN KEY constraints can reference another column in the same table (a self-reference).
--ON DELETE { CASCADE | NO ACTION | SET DEFAULT |SET NULL }
--ON UPDATE { CASCADE | NO ACTION | SET DEFAULT |SET NULL }

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

drop table if exists MyEmployeePayment
create table MyEmployeePayment
(
	PaymentID int primary key,
	EmpID int not null ,
	EffectiveDate date not null,
	EndDate date,
	Payment money not null 
)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F'),
	 (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M'),
	 (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F'),
	 (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F')

insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
values (1,3,'1/1/2018', '2/15/2018', 56000.00),
	(2,3,'2/16/2018', null, 60000.00),
	(3,1,'6/1/2018', null, 90000.00),
	(4,4,'6/15/2018', null, 100000.00)

select * from MyEmployee
select * from MyEmployeePayment 

select *
from MyEmployee e
left outer join MyEmployeePayment  p on e.EmpID = p.EmpID






