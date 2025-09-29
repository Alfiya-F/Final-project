-- 3.1. Проверка, что в витрине только 5 записей на год для каждого типа:
SELECT year, top_type, COUNT(*) as city_count
FROM settlement_top_stats
GROUP BY year, top_type
HAVING COUNT(*) > 5;

-- 3.2. Проверка, что для типа “decline” действительно отбираются города с отрицательным приростом:
SELECT year, settlement, rni, top_type
FROM settlement_top_stats
WHERE top_type = 'decline' AND rni >= 0;
 
