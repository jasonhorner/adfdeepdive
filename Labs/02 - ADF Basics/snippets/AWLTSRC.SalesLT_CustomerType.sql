/****** Object:  UserDefinedTableType [AWLTSRC].[SalesLT_CustomerType]    Script Date: 2/17/2019 11:42:37 AM ******/
CREATE TYPE [AWLTSRC].[SalesLT_CustomerType] AS TABLE(
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
	[PasswordHash] [varchar](128) NULL,
	[PasswordSalt] [varchar](10) NULL,
	[rowguid] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO


