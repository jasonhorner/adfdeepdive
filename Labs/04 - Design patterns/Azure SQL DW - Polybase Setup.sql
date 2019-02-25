--reference: https://docs.microsoft.com/en-us/azure/sql-data-warehouse/sql-data-warehouse-load-from-azure-data-lake-store

-- Setup External File formats (Generic)
CREATE EXTERNAL FILE FORMAT TextFileFormat
WITH
(   FORMAT_TYPE = DELIMITEDTEXT
,    FORMAT_OPTIONS    (   FIELD_TERMINATOR = ','
                    ,    STRING_DELIMITER = ''
                    ,    DATE_FORMAT         = 'yyyy-MM-dd HH:mm:ss.fffffff'
                    ,    USE_TYPE_DEFAULT = FALSE
                    )
);

CREATE EXTERNAL FILE FORMAT TextFileFormatDefault
WITH
(   FORMAT_TYPE = DELIMITEDTEXT
,    FORMAT_OPTIONS    (   FIELD_TERMINATOR = ','
                    ,    STRING_DELIMITER = ''
                    ,    DATE_FORMAT         = 'yyyy-MM-dd HH:mm:ss.fffffff'
                    ,    USE_TYPE_DEFAULT = TRUE
                    )
);

CREATE EXTERNAL FILE FORMAT ORCFileFormat
WITH (  
    FORMAT_TYPE = ORC
);

CREATE EXTERNAL FILE FORMAT PARQUETFileFormat 
WITH (  
    FORMAT_TYPE = PARQUET 

);


-- Security Setup
CREATE MASTER KEY;

-- Needed for ADLSv2 Support
CREATE DATABASE SCOPED CREDENTIAL MSICredential WITH IDENTITY = 'Managed Service Identity';

-- ADLSv1 Support
CREATE DATABASE SCOPED CREDENTIAL ADLSCredential
WITH
    IDENTITY = '<ApplicationId>@https://login.microsoftonline.com/<Tenant ID>/oauth2/token',
    SECRET = '<KEY>'
;

-- WASB Support
CREATE DATABASE SCOPED CREDENTIAL WASBCredential
WITH
    IDENTITY = 'user',
    SECRET = '<KEY>'
;

DROP EXTERNAL DATA SOURCE WASBDataSource;

-- Enter your URL here:
CREATE EXTERNAL DATA SOURCE WASBDataSource
WITH 
(
    TYPE = HADOOP,
    LOCATION = 'wasbs://<Container>@<Storage Account Name>.blob.core.windows.net',
    CREDENTIAL = WASBCredential
);

/*
DROP External Data SOURCE ADLSDataSource

CREATE EXTERNAL DATA SOURCE [ADLSDataSource] WITH (TYPE = HADOOP, LOCATION = N'adl://adfdpadlsv1.azuredatalakestore.net/', CREDENTIAL = [ADLSCredential])
GO

DROP DATABASE SCOPED CREDENTIAL ADLSCredential

CREATE DATABASE SCOPED CREDENTIAL ADLSCredential
WITH
    IDENTITY = 'ac53b03f-e23d-4b11-94e5-012456012210@https://login.microsoftonline.com/c9f8d652-42d0-48b2-afe6-0ed4d77b08d4/oauth2/token',
    SECRET = 'qpHZAMkvimxUM0uaVfejpn/QA6zSqDMb+PHm+Nc48ec='
;

-- Service Princpal Id: ac53b03f-e23d-4b11-94e5-012456012210
-- Key: qpHZAMkvimxUM0uaVfejpn/QA6zSqDMb+PHm+Nc48ec=

*/

--DROP EXTERNAL DATA SOURCE ADLSDataSource;

-- Modify with your ADLS v1 URL
CREATE EXTERNAL DATA SOURCE ADLSDataSource
WITH (
    TYPE = HADOOP,
    LOCATION = 'adl://adfdpadlsv1.azuredatalakestore.net/',
    CREDENTIAL = ADLSCredential
);


-- ADLSv2
CREATE EXTERNAL DATA SOURCE ABFSDataSource
WITH (
   TYPE = hadoop, 
   LOCATION = 'abfss://<containerName>@<adlsv2 Name>.dfs.core.windows.net', 
   CREDENTIAL = MSICredential
);

