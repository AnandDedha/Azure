create table watermarktable
(

TableName varchar(255),
WatermarkValue datetime,
);

INSERT INTO watermarktable
VALUES ('data_source_table','1/1/2010 12:00:00 AM')

Select * from watermarktable;


CREATE PROCEDURE usp_write_watermark @LastModifiedtime datetime, @TableName varchar(50)
AS

BEGIN

UPDATE watermarktable
SET [WatermarkValue] = @LastModifiedtime
WHERE [TableName] = @TableName

END
