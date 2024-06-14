-- Create database
CREATE DATABASE amazon;

USE amazon;

-- Products - pid, pname, price, stock, location (Mumbai or Delhi)
CREATE TABLE products
(
    pid INT(3) PRIMARY KEY,
    pname VARCHAR(50) NOT NULL,
    price INT(10) NOT NULL,
    stock INT(5),
    location VARCHAR(30) CHECK(location IN ('Mumbai','Delhi'))
);

-- Customer - cid, cname, age, addr
CREATE TABLE customer
(
    cid INT(3) PRIMARY KEY,
    cname VARCHAR(30) NOT NULL,
    age INT(3),
    addr VARCHAR(50)
);

-- Orders - oid, cid, pid, amt
CREATE TABLE orders
(
    oid INT(3) PRIMARY KEY,
    cid INT(3),
    pid INT(3),
    amt INT(10) NOT NULL,
    FOREIGN KEY (cid) REFERENCES customer(cid),
    FOREIGN KEY (pid) REFERENCES products(pid)
);

-- Payment - pay_id, oid, amount, mode (upi, credit, debit), status
CREATE TABLE payment
(
    pay_id INT(3) PRIMARY KEY,
    oid INT(3),
    amount INT(10) NOT NULL,
    mode VARCHAR(30) CHECK(mode IN ('upi','credit','debit')),
    status VARCHAR(30),
    FOREIGN KEY (oid) REFERENCES orders(oid)
);
-- Insert values into the products table
INSERT INTO products (pid, pname, price, stock, location) VALUES 
(101, 'Laptop', 60000, 10, 'Mumbai'),
(102, 'Smartphone', 30000, 20, 'Delhi'),
(103, 'Headphones', 2000, 50, 'Mumbai'),
(104, 'Monitor', 15000, 15, 'Delhi'),
(105, 'Keyboard', 1000, 30, 'Mumbai');

-- Insert values into the customer table
INSERT INTO customer (cid, cname, age, addr) VALUES 
(201, 'John Doe', 30, '123 Street, Mumbai'),
(202, 'Jane Smith', 25, '456 Avenue, Delhi'),
(203, 'Michael Johnson', 35, '789 Boulevard, Mumbai'),
(204, 'Emily Davis', 28, '1010 Circle, Delhi'),
(205, 'Daniel Brown', 40, '1111 Square, Mumbai');

-- Insert values into the orders table
INSERT INTO orders (oid, cid, pid, amt) VALUES 
(301, 201, 101, 60000),
(302, 202, 102, 30000),
(303, 203, 103, 2000),
(304, 204, 104, 15000),
(305, 205, 105, 1000);

-- Insert values into the payment table
INSERT INTO payment (pay_id, oid, amount, mode, status) VALUES 
(401, 301, 60000, 'credit', 'Completed'),
(402, 302, 30000, 'debit', 'Completed'),
(403, 303, 2000, 'upi', 'Pending'),
(404, 304, 15000, 'credit', 'Completed'),
(405, 305, 1000, 'debit', 'Pending');

-- Select all products
SELECT * FROM products;

-- Select all customers
SELECT * FROM customer;

-- Select all orders
SELECT * FROM orders;

-- Select all payments
SELECT * FROM payment;

-- Update stock of Laptop (pid = 101) in Mumbai
UPDATE products SET stock = 12 WHERE pid = 101 AND location = 'Mumbai';
select * from products;

-- Update age of Jane Smith (cid = 202)
UPDATE customer SET age = 26 WHERE cid = 202;
select * from customer;

-- Delete an order (oid = 303) and associated payment
DELETE FROM payment WHERE oid = 303;
select * from payment

DELETE FROM orders WHERE oid = 303;
select * from orders;

-- Delete a customer (cid = 204) and associated orders and payments
DELETE FROM orders WHERE cid = 204;
DELETE FROM payment WHERE oid IN (SELECT oid FROM orders WHERE cid = 204);
DELETE FROM customer WHERE cid = 204;

-- Add a new column 'email' to the customer table
ALTER TABLE customer
ADD COLUMN email VARCHAR(50);
select * from customer;

-- Modify the datatype of the 'amt' column in orders table
ALTER TABLE orders
MODIFY COLUMN amt DECIMAL(12, 2);
select * from orders;

-- Rename the 'status' column in payment table to 'payment_status'
ALTER TABLE payment
CHANGE COLUMN status payment_status VARCHAR(30);
select * from payment;

-- Truncate the orders table (removes all data but keeps the structure)
TRUNCATE TABLE orders;

-- Drop the tables in reverse order of creation to avoid foreign key constraints issues

DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS products;

-- Drop the database amazon
DROP DATABASE IF EXISTS amazon;

-- Arithmetic Operators Examples:

-- Addition
SELECT 10 + 5;

-- Subtraction
SELECT 20 - 8;

-- Multiplication
SELECT 5 * 4;

-- Division
SELECT 20 / 4;

-- Modulo
SELECT 15 % 4;

-- Logical Operators Examples:

-- AND
SELECT * FROM products WHERE location = 'Mumbai' AND stock > 20;

-- OR
SELECT * FROM products WHERE location = 'Delhi' OR price > 20000;

-- NOT
SELECT * FROM customer WHERE NOT age > 30;

-- IN
SELECT * FROM products WHERE location IN ('Mumbai', 'Delhi');

-- BETWEEN
SELECT * FROM orders WHERE amt BETWEEN 1000 AND 5000;

-- LIKE
SELECT * FROM customer WHERE cname LIKE 'J%';

-- IS NULL
SELECT * FROM customer WHERE addr IS NULL;
