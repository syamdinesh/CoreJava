--Start connection Number 1 using SSMS:
----------------------------------------
USE [AdventureWorks]
GO

--SET DEADLOCK_PRIORITY LOW 

BEGIN TRAN

--Update One: Run 1st
UPDATE sales.[SalesTaxRate]
SET taxrate = taxrate + 0.05
WHERE taxtype = 1;
--The above starts the first transaction, but leaves it open(do not commit transaction).


--------------------------------------------------------------------------------------------

--Step 3: In the first connection:
--------------------------------
--Update Two: Run 3rd
UPDATE sales.[SalesTerritory]
SET salesytd = salesytd + 1
WHERE territoryID = 1;

COMMIT TRAN

--Now, if you run the above code in the first connection (which completes the transaction), 
--the deadlock occurs. Immediately, then this code, in connection 1 completes, and the code 
--in connection 2 fails and returns a deadlock message.


