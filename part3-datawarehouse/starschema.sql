-- =============================================
-- Part 3.1 - Star Schema Design
-- Source: retail_transactions.csv
-- =============================================

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- Dimension: Date
CREATE TABLE dim_date (
    date_id       INT          NOT NULL AUTO_INCREMENT,
    full_date     DATE         NOT NULL,
    day_of_month  INT          NOT NULL,
    month_num     INT          NOT NULL,
    month_name    VARCHAR(20)  NOT NULL,
    quarter       INT          NOT NULL,
    year          INT          NOT NULL,
    PRIMARY KEY (date_id)
);

-- Dimension: Store
CREATE TABLE dim_store (
    store_id    INT          NOT NULL AUTO_INCREMENT,
    store_name  VARCHAR(100) NOT NULL,
    store_city  VARCHAR(50)  NOT NULL,
    PRIMARY KEY (store_id)
);

-- Dimension: Product
CREATE TABLE dim_product (
    product_id    INT          NOT NULL AUTO_INCREMENT,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(50)  NOT NULL,
    PRIMARY KEY (product_id)
);

-- Fact Table: Sales
CREATE TABLE fact_sales (
    sale_id       INT           NOT NULL AUTO_INCREMENT,
    date_id       INT           NOT NULL,
    store_id      INT           NOT NULL,
    product_id    INT           NOT NULL,
    units_sold    INT           NOT NULL,
    unit_price    DECIMAL(12,2) NOT NULL,
    total_revenue DECIMAL(14,2) NOT NULL,
    PRIMARY KEY (sale_id),
    FOREIGN KEY (date_id)    REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id)   REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- =============================================
-- INSERT CLEANED SAMPLE DATA
-- (dates standardized to YYYY-MM-DD, 
--  category casing standardized to Title Case,
--  NULLs removed)
-- =============================================

INSERT INTO dim_date (full_date, day_of_month, month_num, month_name, quarter, year) VALUES
('2023-08-29', 29, 8,  'August',    3, 2023),
('2023-12-12', 12, 12, 'December',  4, 2023),
('2023-02-05',  5, 2,  'February',  1, 2023),
('2023-02-20', 20, 2,  'February',  1, 2023),
('2023-01-15', 15, 1,  'January',   1, 2023),
('2023-06-10', 10, 6,  'June',      2, 2023),
('2023-09-03',  3, 9,  'September', 3, 2023),
('2023-03-22', 22, 3,  'March',     1, 2023),
('2023-07-14', 14, 7,  'July',      3, 2023),
('2023-11-05',  5, 11, 'November',  4, 2023);

INSERT INTO dim_store (store_name, store_city) VALUES
('Chennai Anna',  'Chennai'),
('Delhi South',   'Delhi'),
('Mumbai West',   'Mumbai'),
('Bangalore Hub', 'Bangalore'),
('Hyderabad Central', 'Hyderabad');

INSERT INTO dim_product (product_name, category) VALUES
('Speaker',    'Electronics'),
('Tablet',     'Electronics'),
('Phone',      'Electronics'),
('Smartwatch', 'Electronics'),
('Laptop',     'Electronics'),
('Jeans',      'Clothing'),
('T-Shirt',    'Clothing'),
('Rice',       'Groceries'),
('Wheat Atta', 'Groceries'),
('Headphones', 'Electronics');

INSERT INTO fact_sales (date_id, store_id, product_id, units_sold, unit_price, total_revenue) VALUES
(1, 1, 1,  3,  49262.78, 147788.34),
(2, 1, 2, 11,  23226.12, 255487.32),
(3, 1, 3, 20,  48703.39, 974067.80),
(4, 2, 2, 14,  23226.12, 325165.68),
(5, 1, 4, 10,  58851.01, 588510.10),
(6, 3, 5,  2, 112000.00, 224000.00),
(7, 4, 6,  8,   1999.00,  15992.00),
(8, 5, 7, 15,    899.00,  13485.00),
(9, 2, 8, 50,     85.00,   4250.00),
(10,3, 9, 30,    289.00,   8670.00);