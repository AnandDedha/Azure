-- Create a Scheman & Table
CREATE SCHEMA Sales
GO
CREATE TABLE Sales.Region
    (  
    id int,  
    SalesRepName nvarchar(50),  
    Regionnvarchar(50),  
    CustomerName nvarchar(50)  
    );


-- Insert data 
INSERT INTO Sales.Region VALUES (1, 'Mann', 'Central Canada', 'C1');
INSERT INTO Sales.Region VALUES (2, 'Anna', 'East Canada', 'E1');
INSERT INTO Sales.Region VALUES (3, 'Anna', 'East Canada', 'E2');
INSERT INTO Sales.Region VALUES (4, 'Abhi', 'West Canada', 'W1');
INSERT INTO Sales.Region VALUES (5, 'Kukku', 'Northern Region', 'ABC1');
INSERT INTO Sales.Region VALUES (6, 'Anna', 'East Canada', 'E3');
INSERT INTO Sales.Region VALUES (7, 'Mann', 'Central Canada', 'C2');
INSERT INTO Sales.Region VALUES (8, 'Abhi', 'West Canada', 'ABC2');
INSERT INTO Sales.Region VALUES (9, 'Kukku', 'Northern Region', 'PNW2');
INSERT INTO Sales.Region VALUES (10, 'Abhi', 'West Canada', 'XYZ3');
INSERT INTO Sales.Region VALUES (11, 'Kukku', 'Northern Region', 'UP3');
INSERT INTO Sales.Region VALUES (12, 'Mann', 'Central Canada', 'C3');


-- View the rows in the table  
SELECT * FROM Sales.Region
ORDER BY id;


-- Create Users
CREATE USER SalesManager WITHOUT LOGIN;  
CREATE USER Mann WITHOUT LOGIN;  
CREATE USER Anna WITHOUT LOGIN;
CREATE USER Abhi WITHOUT LOGIN;  
CREATE USER Kukku WITHOUT LOGIN;



-- Grant Read Access to the Users
GRANT SELECT ON Sales.Region TO SalesManager;  
GRANT SELECT ON Sales.Region TO Mann;  
GRANT SELECT ON Sales.Region TO Anna; 
GRANT SELECT ON Sales.Region TO Abhi;  
GRANT SELECT ON Sales.Region TO Kukku;



--Create Schema for Security Predicate Function
CREATE SCHEMA spf;  
  

-- Create Security Filter Predicate Function 
-- The function returns 1 when a row in the SalesRepName column is the same as the user executing the query (@SalesRepName = USER_NAME()) or if the user executing the query is the Manager user (USER_NAME() = 'Manager').
CREATE FUNCTION spf.itvf_securitypredicate(@SalesRepName AS nvarchar(50))  
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  
    RETURN SELECT 1 AS tvf_securitypredicate_result
WHERE @SalesRepName = USER_NAME() OR USER_NAME() = 'SalesManager';  



--Bind Security Policy to Filter Predicate
CREATE SECURITY POLICY MySalesFilterPolicy  
ADD FILTER PREDICATE spf.itvf_securitypredicate(SalesRepName)
ON Sales.Region
WITH (STATE = ON);  

--test our security predicate function SELECT permissions
GRANT SELECT ON spf.itvf_securitypredicate TO SalesManager;  
GRANT SELECT ON spf.itvf_securitypredicate TO Mann;  
GRANT SELECT ON spf.itvf_securitypredicate TO Anna;
GRANT SELECT ON spf.itvf_securitypredicate TO Abhi;  
GRANT SELECT ON spf.itvf_securitypredicate TO Kukku;


EXECUTE AS USER = 'Mann';  
SELECT * FROM Sales.Region
ORDER BY id;
REVERT;  
  
EXECUTE AS USER = 'Anna';  
SELECT * FROM Sales.Region
ORDER BY id;
REVERT;  
  
EXECUTE AS USER = 'Abhi';  
SELECT * FROM Sales.Region
ORDER BY id;
REVERT;

EXECUTE AS USER = 'Kukku';  
SELECT * FROM Sales.Region
ORDER BY id;
REVERT;

EXECUTE AS USER = 'SalesManager';  
SELECT * FROM Sales.Region
ORDER BY id;
REVERT;


-- You can disable RLS by Altering the Security Policy 
ALTER SECURITY POLICY MySalesFilterPolicy  
WITH (STATE = OFF);



--Clean Up
DROP USER SalesManager;
DROP USER Mann;
DROP USER Anna;
DROP USER Abhi;
DROP USER Kukku;


DROP SECURITY POLICY MySalesFilterPolicy;
DROP TABLE Sales.Region;
DROP FUNCTION spf.itvf_securitypredicate;
DROP SCHEMA spf;
DROP SCHEMA Sales;
