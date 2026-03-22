# assignment-01-2511778
\# Retail Data Management and Analytics System





![Python](https://img.shields.io/badge/Python-Data%20Processing-blue)

![SQL](https://img.shields.io/badge/SQL-Database-green)

![MongoDB](https://img.shields.io/badge/MongoDB-NoSQL-brightgreen)

![Data Warehouse](https://img.shields.io/badge/Data-Warehouse-orange)

![Vector DB](https://img.shields.io/badge/Vector-Database-purple)

![Data Lake](https://img.shields.io/badge/Data-Lake-blueviolet)





\## Project Overview



This project demonstrates the implementation of a modern data architecture for managing and analyzing retail order data. The assignment explores multiple data storage and processing technologies commonly used in modern data engineering systems.



The objective of this project is to understand how different data management solutions can work together to store, process, and analyze large volumes of data efficiently.



The project is divided into six sections, each focusing on a different data management approach.



\---



\## Technologies and Concepts Covered



The following data technologies and concepts were implemented in this project:



\* Relational Databases (SQL)

\* NoSQL Document Databases

\* Data Warehouse Design (Star Schema)

\* Vector Databases and Similarity Search

\* Data Lake Processing

\* Integrated Data Architecture



These technologies represent key components of modern data engineering and analytics platforms.

---

## System Architecture

The system follows a modern multi-layer data architecture where different storage technologies handle different workloads.

```mermaid
flowchart TD

A[Raw Datasets<br>CSV / JSON / Parquet]

B[Relational Database<br>SQL]

C[NoSQL Database<br>MongoDB]

D[Data Warehouse<br>Star Schema]

E[Vector Database<br>Similarity Search]

F[Data Lake<br>Large Scale Storage]

A --> B
B --> C
C --> D
D --> E
E --> F
```



\## Project Structure



The repository is organized into the following sections:



\### Part 1 — RDBMS



This section demonstrates the design of a relational database schema for managing retail order data using SQL. Tables were created for customers, products, orders, and order items. SQL queries were also implemented to retrieve and analyze the stored data.



\---



\### Part 2 — NoSQL Database



This section demonstrates how retail order data can be stored in a document-based NoSQL database using JSON documents. Various queries were implemented to retrieve and filter order data.



\---



\### Part 3 — Data Warehouse



A star schema data warehouse model was designed to support analytical queries. The schema includes a central fact table and multiple dimension tables to enable efficient reporting and business intelligence analysis.



\---



\### Part 4 — Vector Database



This section demonstrates the concept of vector embeddings and similarity search. Vector representations of product data were used to identify the most relevant items using cosine similarity.



\---



\### Part 5 — Data Lake



A data lake processing example was implemented using Python. The dataset was treated as raw data stored in a data lake and analyzed using data processing techniques.



\---



\### Part 6 — Capstone



The capstone section integrates all the previous components and explains how different data technologies can work together within a modern data architecture.



\---



\## Conclusion



This project demonstrates how multiple data management technologies can be integrated to create a scalable and flexible data ecosystem. By combining relational databases, NoSQL systems, data warehouses, vector databases, and data lakes, organizations can build powerful platforms for storing and analyzing large datasets.



The implementation of these technologies provides practical insight into modern data engineering workflows and data-driven system design.




