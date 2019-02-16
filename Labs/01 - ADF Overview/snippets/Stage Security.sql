
CREATE USER [ADF_Access] FROM EXTERNAL PROVIDER

CREATE USER DataLoadUser FOR LOGIN DataLoadUser;
CREATE USER AnalysisServiceUser FOR LOGIN AnalysisServiceUser;
CREATE USER DeploymentUser FOR LOGIN DeploymentUser;

GRANT CONTROL ON DATABASE::[Stage] to DeploymentUser;


CREATE ROLE Executor; 
GRANT EXECUTE TO [Executor]

CREATE ROLE Reader;

EXEC sp_addrolemember 'Executor', 'Reader';
GRANT SELECT TO [Reader];

CREATE ROLE Writer;

EXEC sp_addrolemember 'Reader', 'Writer';
GRANT INSERT TO [Writer]
GRANT UPDATE TO [Writer]
GRANT DELETE TO [Writer]
GRANT CREATE TABLE TO [Writer] --CTAS
GRANT ALTER ANY SCHEMA TO [Writer] -- Rename
GRANT ALTER ANY DATASPACE To [Writer] -- partition


--
EXEC sp_addrolemember 'Writer', 'DataLoadUser';

EXEC sp_addrolemember 'Reader', 'AnalysisServiceUser';
