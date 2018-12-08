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


select *
from MyEmployee e
left outer join MyEmployeePayment  p on e.EmpID = p.EmpID

--Method-1
delete from MyEmployee where EmpID = 4

--Method-2
insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
values (5,500,'1/1/2018', '2/15/2018', 56000.00)

--Method-3
update MyEmployee
set empid =100
where empid=1

--Method-4
update MyEmployeePayment
set empid = 300
where empid = 3

select * from MyEmployee
select * from MyEmployeePayment 

---------------
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
	EmpID int not null foreign key references MyEmployee(EmpID),
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


--Method-1
delete from MyEmployee where EmpID = 4

--Method-2
insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
values (5,500,'1/1/2018', '2/15/2018', 56000.00)

--Method-3
update MyEmployee
set empid =100
where empid=1

--Method-4
update MyEmployeePayment
set empid = 300
where empid = 3

-----ON DELETE/UPDATE Options ---------------------------------
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
	EmpID int foreign key references MyEmployee(EmpID) 
		on delete set null on update set null,
		--on delete set default on update set default,
		--on delete cascade on update cascade,
	EffectiveDate date not null,
	EndDate date,
	Payment money not null 
)

insert into MyEmployee (EmpID,FirstName,MiddleName,LastName,SSN,DOB,Gender)
values (1,'Lisa', null, 'George', '123-45-6789', '1/1/1980', 'F'),
	 (2,'Eric', null, 'Weist', '435-09-8976', '12/12/1980', 'M'),
	 (3,'Shannon', null, 'Mathews', '546-99-0087', '7/8/2004', 'F'),
	 (4,'Priya', null, 'Patel', '546-99-0087', '7/8/2004', 'F'),
	 (100,'Default', null, 'Employee', '000-00-0000', '7/8/2004', 'F')

insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
values (1,3,'1/1/2018', '2/15/2018', 56000.00),
	(2,3,'2/16/2018', null, 60000.00),
	(3,1,'6/1/2018', null, 90000.00),
	(4,4,'6/15/2018', null, 100000.00)

select * from MyEmployee
select * from MyEmployeePayment 


--Method-1
delete from MyEmployee where EmpID = 4

--Method-2
insert into MyEmployeePayment (PaymentID,EmpID,EffectiveDate,EndDate,Payment)
values (5,500,'1/1/2018', '2/15/2018', 56000.00)

--Method-3
update MyEmployee
set empid =200
where empid=1

--Method-4
update MyEmployeePayment
set empid = 300
where empid = 3

----------self-reference foreign key---------
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
	ManagerID int foreign key references MyEmployee(EmpID) 
)

--------------TRUNCATE ----------------------------
TRUNCATE TABLE MyEmployee 
DELETE FROM MyEmployee






