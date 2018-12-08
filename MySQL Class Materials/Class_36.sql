-----------------------Local Temp Table --------------------------
--table is preceded by single ‘#’ sign, 
--local temporary table scope is limited to session in which it is created.
--MS SQL Server creates temporary table in tempdb database. 
--Cannot create another temporary table with the same name in the same session

CREATE TABLE #ABC
(
	COL1 INT,
	COL2 VARCHAR(30),
	COL3 DATETIME DEFAULT GETDATE()
)
GO

INSERT INTO #ABC(COL1, COL2) VALUES(1,'Decipher');
INSERT INTO #ABC(COL1, COL2) VALUES(2,'Information');
INSERT INTO #ABC(COL1, COL2) VALUES(3,'systems');

select * from #ABC

SELECT *
FROM information_schema.tables
WHERE table_name like '%abc%' or table_name like '%xyz%'
GO

-------------------Global Temp Table-----------------------
CREATE TABLE ##XYZ
(
	COL1 INT,
	COL2 VARCHAR(30),
	COL3 DATETIME DEFAULT GETDATE()
)
GO

INSERT INTO ##XYZ(COL1, COL2) VALUES(1,'Decipher');
INSERT INTO ##XYZ(COL1, COL2) VALUES(2,'Information');
INSERT INTO ##XYZ(COL1, COL2) VALUES(3,'systems');

select * from ##XYZ

-----------------Table Variable----------------
declare @cars table 
( 
   car_id int not null,  
   colorcode varchar(10),  
   modelname varchar(20),  
   code int , 
   dateentered datetime 
) 

insert into @cars (car_id, colorcode, modelname, code, dateentered) 
values (1,'bluegreen', 'austen', 200801, getdate()) 

select car_id, colorcode, modelname, code, dateentered from @cars

---------------------------------Log Shipping-------------------------------------













