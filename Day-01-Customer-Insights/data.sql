-- Step 1: Create the database (if not already created)
CREATE DATABASE IF NOT EXISTS SalesDB;
USE SalesDB;

-- Step 2: Drop existing Sales table (if it exists) to avoid duplicate errors
DROP TABLE IF EXISTS Sales;

-- Step 3: Create the Sales table
CREATE TABLE Sales (
    Sale_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Purchase_Date DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);

-- Step 4: Insert Sample Data (Customer Purchases)
INSERT INTO Sales (Customer_ID, Purchase_Date, Amount) VALUES
(101, '2024-01-01', 200.00),
(101, '2024-01-05', 350.00),
(101, '2024-01-10', 500.00),
(101, '2024-01-15', 420.00),
(101, '2024-01-20', 275.00),

(102, '2024-01-02', 150.00),
(102, '2024-01-07', 300.00),
(102, '2024-01-12', 450.00),
(102, '2024-01-17', 380.00),
(102, '2024-01-22', 260.00),

(103, '2024-01-03', 400.00),
(103, '2024-01-08', 600.00),
(103, '2024-01-13', 550.00),
(103, '2024-01-18', 350.00),
(103, '2024-01-23', 500.00),

(104, '2024-01-04', 180.00),
(104, '2024-01-09', 320.00),
(104, '2024-01-14', 290.00),
(104, '2024-01-19', 470.00),
(104, '2024-01-24', 150.00),

(105, '2024-01-06', 210.00),
(105, '2024-01-11', 390.00),
(105, '2024-01-16', 490.00),
(105, '2024-01-21', 250.00),
(105, '2024-01-26', 520.00);

-- Step 5: Verify Data Insertion
SELECT * FROM Sales;
