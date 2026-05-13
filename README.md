# Customer Review Intelligence System
### Built with Snowflake Cortex LLM Functions

A real-world GenAI project that applies every major Snowflake Cortex function to automate product review analysis — sentiment scoring, translation, summarisation, fact extraction, and AI-generated responses.

Built after completing **Introduction to Generative AI with Snowflake** (Coursera).

---

## What this project does

Takes raw customer reviews in multiple languages and transforms them into structured, actionable intelligence — entirely inside Snowflake using SQL. No Python, no external APIs, no data leaving Snowflake.

---

## Cortex functions used

| Function | What it does | Business use case |
|---|---|---|
| `SENTIMENT` | Returns score -1 to +1 | Flag bad reviews automatically |
| `TRANSLATE` | Converts any language to English | Read Hindi/Spanish/French reviews |
| `SUMMARIZE` | Condenses long reviews | Product managers scan 1000s of reviews |
| `EXTRACT_ANSWER` | Pulls specific facts from text | Extract prices, dates, issues mentioned |
| `COMPLETE` (mistral-large) | Generate support responses | Auto-draft empathetic replies to complaints |
| `COMPLETE` (llama3.1-8b) | Classify reviews into action categories | Route issues to correct team |
| `COMPLETE` (claude-3-5-sonnet) | Product improvement suggestions | Weekly product team briefings |

---

## Project structure

```
cortex-review-intelligence/
├── 01_setup.sql           # Warehouse, database, schema, table
├── 02_seed_data.sql       # 15 reviews across 4 languages
├── 03_cortex_analysis.sql # All 5 Cortex functions demonstrated
├── 04_insights_view.sql   # Master AI dashboard view
└── README.md
```

---

## How to run

### Step 1 — Free Snowflake account
Sign up at snowflake.com (30-day free trial, no card needed).

### Step 2 — Open a Worksheet
Projects → Worksheets → + → SQL Worksheet

### Step 3 — Run in order
1. `01_setup.sql` — creates all objects
2. `02_seed_data.sql` — loads 15 reviews
3. `03_cortex_analysis.sql` — run each block individually (select block → Ctrl+Enter)
4. `04_insights_view.sql` — creates and queries the master dashboard

---

## Key design decisions

**Why three different models in COMPLETE?**

- `mistral-large` — best for nuanced, empathetic text generation (support responses)
- `llama3.1-8b` — smaller, faster, cheaper — ideal for simple classification tasks
- `claude-3-5-sonnet` — strongest reasoning for complex analysis tasks

This demonstrates the model selection principle from the course: match model size to task complexity to balance cost and quality.

**Why TRANSLATE before SENTIMENT?**

Cortex SENTIMENT is optimised for English. Running it directly on Hindi or Spanish text gives unreliable scores. Translating first then scoring gives accurate results — a real production pattern.

**Why create a VIEW in Block 4?**

In production, a data analyst doesn't run 5 separate queries. They query one view that does all the AI processing transparently. The `review_intelligence_dashboard` view is what you'd actually deliver to a product team.

---

## Sample outputs

**SENTIMENT on negative review:**
> "The desk arrived with a scratch... I expected better quality" → Score: **-0.72** → Label: Negative

**TRANSLATE (Hindi → English):**
> "यह लैपटॉप बहुत अच्छा है..." → "This laptop is very good. The battery lasts a long time..."

**COMPLETE (mistral-large) support response:**
> "Dear Sneha, we're truly sorry your desk arrived damaged. This is not the experience we want for you. Please contact us at returns@store.com and we'll arrange an immediate replacement or full refund."

**EXTRACT_ANSWER:**
> Review mentions "contacted support on January 5th" → extracted date: **January 5th**

---

## What I learned

- Cortex LLM functions run directly in SQL — no Python or external API calls needed
- Smaller models (`llama3.1-8b`) are faster and cheaper for classification; larger models (`mistral-large`, `claude`) produce better quality for generation tasks
- The `COMPLETE` function's power comes from prompt engineering — the same function with a different prompt does classification, generation, or analysis
- Production AI pipelines translate → normalise → then apply AI functions, not the other way around
- Snowflake keeps all data within its governance boundary — no reviews leave the platform

---

## Built by
**Aaryan Goswami** — BBA Business Analytics, Manipal University Jaipur
Backtesting Lead @ AperioHub (Singapore) | Building toward AI + Analytics career
[LinkedIn](https://linkedin.com/in/aaryan-goswami-058920240) · [GitHub](https://github.com/Aaryan0goswami07)
