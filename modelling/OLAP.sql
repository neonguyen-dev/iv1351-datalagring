SELECT TO_CHAR(time_slot, 'Mon') AS Month,
COUNT(*) AS Total,
SUM(CASE WHEN type_of_lesson = 1 THEN 1 ELSE 0 END) AS Individual,
SUM(CASE WHEN type_of_lesson = 2 THEN 1 ELSE 0 END) AS GroupLesson,
SUM(CASE WHEN type_of_lesson = 3 THEN 1 ELSE 0 END) AS Ensemble FROM lesson
GROUP BY time_slot
ORDER BY time_slot;

SELECT 
    instructor_id AS Instructor_id,
    (SELECT first_name FROM person WHERE id=instructor_id) AS First_Name,
    (SELECT last_name FROM person WHERE id=instructor_id) AS Last_Name,
    COUNT(*) AS No_of_Lessons
FROM
    lesson
GROUP BY
    instructor_id
HAVING 
    COUNT(*) >= 1
ORDER BY
    No_of_Lessons DESC

SELECT 
    TO_CHAR(time_slot, 'Dy') AS Day,
    (SELECT genre_name FROM genre WHERE id=genre_id) AS Genre,
    CASE 
        WHEN (maximum - seats_taken) = 0 THEN 'No Seats'
        WHEN (maximum - seats_taken) BETWEEN 1 AND 2 THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS "No of Free Seats"
FROM 
    lesson
WHERE 
    time_slot >= CURRENT_DATE AND time_slot <= CURRENT_DATE + INTERVAL '1 week' AND type_of_lesson=3
GROUP BY 
    Day, Genre, maximum, seats_taken
ORDER BY 
    Day;

SELECT 
    COALESCE(No_of_Siblings, 0) AS No_of_Siblings,
    COUNT(student_id) AS No_of_Students
FROM (
    SELECT 
        student_id,
        COUNT(sibling_id) AS No_of_Siblings
    FROM 
        sibling
    GROUP BY 
        student_id
)
GROUP BY 
    No_of_Siblings
ORDER BY 
    No_of_Siblings;