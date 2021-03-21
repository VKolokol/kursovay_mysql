-- Триггер для замены значения пола. Использовал другой генератор данных.
DELIMITER //
CREATE TRIGGER update_gender BEFORE INSERT ON profiles
FOR EACH ROW
BEGIN
	IF NEW.gender = 'True'  THEN
		SET NEW.gender = 'Male';
	END IF;
	IF NEW.gender = 'False' THEN
		SET NEW.gender = 'Female';
	END IF;
END //
DELIMITER ;


-- Триггер на дату рождения режиссеров. Данные даты рождения уже не успевал завбрать из интернета :(
DELIMITER //
CREATE TRIGGER update_bd_directors BEFORE INSERT ON kinopoisk.directors 
FOR EACH ROW
BEGIN
	IF NEW.birthday IS NULL THEN
		SET NEW.birthday = (SELECT (NOW() -INTERVAL FLOOR(RAND()*30 ) DAY) - INTERVAL CONCAT(FLOOR(RAND()*40 + 25), '-',FLOOR(RAND()*12+1))  YEAR_MONTH as random);
	END IF;
END //
DELIMITER ;


-- Триггер на дату рождения сценаристов.
DELIMITER //
CREATE TRIGGER update_bd_scriptwriters BEFORE INSERT ON kinopoisk.scriptwriters 
FOR EACH ROW
BEGIN
	IF NEW.birthday IS NULL THEN
		SET NEW.birthday = (SELECT (NOW() -INTERVAL FLOOR(RAND()*30 ) DAY) - INTERVAL CONCAT(FLOOR(RAND()*40 + 25), '-',FLOOR(RAND()*12+1))  YEAR_MONTH as random);
	END IF;
END //
DELIMITER ;

-- Триггер на дату рождения актеров.
DELIMITER //
CREATE TRIGGER update_bd_actors BEFORE INSERT ON kinopoisk.actors 
FOR EACH ROW
BEGIN
	IF NEW.birthday IS NULL THEN
		SET NEW.birthday = (SELECT (NOW() -INTERVAL FLOOR(RAND()*30 ) DAY) - INTERVAL CONCAT(FLOOR(RAND()*40 + 25), '-',FLOOR(RAND()*12+1))  YEAR_MONTH as random);
	END IF;
END //
DELIMITER ;


-- Триггер на автозаполнение таблицы media
DELIMITER //
CREATE TRIGGER update_db_med AFTER INSERT ON kinopoisk.films 
FOR EACH ROW
BEGIN
	INSERT INTO media (media.film_id, media.poster, media.`size`, media.trailer)  
	VALUES (NEW.id, CONCAT('posters/', NEW.name,'.png'), FLOOR(RAND()*10000), CONCAT('https://www.youtube.com/', NEW.name,'.com')); 
END //
DELIMITER ;