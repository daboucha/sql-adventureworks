-- use AdventureWorksLT2008R2 database
USE [AdventureWorksLT2008R2]
GO

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