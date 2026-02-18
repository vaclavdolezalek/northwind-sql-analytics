WITH customer_retention_flags AS (
  SELECT
    EXTRACT(YEAR FROM o.orderDate) AS year,
    EXTRACT(QUARTER FROM o.orderDate) AS quarter,
    c.customerID,
     CASE 
      WHEN LAG(1) OVER (
        PARTITION BY c.customerID
        ORDER BY 
          EXTRACT(YEAR FROM o.orderDate),
          EXTRACT(QUARTER FROM o.orderDate)
      ) = 1 THEN 1
      ELSE 0
    END AS is_retained
  FROM `northwind.customers` AS c
  JOIN `northwind.orders` AS o
    ON c.customerID = o.customerID
  GROUP BY c.customerID, year, quarter, o.orderDate
)
SELECT
  year,
  quarter,
  COUNT(DISTINCT customerID) AS active_customers,
  SUM(is_retained) AS retained_customers,
  ROUND(100.0 * SUM(is_retained) / COUNT(DISTINCT customerID), 1) AS retention_rate_percent
FROM customer_retention_flags
WHERE is_retained IS NOT NULL  
GROUP BY year, quarter
ORDER BY year, quarter;