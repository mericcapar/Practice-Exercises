-- Task 0: Create the practice database
DROP DATABASE IF EXISTS beanbrew_dev;
CREATE DATABASE beanbrew_dev;
USE beanbrew_dev;
SELECT DATABASE();

-- Task 1.1: Create the category table
CREATE TABLE category
( category_id   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  category_name VARCHAR(30) NOT NULL
);
DESCRIBE category;

-- Task 1.2: Create the product table with a foreign key
CREATE TABLE product
( product_id   INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(60) NOT NULL,
  category_id  TINYINT UNSIGNED NOT NULL,
  unit_price   DECIMAL(6,2) NOT NULL,
  stock_qty    INT UNSIGNED,
  active       BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_product_category FOREIGN KEY (category_id)
    REFERENCES category(category_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);
DESCRIBE product;

-- Task 1.3: Predict, then run: a child table before its parent
-- Prediction: It will fail because the customer table doesn't exist yet.
CREATE TABLE orders
( order_id    INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  product_id  INT NOT NULL,
  order_date  DATE NOT NULL,
  quantity    SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
    REFERENCES customer(customer_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_orders_product FOREIGN KEY (product_id)
    REFERENCES product(product_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Result: Error Code 1824. Failed to open the referenced table 'customer'
SHOW TABLES;

-- Task 1.4: Create the customer table
CREATE TABLE customer
( customer_id    INT PRIMARY KEY AUTO_INCREMENT,
  first_name     VARCHAR(30) NOT NULL,
  last_name      VARCHAR(30) NOT NULL,
  email          VARCHAR(100),
  city           VARCHAR(40),
  loyalty_points INT UNSIGNED NOT NULL DEFAULT 0,
  joined_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DESCRIBE customer;
-- The two defaults are loyalty_points = 0 and joined_at = CURRENT_TIMESTAMP.

-- Task 1.5: Create the orders table (now it works)
CREATE TABLE orders
( order_id    INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  product_id  INT NOT NULL,
  order_date  DATE NOT NULL,
  quantity    SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
    REFERENCES customer(customer_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_orders_product FOREIGN KEY (product_id)
    REFERENCES product(product_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);
SHOW TABLES;

-- Task 1.6: Create the employee table (recursive relationship)
CREATE TABLE employee
( employee_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name  VARCHAR(30) NOT NULL,
  last_name   VARCHAR(30) NOT NULL,
  job_title   VARCHAR(40) NOT NULL,
  hire_date   DATE NOT NULL,
  reports_to  INT,
  CONSTRAINT fk_employee_manager FOREIGN KEY (reports_to)
    REFERENCES employee(employee_id)
    ON DELETE SET NULL
);
ALTER TABLE employee AUTO_INCREMENT = 100;
SHOW TABLES;

-- Task 1.7: Load the starter data (provided)
INSERT INTO category (category_name) VALUES
('Coffee'), ('Tea'), ('Bakery'), ('Merchandise');

INSERT INTO product (product_name, category_id, unit_price, stock_qty) VALUES
('House Blend Drip', 1, 2.75, 120), ('Espresso Single', 1, 3.25, 80),
('Caramel Latte', 1, 4.95, 60), ('Cold Brew', 1, 4.50, 45),
('Earl Grey', 2, 2.95, 50), ('Chai Latte', 2, 4.75, 40),
('Blueberry Muffin', 3, 3.50, 24), ('Butter Croissant', 3, 3.25, 30),
('Cinnamon Roll', 3, 3.95, 18), ('Logo Travel Mug', 4, 14.99, 25),
('Pumpkin Spice Latte', 1, 5.45, 35), ('Ceramic Pour-Over Set', 4, 29.99, NULL);

INSERT INTO customer (first_name, last_name, email, city, loyalty_points) VALUES
('Maria', 'Lopez', 'maria.lopez@example.com', 'Boston', 340),
('James', 'Carter', 'james.carter@example.com', 'Cambridge', 120),
('Aisha', 'Khan', 'aisha.khan@example.com', 'Boston', 560),
('Tom', 'Nguyen', NULL, 'Somerville', 75),
('Priya', 'Shah', 'priya.shah@example.com', 'Boston', 0),
('Daniel', 'Brooks', 'daniel.brooks@example.com', 'Quincy', 210);

INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES
(1, 3, '2026-09-01', 1), (2, 1, '2026-09-02', 2), (3, 7, '2026-09-03', 1),
(1, 5, '2026-09-03', 1), (3, 11, '2026-09-04', 2), (4, 2, '2026-09-05', 1),
(6, 10, '2026-09-06', 1), (1, 11, '2026-09-08', 1), (2, 8, '2026-09-09', 3);

INSERT INTO employee (first_name, last_name, job_title, hire_date, reports_to) VALUES
('Dana', 'Reyes', 'Operations Manager', '2021-03-15', NULL);
SELECT LAST_INSERT_ID();

INSERT INTO employee (first_name, last_name, job_title, hire_date, reports_to) VALUES
('Marcus', 'Hill', 'Shift Lead', '2023-06-01', 100),
('Sofia', 'Alvarez', 'Barista', '2024-09-10', 101),
('Ken', 'Ito', 'Barista', '2025-01-20', 101);

-- Check the row counts
SELECT 'category' AS table_name, COUNT(*) AS row_count FROM category
UNION ALL SELECT 'product', COUNT(*) FROM product
UNION ALL SELECT 'customer', COUNT(*) FROM customer
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'employee', COUNT(*) FROM employee;

SELECT employee_id, first_name, job_title, reports_to FROM employee;

-- Task 2.1: Add a column
ALTER TABLE product
ADD product_description TEXT;
DESCRIBE product;

-- Task 2.2: Modify a column and add a phone number
ALTER TABLE product
MODIFY COLUMN product_name VARCHAR(100) NOT NULL;

ALTER TABLE customer
ADD phone VARCHAR(20);
DESCRIBE customer;

-- Task 2.3: Predict, then run: set a default value
-- Prediction: (a) will fail with a syntax error, (b) will work.
-- (a) Guide form: fails in MySQL 8
ALTER TABLE customer MODIFY COLUMN city SET DEFAULT 'Boston';
-- Result: Error Code 1064 (syntax error)

-- (b) MySQL 8 form: works
ALTER TABLE customer
ALTER COLUMN city SET DEFAULT 'Boston';

-- (c) Add a walk-in customer
INSERT INTO customer (first_name, last_name) VALUES ('Lena', 'Park');

-- (d) Verify
SELECT customer_id, first_name, last_name, email, city, loyalty_points
FROM customer
WHERE last_name = 'Park';
-- city and loyalty_points got default values (Boston, 0). email is NULL because it has no default.


-- Task 3.1: No duplicate emails (UNIQUE)
ALTER TABLE customer
ADD CONSTRAINT uq_customer_email UNIQUE (email);
-- Prediction: It will fail because this email already exists.

INSERT INTO customer (first_name, last_name, email)
VALUES ('Maria', 'Lopez', 'maria.lopez@example.com');
-- Result: Error Code 1062. Duplicate entry

-- Task 3.2: No zero prices
ALTER TABLE product
ADD CONSTRAINT chk_price_positive CHECK (unit_price > 0);

-- Prediction: It will fail because the price must be greater than 0.
INSERT INTO product (product_name, category_id, unit_price)
VALUES ('Free Sample Cup', 1, 0.00);
-- Result: Error Code 3819. Check constraint 'chk_price_positive' is violated.

-- Task 3.3: Create the store table (column-level constraints)
CREATE TABLE store
( store_id   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  store_name VARCHAR(40) NOT NULL UNIQUE,
  zip_code   CHAR(5) NOT NULL CHECK (CHAR_LENGTH(zip_code) = 5),
  opened_on  DATE
);
SHOW CREATE TABLE store;
-- Generated constraint names: store_chk_1 and store_name

INSERT INTO store (store_name, zip_code, opened_on) VALUES
('Back Bay', '02116', '2019-05-01'),
('Kendall Square', '02142', '2022-02-14'),
('Seaport', '02210', '2025-08-30');

-- Predict, then run
-- Prediction: It will fail because the zip code has only 4 characters.
INSERT INTO store (store_name, zip_code) VALUES ('Dorchester', '0212');
-- Result: Error Code 3819. Check constraint 'store_chk_1' is violated.

-- Task 3.4: Track stock per store (composite primary key)
CREATE TABLE store_inventory
( store_id    TINYINT UNSIGNED,
  product_id  INT,
  qty_on_hand SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  CONSTRAINT pk_store_inventory PRIMARY KEY (store_id, product_id),
  CONSTRAINT fk_inv_store FOREIGN KEY (store_id)
    REFERENCES store(store_id) ON DELETE CASCADE,
  CONSTRAINT fk_inv_product FOREIGN KEY (product_id)
    REFERENCES product(product_id) ON DELETE CASCADE
);

INSERT INTO store_inventory (store_id, product_id, qty_on_hand) VALUES
(1, 1, 40), (1, 7, 12), (2, 1, 35), (3, 1, 20), (3, 7, 8);

-- Predict, then run
-- Prediction: It will fail because store 1 already has product 1.
INSERT INTO store_inventory (store_id, product_id, qty_on_hand)
VALUES (1, 1, 99);
-- Result: Error Code 1062. Duplicate entry '1-1' for key 'store_inventory.PRIMARY' 

-- Task 3.5: Predict, then run: ON DELETE and ON UPDATE rules
-- (a) RESTRICT
-- Prediction: It will fail because orders still use product 11.
DELETE FROM product WHERE product_id = 11;
-- Result: Error Code 1451. Cannot delete or update a parent row

-- (b) CASCADE
-- Prediction: Store 3 and its inventory rows will be deleted.
DELETE FROM store WHERE store_id = 3;
SELECT * FROM store_inventory;

-- (c) SET NULL
-- Prediction: Marcus will be deleted, and Sofia and Ken's reports_to will become NULL.
DELETE FROM employee WHERE employee_id = 101;
SELECT employee_id, first_name, job_title, reports_to FROM employee;

-- (d) ON UPDATE CASCADE
-- Prediction: The products in category 4 will change to category 40 too.
UPDATE category SET category_id = 40 WHERE category_id = 4;
SELECT product_id, product_name, category_id FROM product WHERE category_id = 40;
UPDATE category SET category_id = 4 WHERE category_id = 40;

-- Task 3.6: Disable, drop and replace a constraint
-- (a) Turn off, then on again
ALTER TABLE store
ALTER CHECK store_chk_1 NOT ENFORCED;
ALTER TABLE store
ALTER CHECK store_chk_1 ENFORCED;

-- (b) Drop the old rule
ALTER TABLE store
DROP CHECK store_chk_1;

-- (c) Add a better, named rule
ALTER TABLE store
ADD CONSTRAINT chk_zip_digits CHECK (zip_code REGEXP '^[0-9]{5}$');

-- (d) Predict, then run
-- Prediction: It will fail because the zip code has a letter.
INSERT INTO store (store_name, zip_code) VALUES ('Dorchester', '0211A');
-- Result: Error Code 3819. Check constraint 'chk_zip_digits' is violated.

-- (e) Verify
SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'beanbrew_dev' AND table_name = 'store';

-- Task 4.1: Test a rule on a scratch table (temporary table)
CREATE TEMPORARY TABLE promo_test
( promo_code   VARCHAR(10) PRIMARY KEY,
  discount_pct TINYINT UNSIGNED NOT NULL,
  CONSTRAINT chk_discount_range CHECK (discount_pct BETWEEN 1 AND 50)
);

INSERT INTO promo_test VALUES ('FALL10', 10);

-- Predict, then run
-- Prediction: It will fail because 60 is more than 50.
INSERT INTO promo_test VALUES ('HALFOFF', 60);
-- Result: Error Code 3819. Check constraint 'chk_discount_range' is violated.

SELECT * FROM promo_test;
SHOW TABLES;
-- promo_test is not listed because it is a temporary table.

-- Task 4.2: Drop a table (safely)
-- (a) Predict, then run
-- Prediction: It will fail because product still references category.
DROP TABLE category;
-- Result: Error Code 3730. Cannot drop table 'category' referenced by a foreign key constraint

-- (b) Drop the scratch table
DROP TABLE promo_test;

-- (c) Prove it is gone
SELECT * FROM promo_test;
-- Result: Error Code 1146. Table 'beanbrew_dev.promo_test' doesn't exist

