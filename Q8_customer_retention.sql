SELECT
  monthsSinceFirst,
	COUNT(DISTINCT customerID) AS customerReturned,
  CASE
    WHEN COUNT(DISTINCT customerID) > 30 THEN 'Excellent Retention'
    WHEN COUNT(DISTINCT customerID) > 20 THEN 'Good Retention'
    WHEN COUNT(DISTINCT customerID) > 10 THEN 'Moderate Retention'
    ELSE 'Need Improvements'
  END AS retentionLevel
	FROM(
SELECT 
  o.customerID,
  o.orderDate,
  s.firstOrderDate,
  DATE_DIFF(o.orderDate, s.firstOrderDate, MONTH) AS monthsSinceFirst
FROM `northwind.orders` AS o
JOIN
(
  SELECT 
    customerID,
    MIN(orderDate) AS firstOrderDate
  FROM `northwind.orders` 
    GROUP BY customerID
) AS s
  ON o.customerID = s.customerID
  ORDER BY o.customerID,o.orderDate
) AS customerTimeline
WHERE monthsSinceFirst > 0
GROUP BY monthsSinceFirst
ORDER BY monthsSinceFirst