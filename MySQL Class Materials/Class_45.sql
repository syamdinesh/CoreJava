-----Column Level Encryption------

CREATE TABLE [UserDetails]
(  
[FirstName] [varchar](50) NOT NULL,  
[LastName] [varchar](50) ,  
[LoginID] [varchar](20) NOT NULL,  
[UserPassword] [varchar] (80)  
)  
GO  

INSERT INTO [UserDetails]  VALUES('Rajesh', 'Pillai', 'rapi', 'password-1')  
INSERT INTO [UserDetails]  VALUES('John', 'Bhaskar', 'johnny', 'john-123')  
INSERT INTO [UserDetails]  VALUES('Jack', 'Daniel', 'pwdJD', 'pwd-17')  
INSERT INTO [UserDetails]  VALUES('Anuraj', 'KS', 'AKS', 'aksPWD')  
INSERT INTO [UserDetails]  VALUES('Jinesh', 'Raj', 'Jinu', 'passJIN')  
INSERT INTO [UserDetails]  VALUES('Mathew', 'John', 'mat', 'Mathewz')  

SELECT * FROM [UserDetails]  

--Set up the Master Key
CREATE MASTER KEY ENCRYPTION BY  
PASSWORD = 'Password-1'  
GO  

--Create the Certificate and Symmetric key
CREATE CERTIFICATE SelfSignedCertificate  WITH SUBJECT = 'Password Encryption';  
GO  

CREATE SYMMETRIC KEY SQLSymmetricKey  
	WITH ALGORITHM = AES_128  
ENCRYPTION BY CERTIFICATE SelfSignedCertificate;  
GO  

--Add column to hold the encrypted data
ALTER TABLE UserDetails  ADD EncryptedPassword varbinary(MAX) NULL  
GO  

--Encrypt column data

OPEN SYMMETRIC KEY SQLSymmetricKey  
DECRYPTION BY CERTIFICATE SelfSignedCertificate;  


UPDATE UserDetails  
SET [EncryptedPassword] = EncryptByKey(Key_GUID('SQLSymmetricKey'), UserPassword);  
GO  

INSERT INTO [UserDetails]  
VALUES('Mathew', 'John', 'mat', 'Mathewz',EncryptByKey(Key_GUID('SQLSymmetricKey'), 'Mathewz')) 

SELECT * FROM [UserDetails]

--De-Encrypt table data
SELECT FirstName, LastName,LoginID,UserPassword,EncryptedPassword,  
	CONVERT(varchar, DecryptByKey(EncryptedPassword)) AS 'DecryptedPassword'  
FROM UserDetails; 

CLOSE SYMMETRIC KEY SQLSymmetricKey;  
GO  

------------------------------------------------------
select *
into tbl_SalesHeader
from sales.SalesOrderHeader

select *
into tbl_SalesDetail
from sales.SalesOrderDetail

select *
from tbl_SalesHeader h
inner join tbl_SalesDetail d on d.SalesOrderID = h.SalesOrderID
where d.ProductID = 777

-------------------Migration and Upgrade of SQL Server ------------------------
--1.In Place Upgrade
--2.Side by side upgrade

--https://www.microsoft.com/en-us/download/details.aspx?id=53595
