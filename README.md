# SQL Business Data Analysis — Awesome Chocolates 🍫

**Author:** M. Charulatha | MSc Bioinformatics and Data Science  
**Tool:** MySQL Workbench  
**Dataset:** Awesome Chocolates Sales Database (Chandoo SQL Tutorial)

---

## About This Project

This project demonstrates core SQL querying skills applied to a chocolate sales business database.
The dataset covers real-world sales transactions across multiple countries, product lines, and sales teams.

Queries were written independently after following a YouTube SQL tutorial by Chandoo.
The focus was on understanding *why* each query works — not just copying syntax.

---

## Dataset

| Table | Description |
|---|---|
| `sales` | Transaction records — sale date, amount, boxes, customers |
| `products` | Product catalogue with product IDs and names |
| `people` | Sales team — salesperson names, teams, IDs |
| `geo` | Geography table — country-level data linked to sales |

---

## SQL Concepts Covered

| Concept | What I Used It For |
|---|---|
| `SELECT`, `WHERE`, `ORDER BY` | Basic data retrieval and sorting |
| Calculated columns | Deriving amount per box from existing fields |
| `AS` — Aliases | Making column names readable in output |
| Date functions — `YEAR()`, `MONTH()`, `WEEKDAY()` | Extracting time-based patterns from sale dates |
| `BETWEEN`, `IN`, `LIKE` | Cleaner, efficient filtering alternatives to multiple OR conditions |
| `CASE` statements | Bucketing sales amounts into readable categories |
| `GROUP BY` + aggregate functions | Summarising shipments and revenue by time, person, product |
| `JOIN` | Connecting sales to people, products, and geography |
| Subqueries | Finding salespersons with no activity in a given period |
| `DISTINCT` | Removing duplicate rows from join results |

---

## Business Questions Answered

| Business Question | SQL Technique |
|---|---|
| Which sales exceeded 10,000 in 2022? | `WHERE` + `YEAR()` |
| What is the revenue per box for each shipment? | Calculated column |
| Which salespersons belong to Delish or Jucies teams? | `IN` operator |
| How many shipments occurred in January 2022? | `COUNT` + date filter |
| Which products sold the most boxes in the first week of Feb 2022? | `JOIN` + `GROUP BY` |
| How many boxes were shipped to India vs Australia each month? | `CASE` inside `SUM` — pivot-style report |
| Which salespersons did NOT sell in the first week of January 2022? | Subquery + `NOT IN` |
| Which months had more than 1,000 boxes shipped? | `GROUP BY` + date functions |
| Were there any Wednesday shipments with under 100 boxes? | `WEEKDAY()` filter |
| How many people are in each sales team? | `GROUP BY` + `COUNT` |

---

## Sample Query Outputs

### 1. CASE Statement — Sales Amount Categories
Categorising every sale into amount brackets using conditional logic.

![CASE Statement Output](outputs/output_1_case_statement.png)

---

### 2. JOIN + GROUP BY — Salesperson Shipment Count (January 2022)
Joining the sales and people tables to count how many shipments each salesperson made in January 2022.

![JOIN GROUP BY Output](outputs/output_2_join_groupby.png)

---

### 3. Pivot Report — India vs Australia Monthly Boxes
Using `CASE` inside `SUM` to compare boxes shipped to two countries side by side, month by month.

![Pivot Output](outputs/output_3_pivot_india_australia.png)

---

### 4. Subquery — Salespersons with No Sales in Week 1 of January 2022
Using `NOT IN` with a subquery to find salespersons who were inactive during a specific period.

![Subquery Output](outputs/output_4_subquery_not_in.png)

---

### 5. GROUP BY + Date Functions — Monthly 1000+ Box Shipments
Counting how many times per month boxes shipped exceeded 1,000 units, grouped by year and month.

![Date Function Output](outputs/output_5_monthly_1k_boxes.png)

---

## Key Learnings

1. **Basic to advanced SELECT** — filtering, sorting, and conditional logic build naturally on each other
2. **Date functions** unlock time-based business insights (monthly trends, day-of-week patterns)
3. **CASE statements** turn raw numbers into meaningful categories without needing extra tables
4. **JOINs** are what make relational databases powerful — connecting people, products, and geography to a single sales record gives a full picture
5. **GROUP BY + aggregates** are the backbone of any business summary report
6. **Subqueries** answer questions like "who did *not* do X" — not easily solved with a simple filter
7. **DISTINCT** matters in JOINs where one-to-many relationships can inflate results
8. Writing clean, commented SQL makes queries readable months later — not just functional now

---

## Files in This Repository

| File | Description |
|---|---|
| `awesome_chocolates_sql_analysis.sql` | All queries with section-by-section comments |
| `awesome-chocolates-data.sql` | Database schema and sample data to run locally |
| `outputs/` | Folder containing 5 sample query result screenshots |
| `README.md` | Project overview |

---

## How to Run Locally

1. Open MySQL Workbench
2. Run `awesome-chocolates-data.sql` to create and populate the database
3. Open `awesome_chocolates_sql_analysis.sql`
4. Execute any query section to see results

---

## Source

Dataset and tutorial by [Chandoo](https://www.youtube.com/@chandoo_) — SQL for beginners series on YouTube.  
All queries written independently as practice.

