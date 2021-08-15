## Steps for Batch Processing
    1. Create Azure Synpase workspace 
    2. Upload the data using MS Storage explorer
    3. create azure key vault cluster 
            Give Access to Databricks
            Give access to Azure Synapse analytics workspace
    4. Add Secrets 
        - ADLGS
        - username and password of dedicated sql pool
     
    5. Create databricks workspace
    6. create databricks cluster 
       - add valut info to databricks 
           #secrets/createScope 
            name - datatech
            Copy from properties 
            Vault URI
            Resource ID
            create a token to access synpase (store in Azure key vault)
            
       7. Check the firewall setting to execute notebook
       8. Pipeline 
           - create two integration datasets
              a. datalake storage with parameters
              b. customer table
           - Lookup with Query
           - Foreach with variables and output from lookup
           - 3 activities ( Two Set variables and copydata )
