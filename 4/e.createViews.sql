Create View Actor(person_id, gender, name) AS (
    SELECT DISTINCT person_id, gender, name 
    FROM Movie_Cast
)

Create View CrewMember(person_id, gender, name) AS (
    SELECT DISTINCT person_id, gender, name
    FROM Movie_Crew
)

Create View Person AS (
    SELECT * FROM Actor
    UNION
    SELECT * FROM CrewMember
)
