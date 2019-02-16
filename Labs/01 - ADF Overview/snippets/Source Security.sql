USE MASTER
GO

-- Azure ADF Loader Account
CREATE LOGIN DataLoadUser WITH PASSWORD = 'DataFactoryD3m0!';
GO

USE AdventureWorksLT2017
GO

CREATE USER DataLoadUser FOR LOGIN DataLoadUser;

-- Create Security

CREATE ROLE Executor; 
GRANT EXECUTE TO [Executor]

CREATE ROLE Reader;

EXEC sp_addrolemember 'Executor', 'Reader';
GRANT SELECT TO [Reader];

GRANT VIEW CHANGE TRACKING ON Schema::SalesLT TO [Reader];
