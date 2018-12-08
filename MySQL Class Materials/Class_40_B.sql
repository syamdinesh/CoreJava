--Start Connection 2 in SSMS:
----------------------------
USE [AdventureWorks]
GO
BEGIN TRAN


--Update: Run 2nd (both examples)
UPDATE sales.[SalesTerritory]
SET salesytd = salesytd + 1
WHERE territoryID = 1;

--Update
UPDATE sales.[SalesTaxRate]
SET taxrate = taxrate + 0.05
WHERE taxtype = 1;

COMMIT TRAN
--Run the above code in the second connection, and this code is now blocked and won't complete 
--due to the blocking lock created by the code running in the first connection.


