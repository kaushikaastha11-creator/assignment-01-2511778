\## Anomaly Analysis

### Insert Anomaly
**Definition:** An insert anomaly occurs when you cannot add new data without also inserting unrelated data.

**Example from the dataset:**
The file `orders_flat.csv` has no standalone product table. Every product record exists only as part of an order row. Suppose the company wants to add a new product **"P009 – Stapler"** at ₹60 under the Stationery category to the catalog *before* any customer orders it. This is **impossible** in the flat file — there is no order to attach it to, so the product simply cannot be recorded.

- **Columns affected:** `product_id`, `product_name`, `category`, `unit_price`
- **Impact:** New products can only enter the system the moment someone orders them, which prevents proper inventory or catalog management.

---

### Update Anomaly
**Definition:** An update anomaly occurs when the same real-world fact is stored in multiple rows, causing inconsistency when only some rows are updated.

**Example from the dataset:**
Sales rep **SR01 – Deepak Joshi** appears in 83 rows. His `office_address` should always be the same, but it is stored inconsistently across rows:
- **68 rows** store: `Mumbai HQ, Nariman Point, Mumbai - 400021`
- **15 rows** store: `Mumbai HQ, Nariman Pt, Mumbai - 400021` *(abbreviated)*

**Specific rows with the incorrect/abbreviated version:**
Row 37 (ORD1180), Row 56 (ORD1173), Row 89 (ORD1170), Row 92 (ORD1183), Row 96 (ORD1181), Row 98 (ORD1184), Row 110 (ORD1172), Row 122 (ORD1182), Row 125 (ORD1177), Row 129 (ORD1178), and 5 more.

- **Columns affected:** `sales_rep_id`, `office_address`
- **Impact:** If Deepak Joshi's office moves, all 83 rows must be updated. Missing even one creates permanently inconsistent data — which has *already happened* in this file.

---

### Delete Anomaly
**Definition:** A delete anomaly occurs when deleting one kind of data unintentionally destroys unrelated data.

**Example from the dataset:**
Customer **C001 – Rohan Mehta** (rohan@gmail.com, Mumbai) has placed 20 orders in the dataset. If the business decides to cancel and delete all of Rohan Mehta's orders (e.g., due to account closure or data retention policy), every row where `customer_id = 'C001'` must be deleted.

After that deletion, **all information about Rohan Mehta is permanently gone** — his name, email address, and city — even though the business may still need to retain customer records for compliance, marketing, or re-engagement purposes.

- **Rows affected:** All 20 rows where `customer_id = 'C001'`
- **Columns lost:** `customer_id`, `customer_name`, `customer_email`, `customer_city`

---

## Normalization Justification

Your manager's argument — that keeping everything in one flat table is simpler — sounds reasonable on the surface, but the data in `orders_flat.csv` itself directly refutes it.

Consider what "simple" actually costs here. Sales rep **Deepak Joshi (SR01)** appears in 83 rows of this 186-row file. His office address is a single real-world fact: he works at one location. Yet that address is stored 83 times — and has already gone wrong. In this very file, 15 of those 83 rows say "Nariman Pt" while 68 say "Nariman Point." The database is already inconsistent, and the file has only 186 rows. In a real company with thousands of orders, this kind of silent data corruption becomes impossible to detect and fix.

The same problem applies to product prices. `unit_price` for Laptop (P001) is stored in 39 separate rows. If the price changes, every one of those rows must be updated manually. Miss one row and queries will silently return wrong revenue calculations — with no error message to warn you.

Normalization into 3NF solves all of this by giving every fact exactly one home. Deepak Joshi's address lives in one row of a `sales_reps` table. Laptop's price lives in one row of a `products` table. A new product can be added to the catalog without creating a fake order. Deleting a customer's orders does not erase their contact information.

The manager is confusing "simple to create" with "simple to maintain." A flat table is faster to build once but grows exponentially harder to keep correct over time. Normalization is not over-engineering — it is the minimum structure needed to prevent the data quality problems that already exist in this file.
