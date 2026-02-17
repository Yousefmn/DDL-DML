-- 1. Create Employees table
CREATE TABLE Employees (
    ID INT IDENTITY(1,1) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Salary DECIMAL(10,2),
    CONSTRAINT PK_Employees PRIMARY KEY (ID)
);

-- 2. Add Department column
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 3. Drop Salary column
ALTER TABLE Employees
DROP COLUMN Salary;

-- 4. Rename Department to DeptName
EXEC sp_rename 'Employees.Department', 'DeptName', 'COLUMN';

------------------------------------------------------------

-- 5. Create Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100)
);

-- 6. Create Foreign Key
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Projects
FOREIGN KEY (ID) REFERENCES Projects(ProjectID);

-- 7. Remove Foreign Key
ALTER TABLE Employees
DROP CONSTRAINT FK_Employees_Projects;

-- 8. Add Unique constraint on Name
ALTER TABLE Employees
ADD CONSTRAINT UQ_Employees_Name UNIQUE (Name);

------------------------------------------------------------

-- 9. Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(150),
    Status VARCHAR(50)
);

-- 10. Unique constraint on FirstName + LastName
ALTER TABLE Customers
ADD CONSTRAINT UQ_Customers_Name UNIQUE (FirstName, LastName);

-- 11. Default value for Status
ALTER TABLE Customers
ADD CONSTRAINT DF_Customers_Status
DEFAULT 'Active' FOR Status;

------------------------------------------------------------

-- 12. Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2)
);

-- 13. Add Check constraint
ALTER TABLE Orders
ADD CONSTRAINT CHK_Orders_TotalAmount
CHECK (TotalAmount > 0);

------------------------------------------------------------

-- 14. Create Schema (must be alone in batch)
GO
CREATE SCHEMA Sales;
GO

-- 15. Move Orders table to Sales schema
ALTER SCHEMA Sales
TRANSFER dbo.Orders;

-- 16. Rename Orders to SalesOrders
EXEC sp_rename 'Sales.Orders', 'SalesOrders';
