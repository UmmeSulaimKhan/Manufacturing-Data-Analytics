create database Manufacturing;
Use Manufacturing;
SELECT * FROM fact_Production LIMIT 10;
show tables;

### --------- KPI ----------

-- Total Manufactured Quantity (M)
SELECT 
ROUND(SUM(Produced_Qty)/1000000,2) AS Manufacture_M
FROM fact_production;

-- Processed Quantity (M)
SELECT ROUND(SUM(Processed_Qty) / 1000000, 2) 
    AS Processed_Qty_M FROM fact_Production; 
    
-- Rejected Quantity (K)
SELECT ROUND(SUM(Rejected_Qty)/1000,1) AS Rejected_K
FROM fact_production;

-- Wastage Quantity (K)
SELECT ROUND((SUM(Produced_Qty)-SUM(Processed_Qty))/1000,1) 
AS Wastage_K FROM fact_production;

-- Rejected Rate
SELECT ROUND(SUM(Rejected_Qty) / SUM(Processed_Qty) * 100, 2) 
    AS Rejection_Rate_Pct FROM Fact_Production;
    
### <<<<>>>>>> CHART <<<>>>>>

-- Employee wise Rejected Quantity
SELECT Employee_Code,SUM(Rejected_Qty) AS Total_Rejected_Quantity
FROM fact_Production GROUP BY Employee_Code
ORDER BY Total_Rejected_Quantity DESC;

-- Machine wise Rejected Quantity
SELECT Machine_Code,ROUND(SUM(Rejected_Qty)/1000,2) AS Rejected_K
FROM fact_production GROUP BY Machine_Code
ORDER BY Rejected_K DESC limit 5;

-- Production Comparison Trend
SELECT MONTHNAME(STR_TO_DATE(Date_FK, '%d-%m-%Y')) 
AS Month_Name, ROUND(SUM(Produced_Qty) / 1000000, 3) 
AS Produced_Quantity_Million FROM fact_Production
GROUP BY MONTH(STR_TO_DATE(Date_FK, '%d-%m-%Y')),
MONTHNAME(STR_TO_DATE(Date_FK, '%d-%m-%Y'))
ORDER BY MONTH(STR_TO_DATE(Date_FK, '%d-%m-%Y'));

-- Manufacture vs Rejected Month wise
SELECT MONTHNAME(STR_TO_DATE(Date_FK, '%d-%m-%Y')) AS Month,
ROUND(SUM(Produced_Qty) / 1000000, 3) 
AS Manufactured_Quantity_Million,
ROUND(SUM(Rejected_Qty) / 1000, 2) AS Rejected_Quantity_K
FROM fact_Production GROUP BY
MONTH(STR_TO_DATE(Date_FK, '%d-%m-%Y')),
MONTHNAME(STR_TO_DATE(Date_FK, '%d-%m-%Y'))
ORDER BY MONTH(STR_TO_DATE(Date_FK, '%d-%m-%Y'));

-- Department Wise Manufacture vs Rejected
SELECT Dept_Name, ROUND(SUM(Produced_Qty) / 1000000, 3) 
AS Produced_M,ROUND(SUM(Rejected_Qty) / 1000, 1) AS Rejected_K
FROM fact_Production f JOIN dim_department d 
ON f.Dept_ID = d.Dept_ID GROUP BY Dept_Name ORDER BY Produced_M DESC;






