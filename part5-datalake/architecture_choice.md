\## Architecture Recommendation

For a fast-growing food delivery startup collecting GPS logs, text reviews, payment transactions, and restaurant menu images, I would recommend a **Data Lakehouse** architecture.

**Reason 1 — Multi-format, heterogeneous data:**
The startup's data cannot fit into a single paradigm. GPS logs are structured time-series, text reviews are unstructured, payment transactions are relational and ACID-sensitive, and menu images are binary files. A traditional Data Warehouse only handles structured data and would reject images and raw text. A pure Data Lake stores everything but provides no structure for reliable SQL analytics. A Data Lakehouse (e.g., Delta Lake on AWS S3, or Databricks Lakehouse) handles all formats in one place — raw files in the lake layer, structured tables in the warehouse layer — with ACID transactions at the table level.

**Reason 2 — ACID + Analytics in one system:**
Payment transactions require ACID guarantees (no double-charging, consistent balances). A pure Data Lake (S3 + Parquet files) does not support transactions natively. The Data Lakehouse adds a transaction log (e.g., Delta Lake's `_delta_log`) on top of the lake storage, giving ACID semantics to structured tables while keeping the cost benefits of object storage. This eliminates the need for a separate OLTP database just for transactional consistency.

**Reason 3 — Scalability and cost:**
Food delivery is a high-volume business. GPS pings from thousands of delivery riders generate millions of rows daily. A Data Warehouse like Redshift or BigQuery bills by data scanned and storage used — expensive at high volume. A Data Lakehouse stores raw data cheaply in S3/GCS and only processes what is needed. As the startup grows from 10,000 to 10 million orders, the architecture scales horizontally without re-platforming.

In summary, the Data Lakehouse is the only architecture that handles all four data types, maintains transactional integrity for payments, and scales cost-effectively with startup growth.
