## Lookup activity names
    1. LookupOldWatermarkvalue
    2. LookupNewWaterMarkTable
    
## NewWaterMarkTable query
    Select max(LastModifytime) as NewWatermarkvalue from data_source_table

## Copy activity source query
    select * from data_source_table where LastModifytime > '@{activity('LookupOldWaterMarkActivity').output.firstRow.WatermarkValue}' and LastModifytime <= '@{activity('LookupNewWaterMarkActivity').output.firstRow.NewWatermarkvalue}'
    
 ## Dynamc value in sink to have a separate file for each increment load
    @CONCAT('Incremental-', pipeline().RunId, '.txt')
    
 ## Import values into the stored procedure 
    @activity('NewWaterMarkTable').output.firstRow.NewWatermarkvalue
    @activity('OldWatermarkvalue').output.firstRow.TableName
