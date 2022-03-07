-- use AdventureWorks2008R2 database
USE [AdventureWorks2008R2]
GO

-- ************************************ Filtering Data ************************************

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

-- displays all the employees listed in the HumanResources.Employee table who do not have the job title Research and Development Engineer
SELECT BusinessEntityID, LoginID, JobTitle
FROM HumanResources.Employee
WHERE JobTitle <> 'Research and Development Engineer';

/* displays all the rows from the Person.Person table where the rows were modified after December 29, 2000. 
Display the business entity ID number, the name columns, and the modified date */
SELECT BusinessEntityID, FirstName, MiddleName, LastName, ModifiedDate
FROM Person.Person
WHERE ModifiedDate > '2000-12-29';

-- displays all the rows from the Person.Person table where the rows were not modified on December 29, 2000
SELECT BusinessEntityID, FirstName, MiddleName, LastName, ModifiedDate
FROM Person.Person
WHERE ModifiedDate <> '2000-12-29';

-- displays all the rows from the Person.Person table where the rows were modified during December 2000
SELECT BusinessEntityID, FirstName, MiddleName, LastName, ModifiedDate
FROM Person.Person
WHERE ModifiedDate BETWEEN '2000-12-01' AND '2000-12-31';

-- displays all the rows from the Person.Person table where the rows were not modified during December 2000
SELECT BusinessEntityID, FirstName, MiddleName, LastName, ModifiedDate
FROM Person.Person
WHERE ModifiedDate NOT BETWEEN '2000-12-01' AND '2000-12-31';

/* Answer this question: 
Why should a WHERE clause be used in many of your T-SQL queries?

1) Unless you require all rows to be displayed, we should be using the WHERE clause in order to keep the report filtered to the information we are looking for.
2) Using the WHERE clause to limit the rows displayed will also keep processing times low and efficient in comparison to loading rows that are not required */

-- ************************************ Filtering with Wildcards ************************************

-- Write a query that displays the product ID and name for each product from the Production.Product table with the name starting with Chain
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'Chain%';

-- Write a query that displays the products with helmet in the name
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE '%helmet%';

-- Write a query that displays the products without helmet in the name
SELECT ProductID, Name
FROM Production.Product
WHERE Name NOT LIKE '%helmet%';

/* Write a query that displays the business entity ID number, first name, middle name, and last name from the Person.Person table
for only those rows that have E or B stored in the middle name column */
SELECT BusinessEntityID, FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName LIKE '[EB]';

/* Explain the difference between the following two queries:
SELECT FirstName
FROM Person.Person
WHERE LastName LIKE 'Ja%es';

SELECT FirstName
FROM Person.Person
WHERE LastName LIKE 'Ja_es';

1) The first query will return all LastNames beginning with Ja and ending in es with any number of characters in the middle including zero characters
2) The second query will return all LastNames beginning with Ja and ending in es with exactly one character between them */

-- ************************************ Filtering with Multiple Predicates ************************************

/* Write a query displaying the order ID, order date, and total due from the Sales.SalesOrderHeader table. 
Retrieve only those rows where the order was placed during the month of September 2001 and the total due exceeded $1,000 */
SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2001-09-01' AND '2001-09-30'
	AND TotalDue > 1000;

-- Write a query displaying the sales orders where the total due exceeds $1,000. Retrieve only those rows where the salesperson ID is 279 or the territory ID is 6
SELECT SalesOrderID, OrderDate, TotalDue, SalesPersonID, TerritoryID
FROM Sales.SalesOrderHeader
WHERE TotalDue > 1000
	AND (SalesPersonID = 279 OR TerritoryID = 6)

-- Write a query displaying the sales orders where the total due exceeds $1,000. Retrieve only those rows where the salesperson ID is 279 or the territory ID is 6 or 4
SELECT SalesOrderID, OrderDate, TotalDue, SalesPersonID, TerritoryID
FROM Sales.SalesOrderHeader
WHERE TotalDue > 1000
	AND (SalesPersonID = 279 OR TerritoryID IN (6,4));
	
/* Answer this question: 
When does it makes sense to use the IN operator:

1) You would likely want to use the IN operator when checking a column for multiple values */

-- ************************************ Working with Nothing ************************************

/* Write a query displaying the ProductID, Name, and Color columns from rows in the Production.Product table. 
Display only those rows where no color has been assigned */
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IS NULL;

/* Write a query displaying the ProductID, Name, and Color columns from rows in the Production.Product table. 
Display only those rows in which the color is not blue */
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IS NULL
	OR Color <> 'Blue';

/* Write a query displaying ProductID, Name, Style, Size, and Color from the Production.Product table. 
Include only those rows where at least one of the Style, Size, or Color columns contains a value */
SELECT ProductID, Name, Style, Size, Color
FROM Production.Product
WHERE NOT (Style IS NULL AND Size IS NULL AND Color IS NULL);

-- ************************************ Performing a Full-Text Search ************************************

/* Write a query using the Production.ProductReview table. Use CONTAINS to find all the rows that have the word socks in the Comments column. 
Return the ProductID and Comments columns */
SELECT ProductID, Comments
FROM Production.ProductReview
WHERE CONTAINS(Comments, 'socks');

SELECT FullTextServiceProperty('IsFullTextInstalled')