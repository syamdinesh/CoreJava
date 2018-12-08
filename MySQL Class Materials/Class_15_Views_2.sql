select * 
from vw_SalesDetail
order by SalesOrderID
-------------
select * from vw_SalesOrderHeader 
delete from vw_SalesOrderHeader  where salesorderid = 43659
-------------
delete from vw_SalesOrderHeader  where salesorderid = 43660
select * from sales.SalesOrderHeader where salesorderid = 43660
select * from sales.SalesOrderDetail where salesorderid = 43660
-------------
update vw_SalesOrderHeader
set OnlineOrderFlag = 1
where SalesOrderID = 43661

select * from sales.SalesOrderHeader where salesorderid = 43661
-----------
select * from vw_SalesDetail

update vw_SalesDetail
set OnlineOrderFlag = 0, OrderQty = OrderQty + 1
where SalesOrderID = 43661

update vw_SalesDetail
set OnlineOrderFlag = 0, [status] = 4
where SalesOrderID = 43661

select * from sales.SalesOrderHeader where salesorderid = 43661
-----------









