
-- Master DB:
CREATE LOGIN DWDataLoadUser WITH PASSWORD = 'adfdpD3m0!';

-- DW
CREATE USER DataLoadUser FOR LOGIN DataLoadUser;
CREATE USER DWDataLoadUser FOR LOGIN DWDataLoadUser;
CREATE USER AnalysisServiceUser FOR LOGIN AnalysisServiceUser;

CREATE USER [ADF_ACCESS] FROM EXTERNAL PROVIDER;

GRANT CONTROL ON DATABASE::[DW] to DWDataLoadUser; -- needed for polybase access
GRANT CONTROL ON DATABASE::[DW] to ADF_Access;

CREATE ROLE Executor; 
GRANT EXECUTE TO [Executor]

CREATE ROLE Reader;

EXEC sp_addrolemember 'Executor', 'Reader';
GRANT SELECT TO [Reader];

Create Role Writer;

EXEC sp_addrolemember 'Reader', 'Writer';
GRANT INSERT TO [Writer]
GRANT UPDATE TO [Writer]
GRANT DELETE TO [Writer]

GRANT CREATE TABLE TO [Writer] --CTAS
GRANT ALTER ANY SCHEMA TO [Writer] -- Rename
GRANT ALTER ANY DATASPACE To [Writer] -- partition

EXEC sp_addrolemember 'Reader', 'AnalysisServiceUser';
EXEC sp_addrolemember 'Writer', 'DataLoadUser';

-- DW Roles
-- Be careful to balance performance and concurrency needs dont overprovison
-- By Default server admin / SA will be mapped to smallrc

EXEC sp_addrolemember 'largerc', 'DWDataLoadUser';
EXEC sp_addrolemember 'mediumrc', 'DataLoadUser';
EXEC sp_addrolemember 'mediumrc', 'AnalysisServiceUser';