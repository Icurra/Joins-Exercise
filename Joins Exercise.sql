/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */
SELECT products.Name AS PRODUCT, categories.Name AS CATEGORY
FROM products
INNER JOIN categories
ON categories.CategoryID = products.CategoryID
WHERE categories.CategoryID = 1;

/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT products.Name AS NAME, products.Price AS PRICE, reviews.Rating
FROM reviews
INNER JOIN products
ON reviews.ProductID = products.ProductID
WHERE reviews.Rating = 5;

/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
SELECT employees.FirstName, employees.LastName, SUM(sales.Quantity) AS UNITS_SOLD
FROM sales
INNER JOIN employees
ON employees.EmployeeID = sales.EmployeeID
GROUP BY employees.EmployeeID
HAVING UNITS_SOLD = (SELECT SUM(sales.Quantity) AS MOST FROM sales GROUP BY sales.EmployeeID ORDER BY MOST DESC LIMIT 1);

/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT departments.Name AS DEPARTMENT, categories.Name AS CATEGORIES FROM categories
INNER JOIN departments
ON categories.DepartmentID = departments.DepartmentID
WHERE categories.Name = 'Appliances' OR categories.Name = 'Games';

/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
 SELECT products.Name AS PRODUCT, SUM(sales.Quantity) AS UNITS_SOLD, SUM(sales.Quantity * sales.PricePerUnit) AS GROSS
 FROM Sales
 INNER JOIN products
 ON sales.productID = products.ProductID
 GROUP BY sales.ProductID
 HAVING products.name LIKE '%Eagles: Hotel California%';

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT products.Name AS PRODUCT, reviews.Reviewer, reviews.Rating, reviews.Comment
FROM reviews
INNER JOIN  products
ON reviews.ProductID = products.ProductID
WHERE products.ProductID = 857 AND reviews.Rating = (SELECT Rating FROM reviews WHERE ProductID = 857 ORDER BY Rating LIMIT 1);

-- ------------------------------------------ Extra - May be difficult

/* Your goal is to write a query that serves as an employee sales report.
This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold */
SELECT sales.EmployeeID, employees.FirstName, employees.LastName, products.Name AS PRODUCT, SUM(sales.Quantity) AS UNITS_SOLD, SUM(sales.Quantity * sales.PricePerUnit) AS GROSS FROM sales
INNER JOIN employees
ON sales.EmployeeID = employees.EmployeeID
INNER JOIN products
ON sales.ProductID = products.ProductID
GROUP BY sales.EmployeeID, sales.ProductID
ORDER BY sales.EmployeeID, GROSS DESC;