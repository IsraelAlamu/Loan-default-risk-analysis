# Loan Default Risk Analysis

## Project Overview
This project analyzes personal loan performance data to identify the main factors driving loan defaults. The goal is to help lenders reduce risk, improve approval strategies, and make better lending decisions.

## Tools Used
- SQL (Data Cleaning & Analysis)
- Power BI (Dashboard & Visualization)
- Excel / CSV (Raw Data Source)

## Business Problem
The company identified a loan default rate higher than target levels. Management needed insights into borrower behavior, risk patterns, and loan characteristics causing higher defaults.

## Key Questions Answered
- What is the overall loan default rate?
- Which loan purpose has the highest default rate?
- How does credit score impact default risk?
- How does debt-to-income ratio affect defaults?
- Which loan terms show higher risk?
- Do higher loan amounts lead to more defaults?

## 💻 SQL Analysis

The SQL queries were used to clean, transform, and analyze loan application data to identify key factors influencing default risk.

Key SQL work included:
- Calculating overall default rate
- Segmenting customers by credit score ranges
- Aggregating loan performance metrics
- Identifying high-risk customer groups
- Preparing data for Power BI dashboard visualization

### 🔍 Sample Query

```sql
SELECT 
    SUM(CAST(defaulted AS INT)) AS Total_Default,
    COUNT(*) AS Total_Loans,
    ROUND(SUM(CAST(defaulted AS INT)) * 100.0 / COUNT(*), 2) AS Overall_Default_Rate
FROM loan_applications;
```
## Key Insights
- Wedding loans had the highest default rates.
- Lower credit score borrowers showed significantly higher default risk.
- Higher debt-to-income ratios were linked to increased defaults.
- Certain loan terms had stronger default patterns than others.

## Dashboard Features
- KPI cards for total loans, defaults, and default rate
- Loan purpose default comparison
- Credit score risk analysis
- DTI ratio analysis
- Loan term trends
- Interactive filters and slicers

## Files Included
- SQL Queries
- Cleaned Dataset
- Project Screenshots

## Business Recommendation
- Tighten approval criteria for low credit score applicants
- Review high-risk loan purposes
- Apply stricter checks for high DTI borrowers
- Adjust pricing or terms based on borrower risk

## Dashboard Preview

![Loan Default Risk Dashboard](https://github.com/IsraelAlamu/Loan-default-risk-analysis/blob/main/Screenshot%202026-04-29%20001649.png?raw=true)

## Author
Israel Alamu
Business Intelligence / Data Analyst
