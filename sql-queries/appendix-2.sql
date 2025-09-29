CREATE VIEW settlement_top_stats AS
-- Топ-5 по приросту
SELECT 
    YEAR,
    settlement,
    rni,
    rn,
    'growth' AS top_type
FROM (
    SELECT 
        settlement,
        YEAR,
        rni,
        row_number() OVER (PARTITION BY YEAR ORDER BY rni DESC) AS rn
    FROM public."data" 
    WHERE rni IS NOT NULL
) AS ranked
WHERE rn <= 5

UNION ALL

-- Топ-5 по убыли
SELECT 
    YEAR,
    settlement,
    rni,
    rn,
    'decline' AS top_type
FROM (
    SELECT 
        settlement,
        YEAR,
        rni,
        row_number() OVER (PARTITION BY YEAR ORDER BY rni ASC) AS rn
    FROM public."data" 
    WHERE rni IS NOT NULL AND rni < 0
) AS ranked
WHERE rn <= 5;
