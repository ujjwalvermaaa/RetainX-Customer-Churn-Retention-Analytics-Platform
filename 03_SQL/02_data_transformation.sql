/* ======================================================================================
Project        : RetainX – Customer Revenue & Subscription Retention Intelligence System
Client         : AirWave Communications (Telecom Domain)
Author         : Ujjwal Verma
File Name      : data_transformation.sql

Purpose:
---------
This script performs feature engineering on the base customer table by:
- Creating revenue-based customer segmentation
- Engineering a composite usage score
- Categorizing customers based on usage behavior

These features are used for:
- Customer segmentation
- Churn analysis
- Revenue-at-risk identification
- Power BI dashboards

Target Table:
-------------
retainx_customer_raw (Curated / Feature-Enhanced Layer)

======================================================================================= */


-- =============================================================================
-- STEP 1: Revenue Segment Classification
-- Business Logic:
--   Customers are grouped into income-based segments using estimated salary
--   This enables revenue-sensitive churn and retention analysis
-- =============================================================================

ALTER TABLE retainx_customer_raw
ADD COLUMN IF NOT EXISTS revenue_segment VARCHAR(20);

UPDATE retainx_customer_raw
SET revenue_segment = CASE
    WHEN estimated_salary < 20000 THEN 'Low Income'
    WHEN estimated_salary BETWEEN 20000 AND 50000 THEN 'Middle Income'
    WHEN estimated_salary > 50000 THEN 'High Income'
END;


-- =============================================================================
-- STEP 2: Usage Score Feature Engineering
-- Business Logic:
--   A weighted usage score is created using customer engagement indicators:
--     - Calls Made  (25% weight)
--     - SMS Sent    (10% weight)
--     - Data Usage  (65% weight)
--
--   Higher weight is given to data usage as it is the primary revenue driver
--   in modern telecom subscription models.
-- =============================================================================
UPDATE retainx_customer_raw
SET
    calls_made = GREATEST(calls_made, 0),
    sms_sent   = GREATEST(sms_sent, 0),
    data_used  = GREATEST(data_used, 0);



ALTER TABLE retainx_customer_raw
ADD COLUMN IF NOT EXISTS usage_score NUMERIC;

UPDATE retainx_customer_raw
SET usage_score =
    (calls_made * 0.25) +
    (sms_sent * 0.10) +
    (data_used * 0.65);

SELECT
    MIN(usage_score) AS min_usage,
    MAX(usage_score) AS max_usage
FROM retainx_customer_raw;

-- =============================================================================
-- STEP 3: Usage Category Segmentation
-- Business Logic:
--   Customers are bucketed into Low / Medium / High usage groups
--   This supports churn-risk identification and engagement analysis
-- =============================================================================

ALTER TABLE retainx_customer_raw
ADD COLUMN IF NOT EXISTS usage_category VARCHAR(20);

UPDATE retainx_customer_raw
SET usage_category = CASE
    WHEN usage_score < 30 THEN 'Low'
    WHEN usage_score BETWEEN 30 AND 75 THEN 'Medium'
    WHEN usage_score > 75 THEN 'High'
END;


-- =============================================================================
-- STEP 4: Metadata Validation
-- Purpose:
--   Validate newly added feature columns and data types
-- =============================================================================

SELECT 
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'retainx_customer_raw'
ORDER BY ordinal_position;


-- =============================================================================
-- STEP 5: Data Preview
-- Purpose:
--   Sanity check feature values after transformation
-- =============================================================================

SELECT *
FROM retainx_customer_raw
LIMIT 20;
