

USE [AdventureWorksLT]
GO

UPDATE [SalesLT].[Customer]
   SET 
      [CompanyName] = [CompanyName] + ':UPD'
  
 WHERE CustomerId < 10
GO


INSERT INTO [SalesLT].[Customer] 

SELECT [NameStyle], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [CompanyName], [SalesPerson], [EmailAddress], [Phone], [PasswordHash], [PasswordSalt], NEWID(), [ModifiedDate]
FROM [SalesLT].[Customer] 
WHERE CustomerId < 10
