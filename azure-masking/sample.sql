-- schema to contain user tables
CREATE SCHEMA Data;
GO

-- table with masked columns
CREATE TABLE Data.Membership(
    FirstName        varchar(100) MASKED WITH (FUNCTION = 'partial(1, "xxxxx", 1)') NULL,
    LastName        varchar(100) NOT NULL,
    Phone            varchar(12) MASKED WITH (FUNCTION = 'default()') NULL,
    Email            varchar(100) MASKED WITH (FUNCTION = 'email()') NOT NULL,
    DiscountCode    smallint MASKED WITH (FUNCTION = 'random(1, 100)') NULL
    );

-- inserting sample data
INSERT INTO Data.Membership 
VALUES   
('Man', 'Kab', '555.123.4567', 'mank@test.com', 10)




CREATE USER MaskingTestUser WITHOUT LOGIN;  

GRANT SELECT ON SCHEMA::Data TO MaskingTestUser;  
  
  -- impersonate for testing:
EXECUTE AS USER = 'MaskingTestUser';  

SELECT * FROM Data.Membership;  

REVERT;
