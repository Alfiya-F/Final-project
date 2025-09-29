-- 4.1. Отбор 5 городов по наибольшему приросту:
SELECT settlement 
       ,count(*) AS cnt
FROM (
SELECT temp_table.YEAR
        ,temp_table.settlement
        ,temp_table.rni
        ,temp_table.rn
   FROM
 (
 SELECT settlement
 		,YEAR
 		,rni
 		,ROW_NUMBER() OVER(PARTITION BY YEAR 
 		                                     ORDER BY rni DESC) AS rn
   FROM public."data" d  
   WHERE rni IS NOT NULL
   ) AS temp_table
   WHERE temp_table.rn BETWEEN 1 AND 5
   GROUP BY temp_table.YEAR, temp_table.settlement, temp_table.rni, temp_table.rn
   ORDER BY temp_table.YEAR, temp_table.rn)
   GROUP BY settlement 
   ORDER BY cnt DESC
;

-- 4.2. Отбор 5 городов по наибольшей убыли:
SELECT settlement 
       ,count(*) AS cnt
FROM (select temp_table.YEAR
        ,temp_table.settlement
        ,temp_table.rni
        ,temp_table.rn
   from 
 (
 select settlement
 		,YEAR
 		,rni
 		,ROW_NUMBER() OVER(PARTITION BY YEAR 
 		                                     ORDER BY rni ASC) AS rn
   from public."data" d  
   WHERE rni IS NOT NULL 
   AND rni < 0
   ) as temp_table
   WHERE temp_table.rn BETWEEN 1 AND 5
   GROUP BY temp_table.YEAR, temp_table.settlement, temp_table.rni, temp_table.rn
   ORDER BY temp_table.YEAR, temp_table.rn)
   GROUP BY settlement 
   ORDER BY cnt DESC
;

