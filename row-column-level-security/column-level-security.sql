-- Create a table
CREATE TABLE Membership
  (MemberID int IDENTITY,
   FirstName varchar(100) NULL,
   SSN char(9) NOT NULL,
   LastName varchar(100) NOT NULL,
   Phone varchar(12) NULL,
   Email varchar(100) NULL);
   
 -- Insert data 
 
 -- Allow TestUser to access all columns except for the SSN column, which has the sensitive data
 GRANT SELECT ON Membership(MemberID, FirstName, LastName, Phone, Email) TO TestUser;
 
 -- 
  SELECT * FROM Membership;

