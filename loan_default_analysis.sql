
USE loanriskproject;
GO

/* =====================================================
   LOAN DEFAULT RISK ANALYSIS PROJECT
   SQL Server / T-SQL
===================================================== */

-------------------------------------------------------
-- 1. Overall Default Rate
-------------------------------------------------------
SELECT 
    SUM(CAST(defaulted AS INT)) AS Total_Default,
    COUNT(*) AS Total_Loans,
    ROUND(SUM(CAST(defaulted AS INT)) * 100.0 / COUNT(*), 2) AS Overall_Default_Rate
FROM loan_applications;


-------------------------------------------------------
-- 2. Default Rate by Credit Score Range
-------------------------------------------------------
SELECT
    CASE
        WHEN bp.credit_score BETWEEN 520 AND 599 THEN '520-599'
        WHEN bp.credit_score BETWEEN 600 AND 649 THEN '600-649'
        WHEN bp.credit_score BETWEEN 650 AND 699 THEN '650-699'
        WHEN bp.credit_score BETWEEN 700 AND 749 THEN '700-749'
        ELSE '750+'
    END AS credit_score_bucket,

    SUM(CAST(la.defaulted AS INT)) AS Total_Default,
    COUNT(*) AS Total_Loans,
    ROUND(SUM(CAST(la.defaulted AS INT)) * 100.0 / COUNT(*), 2) AS Overall_Default_Rate

FROM loan_applications la
JOIN borrower_profiles bp
    ON bp.borrower_id = la.borrower_id

GROUP BY
    CASE
        WHEN bp.credit_score BETWEEN 520 AND 599 THEN '520-599'
        WHEN bp.credit_score BETWEEN 600 AND 649 THEN '600-649'
        WHEN bp.credit_score BETWEEN 650 AND 699 THEN '650-699'
        WHEN bp.credit_score BETWEEN 700 AND 749 THEN '700-749'
        ELSE '750+'
    END

ORDER BY Overall_Default_Rate DESC;


-------------------------------------------------------
-- 3. Default Rate by Debt-to-Income Ratio
-------------------------------------------------------
SELECT
    CASE
        WHEN dti_ratio < 20 THEN '0-19.99'
        WHEN dti_ratio >= 20 AND dti_ratio < 30 THEN '20-29.99'
        WHEN dti_ratio >= 30 AND dti_ratio < 40 THEN '30-39.99'
        WHEN dti_ratio >= 40 AND dti_ratio < 50 THEN '40-49.99'
        ELSE '50+'
    END AS dti_bucket_ratio,

    SUM(CAST(defaulted AS INT)) AS Total_Default,
    COUNT(*) AS Total_Loans,
    ROUND(SUM(CAST(defaulted AS INT)) * 100.0 / COUNT(*), 2) AS Overall_Default_Rate

FROM loan_applications

GROUP BY
    CASE
        WHEN dti_ratio < 20 THEN '0-19.99'
        WHEN dti_ratio >= 20 AND dti_ratio < 30 THEN '20-29.99'
        WHEN dti_ratio >= 30 AND dti_ratio < 40 THEN '30-39.99'
        WHEN dti_ratio >= 40 AND dti_ratio < 50 THEN '40-49.99'
        ELSE '50+'
    END

ORDER BY Overall_Default_Rate DESC;


-------------------------------------------------------
-- 4. Default Rate by Loan Purpose
-------------------------------------------------------
SELECT
    loan_purpose,
    SUM(CAST(defaulted AS INT)) AS Total_Default,
    COUNT(*) AS Total_Loans,
    ROUND(SUM(CAST(defaulted AS INT)) * 100.0 / COUNT(*), 2) AS Overall_Default_Rate,
    AVG(loan_amount) AS Average_Loan_Amount

FROM loan_applications

GROUP BY loan_purpose
ORDER BY Overall_Default_Rate DESC;


-------------------------------------------------------
-- 5. Average Loan Amount:
-- Defaulted vs Non-Defaulted
-------------------------------------------------------
SELECT
    CASE
        WHEN defaulted = 1 THEN 'Defaulted'
        ELSE 'Non Defaulted'
    END AS Default_Status,

    AVG(loan_amount) AS Average_Loan_Amount

FROM loan_applications

GROUP BY defaulted;


-------------------------------------------------------
-- 6. Default Risk by Years Employed
-------------------------------------------------------
SELECT
    CASE
        WHEN bp.years_employed < 2 THEN '< 2 Years'
        ELSE '2+ Years'
    END AS Years_Employed_Bucket,

    SUM(CAST(la.defaulted AS INT)) AS Total_Default,
    COUNT(*) AS Total_Loans,
    ROUND(SUM(CAST(la.defaulted AS INT)) * 100.0 / COUNT(*), 2) AS Overall_Default_Rate

FROM loan_applications la
JOIN borrower_profiles bp
    ON bp.borrower_id = la.borrower_id

GROUP BY
    CASE
        WHEN bp.years_employed < 2 THEN '< 2 Years'
        ELSE '2+ Years'
    END

ORDER BY Overall_Default_Rate DESC;
