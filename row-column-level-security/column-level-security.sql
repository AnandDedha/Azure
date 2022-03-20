-- schema to contain user tables
CREATE SCHEMA sales2;
GO

-- Create a table
CREATE TABLE sales2.Membership
  (MemberID int IDENTITY,
   FirstName varchar(100) NULL,
   SIN char(9) NOT NULL,
   LastName varchar(100) NOT NULL,
   Phone varchar(12) NULL,
   Email varchar(100) NULL);
   
 -- inserting sample data
INSERT INTO sales2.Membership VALUES   ('Man','999999999' ,'Kab', '555.123.4567', 'mank@test.com')
INSERT INTO sales2.Membership VALUES   ('Alk', '888888888' ,'Bd', '666.123.4567', 'alk@test.com')
INSERT INTO sales2.Membership VALUES   ('zar', '222222222','Kh', '777.123.4567', 'zar@test.com')
INSERT INTO sales2.Membership VALUES   ('San','333333333' ,'Dp', '888.123.4567', 'sank@test.com')

 -- Create a test user
 CREATE USER TestUser WITHOUT LOGIN; 
 
 -- Allow TestUser to access all columns except for the SSN column, which has the sensitive data
 GRANT SELECT ON Membership(MemberID, FirstName, LastName, Phone, Email) TO TestUser;
 
-- impersonate for testing:
EXECUTE AS USER = 'TestUser';   
SELECT * FROM sales2.Membership;

