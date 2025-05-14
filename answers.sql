-- Assignment: Database Design and Normalization
-- Question 1: Achieving First Normal Form (1NF)
-- ------------------------------------------------------
-- In the original ProductDetail table, the "Products" column
-- contains multiple values, which violates 1NF.
-- In 1NF, each column must contain atomic (indivisible) values.
-- So we split the products into individual rows.

-- Create the ProductDetail table with normalized structure
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert one product per row to achieve 1NF
INSERT INTO ProductDetail (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- This structure is now in First Normal Form (1NF)

-- Question 2: Achieving Second Normal Form (2NF)
-- ------------------------------------------------------
-- In the original OrderDetails table, there is a partial dependency:
-- CustomerName depends only on OrderID (not on OrderID + Product).
-- To achieve 2NF, we must remove this partial dependency.

-- Create the Orders table to store customer information
-- Each OrderID maps to only one CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerName)
VALUES 
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Create the OrderItems table to store product details per order
-- The combination of OrderID and Product uniquely identifies each row
-- Quantity depends on both OrderID and Product → this is now in 2NF
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES 
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

