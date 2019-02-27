-- This query enables the source database for change Tracking

ALTER DATABASE AdventureWorksLT  
SET CHANGE_TRACKING = ON  
(CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON);

-- Snapshot isolation is recomended to simplify the process of getting changed data
ALTER DATABASE AdventureWorksLT  
    SET ALLOW_SNAPSHOT_ISOLATION ON;  

-- Each table must have changed tracking enabled
ALTER TABLE [SalesLT].[Customer]
ENABLE CHANGE_TRACKING  
WITH (TRACK_COLUMNS_UPDATED = ON) ; 

-- Users must have VIEW CHANGE TRACKING RIGHTS or better
GRANT VIEW CHANGE TRACKING ON Schema::SalesLT TO [Reader];


-- Initial Load Query
SELECT NameStyle, Title, FirstName, MiddleName, LastName, Suffix, CompanyName, SalesPerson, EmailAddress, Phone, PasswordHash, PasswordSalt, rowguid, ModifiedDate , c.CustomerID
, c.SYS_CHANGE_VERSION
, c.SYS_CHANGE_VERSION as SYS_CHANGE_CREATION_VERSION
, 'I' AS SYS_CHANGE_OPERATION
, c.SYS_CHANGE_CONTEXT 
FROM [SalesLT].[Customer] AS s 
CROSS APPLY CHANGETABLE (VERSION [SalesLT].[Customer], (CustomerID), (s.CustomerID)) AS c;

-- Incremental Load Query
SELECT NameStyle, Title, FirstName, MiddleName, LastName, Suffix, CompanyName, SalesPerson, EmailAddress, Phone, PasswordHash, PasswordSalt, rowguid, ModifiedDate, c.CustomerID
 ,c.SYS_CHANGE_VERSION  
 ,c.SYS_CHANGE_CREATION_VERSION
 ,c.SYS_CHANGE_OPERATION 
 ,c.SYS_CHANGE_CONTEXT 
-- HighWaterMarkId (LAST CHANGE VERSION from CTL Table)
FROM CHANGETABLE(CHANGES [SalesLT].[Customer], 1) c 
LEFT OUTER JOIN [SalesLT].[Customer] s ON s.CustomerID = c.CustomerID 
WHERE (SELECT MAX(v) FROM (VALUES(c.SYS_CHANGE_VERSION), (c.SYS_CHANGE_CREATION_VERSION)) AS VALUE(v)) <= 10; -- CHANGE_TRACKING_CURRENT_VERSION 
