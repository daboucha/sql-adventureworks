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
When does it makes sense to use the IN operator?

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

/* Write a query using the Production.ProductReview table. Use CONTAINS to find all the rows that have the word reflector in any column
that is indexed with Full-Text Search.  Display the Title and FileName columns */
SELECT Title, FileName
FROM Production.Document
WHERE CONTAINS(*, 'reflector');

/* Write a query using the Production.ProductReview table. Use CONTAINS to find all the rows that have the word reflector, and not the word seat
in any column that is indexed with Full-Text Search.  Display the Title and FileName columns */
SELECT Title, FileName
FROM Production.Document
WHERE CONTAINS(*, 'reflector AND NOT seat');

/* Answer this question: 
When searching a VARBINARY(MAX) column that contains Word documents, a LIKE search can be used, but the performance will be worse. True or false?

1) False, you cannot use LIKE with VARBINARY(MAX) columns. You would use Full-Text searching to search VARBINARY(MAX) columns */

-- ************************************ Sorting Data ************************************

-- Write a query that returns the business entity ID and name columns from the Person.Person table. Sort the results by LastName, FirstName, and MiddleName
SELECT BusinessEntityID, FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY LastName, FirstName, MiddleName;

-- Change the query so that it is in the opposite order
SELECT BusinessEntityID, FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY LastName DESC, FirstName DESC, MiddleName DESC;

-- ************************************ Thinking About Performance ************************************ --1
SELECT LastName
FROM Person.Person
WHERE LastName = 'Smith';
--2
SELECT LastName
FROM Person.Person
WHERE LastName LIKE 'Sm%';
--3
SELECT LastName
FROM Person.Person
WHERE LastName LIKE '%mith';
--4
SELECT ModifiedDate
FROM Person.Person
WHERE ModifiedDate BETWEEN '2000-01-01' and '2000-01-31'; -- ************************************ Writing Expressions Using Operators ************************************ -- Write a query that displays in the �AddressLine1 (City PostalCode)� format from the Person.Address tableSELECT AddressLine1 + ' (' + City + ' ' + PostalCode + ')' AS AddressFROM Person.Address/* Write a query using the Production.Product table displaying the product ID, color, and name columns. If the color column contains a NULL value, replace the color with No Color */SELECT ProductID, Name, ISNULL(Color, 'No Color') AS ColorFROM Production.Product;/* Modify the query so that the description of the product is displayed in the �Name: Color� format.Make sure that all rows display a value even if the Color value is missing */SELECT ProductID, (Name + ISNULL(': ' + Color, '')) AS DescriptionFROM Production.Product;-- Write a query using the Production.Product table displaying a description with the �ProductID: Name� formatSELECT CAST(ProductID AS varchar) + ': ' + Name AS DescriptionFROM Production.Product;/* Answer this question: 
What is the difference between the ISNULL and COALESCE functions?

1) You can use ISNULL to replace a NULL value or column with another value or column
2) You can use COALESCE to return the first non-NULL value from a list of values or columns */

-- ************************************ Using Mathematical Operators ************************************ 

/* Write a query using the Sales.SpecialOffer table. 
Display the difference between the MinQty and MaxQty columns along with the SpecialOfferID and Description columns */
SELECT SpecialOfferID, Description, (MaxQty - MinQty) AS MinMaxQtyDifference
FROM Sales.SpecialOffer;

/* Write a query using the Sales.SpecialOffer table. 
Multiply the MinQty column by the DiscountPct column. Include the SpecialOfferID and Description columns in the results */
SELECT SpecialOfferID, Description, (MinQty*DiscountPct) AS MinDiscount
FROM Sales.SpecialOffer;

/* Write a query using the Sales.SpecialOffer table that multiplies the MaxQty column by the DiscountPCT column. 
If the MaxQty value is null, replace it with the value 10. Include the SpecialOfferID and Description columns in the results */
SELECT SpecialOfferID, Description, (ISNULL(MaxQty, 10)*DiscountPct) AS MaxDiscount
FROM Sales.SpecialOffer;

/* Answer this question: 
What is the difference between division and modulo?

1) When performing division, you divide two numbers, and the result, the quotient, is the answer
2) When you are using modulo, you divide two numbers, but the reminder is the answer. If the numbers are evenly divisible, the answer will be zero */

-- ************************************ Using String Functions ************************************ 

-- Write a query that displays the first 10 characters of the AddressLine1 column in the Person.Address table
SELECT LEFT(AddressLine1, 10) AS PartialAddress
FROM Person.Address;

-- Write a query that displays characters 10 to 15 of the AddressLine1 column in the Person.Address table
SELECT SUBSTRING(AddressLine1, 10, 6) AS PartialAddress
FROM Person.Address;

-- Write a query displaying the first name and last name from the Person.Person table all in uppercase
SELECT UPPER(FirstName) AS FirstName, UPPER(LastName) AS LastName
FROM Person.Person;

/* The product number in the Production.Product contains a hyphen (-). Write a query that uses the SUBSTRING function and the CHARINDEX function
to display the characters in the product number following the hyphen */
SELECT ProductNumber, SUBSTRING(ProductNumber, CHARINDEX('-', ProductNumber)+1, LEN(ProductNumber)-CHARINDEX('-', ProductNumber)) AS AfterHyphen
FROM Production.Product;

-- ************************************ Using Date Functions ************************************ 

/* Write a query that calculates the number of days between the date an order was placed and the date that it was shipped using the Sales.SalesOrderHeader table. 
Include the SalesOrderID, OrderDate, and ShipDate columns */
SELECT SalesOrderID, OrderDate, ShipDate, DATEDIFF(DAY, OrderDate, ShipDate) AS NumDays
FROM Sales.SalesOrderHeader;

-- Write a query that displays only the date, not the time, for the order date and ship date in the Sales.SalesOrderHeader table
SELECT CONVERT(VARCHAR, OrderDate, 101) AS OrderDate, CONVERT(VARCHAR, ShipDate, 101) AS ShipDate
FROM Sales.SalesOrderHeader;

-- Write a query that adds six months to each order date in the Sales.SalesOrderHeader table. Include the SalesOrderID and OrderDate columns
SELECT OrderDate, DATEADD(MONTH, 6, OrderDate) AS PlusSixMonths
FROM Sales.SalesOrderHeader;

/* Write a query that displays the year of each order date and the numeric month of each order date in separate columns in the results. 
Include the SalesOrderID and OrderDate columns */
SELECT SalesOrderID, OrderDate, DATEPART(YEAR, OrderDate) AS Year, DATEPART(MONTH, OrderDate) AS Month
FROM Sales.SalesOrderHeader;

-- Change the query to display the month name instead
SELECT SalesOrderID, OrderDate, DATEPART(YEAR, OrderDate) AS Year, DATENAME(MONTH, OrderDate) AS Month
FROM Sales.SalesOrderHeader;

-- ************************************ Using Mathematical Functions ************************************ 

-- Write a query using the Sales.SalesOrderHeader table that displays the SubTotal rounded to two decimal places. Include the SalesOrderID column in the results
SELECT SalesOrderID, ROUND(SubTotal, 2) AS SubTotal
FROM Sales.SalesOrderHeader;

-- Modify the query so that the SubTotal is rounded to the nearest dollar but still displays two zeros to the right of the decimal place
SELECT SalesOrderID, ROUND(SubTotal,0) AS SubTotal
FROM Sales.SalesOrderHeader;

-- Write a query that calculates the square root of the SalesOrderID value from the Sales.SalesOrderHeader table
SELECT SQRT(SalesOrderID) AS RootOrderID
FROM Sales.SalesOrderHeader;

-- Write a statement that generates a random number between 1 and 10 each time it is run
SELECT CAST(RAND()*10 AS INT)+1;

-- ************************************ Using System Functions ************************************ 

/* Write a query using the HumanResources.Employee table to display the BusinessEntityID column. 
Also include a CASE statement that displays �Even� when the BusinessEntityID value is an even number or �Odd� when it is odd */
SELECT BusinessEntityID,
CASE
	WHEN BusinessEntityID%2 = 0 THEN 'Even'
	ELSE 'Odd'
END AS OddEven
FROM HumanResources.Employee;

/* Write a query using the Sales.SalesOrderDetail table to display a value (�Under 10� or �10�19� or �20�29� or �30�39� or �40 and over�)
based on the OrderQty value by using the CASE function. Include the SalesOrderID and OrderQty columns in the results */
SELECT SalesOrderID, OrderQty,
CASE
	WHEN OrderQty < 10 THEN 'Under 10'
	WHEN OrderQty < 20 THEN '10-19'
	WHEN OrderQty < 30 THEN '20-29'
	WHEN OrderQty < 40 THEN '30-39'
	ELSE '40 and over'
End AS OrderRange
FROM Sales.SalesOrderDetail;

/* Using the Person.Person table, build the full names using Title, FirstName, MiddleName, LastName, and Suffix columns.
Check the table definition to see which columns allow NULL values, and use the COALESCE function on the appropriate columns */
SELECT COALESCE(Title+' ', '') + FirstName + ' ' + COALESCE(MiddleName+' ', '') + LastName + COALESCE(', '+Suffix, '') AS FullName
FROM Person.Person;

-- Look up the SERVERPROPERTY function in Books Online. Write a statement that displays the edition, instance name, and machine name using this function
SELECT SERVERPROPERTY('Edition'), SERVERPROPERTY('InstanceName'), SERVERPROPERTY('MachineName');

-- ************************************ Using Functions in the WHERE and ORDER BY Clauses ************************************

/* Write a query using the Sales.SalesOrderHeader table to display the orders placed during 2001 by using a function.
Include the SalesOrderID and OrderDate columns in the results */
SELECT SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2001;

/* Write a query using the Sales.SalesOrderHeader table listing the sales in order of the month the order was placed and then the year the order was placed.
Include the SalesOrderID and OrderDate columns in the results */
SELECT SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader
ORDER BY MONTH(OrderDate), YEAR(OrderDate);

/* Write a query that displays the PersonType and the name columns from the Person.Person table.
Sort the results so that rows with a PersonType of IN, SP, or SC sort by LastName. The other rows should sort by FirstName */
SELECT PersonType, FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY 
CASE
	WHEN PersonType IN ('IN', 'SP', 'SC') THEN LastName
	ELSE FirstName
END;

-- ************************************ Thinking About Performance ************************************ --1
SELECT Name
FROM Production.Product
WHERE Name LIKE 'B%';
--2
SELECT Name
FROM Production.Product
WHERE CHARINDEX('B',Name) = 1;
--3
SELECT LastName
FROM Person.Person
WHERE LastName LIKE '%i%';
--4
SELECT LastName
FROM Person.Person
WHERE CHARINDEX('i',LastName) > 0; 

-- ************************************ Querying Multiple Tables  ************************************ 
-- *************************************** Writing Inner Joins ***************************************

/* The HumanResources.Employee table does not contain the employee names. Join that table to the Person.Person table on the BusinessEntityID column.
Display the job title, birth date, first name, and last name */
SELECT E.JobTitle, E.BirthDate, P.FirstName, P.LastName
FROM HumanResources.Employee AS E
INNER JOIN Person.Person AS P ON E.BusinessEntityID = P.BusinessEntityID;

/* The customer names also appear in the Person.Person table. Join the Sales.Customer table to the Person.Person table. 
The BusinessEntityID column in the Person.Person table matches the PersonID column in the Sales.Customer table. 
Display the CustomerID, StoreID, and TerritoryID columns along with the name columns */
SELECT C.CustomerID, C.StoreID, C.TerritoryID, P.FirstName, P.MiddleName, P.LastName
FROM Sales.Customer AS C
INNER JOIN Person.Person AS P ON C.PersonID = P.BusinessEntityID;

/* Extend the query to include the Sales.SalesOrderHeader table. Display the SalesOrderID column along with the columns already specified. 
The Sales.SalesOrderHeader table joins the Sales.Customer table on CustomerID */
SELECT C.CustomerID, C.StoreID, C.TerritoryID, P.FirstName, P.MiddleName, P.LastName, S.SalesOrderID
FROM Sales.Customer AS C
INNER JOIN Person.Person AS P ON C.PersonID = P.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader AS S ON S.CustomerID = C.CustomerID;

/* Write a query that joins the Sales.SalesOrderHeader table to the Sales.SalesPerson table.
Join the BusinessEntityID column from the Sales.SalesPerson table to the SalesPersonID column in the Sales.SalesOrderHeader table.
Display the SalesOrderID along with the SalesQuota and Bonus */
SELECT SOH.SalesOrderID, SP.SalesQuota, SP.Bonus
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesPerson AS SP ON SP.BusinessEntityID = SOH.SalesPersonID;

-- Add the name columns to the query by joining on the Person.Person table. Figure out which columns will be used to write the join
SELECT SOH.SalesOrderID, SP.SalesQuota, SP.Bonus, P.FirstName, P.MiddleName, P.LastName
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesPerson AS SP ON SP.BusinessEntityID = SOH.SalesPersonID
INNER JOIN Person.Person AS P ON P.BusinessEntityID = SP.BusinessEntityID;

/* The catalog description for each product is stored in the Production.ProductModel table.
Display the columns that describe the product from the Production.Product table, such as the color and size along with the catalog description for each product */
SELECT PM.CatalogDescription, P.Color, P.Size
FROM Production.ProductModel AS PM
INNER JOIN Production.Product AS P ON P.ProductModelID = PM.ProductModelID;

-- Write a query that displays the names of the customers along with the product names that they have purchased. 
SELECT P.FirstName, P.MiddleName, P.LastName, Pr.Name
FROM Person.Person AS P
INNER JOIN Production.Product AS Pr ON

SELECT *
FROM Production.Product

Hint: Five tables will be required to write this query

