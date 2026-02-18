SELECT
  c.customerID,
  c.companyName,
  c.country,
  AVG(od.quantity * od.unitPrice * (1 - od.discount)) AS averageOrderValue,
  CASE
  WHEN AVG(od.quantity * od.unitPrice * (1 - od.discount)) > 1000 THEN 'High Value'
  WHEN AVG(od.quantity * od.unitPrice * (1 - od.discount)) >= 500  THEN 'Medium Value'
  ELSE 'Low Value'
  END AS customerSegment
FROM `northwind.customers` AS c   
JOIN `northwind.orders` AS o
 ON c.customerID = o.customerID
JOIN `northwind.order_details` AS od
 ON o.orderID = od.orderID
 GROUP BY c.customerID,  c.companyName,c.country
 ORDER BY averageOrderValue DESC