-- Step 1: Create the Database
USE challenge;

-- Step 2: Drop Existing Tables (If They Exist)
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Products;

-- Step 3: Create the Products Table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(255),
    Category VARCHAR(100)
);

-- Step 4: Insert Sample Products
INSERT INTO Products (Product_ID, Product_Name, Category) VALUES
(5001, 'Laptop', 'Electronics'),
(5002, 'Mouse', 'Electronics'),
(5003, 'Keyboard', 'Electronics'),
(5004, 'Monitor', 'Electronics'),
(5005, 'Desk Chair', 'Furniture'),
(5006, 'Office Desk', 'Furniture'),
(5007, 'USB Cable', 'Accessories'),
(5008, 'Headphones', 'Accessories'),
(5009, 'Smartphone', 'Electronics'),
(5010, 'Tablet', 'Electronics');

-- Step 5: Create the Sales Transactions Table
CREATE TABLE Sales (
    Transaction_ID INT,
    Customer_ID INT,
    Product_ID INT,
    Purchase_Date DATE,
    PRIMARY KEY (Transaction_ID, Product_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Step 6: Insert Sample Transactions
INSERT INTO Sales (Transaction_ID, Customer_ID, Product_ID, Purchase_Date) VALUES
-- Transactions for Customer 101
(1, 101, 5001, '2024-01-05'),
(1, 101, 5002, '2024-01-05'),
(1, 101, 5007, '2024-01-05'),

-- Transactions for Customer 102
(2, 102, 5003, '2024-01-12'),
(2, 102, 5001, '2024-01-12'),

-- Transactions for Customer 103
(3, 103, 5004, '2024-02-02'),
(3, 103, 5002, '2024-02-02'),

-- Transactions for Customer 104
(4, 104, 5005, '2024-02-10'),
(4, 104, 5006, '2024-02-10'),

-- Transactions for Customer 105
(5, 105, 5008, '2024-03-15'),
(5, 105, 5009, '2024-03-15'),

-- Additional Purchases from Customers 101 and 102
(6, 101, 5001, '2024-04-05'),
(6, 101, 5003, '2024-04-05'),
(7, 102, 5002, '2024-04-15'),
(7, 102, 5009, '2024-04-15'),

-- Transactions for Customer 106
(8, 106, 5004, '2024-05-20'),
(8, 106, 5005, '2024-05-20'),
(8, 106, 5006, '2024-05-20'),

-- Transactions for Customer 107
(9, 107, 5007, '2024-06-10'),
(9, 107, 5008, '2024-06-10'),

-- Transactions for Customer 108
(10, 108, 5009, '2024-07-02'),
(10, 108, 5010, '2024-07-02');

-- Step 7: Verify Data
SELECT * FROM Sales;

-- Step 1: Drop Table If Exists
DROP TABLE IF EXISTS AssociationRules;

-- Step 2: Create Association Rules Table
CREATE TABLE AssociationRules (
    Product_A INT,
    Product_B INT,
    Pair_Count INT,
    Product_A_Count INT,
    Product_B_Count INT,
    Support DECIMAL(5,2),
    Confidence_A_to_B DECIMAL(5,2),
    Confidence_B_to_A DECIMAL(5,2),
    Lift DECIMAL(5,2),
    PRIMARY KEY (Product_A, Product_B)
);

-- Step 3: Populate Association Rules Table
INSERT INTO AssociationRules
SELECT 
    p.Product_A, 
    p.Product_B,
    p.Pair_Count,
    ps1.Product_Count AS Product_A_Count,
    ps2.Product_Count AS Product_B_Count,
    ROUND((p.Pair_Count / (SELECT COUNT(DISTINCT Transaction_ID) FROM Sales)) * 100, 2) AS Support,
    ROUND((p.Pair_Count / ps1.Product_Count) * 100, 2) AS Confidence_A_to_B,
    ROUND((p.Pair_Count / ps2.Product_Count) * 100, 2) AS Confidence_B_to_A,
    ROUND((p.Pair_Count / (ps1.Product_Count * ps2.Product_Count)) * (SELECT COUNT(DISTINCT Transaction_ID) FROM Sales), 2) AS Lift
FROM (
    -- Create Pairs of Items Purchased Together
    SELECT 
        A.Product_ID AS Product_A,
        B.Product_ID AS Product_B,
        COUNT(*) AS Pair_Count
    FROM Sales A
    JOIN Sales B ON A.Transaction_ID = B.Transaction_ID
    WHERE A.Product_ID < B.Product_ID
    GROUP BY Product_A, Product_B
) p
JOIN (
    -- Compute Individual Product Frequency
    SELECT 
        Product_ID, 
        COUNT(*) AS Product_Count
    FROM Sales
    GROUP BY Product_ID
) ps1 ON p.Product_A = ps1.Product_ID
JOIN (
    -- Compute Individual Product Frequency Again
    SELECT 
        Product_ID, 
        COUNT(*) AS Product_Count
    FROM Sales
    GROUP BY Product_ID
) ps2 ON p.Product_B = ps2.Product_ID;

-- Step 4: Query the Association Rules Table
SELECT * FROM AssociationRules WHERE Lift > 1 ORDER BY Lift DESC;
