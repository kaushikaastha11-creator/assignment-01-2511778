\## Storage Systems

The hospital network's four goals require four distinct storage systems, each chosen for the specific demands of that use case.

**Goal 1 — Predict patient readmission risk:** Historical treatment data (diagnoses, procedures, lab results, discharge summaries) is stored in a **Data Warehouse** (e.g., Google BigQuery or Amazon Redshift). This data is structured, batch-updated, and queried analytically for ML feature engineering. The warehouse's columnar storage makes aggregations across millions of patient records fast and efficient.

**Goal 2 — Plain English queries on patient history:** This goal requires a **Vector Database** (e.g., Pinecone or Weaviate) combined with an LLM. Patient records, clinical notes, and discharge summaries are chunked and embedded. When a doctor asks "Has this patient had a cardiac event before?", the query is embedded and semantically matched against stored embeddings — returning relevant notes even when exact keywords don't match. The source of truth remains the operational RDBMS; the vector DB is an index layer on top.

**Goal 3 — Monthly management reports:** A **Data Warehouse with a BI layer** (e.g., BigQuery + Looker, or MySQL + Metabase) handles bed occupancy, department costs, and admission trends. Data is loaded via nightly ETL from the OLTP system. Report queries run on pre-aggregated summary tables for performance.

**Goal 4 — Real-time ICU vitals:** A **Time-Series Database** (e.g., InfluxDB or TimescaleDB) is ideal for high-frequency, timestamped sensor data. ICU monitors emit heart rate, blood pressure, and SpO₂ every second. Time-series databases handle this with efficient compression, fast time-range queries, and built-in downsampling.

## OLTP vs OLAP Boundary

The OLTP system is a **relational database** (MySQL or PostgreSQL) that handles real-time clinical operations: admissions, prescriptions, lab orders, billing, and scheduling. It is optimized for fast reads and writes on individual rows, with strict ACID compliance to ensure that no prescription is lost or double-written.

The OLAP boundary begins at the **ETL pipeline**. Nightly (or near-real-time via CDC — Change Data Capture), data is extracted from the OLTP system, transformed (cleaned, deduplicated, standardized), and loaded into the Data Warehouse. The warehouse is the read-only analytical layer: queries here aggregate over months or years of data across all patients and departments, and they never touch the live OLTP system.

The Vector DB sits outside this OLTP/OLAP boundary — it is an AI index layer that is updated asynchronously whenever new clinical notes are written.

## Trade-offs

**Trade-off: Complexity vs. Capability.** Using four different storage systems (RDBMS, Data Warehouse, Vector DB, Time-Series DB) introduces significant operational complexity: four systems to monitor, back up, secure, and keep in sync. A failure in the ETL pipeline means the warehouse has stale data; a sync delay between the RDBMS and Vector DB means the plain-English query tool misses recent records.

**Mitigation:** Use a **managed, unified platform** where possible. For example, Databricks Lakehouse can unify the warehouse and lake layers, reducing two systems to one. For the Vector DB, use a managed cloud service (Pinecone) with automatic synchronization triggers via database CDC (e.g., Debezium). Implement comprehensive observability with data freshness monitors and automated alerts so that any sync failures are caught within minutes rather than discovered during a clinical query.
