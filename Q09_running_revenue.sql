WITH monthlySalesData AS
(
 SELECT 
   EXTRACT(YEAR FROM o.orderDate) AS year,
   EXTRACT(MONTH FROM o.orderDate) AS month,
   ROUND(SUM(od.quantity * od.unitPrice * (1- od.discount)),0) AS revenue
 FROM `northwind.orders` AS o     
 JOIN `northwind.order_details` AS od 
   ON o.orderID = od.orderID
 GROUP BY year, month
)
SELECT  
  year, 
  month,
  revenue,
  SUM(revenue) OVER(ORDER BY year, month) AS runningTotal,
CASE 
  WHEN SUM(revenue) OVER(ORDER BY year, month) >= 1000000 THEN 'Target $1M+'
  WHEN SUM(revenue) OVER(ORDER BY year, month) >= 500000 THEN 'Target $500K+'
  WHEN SUM(revenue) OVER(ORDER BY year, month) >= 100000 THEN 'Target $100K+'
  ELSE 'Growing'
END AS milestone
FROM monthlySalesData
ORDER BY month, year
