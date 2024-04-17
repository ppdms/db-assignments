SELECT person_id, count(*) as count
FROM Person
GROUP BY person_id
HAVING COUNT(*) > 1

/*
47395	2
1785844	2
63574	2
 */

/*
SELECT *
FROM Actor
WHERE person_id IN (
    SELECT person_id
    FROM Person
    GROUP BY person_id
    HAVING COUNT(*) > 1)

1785844	2	Peter Malota
1785844	0	Peter Malota -> WRONG GENDER
47395	2	Miles Malleson
47395	0	Miles Malleson -> WRONG GENDER

SELECT *
FROM Movie_Cast
WHERE  person_id IN (
    SELECT person_id
    FROM Person
    GROUP BY person_id
    HAVING COUNT(*) > 1)

27410	1978	Mr. Fortesque	0	47395	Miles Malleson
49220	20324	Canon Chasuble	0	47395	Miles Malleson
54416	11167	Elderly Gentleman Customer	0	47395	Miles Malleson
72360	11791	Bishop	0	47395	Miles Malleson
84668	12232	Sultan	2	47395	Miles Malleson
104348	13188	Old Joe	2	47395	Miles Malleson
105769	34276	Dymchurch Registrar	0	47395	Miles Malleson
108214	34783	Windrush Snr.	0	47395	Miles Malleson
108392	13581	Hearse Driver (The Hearse Conductor)	0	47395	Miles Malleson
123835	43037	Mr. Rankeillor	0	47395	Miles Malleson
184802	11898	The Hangman	0	47395	Miles Malleson
281736	38770	Morrison	2	47395	Miles Malleson
288242	9594	Body Guard With Spurs	0	1785844	Peter Malota
288243	10413	Prisoner	2	1785844	Peter Malota
288244	9103	Spanish Fighter	0	1785844	Peter Malota
297940	11868	Marx - Undertaker	0	47395	Miles Malleson

-> ACTION: Turn Miles Malleson's gender to 2 everywhere. Same for Peter Malota. (1)

SELECT *
FROM CrewMember
WHERE person_id IN (
    SELECT person_id
    FROM Person
    GROUP BY person_id
    HAVING COUNT(*) > 1)

63574	2	Cheung Ka-Fai -> SURNAME GOES FIRST IN CHINESE, BUT SECOND IN OUR SCHEMA. ACTION: SET HIS NAME TO Ka-Fai Cheung
1785844	0	Peter Malota -> WRONG GENDER. ACTION: SET IT TO 2 (ACTION 3)
63574	2	Ka-Fai Cheung
47395	2	Miles Malleson

SELECT *
FROM Movie_Crew
WHERE  person_id IN (
    SELECT person_id
    FROM Person
    GROUP BY person_id
    HAVING COUNT(*) > 1)

47707	10951	Editing	2	63574	Editor	Cheung Ka-Fai -> ACTION 2
278730	9460	Editing	2	63574	Editor	Ka-Fai Cheung
288245	9594	Crew	0	1785844	Stunts	Peter Malota -> ACTION 3, ALL THE ROWS BELOW AS WELL
288246	9594	Crew	0	1785844	Martial Arts Choreographer	Peter Malota
288247	9103	Crew	0	1785844	Martial Arts Choreographer	Peter Malota
288248	9349	Crew	0	1785844	Stunts	Peter Malota
288249	10366	Crew	0	1785844	Martial Arts Choreographer	Peter Malota

 */

-- ACTION 1

UPDATE Movie_Cast
SET gender = 2
WHERE person_id IN (
    SELECT person_id
    FROM Person
    WHERE name IN ('Miles Malleson', 'Peter Malota')
);

-- ACTION 2

UPDATE Movie_Crew
SET name = 'Ka-Fai Cheung'
WHERE person_id IN (
    SELECT person_id
    FROM Person
    WHERE name = 'Cheung Ka-Fai'
);


-- ACTION 3

UPDATE Movie_Crew
SET gender = 2
WHERE person_id IN (
    SELECT person_id
    FROM Person
    WHERE name = 'Peter Malota'
);

/*
 CHECKING FOR INCONSISTENCIES AGAIN:
 
 SELECT person_id, count(*) as count
 FROM Person
 GROUP BY person_id
 HAVING COUNT(*) > 1

 RETURNS NOTHING!
 */
