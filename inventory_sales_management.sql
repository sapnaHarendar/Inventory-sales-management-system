-- PROJECT 3: Inventory and Sales Analysis Management System
-- I built this project to understand how a real shop manages
-- stock, customers, suppliers and daily sales using MySQL.

DROP DATABASE IF EXISTS Inventory_Sales_DB;
CREATE DATABASE Inventory_Sales_DB;
USE Inventory_Sales_DB;

-- 1. Suppliers - who supplies products to the shop
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50)
);

-- 2. Products - what the shop sells
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    supplier_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    reorder_level INT DEFAULT 10,
    CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CHECK (price >= 0),
    CHECK (stock_quantity >= 0),
    CHECK (reorder_level >= 0)
);

-- 3. Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50)
);

-- 4. Sales - one row for each bill
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    sale_date DATE NOT NULL,
    CONSTRAINT fk_sale_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Sale Items - what items were in each bill
CREATE TABLE sale_items (
    sale_item_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_item_sale FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    CONSTRAINT fk_item_product FOREIGN KEY (product_id) REFERENCES products(product_id),
    CHECK (quantity > 0),
    CHECK (unit_price >= 0)
);

-- Sample Suppliers
INSERT INTO suppliers (supplier_name, contact_person, phone, city) VALUES
('TechWorld Distributors', 'Arun Kumar', '9876543210', 'Chennai'),
('Global Electronics', 'Rahul Sharma', '9876543211', 'Bangalore'),
('FreshMart Supplies', 'Priya Singh', '9876543212', 'Mumbai'),
('Office Essentials Ltd', 'Karthik Raj', '9876543213', 'Coimbatore'),
('HomeStyle Traders', 'Meena Devi', '9876543214', 'Hyderabad');

-- Sample Products
INSERT INTO products (product_name, category, supplier_id, price, stock_quantity, reorder_level) VALUES
('Laptop', 'Electronics', 1, 55000.00, 30, 10),
('Smartphone', 'Electronics', 2, 25000.00, 50, 15),
('Tablet', 'Electronics', 1, 18000.00, 25, 8),
('Headphones', 'Electronics', 2, 2500.00, 40, 10),
('Keyboard', 'Accessories', 1, 1200.00, 35, 10),
('Mouse', 'Accessories', 1, 700.00, 45, 12),
('Printer', 'Electronics', 2, 12000.00, 15, 5),
('Monitor', 'Electronics', 2, 15000.00, 20, 8),
('Office Chair', 'Furniture', 4, 6500.00, 18, 5),
('Office Table', 'Furniture', 4, 8500.00, 12, 4),
('Notebook', 'Stationery', 4, 80.00, 100, 20),
('Pen Pack', 'Stationery', 4, 120.00, 150, 30),
('Water Bottle', 'Accessories', 5, 350.00, 60, 15),
('Backpack', 'Accessories', 5, 1800.00, 30, 10),
('Rice Bag 5kg', 'Groceries', 3, 350.00, 50, 15),
('Cooking Oil 1L', 'Groceries', 3, 180.00, 70, 20),
('Sugar 1kg', 'Groceries', 3, 55.00, 90, 25),
('Coffee Powder', 'Groceries', 3, 250.00, 40, 10),
('Desk Lamp', 'Home Appliances', 5, 950.00, 25, 8),
('Electric Kettle', 'Home Appliances', 5, 1800.00, 20, 6);

-- Sample Customers
INSERT INTO customers (customer_name, email, phone, city) VALUES
('Aarav Kumar', 'aarav@gmail.com', '9000011111', 'Chennai'),
('Priya Sharma', 'priya@gmail.com', '9000011112', 'Bangalore'),
('Rahul Verma', 'rahul@gmail.com', '9000011113', 'Mumbai'),
('Sneha Raj', 'sneha@gmail.com', '9000011114', 'Chennai'),
('Karthik S', 'karthik@gmail.com', '9000011115', 'Coimbatore'),
('Divya Menon', 'divya@gmail.com', '9000011116', 'Hyderabad'),
('Arjun Reddy', 'arjun@gmail.com', '9000011117', 'Hyderabad'),
('Meera Nair', 'meera@gmail.com', '9000011118', 'Kochi'),
('Vikram Singh', 'vikram@gmail.com', '9000011119', 'Delhi'),
('Ananya Das', 'ananya@gmail.com', '9000011120', 'Kolkata');

-- Sample Sales (Jan to April 2026)
INSERT INTO sales (customer_id, sale_date) VALUES
(1, '2026-01-05'), (2, '2026-01-10'), (3, '2026-01-15'), (4, '2026-01-20'), (5, '2026-01-25'),
(6, '2026-02-03'), (7, '2026-02-08'), (8, '2026-02-12'), (9, '2026-02-18'), (10, '2026-02-25'),
(1, '2026-03-02'), (2, '2026-03-07'), (3, '2026-03-14'), (4, '2026-03-19'), (5, '2026-03-26'),
(6, '2026-04-04'), (7, '2026-04-09'), (8, '2026-04-15'), (9, '2026-04-21'), (10, '2026-04-28');

-- Sample Sale Items
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 55000.00), (1, 5, 2, 1200.00),
(2, 2, 1, 25000.00), (2, 6, 3, 700.00),
(3, 3, 1, 18000.00), (3, 4, 2, 2500.00),
(4, 7, 1, 12000.00), (4, 11, 5, 80.00),
(5, 8, 1, 15000.00), (5, 12, 4, 120.00),
(6, 1, 2, 55000.00), (6, 9, 1, 6500.00),
(7, 2, 2, 25000.00), (7, 13, 3, 350.00),
(8, 10, 1, 8500.00), (8, 14, 2, 1800.00),
(9, 15, 4, 350.00), (9, 16, 5, 180.00),
(10, 17, 6, 55.00), (10, 18, 2, 250.00),
(11, 1, 1, 55000.00), (11, 5, 3, 1200.00),
(12, 2, 1, 25000.00), (12, 6, 2, 700.00),
(13, 3, 2, 18000.00), (13, 4, 1, 2500.00),
(14, 7, 2, 12000.00), (14, 11, 10, 80.00),
(15, 8, 1, 15000.00), (15, 12, 5, 120.00),
(16, 1, 1, 55000.00), (16, 9, 2, 6500.00),
(17, 2, 1, 25000.00), (17, 13, 4, 350.00),
(18, 10, 2, 8500.00), (18, 14, 1, 1800.00),
(19, 15, 5, 350.00), (19, 16, 3, 180.00),
(20, 17, 8, 55.00), (20, 18, 3, 250.00);

-- Quick checks
SELECT COUNT(*) AS total_suppliers FROM suppliers;
SELECT COUNT(*) AS total_products FROM products;
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_sales FROM sales;
SELECT COUNT(*) AS total_sale_items FROM sale_items;

-- I added opening_stock later to keep track of original stock before sales
ALTER TABLE products ADD COLUMN opening_stock INT;
UPDATE products SET opening_stock = stock_quantity WHERE product_id > 0;

-- PART 3: Filtering
SELECT * FROM products WHERE category = 'Electronics';
SELECT * FROM products WHERE price BETWEEN 500 AND 5000;
SELECT p.product_id, p.product_name, p.category, p.price, s.supplier_name
FROM products p INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE s.supplier_name = 'TechWorld Distributors';

-- PART 4: JOINS - Complete sales info
SELECT s.sale_id, s.sale_date, c.customer_name, p.product_name, p.category, si.quantity, si.unit_price, sup.supplier_name
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN sale_items si ON s.sale_id = si.sale_id
INNER JOIN products p ON si.product_id = p.product_id
INNER JOIN suppliers sup ON p.supplier_id = sup.supplier_id
ORDER BY s.sale_id;

-- Customer-wise sales
SELECT c.customer_id, c.customer_name, s.sale_id, s.sale_date, p.product_name, si.quantity, si.unit_price
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
INNER JOIN sale_items si ON s.sale_id = si.sale_id
INNER JOIN products p ON si.product_id = p.product_id
ORDER BY c.customer_id;

-- Invoice style - with line total
SELECT s.sale_id, s.sale_date, c.customer_name, p.product_name, si.quantity, si.unit_price, si.quantity * si.unit_price AS line_total
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN sale_items si ON s.sale_id = si.sale_id
INNER JOIN products p ON si.product_id = p.product_id
ORDER BY s.sale_id;

-- Products with no sales
SELECT p.product_name, COALESCE(SUM(si.quantity),0) AS total_sold
FROM products p LEFT JOIN sale_items si ON p.product_id = si.product_id
GROUP BY p.product_name;

-- PART 5: Stock Management
SELECT p.product_id, p.product_name, p.category, p.price, p.stock_quantity, s.supplier_name
FROM products p INNER JOIN suppliers s ON p.supplier_id = s.supplier_id ORDER BY p.product_id;

-- Update current stock = opening stock - sold qty
UPDATE products p SET p.stock_quantity = p.opening_stock - COALESCE((SELECT SUM(si.quantity) FROM sale_items si WHERE si.product_id = p.product_id), 0) WHERE p.product_id > 0;

SELECT product_id, product_name, category, opening_stock, stock_quantity AS current_stock FROM products ORDER BY product_id;

-- Low stock report
SELECT product_id, product_name, category, stock_quantity AS current_stock, reorder_level
FROM products WHERE stock_quantity < reorder_level ORDER BY stock_quantity;

SELECT product_name, stock_quantity, CASE WHEN stock_quantity < reorder_level THEN 'Low Stock' ELSE 'Available' END AS stock_status FROM products;

-- PART 6: Revenue Analysis
SELECT s.sale_id, s.sale_date, c.customer_name, SUM(si.quantity * si.unit_price) AS total_sale_value
FROM sales s INNER JOIN customers c ON s.customer_id = c.customer_id INNER JOIN sale_items si ON s.sale_id = si.sale_id
GROUP BY s.sale_id, s.sale_date, c.customer_name ORDER BY s.sale_id;

SELECT SUM(quantity * unit_price) AS total_revenue FROM sale_items;

SELECT p.product_id, p.product_name, SUM(si.quantity * si.unit_price) AS total_revenue
FROM products p INNER JOIN sale_items si ON p.product_id = si.product_id
GROUP BY p.product_id, p.product_name ORDER BY total_revenue DESC;

SELECT DATE_FORMAT(s.sale_date, '%Y-%m') AS sales_month, SUM(si.quantity * si.unit_price) AS monthly_revenue
FROM sales s INNER JOIN sale_items si ON s.sale_id = si.sale_id
GROUP BY DATE_FORMAT(s.sale_date, '%Y-%m') ORDER BY sales_month;

SELECT p.category, SUM(si.quantity * si.unit_price) AS category_revenue
FROM products p INNER JOIN sale_items si ON p.product_id = si.product_id
GROUP BY p.category HAVING SUM(si.quantity * si.unit_price) > 5000 ORDER BY category_revenue DESC;

SELECT product_id, product_name, category, price FROM products
WHERE price > (SELECT AVG(price) FROM products) ORDER BY price DESC;

SELECT p.product_id, p.product_name, SUM(si.quantity) AS total_quantity_sold
FROM products p INNER JOIN sale_items si ON p.product_id = si.product_id
GROUP BY p.product_id, p.product_name ORDER BY total_quantity_sold DESC LIMIT 5;

-- PART 7: View for easy reporting
CREATE VIEW sales_summary AS
SELECT s.sale_id, s.sale_date, c.customer_name, SUM(si.quantity * si.unit_price) AS total_sale_value
FROM sales s INNER JOIN customers c ON s.customer_id = c.customer_id INNER JOIN sale_items si ON s.sale_id = si.sale_id
GROUP BY s.sale_id, s.sale_date, c.customer_name;
SELECT * FROM sales_summary;

-- PART 8: Transaction - test rollback
START TRANSACTION;
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
SELECT product_id, product_name, stock_quantity FROM products WHERE product_id = 1;
ROLLBACK;
SELECT product_id, product_name, stock_quantity FROM products WHERE product_id = 1;

-- Transaction - commit
START TRANSACTION;
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
COMMIT;
SELECT product_id, product_name, stock_quantity FROM products WHERE product_id = 1;

-- Restore correct stock after testing
UPDATE products p SET p.stock_quantity = p.opening_stock - COALESCE((SELECT SUM(si.quantity) FROM sale_items si WHERE si.product_id = p.product_id), 0) WHERE p.product_id > 0;
SELECT product_name, opening_stock, stock_quantity FROM products;
