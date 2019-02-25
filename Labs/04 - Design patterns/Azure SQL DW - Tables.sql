-- Best Practice: Create schema to hold external tables
CREATE SCHEMA [Ext]
GO

CREATE SCHEMA [AWLTSRC]
GO

CREATE SCHEMA [Stage]
GO

CREATE SCHEMA [Ref]
GO

CREATE SCHEMA [DW]
GO


DROP EXTERNAL TABLE [Ext].[SalesLT_SalesOrderHeader]
GO

CREATE EXTERNAL TABLE [Ext].[SalesLT_SalesOrderHeader]
(
	[SalesOrderID] [int] NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[OnlineOrderFlag] bit NOT NULL,
	[SalesOrderNumber] nvarchar(25) NOT NULL,
	[PurchaseOrderNumber] nvarchar(25) NULL,
	[AccountNumber] nvarchar(15) NULL,
	[CustomerID] [int] NOT NULL,
	[ShipToAddressID] [int] NULL,
	[BillToAddressID] [int] NULL,
	[ShipMethod] [nvarchar](50) NOT NULL,
	[CreditCardApprovalCode] [varchar](15) NULL,
	[SubTotal] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[TotalDue] [money] NOT NULL,
	[Comment] [nvarchar](4000) NULL,
	[rowguid] char(36) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
)
WITH (DATA_SOURCE = [ADLSDataSource],LOCATION = N'raw/AdventureWorksLT/SalesLT/SalesOrderHeader/',FILE_FORMAT = [PARQUETFileFormat],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO

DROP TABLE [AWLTSRC].[SalesLT_SalesOrderHeader]
GO

CREATE TABLE [AWLTSRC].[SalesLT_SalesOrderHeader]
(
	[SalesOrderID] [int] NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[OnlineOrderFlag] bit NOT NULL,
	[SalesOrderNumber] nvarchar(25) NOT NULL,
	[PurchaseOrderNumber] nvarchar(25) NULL,
	[AccountNumber] nvarchar(15) NULL,
	[CustomerID] [int] NOT NULL,
	[ShipToAddressID] [int] NULL,
	[BillToAddressID] [int] NULL,
	[ShipMethod] [nvarchar](50) NOT NULL,
	[CreditCardApprovalCode] [varchar](15) NULL,
	[SubTotal] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[TotalDue] [money] NOT NULL,
	[Comment] [nvarchar](4000) NULL,
	[rowguid] char(36) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
)
WITH (
   DISTRIBUTION = ROUND_ROBIN,  
   HEAP
)
GO

DROP EXTERNAL TABLE [Ext].[SalesLT_SalesOrderDetail]
GO

CREATE EXTERNAL TABLE [Ext].[SalesLT_SalesOrderDetail]
(
	[SalesOrderID] [int] NOT NULL,
	[SalesOrderDetailID] [int] NOT NULL,
	[OrderQty] [smallint] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[UnitPriceDiscount] [money] NOT NULL,
	[LineTotal] [money] NOT NULL,
	[rowguid] char(36) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
)
WITH (DATA_SOURCE = [ADLSDataSource],LOCATION = N'raw/AdventureWorksLT/SalesLT/SalesOrderDetail/',FILE_FORMAT = [PARQUETFileFormat],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO


DROP TABLE [AWLTSRC].[SalesLT_SalesOrderDetail]
GO

CREATE TABLE [AWLTSRC].[SalesLT_SalesOrderDetail]
(
    [SalesOrderID] [int] NOT NULL,
	[SalesOrderDetailID] [int] NOT NULL,
	[OrderQty] [smallint] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[UnitPriceDiscount] [money] NOT NULL,
	[LineTotal] [money] NOT NULL,
	[rowguid] char(36) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
)
WITH (
   DISTRIBUTION = ROUND_ROBIN,  
   HEAP
)
GO


SELECT * FROM [Ext].[SalesLT_SalesOrderDetail]

SELECT * FROM [Ext].[SalesLT_SalesOrderHeader]

ALTER PROCEDURE [Stage].[usp_SalesLT_SalesOrderHeader_Load] 
AS
BEGIN

 BEGIN TRY 	

	IF OBJECT_ID('AWLTSRC.SalesLT_OrderHeader') IS NOT NULL
	DROP TABLE AWLTSRC.SalesLT_SalesOrderHeader;

	CREATE TABLE AWLTSRC.SalesLT_SalesOrderHeader  
	WITH   
	(   
		DISTRIBUTION = ROUND_ROBIN,
		HEAP
	)
	AS 
		SELECT * 
		FROM [Ext].[SalesLT_SalesOrderHeader]
		OPTION (LABEL = 'CTAS : AWLTSRC.SalesLT_SalesOrderHeader');
		
END TRY	
BEGIN CATCH
  
  --SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();  
  THROW;
 END CATCH 

END
GO


--EXEC [Stage].[usp_SalesLT_SalesOrderHeader_Load] 	 


CREATE PROCEDURE [Stage].[usp_SalesLT_SalesOrderDetail_Load] 
AS
BEGIN

 BEGIN TRY 	

	IF OBJECT_ID('AWLTSRC.SalesLT_OrderDetail') IS NOT NULL
	DROP TABLE AWLTSRC.SalesLT_SalesOrderDetail;

	CREATE TABLE AWLTSRC.SalesLT_SalesOrderDetail  
	WITH   
	(   
		DISTRIBUTION = ROUND_ROBIN,
		HEAP
	)
	AS 
		SELECT * 
		FROM [Ext].[SalesLT_SalesOrderDetail]
		OPTION (LABEL = 'CTAS : AWLTSRC.SalesLT_SalesOrderDetail');
		
END TRY	
BEGIN CATCH
  
  --SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();  
  THROW;
 END CATCH 

END
GO


--EXEC [Stage].[usp_SalesLT_SalesOrderDetail_Load] 