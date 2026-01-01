/* ======================================================================================
Project        : RetainX – Customer Revenue & Subscription Retention Intelligence System
Client         : AirWave Communications (Telecom Domain)
Author         : Ujjwal Verma
File Name      : create_database_and_tables.sql

Purpose:
---------
1. Create the project database used for retention analytics.
2. Create the base customer table (RAW / CURATED layer).
3. This table serves as the primary source for all downstream
   transformations, feature engineering, and analytical modeling.

Usage:
-------
- Execute this script once during project setup.
- Data will be loaded into retainx_customer_raw after creation.
- Subsequent SQL scripts depend on this table.

========================================================================================= */


-- =============================================================================
-- STEP 1: Create Project Database
-- Business Context:
--   This database stores all data related to customer retention analytics
--   for AirWave Communications.
-- =============================================================================

CREATE DATABASE retainx_airwave;


-- =============================================================================
-- STEP 2: Create Base Customer Table (Raw Curated Layer)
-- Business Context:
--   This table represents the cleaned and standardized customer dataset
--   loaded from Python preprocessing.
--
--   It acts as the RAW / CURATED layer in the analytics pipeline.
--   No business logic or segmentation is applied at this stage.
--
-- Table Characteristics:
--   - One record per customer
--   - Primary key ensures uniqueness
--   - Contains demographic, usage, revenue, and churn indicators
-- =============================================================================

CREATE TABLE IF NOT EXISTS retainx_customer_raw (
    
    -- Unique identifier for each customer
    customer_id VARCHAR(50) PRIMARY KEY,
    
    -- Telecom service provider associated with the customer
    telecom_partner VARCHAR(50),
    
    -- Customer demographic attributes
    gender VARCHAR(15),
    age INT,
    
    -- Geographic attributes
    state VARCHAR(100),
    city VARCHAR(100),
    pincode VARCHAR(20),
    
    -- Customer lifecycle information
    date_of_registration DATE,
    tenure_months INT,
    
    -- Household information
    num_dependents INT,
    
    -- Financial attribute representing estimated income / ARPU proxy
    estimated_salary NUMERIC(12,2),
    
    -- Usage behavior metrics
    calls_made INT,
    sms_sent INT,
    data_used NUMERIC(12,2),
    
    -- Churn flag
    -- 0 = Active Customer
    -- 1 = Churned Customer
    churn INT
);


-- =============================================================================
-- STEP 3: Basic Validation Check
-- Purpose:
--   Verify table creation and data load status
-- =============================================================================

SELECT *
FROM retainx_customer_raw
LIMIT 10;
