🛒 Day 3: Advanced Market Basket Analysis Using SQL & Python
🚀 Overview
💡 How do businesses analyze customer purchasing patterns and recommend products?
Today, we explore Market Basket Analysis (MBA) using SQL and Python. This technique helps e-commerce, retail, and finance industries understand which products are frequently bought together and optimize recommendation systems, cross-selling, and inventory management.

🔹 Key Objectives
✅ Use SQL Window Functions & CTEs to analyze transaction patterns
✅ Implement Apriori Algorithm in SQL for Association Rule Mining
✅ Extract Support, Confidence, and Lift metrics
✅ Build Customer Segmentation & Product Affinity Groups
✅ Visualize the results using Network Graphs & Heatmaps in Python

## **📜 SQL Query for Market Basket Analysis & Association Rule Mining**
```sql
WITH TransactionPairs AS (
    -- Step 1: Create Pairs of Items Purchased Together
    SELECT 
        A.Transaction_ID,
        A.Customer_ID,
        A.Product_ID AS Product_A,
        B.Product_ID AS Product_B
    FROM Sales A
    JOIN Sales B ON A.Transaction_ID = B.Transaction_ID
    WHERE A.Product_ID < B.Product_ID
),
PairFrequency AS (
    -- Step 2: Count Frequency of Each Product Pair
    SELECT 
        Product_A, 
        Product_B, 
        COUNT(*) AS Pair_Count
    FROM TransactionPairs
    GROUP BY Product_A, Product_B
),
ProductSupport AS (
    -- Step 3: Compute Individual Product Frequency
    SELECT 
        Product_ID, 
        COUNT(*) AS Product_Count
    FROM Sales
    GROUP BY Product_ID
),
AssociationRules AS (
    -- Step 4: Calculate Association Rule Metrics (Support, Confidence, Lift)
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
    FROM PairFrequency p
    JOIN ProductSupport ps1 ON p.Product_A = ps1.Product_ID
    JOIN ProductSupport ps2 ON p.Product_B = ps2.Product_ID
)
-- Step 5: Retrieve Association Rules With Strongest Lift
SELECT * FROM AssociationRules WHERE Lift > 1 ORDER BY Lift DESC;
