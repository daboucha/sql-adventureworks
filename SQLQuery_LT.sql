-- use AdventureWorksLT2008R2 database
USE [AdventureWorksLT2008R2]
GO

-- ************************************ Writing Simple SELECT Queries ************************************

-- lists the customers along with their ID numbers. Include the last names, first names, and company names
SELECT CustomerID, FirstName, LastName, CompanyName
FROM SalesLT.Customer;

-- lists the name, product number, and color of each product
SELECT Name, ProductNumber, Color
FROM SalesLT.Product;

-- lists the customer ID numbers and sales order ID numbers from the SalesLT.SalesOrderHeader table
SELECT CustomerID, SalesOrderID
FROM SalesLT.SalesOrderHeader;

/* Answer this question: 
Why should you specify column names rather than an asterisk when writing the SELECT list?

1) Unless you require all columns to be displayed, specifying column names will keep your report clean and concise.
2) Specifying column names will also keep processing times low and efficient in comparison to loading columns that are not required */

-- **************************************** Manipulating Data ***************************************
-- *************************************** Inserting New Rows ***************************************

USE AdventureWorksLT2008R2;
GO
IF EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[demoProduct]')
	AND type IN (N'U'))
DROP TABLE [dbo].[demoProduct]
GO
CREATE TABLE [dbo].[demoProduct](
	[ProductID] [INT] NOT NULL PRIMARY KEY,
	[Name] [dbo].[Name] NOT NULL,
	[Color] [NVARCHAR](15) NULL,
	[StandardCost] [MONEY] NOT NULL,
	[ListPrice] [MONEY] NOT NULL,
	[Size] [NVARCHAR](5) NULL,
	[Weight] [DECIMAL](8, 2) NULL,);
IF EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[demoSalesOrderHeader]')
	AND type in (N'U'))
DROP TABLE [dbo].[demoSalesOrderHeader]
GO
CREATE TABLE [dbo].[demoSalesOrderHeader](
	[SalesOrderID] [INT] NOT NULL PRIMARY KEY,
	[SalesID] [INT] NOT NULL IDENTITY,
	[OrderDate] [DATETIME] NOT NULL,
	[CustomerID] [INT] NOT NULL,
	[SubTotal] [MONEY] NOT NULL,
	[TaxAmt] [MONEY] NOT NULL,
	[Freight] [MONEY] NOT NULL,
	[DateEntered] [DATETIME],
	[TotalDue] AS (ISNULL(([SubTotal]+[TaxAmt])+[Freight],(0))),
	[RV] ROWVERSION NOT NULL);
GO
ALTER TABLE [dbo].[demoSalesOrderHeader] ADD CONSTRAINT
[DF_demoSalesOrderHeader_DateEntered]
DEFAULT (GETDATE()) FOR [DateEntered];
GO
IF EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[demoAddress]')
	AND type in (N'U'))
DROP TABLE [dbo].[demoAddress]
GO
CREATE TABLE [dbo].[demoAddress](
	[AddressID] [INT] NOT NULL IDENTITY PRIMARY KEY,
	[AddressLine1] [NVARCHAR](60) NOT NULL,
	[AddressLine2] [NVARCHAR](60) NULL,
	[City] [NVARCHAR](30) NOT NULL,
	[StateProvince] [dbo].[Name] NOT NULL,
	[CountryRegion] [dbo].[Name] NOT NULL,
	[PostalCode] [NVARCHAR](15) NOT NULL);

/* Write a SELECT statement to retrieve data from the SalesLT.Product table. Use these values to insert seven rows into the dbo.demoProduct
table using literal values. Write five individual INSERT statements */
SELECT Productid, Name, Color, StandardCost, ListPrice, Size, Weight
FROM SalesLT.Product;

INSERT INTO dbo.demoProduct (Productid, Name, Color, StandardCost, ListPrice, Size, Weight)
VALUES (680, 'HL Road Frame - Black, 58', 'Black', 1059.31, 1431.50, '58', 1016.04);

INSERT INTO dbo.demoProduct(ProductID, Name, Color, StandardCost, ListPrice, Size, Weight)
VALUES (706,'HL Road Frame - Red, 58','Red',1059.31, 1431.50,'58',1016.04);

INSERT INTO dbo.demoProduct(ProductID, Name, Color, StandardCost, ListPrice, Size, Weight)
VALUES (707,'Sport-100 Helmet, Red','Red',13.0863,34.99,NULL,NULL);

INSERT INTO dbo.demoProduct(ProductID, Name, Color, StandardCost, ListPrice, Size, Weight)
VALUES (708,'Sport-100 Helmet, Black','Black',13.0863,34.99,NULL,NULL);

INSERT INTO dbo.demoProduct(ProductID, Name, Color, StandardCost, ListPrice, Size, Weight)
VALUES (709,'Mountain Bike Socks, M','White',3.3963,9.50,'M',NULL); 

SELECT ProductID, Name, Color, StandardCost, ListPrice, Size, Weight
FROM dbo.demoProduct;

-- Insert five more rows into the dbo.demoProduct table. This time write one INSERT statement
INSERT INTO dbo.demoProduct(ProductID, Name, Color, StandardCost, ListPrice, Size, Weight)
VALUES (711,'Sport-100 Helmet, Blue','Blue', 13.0863,34.99,NULL,NULL),
	(712,'AWC Logo Cap','Multi',6.9223, 8.99,NULL,NULL),
	(713,'Long-Sleeve Logo Jersey,S','Multi', 38.4923,49.99,'S',NULL),
	(714,'Long-Sleeve Logo Jersey,M','Multi', 38.4923,49.99,'M',NULL),
	(715,'Long-Sleeve Logo Jersey,L','Multi', 38.4923,49.99,'L',NULL); 
	
SELECT ProductID, Name, Color, StandardCost, ListPrice, Size, Weight
FROM dbo.demoProduct;

-- Write an INSERT statement that inserts all the rows into the dbo.demoSalesOrderHeader table from the SalesLT.SalesOrderHeader table
INSERT INTO dbo.demoSalesOrderHeader (SalesOrderID, OrderDate, CustomerID, SubTotal, TaxAmt, Freight)
SELECT SalesOrderID, OrderDate, CustomerID, SubTotal, TaxAmt, Freight
FROM SalesLT.SalesOrderHeader;

/* Write a SELECT INTO statement that creates a table, dbo.tempCustomerSales, showing every CustomerID from the SalesLT.Customer
along with a count of the orders placed and the total amount due for each customer */
SELECT C.CustomerID, COUNT(ISNULL(SOH.SalesOrderID, 0)) AS NumOrders, SUM(SOH.TotalDue) AS TotalDue
INTO dbo.tempCustomerSales
FROM SalesLT.Customer AS C
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS SOH ON C.CustomerID = SOH.CustomerID
GROUP BY C.CustomerID;

/* Write an INSERT statement that inserts all the products into the dbo.demoProduct table from the SalesLT.Product table that have not
already been inserted. Do not specify literal ProductID values in the statement */
INSERT INTO dbo.demoProduct (ProductID, Name, Color, StandardCost, ListPrice, Size, Weight)
SELECT ProductID, Name, Color, StandardCost, ListPrice, Size, Weight
FROM SalesLT.Product
WHERE ProductID NOT IN (
	SELECT ProductID FROM dbo.demoProduct);

/* Write an INSERT statement that inserts all the addresses into the dbo.demoAddress table from the SalesLT.Address table.
Before running the INSERT statement, type and run the command so that you can insert values into the AddressID column */
INSERT INTO dbo.demoAddress (AddressID, AddressLine1, AddressLine2, City, StateProvince, CountryRegion, PostalCode)
SELECT AddressID, AddressLine1, AddressLine2, City, StateProvince, CountryRegion, PostalCode
FROM SalesLT.Address;

--to turn the setting off
SET IDENTITY_INSERT dbo.demoAddress OFF;
