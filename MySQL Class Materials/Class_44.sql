----------------Row Level Security------------

--Create a quick table to hold data.
create table dbo.Orders
(
    OrderID	int,
    SalesRep	sysname,
    Product	varchar (25),
    Quantity	int
);


insert dbo.Orders
 values (1, 'Sales1', 'Bracket', 11), 
	(2, 'Sales1', 'Wheel', 21), 
	(3, 'Sales1', 'Valve', 4),
	(4, 'Sales1', 'Bracket', 6), 
	(5, 'Sales1', 'Wheel', 8), 
	(6, 'Sales2', 'Seat', 13),
	(7, 'Sales2', 'Seat', 5),
	(8, 'Sales2', 'Seat', 7),
	(9, 'Sales2', 'Bracket', 17),
	(10, 'Sales2', 'Wheel', 20);

select * from dbo.Orders 

--Create three user accounts that will demonstrate different access capabilities.
create user Manager without login;
create user Sales1 without login;
create user Sales2 without login;

--Grant read access on the table to each of the users.
grant select on dbo.Orders to Manager;
grant select on dbo.Orders to Sales1;
grant select on dbo.Orders to Sales2;

--
execute as user = 'Manager';
select * from dbo.Orders; 
revert;

execute as user = 'Sales1';
select * from dbo.Orders; 
revert;

execute as user = 'Sales2';
select * from dbo.Orders; 
revert;



-------------
--Create a new schema, and an inline table valued function
create schema Security;
go

create function Security.fn_securitypredicate(@SalesRep as sysname)
returns table
with schemabinding
as
    return select 1 as fn_securitypredicate_result 
			where @SalesRep = user_name() or user_name() = 'Manager';


--Create a security policy adding the function as a filter predicate. The state must be set to ON to enable the policy.
create security policy OrdersFilter
	add filter predicate Security.fn_securitypredicate(SalesRep) 
	on dbo.Orders
with (state = on);


---
execute as user = 'Manager';
select * from dbo.Orders; 
revert;


execute as user = 'Sales2';
select * from dbo.Orders; 
revert;

select * from dbo.Orders 

-----------------Offline/Online Mode----------------------------
ALTER DATABASE [ABCD] SET  OFFLINE
GO

ALTER DATABASE [ABCD] SET  ONLINE
GO

-------------------------
























