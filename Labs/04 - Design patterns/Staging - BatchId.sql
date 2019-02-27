-- More Info: https://docs.microsoft.com/en-us/sql/t-sql/statements/create-sequence-transact-sql?view=sql-server-2017
CREATE SEQUENCE [ETL].[SEQ_ETLBATCHID] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO


SELECT NEXT VALUE FOR ETL.SEQ_ETLBATCHID AS BatchId;

-- Alternate approach: GUID's
SELECT NEWID() AS BatchId;

