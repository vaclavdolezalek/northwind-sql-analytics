SELECT
  e.employeeName AS emplName,
  e.title AS emplTitle,
  e.city AS emplCity,
  COUNT(DISTINCT o.orderID) AS totalOrdersCount,
  SUM(od.quantity) AS totalQuantityCount
FROM `northwind.employees` AS e
JOIN `northwind.orders` AS o  
  ON e.employeeID = o.employeeID
JOIN `northwind.order_details` AS od 
  ON o.orderID = od.orderID
WHERE o.orderDate >= '2014-01-01'
GROUP BY e.employeeName, e.title, e.city
ORDER BY totalOrdersCount DESC
