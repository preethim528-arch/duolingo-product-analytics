-- Duolingo Learning Behavior & Premium Conversion
-- Product Analytics KPI Analysis


-- 1. Total Users
SELECT
    COUNT(DISTINCT User_id) AS total_users
FROM Duolingo_users;


-- 2. Premium Users
SELECT
    COUNT(DISTINCT User_id) AS premium_users
FROM Duolingo_users
WHERE premium_user = TRUE;


-- 3. Free Users
SELECT
    COUNT(DISTINCT user_id) AS free_users
FROM Duolingo_users
WHERE premium_user = FALSE;


-- 4. Premium Conversion Rate %
SELECT
    ROUND(
        COUNT(DISTINCT CASE
            WHEN premium_user = TRUE THEN User_id
        END)::NUMERIC
        / COUNT(DISTINCT User_id) * 100,
        2
    ) AS premium_conversion_prct
FROM Duolingo_users;


-- 5. High-Intent Free Users (Count)
SELECT
    COUNT(DISTINCT user_id) AS high_intent_free_users
FROM duolingo_users
WHERE premium_user = FALSE
  AND daily_streak >= 7;


-- 6. High-Intent Free Users (% of Free Users)
SELECT
    ROUND(
        COUNT(DISTINCT CASE
            WHEN premium_user = FALSE
             AND daily_streak >= 7
            THEN user_id
        END)::NUMERIC
        /
        COUNT(DISTINCT CASE
            WHEN premium_user = FALSE
            THEN user_id
        END) * 100,
        2
    ) AS high_intent_free_users_percentage
FROM duolingo_users;


-- 7. Actual Revenue (from Premium Users)
SELECT
    SUM(actual_revenue) AS actual_revenue
FROM duolingo_users
WHERE premium_user = TRUE;


-- 8. Potential Revenue (High-Intent Free Users)
SELECT
    SUM(potential_revenue) AS potential_revenue
FROM duolingo_users
WHERE premium_user = FALSE
  AND daily_streak >= 7;
