
CREATE PROCEDURE [Stage].[usp_Customer_Load]
 @BatchId BIGINT = -1
,@ETLControlId INT = -1
,@ETLAuditLogId BIGINT = NULL
,@SourceSystem VARCHAR(50) = NULL
,@SourceName VARCHAR(50) = NULL
,@SinkName VARCHAR(50) = NULL	
,@PipelineId VARCHAR(50) = NULL
,@PipelineName VARCHAR(50) = NULL
,@PipelineTriggerType VARCHAR(50) = NULL
AS
BEGIN
  
  SET NOCOUNT ON;

  DECLARE 
     @CurrentDateTime DATETIME2(3) = CURRENT_TIMESTAMP
	,@ProcedureName sysname = OBJECT_NAME(@@PROCID)
	,@ErrorMsg NVARCHAR(max)  
	,@ErrorSeverity INT  
	,@ErrorState INT;  
  
BEGIN TRY 

INSERT INTO [Stage].[Customer]
           ([CustomerID]
           ,[NameStyle]
           ,[Title]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[Suffix]
           ,[CompanyName]
           ,[SalesPerson]
           ,[EmailAddress]
           ,[Phone]
           ,[AddressType]
           ,[AddressID]
           ,[AddressLine1]
           ,[AddressLine2]
           ,[City]
           ,[StateProvince]
           ,[CountryRegion]
           ,[PostalCode]
		   )
SELECT
 c.[CustomerID]
,c.[NameStyle]
,c.[Title]
,c.[FirstName]
,c.[MiddleName]
,c.[LastName]
,c.[Suffix]
,c.[CompanyName]
,c.[SalesPerson]
,c.[EmailAddress]
,c.[Phone]
,ca.AddressType
,a.[AddressID]
,a.[AddressLine1]
,a.[AddressLine2]
,a.[City]
,a.[StateProvince]
,a.[CountryRegion]
,a.[PostalCode]
FROM [AWLTSRC].[SalesLT_Customer] c
LEFT OUTER JOIN [AWLTSRC].[SalesLT_CustomerAddress] ca ON (ca.CustomerId = c.customerId)
LEFT OUTER JOIN [AWLTSRC].[SalesLT_Address] a ON (a.AddressId = ca.AddressId)

  
END TRY

BEGIN CATCH
	
	SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();		 
	THROW;

END CATCH

END


