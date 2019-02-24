
-- Testing Scripts
TRUNCATE TABLE [AWLTSRC].[SalesLT_Customer];

-- check for updates, replace with your Datetime
SELECT * FROM  [AWLTSRC].[SalesLT_Customer]
Where Createdatetime = '2019-02-24 19:33:23.783'
AND UpdateDateTime != Createdatetime

-- check for Inserts, replace with your Datetime
SELECT * FROM  [AWLTSRC].[SalesLT_Customer]
Where Createdatetime != '2019-02-24 19:33:23.783'

