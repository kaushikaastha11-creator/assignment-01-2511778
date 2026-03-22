\## Database Recommendation

For a healthcare patient management system, I would recommend **MySQL** (RDBMS) as the primary database — and my reasoning centers on the ACID vs BASE trade-off and the CAP theorem.

Patient data is one of the most sensitive and legally regulated categories of information. Every write to the database — whether recording a prescription, updating a diagnosis, or billing a procedure — must be Atomic, Consistent, Isolated, and Durable. Consider a scenario where a doctor updates a patient's allergy record and a prescription is written in the same moment: if one succeeds and the other fails mid-transaction, the patient could receive a drug they are allergic to. MySQL's ACID guarantees prevent this. MongoDB, with its BASE (Basically Available, Soft state, Eventually consistent) model, allows temporary inconsistency across nodes — acceptable for a shopping cart, dangerous in a hospital.

From the CAP theorem perspective, healthcare systems must prioritize Consistency and Partition Tolerance (CP). A MongoDB replica set can serve stale reads during a partition, which is unacceptable when a doctor asks "what is this patient's current medication list?" MySQL with synchronous replication ensures every read reflects the latest committed write.

Patient data is also highly structured and relational: patients have appointments, appointments link to doctors, doctors belong to departments, billing ties to procedures. This natural relational model is exactly what a normalized RDBMS handles best.

**Would the answer change for a fraud detection module?**
Yes, partially. Fraud detection requires analyzing large volumes of behavioral events in real time — login timestamps, transaction patterns, device fingerprints. This is write-heavy, schema-flexible, and benefits from horizontal scaling. Here, MongoDB (or even a time-series database like InfluxDB) would be a better fit. The recommended architecture is therefore **hybrid**: MySQL for core patient records (ACID-critical), and MongoDB or a dedicated event store for the fraud detection pipeline.
