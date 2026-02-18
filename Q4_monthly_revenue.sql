SELECT
  EXTRACT(YEAR FROM o.orderDate) AS ordersYear,
  EXTRACT(MONTH FROM o.orderDate) AS ordersMonth,
  ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)),0) AS monthlyRevenue,
  COUNT(DISTINCT o.orderID) AS totalOrders,
  SUM(od.quantity) AS totalUnitsSold
FROM `northwind.orders` AS o   
JOIN `northwind.order_details` AS od   
  ON o.orderID = od.orderID 
GROUP BY ordersYear, ordersMonth
ORDER BY ordersYear, ordersMonth;