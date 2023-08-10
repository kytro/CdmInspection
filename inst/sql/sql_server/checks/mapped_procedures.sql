-- top 25 mapped devices

SELECT *
FROM (
	select ROW_NUMBER() OVER(ORDER BY count_big(procedure_occurrence_id) DESC) AS ROW_NUM,
       Cr.concept_name as `Concept Name`,
       floor((count_big(procedure_occurrence_id)+99)/100)*100 as "#Records",
       floor((count_big(distinct person_id)+99)/100)*100 as "#Subjects"
       from @cdmDatabaseSchema.procedure_occurrence C
JOIN @vocabDatabaseSchema.CONCEPT CR
ON C.procedure_concept_id = CR.CONCEPT_ID
where c. procedure_concept_id != 0
group by CR.concept_name
having count_big(procedure_occurrence_id)>@smallCellCount
) z
WHERE z.ROW_NUM <= 25
ORDER BY z.ROW_NUM
