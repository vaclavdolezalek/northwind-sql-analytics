SELECT 
  p.productID,
  p.productName,
  p.unitPrice,
  SUM(od.quantity) AS totalUnitsSold,
  ROUND(SUM(od.quantity * od.unitPrice * (1 - od.discount)),0) AS productRevenue,
  COUNT(DISTINCT od.orderID) AS timesOrdered,
CASE 
  WHEN p.unitPrice >50 THEN 'Premium'
  WHEN p.unitPrice >=20 THEN 'Mid-Range'
  ELSE 'Value'
END AS priceTier
FROM `northwind.products` AS p
JOIN `northwind.order_details` AS od
  ON p.productID = od.productID
GROUP BY p.productID, p.productName, p.unitPrice
HAVING SUM(od.quantity) > 500
ORDER BY productRevenue DESC, totalUnitsSold DESC

