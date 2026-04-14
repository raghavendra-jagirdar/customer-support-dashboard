-- =========================
-- DATABASE SETUP
-- =========================
CREATE DATABASE support_db;
USE support_db;

-- =========================
-- TABLE CREATION
-- =========================
CREATE TABLE customer_support_tickets (
ticket_id INT PRIMARY KEY,
customer_name VARCHAR(255),
customer_email VARCHAR(255),
customer_age INT,
customer_gender VARCHAR(50),
product_purchased VARCHAR(255),
date_of_purchase DATE,
ticket_type VARCHAR(100),
ticket_subject VARCHAR(255),
ticket_description TEXT,
ticket_status VARCHAR(100),
resolution TEXT,
ticket_priority VARCHAR(50),
ticket_channel VARCHAR(100),
first_response_time DATETIME,
time_to_resolution DATETIME,
customer_satisfaction_rating DECIMAL(3,2)
);

-- =========================
-- KEY METRICS
-- =========================

-- Total Tickets
SELECT COUNT(*) AS total_tickets
FROM customer_support_tickets;

-- Resolved Tickets
SELECT COUNT(*) AS resolved_tickets
FROM customer_support_tickets
WHERE ticket_status = 'Closed';

-- Resolution Rate
SELECT COUNT(CASE WHEN ticket_status = 'Closed' THEN 1 END) * 100.0 / COUNT(*) AS resolution_rate
FROM customer_support_tickets;

-- Avg Customer Satisfaction
SELECT AVG(customer_satisfaction_rating) AS avg_rating
FROM customer_support_tickets
WHERE customer_satisfaction_rating IS NOT NULL;

-- =========================
-- ANALYSIS
-- =========================

-- Tickets by Priority
SELECT ticket_priority, COUNT(*) AS total_tickets
FROM customer_support_tickets
GROUP BY ticket_priority
ORDER BY total_tickets DESC;

-- Tickets by Channel
SELECT ticket_channel, COUNT(*) AS total_tickets
FROM customer_support_tickets
GROUP BY ticket_channel
ORDER BY total_tickets DESC;

-- Satisfaction by Channel
SELECT ticket_channel, AVG(customer_satisfaction_rating) AS avg_rating
FROM customer_support_tickets
GROUP BY ticket_channel
ORDER BY avg_rating DESC;

-- Monthly Trend
SELECT DATE_FORMAT(date_of_purchase, '%Y-%m') AS month,
COUNT(*) AS total_tickets
FROM customer_support_tickets
GROUP BY month
ORDER BY month;

