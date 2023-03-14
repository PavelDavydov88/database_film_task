DROP TABLE IF EXISTS viewer;
DROP TABLE IF EXISTS film_translator;
DROP TABLE IF EXISTS film_person;
DROP TABLE IF EXISTS film_genre;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS film;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS country;

CREATE TABLE  IF NOT EXISTS country
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 ),
    name text  NOT NULL,
    CONSTRAINT country_pkey PRIMARY KEY (id)
    );

CREATE TABLE IF NOT EXISTS person
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 ),
    first_name text  NOT NULL,
    second_name text NOT NULL,
    CONSTRAINT perso_pkey PRIMARY KEY (id)
    );

CREATE TABLE IF NOT EXISTS film
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 ),
    name text NOT NULL,
    audio_tracks text NOT NULL,
    subtitles text NOT NULL,
    film_quality text NOT NULL,
    year integer NOT NULL,
    country_id integer NOT NULL,
    slogan text NOT NULL,
    director_id integer NOT NULL,
    scriptwriter_id integer NOT NULL,
    producer_id integer NOT NULL,
    operator_id integer NOT NULL,
    music_composer_id integer NOT NULL,
    designer_id integer NOT NULL,
    film_editor_id integer NOT NULL,
    budget integer NOT NULL,
    marketing integer NOT NULL,
    tax_usa integer NOT NULL,
    tax_world integer NOT NULL,
    premiere_world date NOT NULL,
    premiere_russia date NOT NULL,
    release_dvd date NOT NULL,
    age_restrictions text NOT NULL,
    reting_mpaa text COLLATE pg_catalog."default" NOT NULL,
    time_during integer NOT NULL,
    trailer text NOT NULL,
    CONSTRAINT film_pkey PRIMARY KEY (id),
    CONSTRAINT fk_country FOREIGN KEY (country_id)
    REFERENCES country (id) MATCH SIMPLE,
    CONSTRAINT fk_designer FOREIGN KEY (designer_id)
    REFERENCES person (id) MATCH SIMPLE,
    CONSTRAINT fk_director FOREIGN KEY (director_id)
    REFERENCES person (id) MATCH SIMPLE,
    CONSTRAINT fk_film_editor FOREIGN KEY (film_editor_id)
    REFERENCES person (id) MATCH SIMPLE,
    CONSTRAINT fk_operator FOREIGN KEY (operator_id)
    REFERENCES person (id) MATCH SIMPLE,
    CONSTRAINT fk_producer FOREIGN KEY (producer_id)
    REFERENCES person (id) MATCH SIMPLE,
    CONSTRAINT fk_writer FOREIGN KEY (scriptwriter_id)
    REFERENCES person (id) MATCH SIMPLE,
    CONSTRAINT fk_music_composer FOREIGN KEY (music_composer_id)
    REFERENCES person (id) MATCH SIMPLE
    );

CREATE TABLE IF NOT EXISTS genre
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 ),
    name text NOT NULL,
    CONSTRAINT genre_pkey PRIMARY KEY (id)
    );

CREATE TABLE IF NOT EXISTS film_translator
(
    film_id integer NOT NULL,
    person_id integer NOT NULL,
    CONSTRAINT pk_film_translator PRIMARY KEY (film_id, person_id),
    CONSTRAINT fk_film_id FOREIGN KEY (film_id)
    REFERENCES film (id) MATCH SIMPLE,
    CONSTRAINT fk_person_id FOREIGN KEY (person_id)
    REFERENCES person (id) MATCH SIMPLE
    );

CREATE TABLE IF NOT EXISTS film_person
(
    film_id integer NOT NULL,
    person_id integer NOT NULL,
    CONSTRAINT pk_film_person PRIMARY KEY (film_id, person_id),
    CONSTRAINT fk_film_id FOREIGN KEY (film_id)
    REFERENCES film (id) MATCH SIMPLE,
    CONSTRAINT fk_person_id FOREIGN KEY (person_id)
    REFERENCES person (id) MATCH SIMPLE
    );

CREATE TABLE IF NOT EXISTS film_genre
(
    film_id integer NOT NULL,
    genre_id integer NOT NULL,
    CONSTRAINT pk_film_genre PRIMARY KEY (film_id, genre_id),
    CONSTRAINT fk_film_id FOREIGN KEY (film_id)
    REFERENCES film (id) MATCH SIMPLE,
    CONSTRAINT fk_genre_id FOREIGN KEY (genre_id)
    REFERENCES genre (id) MATCH SIMPLE
    );

CREATE TABLE IF NOT EXISTS viewer
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 ),
    film_id integer NOT NULL,
    population integer NOT NULL,
    country_id integer NOT NULL,
    CONSTRAINT viewer_pkey PRIMARY KEY (id),
    CONSTRAINT country_id FOREIGN KEY (country_id)
    REFERENCES country (id) MATCH SIMPLE,
    CONSTRAINT film_id FOREIGN KEY (film_id)
    REFERENCES film (id) MATCH SIMPLE
    );