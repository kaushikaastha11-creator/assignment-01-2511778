\## ETL Decisions

### Decision 1 — Standardizing Date Formats
**Problem:** The `date` column in retail_transactions.csv contained three different formats: ISO format (2023-02-05), DD-MM-YYYY with dashes (20-02-2023), and DD/MM/YYYY with slashes (29/08/2023). SQL databases require a single consistent date format, and mixing formats would cause parse errors or silent data corruption.
**Resolution:** All dates were converted to the ISO 8601 standard format (YYYY-MM-DD) before insertion into `dim_date`. In a production ETL pipeline, this would be handled using Python's `dateutil.parser` or a CASE expression in SQL to detect and convert each format.

### Decision 2 — Normalizing Category Casing
**Problem:** The `category` column had inconsistent capitalization: "Electronics" appeared as both "Electronics" (Title Case) and "electronics" (lowercase) in different rows. This would cause GROUP BY queries to treat them as two separate categories, splitting analytics and producing wrong totals.
**Resolution:** All category values were standardized to Title Case (first letter uppercase, rest lowercase) before insertion into `dim_product`. In SQL this can be enforced with `INITCAP()` (PostgreSQL) or `CONCAT(UPPER(SUBSTRING(category,1,1)), LOWER(SUBSTRING(category,2)))` in MySQL.

### Decision 3 — Handling NULL Values
**Problem:** Some rows in retail_transactions.csv contained NULL values in the `units_sold` or `unit_price` columns. Inserting NULLs into a fact table's numeric measure columns would break SUM() and AVG() aggregations silently, or cause divide-by-zero errors in ratio calculations.
**Resolution:** Rows with NULL in `units_sold` or `unit_price` were excluded from the warehouse load (filtered out during staging). An alternative would be to substitute NULLs with 0 using COALESCE, but since these rows represent incomplete transactions, exclusion is the safer and more analytically correct decision.
