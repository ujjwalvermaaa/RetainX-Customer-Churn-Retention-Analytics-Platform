/* ======================================================================================
Project        : RetainX – Customer Revenue & Subscription Retention Intelligence System
Client         : AirWave Communications (Telecom Domain)
Author         : Ujjwal Verma
File Name      : derived_tables.sql

Purpose:
---------
This script builds the ANALYTICAL (GOLD) layer by:
1. Creating customer lifecycle and retention segments
2. Producing a unified analytics table for BI and reporting

These derived tables:
- Translate raw data into business-ready insights
- Serve as the single source of truth for Power BI dashboards
- Enable churn, retention, and revenue intelligence

Source Table:
-------------
retainx_customer_raw (Feature-Enhanced Curated Layer)

======================================================================================== */


-- =============================================================================
-- STEP 1: Customer Retention & Lifecycle Segmentation Table
-- Business Logic:
--   Customers are classified into lifecycle segments using:
--     - Churn status
--     - Tenure duration
--     - Usage behavior
--
-- Segments Created:
--   1. Churned Customer : Already exited
--   2. New Customer     : Recently onboarded (< 6 months)
--   3. At Risk          : Active but low engagement
--   4. Loyal Customer   : Active and highly engaged
--
-- This table enables:
--   - Segment-level churn analysis
--   - Retention prioritization
-- =============================================================================

DROP TABLE IF EXISTS retainx_retention_segments;

CREATE TABLE retainx_retention_segments AS
SELECT
    customer_id,
    churn,
    tenure_months,
    revenue_segment,
    usage_score,
    usage_category,

    CASE
        WHEN churn = 1 THEN 'Churned Customer'
        WHEN churn = 0 AND tenure_months < 6 THEN 'New Customer'
        WHEN churn = 0 AND tenure_months >= 6 AND usage_score < 30 THEN 'At Risk'
        WHEN churn = 0 AND tenure_months >= 6 AND usage_score >= 30 THEN 'Loyal Customer'
    END AS customer_segment

FROM retainx_customer_raw;


-- =============================================================================
-- STEP 2: Final Analytical GOLD Table Creation
-- Business Logic:
--   Combines segmentation data with customer attributes to create
--   a single, analytics-ready dataset.
--
-- This table is used by:
--   - Power BI dashboards
--   - Business queries
--   - EDA & insight generation
--
-- Design Principle:
--   One row per customer with all analytical attributes
-- =============================================================================

DROP TABLE IF EXISTS retainx_customer_analytics;

CREATE TABLE retainx_customer_analytics AS
SELECT
    r.customer_id,
    r.customer_segment,
    r.usage_score,
    r.usage_category,
    r.revenue_segment,
    r.tenure_months,

    -- Demographic & geographic attributes
    c.gender,
    c.age,
    c.state,
    c.city,

    -- Financial & behavioral attributes
    c.estimated_salary,
    c.churn,
    c.calls_made,
    c.sms_sent,
    c.data_used

FROM retainx_retention_segments r
INNER JOIN retainx_customer_raw c
    ON r.customer_id = c.customer_id;


-- =============================================================================
-- STEP 3: DATA QUALITY & VALIDATION CHECKS
-- Purpose:
--   Ensure data integrity across layers before BI consumption
-- =============================================================================

-- Row count consistency check across layers
SELECT
    (SELECT COUNT(*) FROM retainx_customer_raw)          AS raw_count,
    (SELECT COUNT(*) FROM retainx_retention_segments)   AS segment_count,
    (SELECT COUNT(*) FROM retainx_customer_analytics)   AS analytics_count;


-- Segment distribution validation
SELECT 
    customer_segment,
    COUNT(*) AS customer_count
FROM retainx_retention_segments
GROUP BY customer_segment
ORDER BY customer_count DESC;


-- Sample data preview for sanity check
SELECT *
FROM retainx_customer_analytics
LIMIT 20;
