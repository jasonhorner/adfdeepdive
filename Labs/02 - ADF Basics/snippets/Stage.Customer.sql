
CREATE TABLE [Stage].[Customer](
	[CustomerID] [int] NOT NULL,
	[NameStyle] [bit] NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Suffix] [nvarchar](10) NULL,
	[CompanyName] [nvarchar](128) NULL,
	[SalesPerson] [nvarchar](256) NULL,
	[EmailAddress] [nvarchar](50) NULL,
	[Phone] [nvarchar](25) NULL,
	[AddressType] [nvarchar](50) NULL,
	[AddressID] [int] NULL,
	[AddressLine1] [nvarchar](60) NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NULL,
	[StateProvince] [nvarchar](50) NULL,
	[CountryRegion] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](15) NULL
) 
GO

