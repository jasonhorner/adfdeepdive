-- TRUNCATE Statement
TRUNCATE TABLE [AWLTSRC].[SalesLT_Customer]

-- Select Statement
SELECT CustomerID, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, CompanyName, SalesPerson, EmailAddress, Phone, PasswordHash, PasswordSalt, CAST(rowguid as nvarchar(50)) AS rowguid, ModifiedDate FROM SalesLt.Customer