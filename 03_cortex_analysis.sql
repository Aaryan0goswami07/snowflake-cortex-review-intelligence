-- ============================================================
-- CORTEX LLM ANALYSIS — All 5 functions demonstrated
-- Run each block individually, screenshot each result
-- ============================================================

USE DATABASE REVIEW_INTELLIGENCE_DB;
USE WAREHOUSE CORTEX_WH;
USE SCHEMA RAW;

-- ============================================================
-- BLOCK 1: SENTIMENT ANALYSIS
-- Returns a score from -1 (very negative) to +1 (very positive)
-- Real use case: automatically flag bad reviews for support team
-- ============================================================

-- 1. SENTIMENT ANALYSIS - Score + Label (optimized single call)
WITH scored AS (
    SELECT
        review_id,
        review_text,
        review_language,
        star_rating,
        ROUND(SNOWFLAKE.CORTEX.SENTIMENT(review_text), 3) AS sentiment_score
    FROM product_reviews
    WHERE review_language = 'en'
)
SELECT
    review_id,
    review_text,
    review_language,
    star_rating,
    sentiment_score,
    CASE
        WHEN sentiment_score > 0.3 THEN 'Positive'
        WHEN sentiment_score < -0.3 THEN 'Negative'
        ELSE 'Neutral'
    END AS sentiment_label
FROM scored
ORDER BY sentiment_score ASC;


-- ============================================================
-- BLOCK 2: TRANSLATE
-- Translate non-English reviews to English automatically
-- Real use case: global product teams reading all reviews
-- ============================================================

SELECT
    review_id,
    reviewer_name,
    review_language,
    review_text                                  AS original_review,
    SNOWFLAKE.CORTEX.TRANSLATE(
        review_text,
        review_language,
        'en'
    )                                            AS translated_to_english
FROM product_reviews
WHERE review_language != 'en'
ORDER BY review_id;


-- ============================================================
-- BLOCK 3: SUMMARIZE
-- Condense long reviews into 1-2 sentences
-- Real use case: product managers reading 1000s of reviews
-- ============================================================
-- Summarize all reviews by translating non-English ones first
SELECT
    review_id,
    review_text,
    review_language,
    SNOWFLAKE.CORTEX.SUMMARIZE(
        CASE
            WHEN review_language = 'en' THEN review_text
            ELSE SNOWFLAKE.CORTEX.TRANSLATE(review_text, review_language, 'en')
        END
    ) AS summary
FROM product_reviews;


-- ============================================================
-- BLOCK 4: EXTRACT_ANSWER
-- Pull specific facts out of unstructured text
-- Real use case: automatically extract issue details, dates, prices
-- ============================================================

SELECT
    review_id,
    product_name,
    reviewer_name,

    -- Extract the specific problem mentioned
    SNOWFLAKE.CORTEX.EXTRACT_ANSWER(
        review_text,
        'What is the main problem or issue mentioned?'
    )                                            AS extracted_problem,

    -- Extract any price mentioned
    SNOWFLAKE.CORTEX.EXTRACT_ANSWER(
        review_text,
        'What price or amount of money is mentioned?'
    )                                            AS extracted_price,

    -- Extract any date mentioned
    SNOWFLAKE.CORTEX.EXTRACT_ANSWER(
        review_text,
        'What date or time period is mentioned?'
    )                                            AS extracted_date

FROM product_reviews
WHERE review_language = 'en'
  AND star_rating <= 3
ORDER BY star_rating ASC;


-- ============================================================
-- BLOCK 5: COMPLETE — Prompt engineering with model selection
-- This is the most powerful function — free-form generation
-- Demonstrating 3 different prompts + 2 different models
-- ============================================================

-- 5A: Using mistral-large — generate a support response
SELECT
    review_id,
    product_name,
    star_rating,
    LEFT(review_text, 80)                        AS review_preview,
    SNOWFLAKE.CORTEX.COMPLETE(
        'mistral-large',
        CONCAT(
            'You are a customer support agent for an Indian e-commerce company. ',
            'A customer left this review: "', review_text, '" ',
            'Write a short, empathetic response under 60 words. ',
            'Acknowledge their concern and offer a solution.'
        )
    )                                            AS support_response_mistral
FROM product_reviews
WHERE review_language = 'en'
  AND star_rating <= 2
ORDER BY review_id;


-- 5B: Using llama3.1-8b — classify review into action category
-- Smaller model, faster, cheaper — good for classification tasks
SELECT
    review_id,
    product_name,
    star_rating,
    SNOWFLAKE.CORTEX.COMPLETE(
        'llama3.1-8b',
        CONCAT(
            'Classify this product review into exactly one category. ',
            'Categories: REFUND_REQUIRED, ESCALATE_TO_SUPPORT, PRODUCT_DEFECT, POSITIVE_FEEDBACK, MONITOR_ONLY. ',
            'Reply with only the category name, nothing else. ',
            'Review: "', review_text, '"'
        )
    )                                            AS action_category
FROM product_reviews
WHERE review_language = 'en'
ORDER BY review_id;


-- 5C: Using claude — generate a product improvement suggestion
-- Demonstrates Anthropic model access inside Snowflake
SELECT
    product_name,
    COUNT(*)                                     AS review_count,
    ROUND(AVG(star_rating), 1)                   AS avg_rating,
    SNOWFLAKE.CORTEX.COMPLETE(
        'claude-3-5-sonnet',
        CONCAT(
            'Based on these product reviews, suggest 3 specific improvements. ',
            'Be concise and actionable. Product: ', product_name, '. ',
            'Reviews: ',
            LISTAGG(LEFT(review_text, 500), ' | ') WITHIN GROUP (ORDER BY review_id)
        )
    )                                            AS improvement_suggestions
FROM product_reviews
WHERE review_language = 'en'
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY avg_rating ASC;

