-- ============================================================
-- SQL BUSINESS DATA ANALYSIS — AWESOME CHOCOLATES
-- ============================================================
-- Author   : M. Charulatha
-- Degree   : MSc Bioinformatics and Data Science
-- Dataset  : Awesome Chocolates Sales Database
-- Source   : YouTube SQL Tutorial Practice (Chandoo)
-- Tool     : MySQL Workbench
--
-- CONCEPTS COVERED:
--   SELECT, WHERE, ORDER BY, GROUP BY
--   Calculated columns, Aliases (AS)
--   Date functions: year(), month(), weekday()
--   BETWEEN, IN, LIKE, OR operators
--   CASE statements (conditional logic)
--   JOINS — combining multiple tables
--   Aggregate functions: COUNT, SUM
--   Subqueries
--   DISTINCT
-- ============================================================


-- ============================================================
-- SECTION 1 — BASIC SELECT QUERIES
-- Exploring the tables and understanding the data structure
-- ============================================================

-- View all records from GEO table
SELECT * FROM geo;

-- View specific columns from SALES table
SELECT SaleDate, Amount, Customers FROM sales;
SELECT Amount, Customers, GeoID FROM sales;

-- View all products
SELECT * FROM products;

-- View all people (sales team)
SELECT * FROM people;


-- ============================================================
-- SECTION 2 — CALCULATED COLUMNS AND ALIASES
-- Creating new columns from existing data
-- ============================================================

-- Calculate amount per box for each sale
SELECT SaleDate, Amount, Boxes, Amount / Boxes
FROM sales;

-- Same calculation with a proper column name using AS
SELECT SaleDate, Amount, Boxes,
       Amount / Boxes AS 'Amount per box'
FROM sales;


-- ============================================================
-- SECTION 3 — WHERE CLAUSE AND FILTERING
-- Filtering data based on conditions
-- ============================================================

-- Sales where amount is greater than 10,000
SELECT * FROM sales
WHERE Amount > 10000;

-- High value sales sorted by amount descending
SELECT * FROM sales
WHERE Amount > 10000
ORDER BY Amount DESC;

-- Sales from Geography G1, sorted by Product ID and Amount
SELECT * FROM sales
WHERE GeoID = 'g1'
ORDER BY PID, Amount DESC;

-- Sales greater than 10,000 after January 1, 2022
SELECT * FROM sales
WHERE Amount > 10000
AND SaleDate >= '2022-01-01';


-- ============================================================
-- SECTION 4 — DATE FUNCTIONS
-- Working with dates using year(), month(), weekday()
-- ============================================================

-- High value sales in the year 2022 only
SELECT SaleDate, Amount FROM sales
WHERE Amount > 10000
AND YEAR(SaleDate) = 2022
ORDER BY Amount DESC;

-- Sales where weekday is Friday (weekday 4 = Friday)
SELECT SaleDate, Amount, Boxes,
       WEEKDAY(SaleDate) AS 'Day of Week'
FROM sales
WHERE WEEKDAY(SaleDate) = 4;

-- Wednesday shipments with small customer and box counts
-- weekday 2 = Wednesday
SELECT Customers, Boxes, SaleDate AS 'Wed Shipment'
FROM sales
WHERE Customers < 100
AND Boxes < 100
AND WEEKDAY(SaleDate) = 2;


-- ============================================================
-- SECTION 5 — BETWEEN, IN, LIKE OPERATORS
-- Different ways to filter data efficiently
-- ============================================================

-- Sales with boxes between 0 and 50 using < and <=
SELECT * FROM sales
WHERE Boxes > 0 AND Boxes <= 50;

-- Same query using BETWEEN (cleaner syntax)
SELECT * FROM sales
WHERE Boxes BETWEEN 0 AND 50;

-- Salespersons from specific teams using OR
SELECT * FROM people
WHERE Team = 'Delish' OR Team = 'Jucies';

-- Same query using IN (more efficient with multiple values)
SELECT * FROM people
WHERE Team IN ('Delish', 'Jucies');

-- Salespersons whose name starts with B
SELECT * FROM people
WHERE Salesperson LIKE 'B%';

-- Salespersons whose name contains B anywhere
SELECT * FROM people
WHERE Salesperson LIKE '%B%';

-- Sales with amount above 2000 and boxes less than 100
SELECT * FROM sales
WHERE Amount > 2000 AND Boxes < 100;


-- ============================================================
-- SECTION 6 — CASE STATEMENTS
-- Creating conditional category labels
-- ============================================================

-- Categorise each sale by amount bracket
SELECT SaleDate, Amount,
    CASE
        WHEN Amount < 1000  THEN 'Under 1k'
        WHEN Amount < 5000  THEN 'Under 5k'
        WHEN Amount < 10000 THEN 'Under 10k'
        ELSE '10k or more'
    END AS 'Amount Category'
FROM sales;


-- ============================================================
-- SECTION 7 — GROUP BY AND AGGREGATE FUNCTIONS
-- Summarising data by groups
-- ============================================================

-- Count of salespersons per team
SELECT Team, COUNT(*) AS 'Team Size'
FROM people
GROUP BY Team;

-- Count of shipments in January 2022
SELECT COUNT(SaleDate) AS 'Jan 2022 Shipments'
FROM sales
WHERE SaleDate BETWEEN '2022-01-01' AND '2022-01-30';

-- Count of Eclairs product entries
SELECT COUNT(Product) AS 'Eclairs Count'
FROM products
WHERE Product = 'Eclairs';

-- Monthly count of shipments where boxes exceeded 1000
SELECT YEAR(SaleDate)  AS 'Year',
       MONTH(SaleDate) AS 'Month',
       COUNT(*)        AS 'Times We Shipped 1k Boxes'
FROM sales
WHERE Boxes > 1000
GROUP BY YEAR(SaleDate), MONTH(SaleDate)
ORDER BY YEAR(SaleDate), MONTH(SaleDate);


-- ============================================================
-- SECTION 8 — JOINS
-- Combining data from multiple tables
-- ============================================================

-- Salesperson shipment count for January 2022
-- Joins SALES and PEOPLE tables on SPID
SELECT p.Salesperson,
       COUNT(*) AS 'Shipment Count'
FROM sales s
JOIN people p ON s.SPID = p.SPID
WHERE SaleDate BETWEEN '2022-01-01' AND '2022-01-31'
GROUP BY p.Salesperson;

-- Total boxes sold for Milk Bars and Eclairs
-- Joins SALES and PRODUCTS tables on PID
SELECT pr.Product,
       SUM(Boxes) AS 'Total Boxes'
FROM sales s
JOIN products pr ON s.PID = pr.PID
WHERE pr.Product IN ('Milk Bars', 'Eclairs')
GROUP BY pr.Product;

-- Total boxes for Milk Bars and Eclairs in first week of Feb 2022
SELECT pr.Product,
       SUM(Boxes) AS 'Total Boxes'
FROM sales s
JOIN products pr ON s.PID = pr.PID
WHERE pr.Product IN ('Milk Bars', 'Eclairs')
AND s.SaleDate BETWEEN '2022-02-01' AND '2022-02-07'
GROUP BY pr.Product;

-- All salesperson sales in January 2022
-- Sorted by sale date ascending
SELECT p.Salesperson AS 'Name',
       s.SaleDate    AS 'Sale Date'
FROM people p
JOIN sales s ON p.SPID = s.SPID
WHERE s.SaleDate BETWEEN '2022-01-01' AND '2022-01-31'
ORDER BY s.SaleDate ASC;

-- Salespersons who made a sale in first week of January 2022
SELECT DISTINCT p.Salesperson
FROM sales s
JOIN people p ON p.SPID = s.SPID
WHERE s.SaleDate BETWEEN '2022-01-01' AND '2022-01-07';


-- ============================================================
-- SECTION 9 — SUBQUERIES
-- Using a query inside another query
-- ============================================================

-- Salespersons who did NOT make any sale in first week of Jan 2022
-- Uses a subquery to find active SPIDs in that period
SELECT Salesperson
FROM people
WHERE SPID NOT IN (
    SELECT SPID FROM sales
    WHERE SaleDate BETWEEN '2022-01-01' AND '2022-01-07'
);


-- ============================================================
-- SECTION 10 — ADVANCED GROUPING WITH CASE AND JOIN
-- Pivoting data — comparing countries side by side
-- ============================================================

-- Monthly comparison of boxes shipped to India vs Australia
-- Uses CASE inside SUM to create a pivot-style report
SELECT YEAR(SaleDate)  AS 'Year',
       MONTH(SaleDate) AS 'Month',
       SUM(CASE WHEN g.Geo = 'India'     THEN Boxes ELSE 0 END) AS 'India Boxes',
       SUM(CASE WHEN g.Geo = 'Australia' THEN Boxes ELSE 0 END) AS 'Australia Boxes'
FROM geo g
JOIN sales s ON g.GeoID = s.GeoID
GROUP BY YEAR(SaleDate), MONTH(SaleDate)
ORDER BY YEAR(SaleDate), MONTH(SaleDate);


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
-- KEY LEARNINGS FROM THIS PRACTICE:
-- 1. Basic to advanced SELECT queries with filtering and sorting
-- 2. Date functions extract useful time-based patterns
-- 3. CASE statements enable conditional logic inside SQL
-- 4. JOINs connect multiple related tables for richer analysis
-- 5. GROUP BY + aggregate functions summarise large datasets
-- 6. Subqueries answer complex business questions cleanly
-- 7. DISTINCT removes duplicates for cleaner results
-- ============================================================
