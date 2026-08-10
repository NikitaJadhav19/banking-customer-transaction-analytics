-- Banking Customer & Transaction Analytics
-- Database: banking_analytics
-- Tables: customers, transactions

CREATE DATABASE IF NOT EXISTS banking_analytics;
USE banking_analytics;

-- 1. View all customers
SELECT * FROM customers;

-- 2. View all transactions
SELECT * FROM transactions;

-- 3. Transaction type summary
SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM transactions
GROUP BY transaction_type;

-- 4. Customer + transaction details using INNER JOIN
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.account_type,
    t.transaction_date,
    t.transaction_type,
    t.amount,
    t.balance
FROM customers c
INNER JOIN transactions t
    ON c.customer_id = t.customer_id;

-- 5. Top 5 customers by total transaction amount
SELECT
    c.customer_id,
    c.customer_name,
    SUM(t.amount) AS total_amount
FROM customers c
INNER JOIN transactions t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_amount DESC
LIMIT 5;

-- 6. Monthly transaction analysis
SELECT
    MONTH(transaction_date) AS month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM transactions
GROUP BY MONTH(transaction_date)
ORDER BY month;

-- 7. City-wise customer count
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- 8. Account type analysis
SELECT
    account_type,
    COUNT(*) AS total_customers
FROM customers
GROUP BY account_type
ORDER BY total_customers DESC;

-- 9. Deposit vs Withdrawal amount
SELECT
    transaction_type,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY transaction_type;

-- 10. Overall KPI values
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

SELECT
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_amount,
    AVG(amount) AS average_transaction
FROM transactions;
