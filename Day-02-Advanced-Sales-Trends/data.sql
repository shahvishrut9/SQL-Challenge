-- Step 1: Create the database (if not already created)
CREATE DATABASE IF NOT EXISTS SalesDB;
USE SalesDB;

-- Step 2: Drop existing Sales table (if it exists)
DROP TABLE IF EXISTS Sales;

-- Step 3: Create the Sales table
CREATE TABLE Sales (
    Sale_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Purchase_Date DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);

-- Step 4: Insert Sample Data (Monthly Sales Trends)
INSERT INTO Sales (Customer_ID, Purchase_Date, Amount) VALUES
-- January Sales
(101, '2024-01-05', 500.00),
(102, '2024-01-12', 420.00),
(103, '2024-01-18', 600.00),
(104, '2024-01-22', 350.00),
(105, '2024-01-30', 250.00),

-- February Sales
(101, '2024-02-03', 750.00),
(102, '2024-02-10', 510.00),
(103, '2024-02-15', 720.00),
(104, '2024-02-21', 410.00),
(105, '2024-02-27', 320.00),

-- March Sales
(101, '2024-03-08', 900.00),
(102, '2024-03-13', 680.00),
(103, '2024-03-19', 890.00),
(104, '2024-03-25', 550.00),
(105, '2024-03-31', 430.00),

-- April Sales
(101, '2024-04-06', 1100.00),
(102, '2024-04-14', 770.00),
(103, '2024-04-20', 970.00),
(104, '2024-04-26', 620.00),
(105, '2024-04-29', 500.00),

-- May Sales
(101, '2024-05-02', 1200.00),
(102, '2024-05-09', 850.00),
(103, '2024-05-17', 1050.00),
(104, '2024-05-22', 700.00),
(105, '2024-05-28', 620.00),

-- June Sales
(101, '2024-06-04', 1350.00),
(102, '2024-06-12', 930.00),
(103, '2024-06-19', 1150.00),
(104, '2024-06-25', 780.00),
(105, '2024-06-30', 690.00),

-- July Sales
(101, '2024-07-07', 1450.00),
(102, '2024-07-15', 1000.00),
(103, '2024-07-21', 1250.00),
(104, '2024-07-26', 840.00),
(105, '2024-07-30', 750.00);

-- Step 5: Verify Data Insertion
SELECT * FROM Sales;
