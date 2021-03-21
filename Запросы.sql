-- Количество пользователей среди женщин и мужчин
SELECT COUNT(l.id) as 'Количество пользователей', (SELECT  gender FROM profiles p2 WHERE p2.user_id = l.user_id) as gender FROM likes l GROUP BY gender;


-- Ищем фильмы режиссера
SELECT d.name as 'Режиссер', f2.name as 'Фильм', f2.description as 'Описание', f2.country as 'Страна' FROM creators c
JOIN directors d ON d.id = c.director_id 
JOIN films f2 ON  f2.creators_id = c.id 
WHERE d.name = 'Кристофер Нолан';


-- Любимые фильмы пользователей
SELECT DISTINCT COUNT(l2.user_id) OVER w as top_likes,
  f.name as 'Название фильма', f.release_date as 'Дата релиза', a2.name as 'Главный актер 1', a3.name as 'Главный актер 2' 
  FROM (films f 
      JOIN likes l2 
        ON l2.film_id = f.id
      JOIN creators c2 
      	ON c2.id = f.creators_id
      JOIN actors a2
      on a2.id = c2.main_actor_1_id
      JOIN actors a3
      ON a3.id = c2.main_actor_2_id)
      WINDOW w AS (PARTITION BY l2.film_id) ORDER BY top_likes DESC LIMIT 10;
     
 
-- Какие жанры любят пользователи
SELECT COUNT(l.id) as top_like, 
(SELECT  name FROM genres_types gt WHERE gt.id = 
(SELECT f2.genres_type_id FROM films f2 WHERE f2.id = l.film_id)) as genre FROM likes l GROUP BY genre ORDER BY top_like DESC ;



-- Главные любители КИНО
SELECT u.id as id , CONCAT(u.first_name,' ', u.last_name) as name, COUNT(film_id) as likes FROM likes l
RIGHT JOIN users u 
ON u.id = l.user_id
GROUP BY name, id ORDER BY likes DESC LIMIT 5;


-- Больше всего хотят посмотреть
SELECT COUNT(p2.user_id) as top_likes, p2.film_id , f.name, d2.name FROM plans p2
JOIN films f 
ON f.id = p2.film_id 
JOIN creators c2 
ON c2.id = f.creators_id 
JOIN directors d2 
ON d2.id = c2.director_id 
GROUP BY p2.film_id ORDER BY top_likes DESC LIMIT 5 ;



# Процедуры
-- Рекомендации: 1. Основываясь на любимых жанрах 2. Основываясь на любимых режиссерах
CALL recomend_films_by_genre(60);
CALL recomend_films_by_director(88);
