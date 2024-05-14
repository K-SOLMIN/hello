SELECT * FROM
	(SELECT rownum AS rnum, m.*
		FROM(
			SELECT * FROM MEMBER ORDER BY enrolldate DESC
		) m
	)
WHERE rnum BETWEEN 1 AND 5;
