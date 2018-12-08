-----------Index Maintenance(Rebuild/Re-Organize)------------------------

------------------REBUILD INDEX--------------------------
-- 1. ALTER INDEX with the REBUILD clause
-- 2. CREATE INDEX with the DROP_EXISTING clause

--ALTER INDEX with the REBUILD clause
ALTER INDEX ncl_PostalCode ON MyAddress REBUILD
with (fillfactor=80)

ALTER INDEX all ON MyAddress REBUILD
with (fillfactor=80)

--CREATE INDEX with the DROP_EXISTING clause
create nonclustered index ncl_PostalCode on MyAddress(addressid,addressline1,addressline2,city, [stateprovinceid], postalcode, rowguid, modifieddate)
WITH (FILLFACTOR=80, DROP_EXISTING = ON) 

--------------------Re-Organize-----------------------------
ALTER INDEX ncl_PostalCode ON MyAddress Reorganize

--Setting options on an index using alter index
ALTER INDEX ncl_PostalCode ON MyAddress
SET (
    fillfactor=80,
	STATISTICS_NORECOMPUTE = ON,
    IGNORE_DUP_KEY = ON,
    ALLOW_PAGE_LOCKS = ON
    ) ;

------Disbale Index------------
ALTER INDEX cl_PostalCode ON MyAddress DISABLE ;
ALTER INDEX all ON MyAddress DISABLE ;

--Rebuilding a partitioned index
ALTER INDEX cl_PostalCode ON MyAddress
REBUILD Partition = 5;

------------------------------Index Related Dynamic Management Views(DMV) and Functions(DMF) ---------------------------------------
SELECT * FROM sys.dm_db_index_operational_stats(NULL, NULL, NULL, NULL);
SELECT * FROM sys.dm_db_index_physical_stats (DB_ID('ADVENTUREWORKS'), OBJECT_ID('Person.Address'), NULL, NULL , 'DETAILED');
SELECT * FROM sys.dm_db_index_physical_stats (DB_ID('ADVENTUREWORKS'), OBJECT_ID('Person.Address'), NULL, NULL , NULL);
select * from sys.dm_db_index_usage_stats where database_id = 5

SELECT DB_ID('ADVENTUREWORKS')
select OBJECT_ID('myaddress')

SELECT * FROM sys.dm_db_index_physical_stats (DB_ID('ADVENTUREWORKS'), OBJECT_ID('myaddress'), NULL, NULL , NULL);
SELECT * FROM sys.dm_db_index_physical_stats (DB_ID('ADVENTUREWORKS'), OBJECT_ID('myaddress'), NULL, NULL , 'DETAILED');

SELECT object_name(IPS.object_id) AS [TableName], 
   SI.name AS [IndexName], 
   IPS.Index_type_desc, 
   IPS.index_level,
   IPS.avg_fragmentation_in_percent, --> It indicates the amount of external fragmentation you have 
							--for the given objects. The lower the number the better 
   IPS.avg_fragment_size_in_pages, 
   IPS.avg_page_space_used_in_percent, --> It indicates on average how full each page in the index 
						--is (internal fragmentation). The higher the number the better 
   IPS.record_count, 
   IPS.Page_count,
   IPS.ghost_record_count,
   IPS.fragment_count, -->A fragment is made up of physically consecutive leaf pages in the same 
			--file for an allocation unit. So the less fragments the more data is 
			--stored consecutively.
   IPS.avg_fragment_size_in_pages -->Larger fragments mean that less disk I/O is required to read 
		--the same number of pages. Therefore, the larger the avg_fragment_size_in_pages value, 
		--the better the range scan performance.
FROM sys.dm_db_index_physical_stats(db_id('AdventureWorks'), OBJECT_ID('myaddress'), NULL, NULL , 'DETAILED') IPS
INNER JOIN sys.tables ST WITH (nolock) ON IPS.object_id = ST.object_id
INNER JOIN sys.indexes SI WITH (nolock) ON IPS.object_id = SI.object_id AND IPS.index_id = SI.index_id
WHERE ST.is_ms_shipped = 0
ORDER BY [TableName], [IndexName] 

---------------------------------------Index Scan,Table Scan and Index Seek----------------------------------------
-- Table1 has five columns : Col1,Col2,Col3,Col4,Col5
-- Index1 on Table1 contains two columns : Col1,Col3
-- Query1 on Table1 retrieves two columns : Col1,Col5 

-- Now when Query1 is ran on Table1 it will use search predicates Col1,Col5 to figure out if it will use Index1 or not. 
	--As Col1,Col5 of Query1 are not same as Col1,Col3 of Index1 there are good chances that Query1 will use Index1.
	--OR the optimizer will go for an index scan instead of an index seek. 

--If there is no index on a table then Query Optimizer goes for table scan. 

--Query Optimizer tries its best to use an Index Seek. An Index Seek means that the Query Optimizer was able to 
--find a useful index in order to locate the appropriate records. 

--When the Query Optimizer is not able to perform an Index Seek, either because there is no indexes or no useful 
--indexes available, then SQL Server has to scan all the records, looking for all the records that meet the 
--requirements of the query. There are two types of scans the SQL Server can perform. 
--	1)When a Table Scan is performed, all the records in a table are examined, one by one. For large tables, this 
--	can take a long time. But for very small tables, a table scan can actually be faster than an Index Seek. So if 
--	SQL Server has performed a Table Scan, take a note of how many rows are in the table. If there arent many, then 
--	in this case, a Table Scan is a good thing. 

--	2)When an Index Scan is performed, all the rows in the leaf level of the index are scanned. What does this mean? 
--	Essentially, this means that all of the rows of the table or the index are examined instead of the table directly. 
--	Sometimes, the Query Optimizer determines that an Index Scan is more efficient than a Table Scan, so one is 
--	performed, although the performance difference between them is generally not much. 

--In some cases, such as if a huge quantity of rows need to be returned, it is faster to do an Index Scan 
--than an Index Seek. Or it may be because the index is not selective enough. In any case, the Query Optimizer doesn't 
--think the available index is useful, other than for performing an Index Scan. 

--For small tables, optimizer prefer index or table scan.This is because the added overhead of first reading the index, 
--then reading the pages containing the rows returned by the index


-----------------------------Selectivity of the index----------------------------------------
--Selectivity refers to the percentage of rows in a table that are returned by a query. 
--A query is considered highly selective if it returns a very limited number of rows. 
--A query is considered to have low selectivity if it returns a high percentage of rows. 
--Generally speaking, if a query returns less than 5% of the number of rows in a table, it is considered to have 
	--high selectivity, and the index will most likely be used. 
--If the query returns from 5% - 10% of the rows, the index may or may not be used. 
--If the query returns more than 10% of the rows, the index most likely will not be used. And assuming there are 
	--no other useful indexes for the query, a table scan will be performed.

-----------------------------Density of the index----------------------------------------------
--Density refers to the average percentage of duplicate rows in an index.
--If density is a high number, then selectively is low, which means an index may not be used. 
--If density is a low number, then selectivity is high, and an index most likely will be used.
--Use DBCC SHOW_STATISTICS to verify the index desity. 

---------------------------Histogram of the index----------------------------------------------
--Histogram of the index is the actual distribution of values of the first column of an index.
--SQL only keeps the histogram for the first column of the index. That means that it only knows the actual 
	--distribution of values of the first column.



--------------------------Order of fields in an Index------------------------------------------
--SQL only keeps the histogram for the first column of the index. 
--That means that it only knows the actual distribution of values of the first column. 
--If the first column is not selective, the index may not be used. However, that’s not the whole story. 

--In addition to the histogram, index keeps density values for all of the left-based subsets of the index keys. 
--For a 3 column index key, SQL knows the density of the first column, of the first and second and of all three. 
--The density is, in a nutshell, a value that shows how unique the set of columns is. It’s 1/(distinct values). 
--The value can be seen for any index using DBCC Show_Statistics with the DENSITY_VECTOR option. 

--This means, while SQL only knows the actual data distribution of the first column, it does know, on average, 
	--how many rows will be returned by an equality match on any left-based subset of the index keys. 
--Therefore, a good rule for the order of columns in an index key is to put the most selective columns first, 
	--when all other considerations are equal. 

--However, its useless to have the most selective column of the index on the left if very few queries use that column 
	--in the where clause. In this case, queries that don’t filter on it, but do filter on the other columns of the 
	--index will have to scan, and scans are expensive. 

--If queries are always going to filter with one or more equality predicates and one or more inequality predicates, 
	--the columns used for the inequalities must appear further to the right in the index than the equalities. 

--What happens when a function is used in the WHERE clause? In that case, the index will not be used because the 
	--function will have to be applied to every row in the table. 

--What happens when a wildcard is used in the WHERE clause? In this case it depends on where the wildcard is located. 
	--If the first character of the search term is replaced with a wildcard, the index will not be used and a table 
	--scan will result.

-------------------------STATISTICS -------------------
--Creates query optimization statistics, including filtered statistics, on one or more columns of a table or indexed view. 
--Filtered statistics can improve query performance for queries that select from well-defined subsets of data. 
--Filtered statistics use a filter predicate in the WHERE clause to select the subset of data that is included 
	--in the statistics. 

--The following table gives maximum numbers for categories relating to statistics.
	--Columns per statistics object --> 32
	--Statistics created --> 1 per index and 1000 per table
	--Statistics created on columns --> 30,000 per table

--To optimize the update process, SQL Server uses an efficient algorithm to decide when to execute the update statistics 
--procedure, based on factors such as the number of modifications and the size of the table:
	--1.When a table with no rows gets a row
	--2.When a table has fewer than 500 rows and is increased by 500 or more rows
	--3.When a table has more than 500 rows and is increased by 500 rows + 20 percent of the number of rows

CREATE STATISTICS st_City  ON MyAddress (City)
WITH SAMPLE 100 PERCENT;



















	