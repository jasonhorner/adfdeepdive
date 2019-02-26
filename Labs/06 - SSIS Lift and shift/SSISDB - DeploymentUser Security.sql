
CREATE USER [DeploymentUser] FOR LOGIN [DeploymentUser];

GRANT CONTROL ON DATABASE::[SSISDB] to [DeploymentUser];

EXEC sp_addrolemember 'ssis_admin', 'DeploymentUser';