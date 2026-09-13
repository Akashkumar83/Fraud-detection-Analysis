-- ====================================================================
-- PostgreSQL Setup Script for pgAdmin 4
-- Database: fraud_db
-- ====================================================================

-- Step 1: Create Table in pgAdmin Query Tool
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    Time NUMERIC,
    V1 NUMERIC,
    V2 NUMERIC,
    V3 NUMERIC,
    V4 NUMERIC,
    V5 NUMERIC,
    V6 NUMERIC,
    V7 NUMERIC,
    V8 NUMERIC,
    V9 NUMERIC,
    V10 NUMERIC,
    V11 NUMERIC,
    V12 NUMERIC,
    V13 NUMERIC,
    V14 NUMERIC,
    V15 NUMERIC,
    V16 NUMERIC,
    V17 NUMERIC,
    V18 NUMERIC,
    V19 NUMERIC,
    V20 NUMERIC,
    V21 NUMERIC,
    V22 NUMERIC,
    V23 NUMERIC,
    V24 NUMERIC,
    V25 NUMERIC,
    V26 NUMERIC,
    V27 NUMERIC,
    V28 NUMERIC,
    Amount NUMERIC,
    Class INT
);

-- Step 2: Create indexes for ultra-fast query execution
CREATE INDEX idx_transactions_class ON transactions(Class);
CREATE INDEX idx_transactions_time ON transactions(Time);

-- ====================================================================
-- Verification Query (Run this after loading data)
-- ====================================================================
SELECT 
    COUNT(*) AS total_records,
    COUNT(CASE WHEN Class = 1 THEN 1 END) AS fraud_records,
    ROUND(AVG(Amount), 2) AS avg_amount
FROM transactions;
