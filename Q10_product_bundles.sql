WITH orderProducts AS (SELECT 
  od.orderID,
  od.productID,
  p.productName
FROM `northwind.order_details` AS od
JOIN `northwind.products` AS p
ON od.productID = p.productID)
SELECT
  p1.productName AS productA,
  p2.productName AS productB,
  COUNT(*) AS timesBoughtTogether,
  CASE
    WHEN COUNT(*) >= 8 THEN 'Strong Bundle'
    WHEN COUNT(*) >= 6 THEN 'Cross-promotion'
    WHEN COUNT(*) >= 5 THEN 'Monitor trend'
  END AS recommendation
FROM orderProducts p1
JOIN orderProducts p2 ON p1.orderID = p2.orderID
WHERE p1.productID < p2.productID
GROUP BY p1.productID, p1.productName, p2.productID, p2.productName
HAVING COUNT(*) >= 5
ORDER BY COUNT(*) DESC