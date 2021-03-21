CREATE INDEX users_last_name_idx ON users(last_name);
CREATE INDEX users_last_name__first_name_idx ON users(last_name, first_name);

CREATE INDEX profiles_birthday_idx ON profiles(birthday);
CREATE INDEX profiles_city_idx ON profiles(city);
CREATE INDEX profiles_city_gender_idx ON profiles(city, gender);


CREATE INDEX films_name_idx ON films(name);
CREATE INDEX films_country_idx ON films(country);
CREATE INDEX films_release_date_idx ON films(release_date);


CREATE INDEX directors_name_idx ON directors(name);
CREATE INDEX actors_name_idx ON actors(name);
CREATE INDEX scriptwriters_idx ON scriptwriters(name);
CREATE INDEX genre_types_idx ON genres_types(name);

CREATE INDEX media_poster_idx ON media(poster);
CREATE INDEX media_size_idx ON media(`size`);