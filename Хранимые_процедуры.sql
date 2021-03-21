DROP PROCEDURE IF EXISTS recomend_films_by_genre;

DELIMITER //
CREATE PROCEDURE recomend_films_by_genre (pid VARCHAR(10))
BEGIN
	SELECT f2.id, f2.name FROM films f2 WHERE genres_type_id IN (SELECT DISTINCT f.genres_type_id FROM users u 
	JOIN likes l 
	ON l.user_id = u.id 
	JOIN films f 
	ON f.id = l.film_id 
	WHERE u.id = pid) AND id NOT IN (SELECT DISTINCT f.id FROM users u 
	JOIN likes l 
	ON l.user_id = u.id 
	JOIN films f 
	ON f.id = l.film_id 
	WHERE u.id = pid);
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS recomend_films_by_director;
DELIMITER //
CREATE PROCEDURE recomend_films_by_director (pid VARCHAR(10))
BEGIN
	SELECT f2.name as 'Фильм', d.name as 'Режиссер', f2.release_date as "Дата выхода" FROM films f2
JOIN creators c 
ON c.id = f2.creators_id 
JOIN directors d 
ON d.id = c.director_id WHERE c.director_id IN (SELECT DISTINCT c2.director_id FROM users u 
JOIN likes l 
ON l.user_id = u.id 
JOIN films f 
ON f.id = l.film_id 
JOIN creators c2 
ON c2.id = f.creators_id 
WHERE u.id = pid) AND f2.id NOT IN (SELECT DISTINCT f.id FROM users u 
JOIN likes l 
ON l.user_id = u.id 
JOIN films f 
ON f.id = l.film_id 
WHERE u.id = pid);
END//
DELIMITER ;