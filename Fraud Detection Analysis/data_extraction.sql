-- ====================================================================
-- PROJECT 1: TRANSACTIONAL FRAUD DETECTION ANALYSIS
-- SQL Data Extraction and Business Analytics Queries
-- ====================================================================

-- --------------------------------------------------------------------
-- QUERY 1: Executive KPI Overview
-- Calculates total volume, fraudulent volume, and overall fraud rate.
-- --------------------------------------------------------------------
SELECT 
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN Class = 0 THEN 1 ELSE 0 END) AS legitimate_transactions,
    ROUND(AVG(CASE WHEN Class = 1 THEN 1.0 ELSE 0.0 END) * 100, 3) AS fraud_rate_percentage,
    ROUND(SUM(Amount), 2) AS total_transaction_volume,
    ROUND(SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END), 2) AS total_fraud_amount,
    ROUND(SUM(CASE WHEN Class = 0 THEN Amount ELSE 0 END), 2) AS total_legitimate_amount
FROM transactions;


-- --------------------------------------------------------------------
-- QUERY 2: Transaction Amount Comparison (Fraud vs. Legitimate)
-- Compares average, maximum, and minimum spend between both classes.
-- --------------------------------------------------------------------
SELECT 
    CASE WHEN Class = 1 THEN 'Fraudulent (Class 1)' ELSE 'Legitimate (Class 0)' END AS transaction_type,
    COUNT(*) AS transaction_count,
    ROUND(AVG(Amount), 2) AS avg_amount,
    ROUND(MIN(Amount), 2) AS min_amount,
    ROUND(MAX(Amount), 2) AS max_amount,
    ROUND(SUM(Amount), 2) AS total_amount
FROM transactions
GROUP BY Class;


-- --------------------------------------------------------------------
-- QUERY 3: Hourly Fraud Trend Analysis
-- Calculates the hour of day from elapsed seconds and measures fraud rate per hour.
-- --------------------------------------------------------------------
SELECT 
    (CAST(Time / 3600 AS INT) % 24) AS hour_of_day,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(AVG(CASE WHEN Class = 1 THEN 1.0 ELSE 0.0 END) * 100, 3) AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END), 2) AS fraud_loss_usd
FROM transactions
GROUP BY hour_of_day
ORDER BY hour_of_day ASC;


-- --------------------------------------------------------------------
-- QUERY 4: High-Value vs. Low-Value Transaction Fraud Risk
-- Categorizes transactions into spend buckets to see where fraud concentrates.
-- --------------------------------------------------------------------
SELECT 
    CASE 
        WHEN Amount < 10 THEN 'Micro (< $10)'
        WHEN Amount BETWEEN 10 AND 100 THEN 'Low ($10 - $100)'
        WHEN Amount BETWEEN 100 AND 500 THEN 'Medium ($100 - $500)'
        WHEN Amount BETWEEN 500 AND 1000 THEN 'High ($500 - $1000)'
        ELSE 'Very High (> $1000)'
    END AS amount_tier,
    COUNT(*) AS total_count,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(AVG(CASE WHEN Class = 1 THEN 1.0 ELSE 0.0 END) * 100, 3) AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END), 2) AS total_stolen_amount
FROM transactions
GROUP BY amount_tier
ORDER BY total_count DESC;


-- --------------------------------------------------------------------
-- QUERY 5: Feature Extraction for Predictive Modeling Pipeline
-- Extracts all normalized features along with derived hour of day.
-- --------------------------------------------------------------------
SELECT 
    (CAST(Time / 3600 AS INT) % 24) AS HourOfDay,
    Amount,
    V1, V2, V3, V4, V5, V6, V7, V8, V9, V10,
    V11, V12, V13, V14, V15, V16, V17, V18, V19, V20,
    V21, V22, V23, V24, V25, V26, V27, V28,
    Class
FROM transactions;
