-- ============================================================
-- BONUS: Create a master AI insights view
-- Combines everything into one table — the deliverable
-- This is what you'd hand to a product manager in real life
-- ============================================================

USE DATABASE REVIEW_INTELLIGENCE_DB;
USE SCHEMA AI_INSIGHTS;

CREATE OR REPLACE VIEW review_intelligence_dashboard AS
SELECT
    r.review_id,
    r.product_name,
    r.category,
    r.reviewer_name,
    r.star_rating,
    r.review_date,

    -- Translate everything to English first
    CASE
        WHEN r.review_language = 'en' THEN r.review_text
        ELSE SNOWFLAKE.CORTEX.TRANSLATE(r.review_text, r.review_language, 'en')
    END                                          AS review_in_english,

    -- Sentiment score on English text
    ROUND(SNOWFLAKE.CORTEX.SENTIMENT(
        CASE
            WHEN r.review_language = 'en' THEN r.review_text
            ELSE SNOWFLAKE.CORTEX.TRANSLATE(r.review_text, r.review_language, 'en')
        END
    ), 2)                                        AS sentiment_score,

    -- One-line summary
    SNOWFLAKE.CORTEX.SUMMARIZE(
        CASE
            WHEN r.review_language = 'en' THEN r.review_text
            ELSE SNOWFLAKE.CORTEX.TRANSLATE(r.review_text, r.review_language, 'en')
        END
    )                                            AS one_line_summary,

    -- Action classification using small fast model
    SNOWFLAKE.CORTEX.COMPLETE(
        'llama3.1-8b',
        CONCAT(
            'Classify into one: REFUND_REQUIRED, ESCALATE_TO_SUPPORT, PRODUCT_DEFECT, POSITIVE_FEEDBACK, MONITOR_ONLY. ',
            'Only reply the category. Review: "',
            CASE
                WHEN r.review_language = 'en' THEN r.review_text
                ELSE SNOWFLAKE.CORTEX.TRANSLATE(r.review_text, r.review_language, 'en')
            END,
            '"'
        )
    )                                            AS recommended_action

FROM REVIEW_INTELLIGENCE_DB.RAW.product_reviews r;


-- Query the final dashboard
SELECT * FROM review_intelligence_dashboard
ORDER BY sentiment_score ASC;

