-- ============================================================
-- PROJECT: Customer Review Intelligence System
-- Using Snowflake Cortex LLM Functions
-- By Aaryan Goswami
-- Concepts: COMPLETE, SENTIMENT, SUMMARIZE, TRANSLATE,
--           EXTRACT_ANSWER, prompt engineering, model selection
-- ============================================================

CREATE WAREHOUSE IF NOT EXISTS CORTEX_WH
  WAREHOUSE_SIZE = 'X-SMALL'
  AUTO_SUSPEND   = 60
  AUTO_RESUME    = TRUE;

USE WAREHOUSE CORTEX_WH;

CREATE DATABASE IF NOT EXISTS REVIEW_INTELLIGENCE_DB;
USE DATABASE REVIEW_INTELLIGENCE_DB;

CREATE SCHEMA IF NOT EXISTS RAW;
CREATE SCHEMA IF NOT EXISTS AI_INSIGHTS;

USE SCHEMA RAW;

-- Product reviews table
-- Simulates real e-commerce review data
CREATE OR REPLACE TABLE product_reviews (
    review_id       INT PRIMARY KEY,
    product_name    VARCHAR(100),
    category        VARCHAR(50),
    reviewer_name   VARCHAR(50),
    review_language VARCHAR(10),  -- 'en', 'hi', 'es', 'fr'
    review_text     TEXT,
    star_rating     INT,          -- 1 to 5
    review_date     DATE
);
