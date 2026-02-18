SELECT
  EXTRACT(YEAR FROM o.orderDate) AS year,
  EXTRACT(QUARTER FROM o.orderDate) AS quarter,
  COUNT(DISTINCT o.customerID) AS activeCustomers,
  COUNT(DISTINCT o.orderID) AS totalOrders,
  CONCAT('$',ROUND(SUM(o.freight), 0)) AS totalShippingCost,
  CONCAT('$',ROUND(SUM(od.unitPrice * od.quantity * (1 - od.discount)), 0)) AS totatRevenue,
  CONCAT('Avg:$',ROUND(SUM(od.unitPrice * od.quantity * (1 - od.discount)) / COUNT(DISTINCT o.orderID), 0), 'per order') AS averageQuarterRevenue 
FROM `northwind.orders`AS o
JOIN `northwind.order_details` AS od
  ON o.orderID = od.orderID
GROUP BY year, quarter 
ORDER BY year, quarter;
