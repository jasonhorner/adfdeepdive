CREATE USER [ADF_Access] FROM EXTERNAL PROVIDER

-- Azure SQL Reader Account
CREATE LOGIN AnalysisServiceUser WITH PASSWORD = 'ADFD3m0!';

-- Azure SQL Loader Account
CREATE LOGIN DataLoadUser WITH PASSWORD = 'ADFD3m0!';

-- Azure SQL Deployment Account
CREATE LOGIN DeploymentUser WITH PASSWORD = 'ADFD3m0!';