SELECT
  c.companyName AS customerCompany,
  c.contactName AS customerPerson,
  c.city AS customerCity,
  c.country AS customerCountry,
  COUNT(DISTINCT o.orderID) AS totalOrders,
  ROUND(SUM(od.unitPrice * od.quantity),0) AS totalRevenue
FROM `ecommerce-portfolio-2026.northwind.customers` AS c
JOIN `ecommerce-portfolio-2026.northwind.orders` AS o 
  ON c.customerID = o.customerID
JOIN `ecommerce-portfolio-2026.northwind.order_details` AS od  
  ON o.orderID = od.orderID
WHERE c.country IN ('Germany', 'UK', 'USA', 'Brazil')
GROUP BY c.customerID, c.companyName, c.contactName, c.city, c.country
ORDER BY totalRevenue DESC, totalOrders DESC
LIMIT 10
