## Steps for Batch Processing
    1. Create Azure Synpase workspace 
       create dedicated sql pool 
    2. Upload the data using MS Storage explorer
    3. Create a blob storage and container in it
    3. create azure key vault cluster 
            Give Access to Databricks
            Give access to Azure Synapse analytics workspace
    4. Add Secrets 
        - ADLGS (azure-datalake-access)
        - username and password of dedicated sql pool  (azure-sql-pwd & azure-sql-username)
     
    5. Create databricks workspace - datatechdb
    6. create databricks cluster 
       - add valut info to databricks 
           #secrets/createScope 
            name - datatech
            Copy from properties 
            Vault URI
            Resource ID
            create a token to access synpase (store in Azure key vault)  - databricks-access-synapse            
       7. Create customer table in edw
       8. Pipeline 
           - create link services
           - create two integration datasets
              a. datalake storage with parameters ( Container, Dir_name, File_name)
              b. customer table from Azure synapse dedciated SQL pool
           - Lookup with Query
           - Foreach with variables and output from lookup value (@activity('Get_date_list').output.value)
           - Set pipeline variables ( DATA_DIR - data/customer/2021/01
                                      FILE_NAME - customers_2021-01-01
                                     )
           - 3 activities in foreach ( Two Set variables and copydata )
             - Set_DIR_NAME 
                - Set varaibles DATA_DIR - @item().DATA_DIR
             - Set_FILE_NAME
                - Set varaibles FILE_NAME - @item().FILE_NAME
             - Copy activity
                - source datalake integrration dataset
                 - please set 
                     directory - @variables('DATA_DIR') (dynamic)
                     file_name - @variables('FILE_NAME') (dynamic)
                     preview the data 
                     
