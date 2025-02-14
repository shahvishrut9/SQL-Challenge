# 📌 Day 2: Advanced Sales Trends Analysis with SQL & Python  

## 🚀 Challenge Overview  
💡 **Today's challenge focuses on analyzing monthly sales trends using advanced SQL techniques.**  

We will explore:  
✅ **Window Functions** (`LAG()`, `AVG() OVER()`, `DENSE_RANK()`) for trend analysis  
✅ **Month-over-Month (MoM) Growth Calculation**  
✅ **3-Month Moving Average for trend smoothing**  
✅ **Ranking peak sales months using `DENSE_RANK()`**  
✅ **Running Total Calculation using `SUM() OVER()`**  

---

## 📜 **SQL Query for Analysis**
```sql
WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(Purchase_Date, '%Y-%m') AS Sales_Month,
        SUM(Amount) AS Total_Sales,
        LAG(SUM(Amount)) OVER (ORDER BY DATE_FORMAT(Purchase_Date, '%Y-%m')) AS Previous_Month_Sales,
        ROUND(AVG(SUM(Amount)) OVER (ORDER BY DATE_FORMAT(Purchase_Date, '%Y-%m') ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS Moving_Avg_3,
        DENSE_RANK() OVER (ORDER BY SUM(Amount) DESC) AS Sales_Rank
    FROM Sales
    GROUP BY Sales_Month
)
SELECT 
    Sales_Month,
    Total_Sales,
    Previous_Month_Sales,
    ROUND(((Total_Sales - Previous_Month_Sales) / Previous_Month_Sales) * 100, 2) AS MoM_Growth_Percentage,
    Moving_Avg_3,
    Sales_Rank,
    SUM(Total_Sales) OVER (ORDER BY Sales_Month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Total
FROM MonthlySales
ORDER BY Sales_Month;
