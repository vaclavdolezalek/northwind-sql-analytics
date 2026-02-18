SELECT
  c.categoryName AS categoryGroup,
  c.description AS categoryDescription,
  SUM(od.quantity) AS totalUnitsSold,
  COUNT(DISTINCT p.productID) AS categoryProductCount
FROM `northwind.categories` AS c
JOIN `northwind.products` AS p 
  ON c.categoryID = p.categoryID
JOIN `northwind.order_details` AS od
  ON p.productID = od.productID
GROUP BY c.categoryID, c.categoryName, c.description 
ORDER BY totalUnitsSold DESC
LIMIT 5