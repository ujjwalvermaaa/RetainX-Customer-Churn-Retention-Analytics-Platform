/* ======================================================================================
Project        : RetainX – Customer Revenue & Subscription Retention Intelligence System
Client         : AirWave Communications (Telecom Domain)
Author         : Ujjwal Verma
File Name      : business_queries.sql

Purpose:
---------
This file contains business-facing analytical SQL queries used to:
- Answer KPIs defined in the Business Requirement Document (BRD)
- Support Power BI dashboards
- Enable churn, revenue, and retention decision-making

Data Source:
------------
retainx_customer_analytics (Analytical / GOLD layer)

Usage:
-------
- Queries are used directly in analysis and Power BI validation
- Logic mirrors metrics shown on dashboards
======================================================================================== */


-- =============================================================================
-- 1. OVERALL CHURN RATE
-- Business Question:
--   What percentage of customers have churned overall?
-- KPI Usage:
--   Executive dashboard (Top-level retention health)
-- =============================================================================
SELECT 
    ROUND(
        (SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)::NUMERIC / COUNT(*)) * 100,
        2
    ) AS churn_rate_percentage
FROM retainx_customer_analytics;


-- =============================================================================
-- 2. CHURN RATE BY CUSTOMER SEGMENT
-- Business Question:
--   Which customer segments contribute most to churn?
-- Insight Usage:
--   Segment-level retention prioritization
-- =============================================================================
SELECT 
    customer_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),
        2
    ) AS churn_rate
FROM retainx_customer_analytics
GROUP BY customer_segment
ORDER BY churn_rate DESC;


-- =============================================================================
-- 3. CHURN BY GEOGRAPHY (STATE LEVEL)
-- Business Question:
--   Are certain regions experiencing higher customer attrition?
-- Insight Usage:
--   Geo-focused retention and service improvement strategies
-- =============================================================================
SELECT 
    state,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),
        2
    ) AS churn_rate
FROM retainx_customer_analytics
GROUP BY state
ORDER BY churn_rate DESC;


-- =============================================================================
-- 4. REVENUE LOST DUE TO CHURN
-- Business Question:
--   What is the total estimated revenue impact of churned customers?
-- KPI Usage:
--   Revenue-at-risk and financial impact assessment
-- =============================================================================
SELECT 
    ROUND(SUM(estimated_salary), 2) AS total_revenue_loss
FROM retainx_customer_analytics
WHERE churn = 1;


-- =============================================================================
-- 5. CHURN PROBABILITY BY REVENUE SEGMENT
-- Business Question:
--   How does churn vary across income / revenue segments?
-- Insight Usage:
--   Revenue-sensitive retention planning
-- =============================================================================
SELECT 
    revenue_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),
        2
    ) AS churn_rate
FROM retainx_customer_analytics
GROUP BY revenue_segment
ORDER BY churn_rate DESC;


-- =============================================================================
-- 6. HIGH-VALUE AT-RISK CUSTOMERS
-- Business Question:
--   Which high-income customers are currently at risk of churn?
-- Insight Usage:
--   Priority list for targeted retention campaigns
-- =============================================================================
SELECT 
    customer_id,
    estimated_salary,
    usage_score,
    usage_category,
    tenure_months,
    customer_segment
FROM retainx_customer_analytics
WHERE customer_segment = 'At Risk'
  AND revenue_segment = 'High Income'
ORDER BY estimated_salary DESC;


-- =============================================================================
-- 7. USAGE BEHAVIOR VS CHURN
-- Business Question:
--   How does customer usage behavior correlate with churn?
-- Insight Usage:
--   Product engagement & behavioral intervention design
-- =============================================================================
SELECT 
    usage_category,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),
        2
    ) AS churn_rate
FROM retainx_customer_analytics
GROUP BY usage_category
ORDER BY churn_rate DESC;


-- =============================================================================
-- 8. TENURE IMPACT ON CHURN
-- Business Question:
--   How does customer tenure influence churn behavior?
-- Insight Usage:
--   Lifecycle-based retention strategies
-- =============================================================================
SELECT 
    tenure_months,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers
FROM retainx_customer_analytics
GROUP BY tenure_months
ORDER BY tenure_months ASC;


-- =============================================================================
-- 9. TOP REVENUE SAVING OPPORTUNITY (ACTIONABLE LIST)
-- Business Question:
--   Which customers should be targeted first to minimize revenue loss?
-- Insight Usage:
--   Immediate retention action planning
-- =============================================================================
SELECT 
    customer_id,
    estimated_salary,
    usage_score,
    tenure_months
FROM retainx_customer_analytics
WHERE customer_segment = 'At Risk'
ORDER BY estimated_salary DESC
LIMIT 50;
