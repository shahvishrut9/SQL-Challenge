# 📌 Day 1: Customer Insights Using SQL Window Functions  

## 🚀 Challenge Overview  
💡 **Today's SQL challenge** focuses on analyzing **customer purchase behavior** using **SQL Window Functions**.  
We will:  
✅ Track **previous & next purchases** using `LAG()` & `LEAD()`  
✅ Rank transactions using `DENSE_RANK()`  
✅ Segment customers into **spending tiers** with `NTILE(4)`  
✅ Calculate **Customer Lifetime Value (CLV)**  
✅ Detect **churn risk** based on days since last purchase  

---

## 📜 **SQL Query for Analysis**  
```sql
SELECT 
    Sale_ID, 
    Customer_ID, 
    Purchase_Date, 
    Amount,

    -- Previous and Next Purchase Tracking
    LAG(Amount) OVER (PARTITION BY Customer_ID ORDER BY Purchase_Date) AS Prev_Purchase,
    LEAD(Amount) OVER (PARTITION BY Customer_ID ORDER BY Purchase_Date) AS Next_Purchase,

    -- Ranking Customer Purchases
    DENSE_RANK() OVER (PARTITION BY Customer_ID ORDER BY Amount DESC) AS Purchase_Rank,

    -- Customer Segmentation Based on Spending
    NTILE(4) OVER (ORDER BY Amount DESC) AS Customer_Tier,

    -- Running Total (Cumulative Sales)
    SUM(Amount) OVER (PARTITION BY Customer_ID ORDER BY Purchase_Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Total,

    -- Moving Average for Trend Detection
    AVG(Amount) OVER (PARTITION BY Customer_ID ORDER BY Purchase_Date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Moving_Avg_3,

    -- Percentage of Total Spend per Customer
    Amount * 100.0 / SUM(Amount) OVER (PARTITION BY Customer_ID) AS Percent_Total_Spend,

    -- Days Since Last Purchase (Churn Risk Detection)
    DATEDIFF(Purchase_Date, LAG(Purchase_Date) OVER (PARTITION BY Customer_ID ORDER BY Purchase_Date)) AS Days_Since_Last_Purchase,

    -- Customer Lifetime Value (CLV)
    SUM(Amount) OVER (PARTITION BY Customer_ID) AS Customer_Lifetime_Value

FROM Sales
ORDER BY Customer_ID, Purchase_Date;
