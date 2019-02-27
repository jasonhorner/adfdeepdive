CREATE USER [DeploymentUser] FOR LOGIN [DeploymentUser];

EXEC sp_addrolemember 'dbmanager', 'DeploymentUser';

EXEC sp_addrolemember 'dbmanager', 'ADF_Access';