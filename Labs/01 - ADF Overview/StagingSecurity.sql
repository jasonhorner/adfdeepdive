CREATE USER [ADF_Access] FROM EXTERNAL PROVIDER;

CREATE USER AnalysisServiceUser FOR LOGIN AnalysisServiceUser;
CREATE USER DataLoadUser FOR LOGIN DataLoadUser;
CREATE USER DeploymentUser FOR LOGIN DeploymentUser;

GRANT CONTROL ON DATABASE::[Staging] to [DeploymentUser];

EXEC sp_addrolemember 'Reader', 'AnalysisServiceUser';
EXEC sp_addrolemember 'Writer', 'DataLoadUser';
EXEC sp_addrolemember 'Writer', 'ADF_Access';