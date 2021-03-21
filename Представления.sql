-- Новинки кино в БД

CREATE OR REPLACE VIEW new_films AS SELECT f.name as 'Фильм', f.description as 'Описание',  d.name as 'Режиссер' , f.release_date  FROM films f , creators c 
JOIN directors d 
ON d.id = c.director_id 
WHERE f.creators_id = c.id AND f.release_date > 2018 ORDER BY f.release_date DESC WITH CHECK OPTION;

-- Данные о фильмах и их создателях
CREATE OR REPLACE VIEW creators_film AS SELECT f.name as 'Фильм', 
d.name as 'Режиссер', s2.name as 'Сценарист' , a.name as 'Актёр 1', a2.name as 'Актёр 2', f.release_date 
FROM films f, creators c 
JOIN directors d 
ON d.id = c.director_id 
JOIN scriptwriters s2 
ON s2.id  = c.scriptwriter_id 
JOIN actors a 
ON a.id = c.main_actor_1_id 
JOIN actors a2 
ON a2.id = c.main_actor_2_id 
WHERE f.creators_id = c.id ORDER BY f.release_date;


SELECT * FROM new_films ;
SELECT * FROM creators_film WHERE release_date > 2018 ORDER BY release_date DESC;