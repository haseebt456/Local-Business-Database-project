CREATE DATABASE ChickenForEveryone;

USE ChickenForEveryone;

--Customer Table
CREATE TABLE Customer
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    ShopName VARCHAR(30),
    Address VARCHAR(100),
    Contact VARCHAR(20),
    FixedBalance INT,
    RunningBalance INT,
);
SELECT *
FROM Customer;
INSERT INTO Customer
VALUES
    (1, 'Jane Smith', 'Bacon Brothers', '1234 Oak Ln.', '617555-1235', 65004, 0);

--Supplier Table
CREATE TABLE Supplier
(
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(50),
    ShopName VARCHAR(30),
    Address VARCHAR(100),
    Contact VARCHAR(20),
    FixedBalance INT,
    RunningBalance INT,
);
SELECT *
FROM Supplier;
INSERT INTO Supplier
VALUES
    (1, 'Jane Smith', 'Bacon Brothers', '1234 Oak Ln.', '617555-1235', 65004, 0);

--Products Table
CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
);
SELECT *
FROM Products;
INSERT INTO Products
VALUES
    (1, 'Leg'),
    (2, 'Thai'),
    (3, 'Boneless');

--Inventory
CREATE TABLE Inventory
(
    ProductID INT,
    Quantity INT,
    Location VARCHAR(100),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
);
SELECT *
FROM Inventory;
INSERT INTO Inventory
VALUES
    (1, 10, 'Main');


--Govt Rate
CREATE TABLE Govt_Rate
(
	ProductID int,
    Date DATE,
    SupplyRate INT,
    ChickenRate FLOAT
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
);
SELECT *FROM Govt_Rate;
INSERT INTO Govt_Rate
VALUES
(
	1,
    '2023-12-05',
    312,
    470
)

--Customer Order
CREATE TABLE CUSTOMER_ORDER
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity Float,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
);
SELECT *FROM CUSTOMER_ORDER;
INSERT INTO CUSTOMER_ORDER
VALUES
    (1, 1, 1, 2.1);


--Customer Ratio
CREATE TABLE CUSTOMER_RATIOS
(
    CustomerID INT,
    ProductID INT,
    Ratio FLOAT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
)
SELECT *
FROM CUSTOMER_RATIOS;
INSERT INTO CUSTOMER_RATIOS
VALUES
    (1, 1, 2.1);
Go
-- Create Customer_BILL view
CREATE VIEW Customer_BILL AS
SELECT
    co.OrderID,
    co.CustomerID,
    co.ProductID,
    co.Quantity,
    gr.SupplyRate,
    cr.Ratio,
    gr.SupplyRate * co.Quantity * cr.Ratio AS Bill
FROM
    CUSTOMER_ORDER co
JOIN Products p ON co.ProductID = p.ProductID
JOIN Govt_Rate gr ON p.ProductID = gr.ProductID
JOIN CUSTOMER_RATIOS cr ON co.CustomerID = cr.CustomerID AND co.ProductID = cr.ProductID;

Go
-- Update Running Balance
UPDATE Customer
SET RunningBalance = RunningBalance + Bill
FROM Customer_BILL
WHERE Customer.CustomerID = Customer_BILL.CustomerID;
Select *from Customer
Go
-- Create Customer_BILL view

CREATE TABLE Recipt (
    OrderID INT,
    CustomerID INT,
    Amount INT,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (OrderID) REFERENCES CUSTOMER_ORDER(OrderID)
)
INSERT INTO Recipt
VALUES
    (1, 1, 100, 'Cash');
SELECT *FROM Recipt;

--Supplier ORder
CREATE TABLE SUPPLIER_ORDER (
	SupplierOrderID INT PRIMARY KEY,
    SupplierID INT,
    ProductID INT,
    Quantity Float,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
)
SELECT *FROM SUPPLIER_ORDER
INSERT INTO SUPPLIER_ORDER
VALUES
    (1, 1, 1, 12.3);

--Supplier Ratio
CREATE TABLE SUPPLIER_RATIOS
(
    SupplierID INT,
    ProductID INT,
    Ratio FLOAT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
)
SELECT *
FROM SUPPLIER_RATIOS;
INSERT INTO SUPPLIER_RATIOS
VALUES
    (1, 1, 2.3);