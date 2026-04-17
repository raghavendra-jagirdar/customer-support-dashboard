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
SELECT 
SUM(CASE WHEN ticket_status = 'Closed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS resolution_rate
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
SELECT 
DATE_FORMAT(date_of_purchase, '%Y-%m') AS month,
COUNT(*) AS total_tickets
FROM customer_support_tickets
GROUP BY DATE_FORMAT(date_of_purchase, '%Y-%m')
ORDER BY month;

-- Avg Resolution Time by Priority
SELECT 
ticket_priority,
AVG(TIMESTAMPDIFF(HOUR, date_of_purchase, time_to_resolution)) AS avg_resolution_hours
FROM customer_support_tickets
GROUP BY ticket_priority
ORDER BY avg_resolution_hours DESC;

-- =========================
-- ADVANCED ANALYSIS
-- =========================

-- Channel Ranking by Resolution Time (WINDOW FUNCTION)
SELECT 
ticket_channel,
AVG(TIMESTAMPDIFF(HOUR, date_of_purchase, time_to_resolution)) AS avg_resolution_hours,
RANK() OVER (ORDER BY AVG(TIMESTAMPDIFF(HOUR, date_of_purchase, time_to_resolution)) DESC) AS rank_by_resolution_time
FROM customer_support_tickets
GROUP BY ticket_channel;

-- Priority Performance Analysis using CTE
WITH priority_analysis AS (
    SELECT 
        ticket_priority,
        COUNT(*) AS total_tickets,
        SUM(CASE WHEN ticket_status = 'Closed' THEN 1 ELSE 0 END) AS resolved_tickets,
        AVG(TIMESTAMPDIFF(HOUR, date_of_purchase, time_to_resolution)) AS avg_resolution_hours
    FROM customer_support_tickets
    GROUP BY ticket_priority
)
SELECT 
    ticket_priority,
    total_tickets,
    resolved_tickets,
    resolved_tickets * 100.0 / total_tickets AS resolution_rate,
    avg_resolution_hours
FROM priority_analysis
ORDER BY avg_resolution_hours DESC;

-- Tickets with SLA Breach
SELECT 
ticket_id,
ticket_priority,
TIMESTAMPDIFF(HOUR, first_response_time, NOW()) AS pending_hours
FROM customer_support_tickets
WHERE time_to_resolution IS NULL
AND first_response_time IS NOT NULL
AND TIMESTAMPDIFF(HOUR, first_response_time, NOW()) > 48;
