-- use AdventureWorks2008R2 database
USE [AdventureWorks2008R2]
GO

/* displays all the employees listed in the HumanResources.Employee table who have the job title Research and Development Engineer.
Display the business entity ID number, the login ID, and the title for each one */
SELECT BusinessEntityID, LoginID, JobTitle
FROM HumanResources.Employee
WHERE JobTitle = 'Research and Development Engineer';

-- displays all the names in Person.Person with the middle name J. Display the first, last, and middle names along with the ID numbers
SELECT FirstName, MiddleName, LastName, BusinessEntityID
FROM Person.Person
WHERE MiddleName = 'J';

-- displaying all the columns of the Production.ProductCostHistory table from the rows that were modified on June 17, 2003
SELECT *
FROM Production.ProductCostHistory
WHERE ModifiedDate = '2003-06-17';