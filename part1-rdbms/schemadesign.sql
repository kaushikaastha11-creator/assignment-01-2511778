-- =============================================
-- Part 1.2 - Schema Design: 3NF Normalization
-- Source: orders_flat.csv
-- =============================================

-- Drop tables if they exist (safe re-run)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS sales_reps;

-- Table 1: sales_reps
-- Each sales rep is stored once with their office address
CREATE TABLE sales_reps (
    sales_rep_id   VARCHAR(10)  NOT NULL,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address VARCHAR(255) NOT NULL,
    PRIMARY KEY (sales_rep_id)
);

-- Table 2: customers
-- Each customer is stored once
CREATE TABLE customers (
    customer_id    VARCHAR(10)  NOT NULL,
    customer_name  VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city  VARCHAR(50)  NOT NULL,
    PRIMARY KEY (customer_id)
);

-- Table 3: products
-- Each product is stored once with its price
CREATE TABLE products (
    product_id   VARCHAR(10)   NOT NULL,
    product_name VARCHAR(100)  NOT NULL,
    category     VARCHAR(50)   NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_id)
);

-- Table 4: orders
-- Links customers, products, and sales reps
CREATE TABLE orders (
    order_id     VARCHAR(10)   NOT NULL,
    customer_id  VARCHAR(10)   NOT NULL,
    product_id   VARCHAR(10)   NOT NULL,
    sales_rep_id VARCHAR(10)   NOT NULL,
    quantity     INT           NOT NULL,
    order_date   DATE          NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id)  REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)   REFERENCES products(product_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

-- =============================================
-- INSERT DATA
-- =============================================

INSERT INTO sales_reps VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai',  'anita@corp.com',  'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar',   'ravi@corp.com',   'South Zone, MG Road, Bangalore - 560001');

INSERT INTO customers VALUES
('C001', 'Rohan Mehta',  'rohan@gmail.com',  'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com',  'Delhi'),
('C003', 'Amit Verma',   'amit@gmail.com',   'Bangalore'),
('C004', 'Sneha Iyer',   'sneha@gmail.com',  'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
('C006', 'Neha Gupta',   'neha@gmail.com',   'Delhi'),
('C007', 'Arjun Nair',   'arjun@gmail.com',  'Bangalore'),
('C008', 'Kavya Rao',    'kavya@gmail.com',  'Hyderabad');

INSERT INTO products VALUES
('P001', 'Laptop',        'Electronics', 55000.00),
('P002', 'Mouse',         'Electronics',   800.00),
('P003', 'Desk Chair',    'Furniture',    8500.00),
('P004', 'Notebook',      'Stationery',    120.00),
('P005', 'Headphones',    'Electronics',  3200.00),
('P006', 'Standing Desk', 'Furniture',   22000.00),
('P007', 'Pen Set',       'Stationery',    250.00),
('P008', 'Webcam',        'Electronics',  2100.00);

INSERT INTO orders VALUES
('ORD1027', 'C002', 'P004', 'SR02', 4,  '2023-11-02'),
('ORD1114', 'C001', 'P007', 'SR01', 2,  '2023-08-06'),
('ORD1153', 'C006', 'P007', 'SR01', 3,  '2023-02-14'),
('ORD1002', 'C002', 'P005', 'SR02', 1,  '2023-01-17'),
('ORD1118', 'C006', 'P007', 'SR02', 5,  '2023-11-10'),
('ORD1132', 'C003', 'P007', 'SR02', 5,  '2023-03-07'),
('ORD1037', 'C002', 'P007', 'SR03', 2,  '2023-03-06'),
('ORD1075', 'C005', 'P003', 'SR03', 3,  '2023-04-18'),
('ORD1083', 'C006', 'P007', 'SR01', 2,  '2023-07-03'),
('ORD1091', 'C001', 'P006', 'SR01', 3,  '2023-07-24'),
('ORD1045', 'C004', 'P001', 'SR02', 1,  '2023-05-12'),
('ORD1060', 'C007', 'P002', 'SR03', 4,  '2023-06-19'),
('ORD1070', 'C008', 'P008', 'SR01', 2,  '2023-09-01'),
('ORD1080', 'C003', 'P003', 'SR03', 1,  '2023-10-15'),
('ORD1090', 'C005', 'P001', 'SR01', 2,  '2023-12-05');