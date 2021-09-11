
## Step 1 CREATE EXTERNAL DATA SOURCE 
CREATE MASTER KEY ENCRYPTION BY PASSWORD ='Test@12345' 

# Please use access key in the secret
CREATE DATABASE SCOPED CREDENTIAL ADLS_credential
WITH IDENTITY='SHARED ACCESS SIGNATURE',  
SECRET = ' eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
GO


CREATE EXTERNAL DATA SOURCE FinanceDataSource WITH
(
	TYPE = HADOOP,
	LOCATION = 'abfss://users@datatechstorage.dfs.core.windows.net',
	CREDENTIAL = ADLS_credential 
)


## Step 2 CREATE EXTERNAL FILE FORMAT 
CREATE EXTERNAL FILE FORMAT FinanceFileFormat WITH
(
	FORMAT_TYPE = DELIMITEDTEXT,
	FORMAT_OPTIONS ( FIELD_TERMINATOR = ',' , First_Row = 2)
)


## Step 3 Create external Table

CREATE EXTERNAL TABLE [dbo].[Finance]
(
	 [Account Type] VARCHAR(200),
	 [Acount Number] VARCHAR(200),
	 [Transaction Date] VARCHAR(200),
	 [Cheque Number] VARCHAR(200),
	 [Transaction] VARCHAR(200),
	 [Description] VARCHAR(200),
	  [CAD$] VARCHAR(200)

)
WITH
(
	LOCATION = '/raw/Financial transaction.csv',
	DATA_SOURCE = FinanceDataSource,
	FILE_FORMAT = FinanceFileFormat
)
