-- 222	Number of persons by age, with age at first visit occurrence

--HINT DISTRIBUTE_ON_KEY(stratum_1)
select 222 as analysis_id,   CAST(year(vo1.index_date) - p1.YEAR_OF_BIRTH AS VARCHAR(255)) as stratum_1, 
cast(null as varchar(255)) as stratum_2, cast(null as varchar(255)) as stratum_3, cast(null as varchar(255)) as stratum_4, cast(null as varchar(255)) as stratum_5,
COUNT_BIG(p1.person_id) as count_value
into @scratchDatabaseSchema@schemaDelim@tempAchillesPrefix_222
from @cdmDatabaseSchema.PERSON p1
	inner join (select person_id, MIN(visit_start_date) as index_date from @cdmDatabaseSchema.VISIT_OCCURRENCE group by PERSON_ID) vo1
	on p1.PERSON_ID = vo1.PERSON_ID
group by year(vo1.index_date) - p1.YEAR_OF_BIRTH;
