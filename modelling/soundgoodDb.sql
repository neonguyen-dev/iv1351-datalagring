CREATE TABLE genre (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 genre_name VARCHAR(500) NOT NULL
);

ALTER TABLE genre ADD CONSTRAINT PK_genre PRIMARY KEY (id);


CREATE TABLE instrument_type (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_name VARCHAR(500) NOT NULL
);

ALTER TABLE instrument_type ADD CONSTRAINT PK_instrument_type PRIMARY KEY (id);


CREATE TABLE person (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_number VARCHAR(13) NOT NULL,
 first_name VARCHAR(500) NOT NULL,
 last_name VARCHAR(500) NOT NULL,
 street VARCHAR(500) NOT NULL,
 zip VARCHAR(5) NOT NULL,
 city VARCHAR(500) NOT NULL,
 phone_number VARCHAR(10) NOT NULL,
 email VARCHAR(500) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE pricing_scheme (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 skill_level_price VARCHAR(500) NOT NULL,
 type_of_lesson_price VARCHAR(500) NOT NULL,
 discount DECIMAL(1,2),
 student_pay VARCHAR(500) NOT NULL,
 instructor_salary VARCHAR(500) NOT NULL
);

ALTER TABLE pricing_scheme ADD CONSTRAINT PK_pricing_scheme PRIMARY KEY (id);


CREATE TABLE contact_person (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (id);


CREATE TABLE instructor (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 employment_id VARCHAR(500) NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instrument (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(500),
 model VARCHAR(500) NOT NULL,
 instrument_type_id INT NOT NULL,
 stored_quantity VARCHAR(10) NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_id VARCHAR(500),
 instrument_type_id INT NOT NULL,
 skill_level INT NOT NULL,
 type_of_lesson INT NOT NULL,
 minimum VARCHAR(500),
 maximum VARCHAR(500),
 time_slot TIMESTAMP(10) NOT NULL,
 genre_id INT,
 instructor_id INT NOT NULL,
 pricing_scheme_id INT
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE schedule (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id INT NOT NULL,
 available_from TIMESTAMP(10),
 available_to TIMESTAMP(10)
);

ALTER TABLE schedule ADD CONSTRAINT PK_schedule PRIMARY KEY (id,instructor_id);


CREATE TABLE student (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL,
 student_id VARCHAR(500) NOT NULL,
 contact_person_id INT NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE student_lesson (
 student_id INT NOT NULL,
 lesson_id INT NOT NULL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (student_id,lesson_id);


CREATE TABLE teaching_instruments (
 instructor_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE teaching_instruments ADD CONSTRAINT PK_teaching_instruments PRIMARY KEY (instructor_id,instrument_id);


CREATE TABLE rental (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_id INT NOT NULL,
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
 monthly_fee DECIMAL(10,2) NOT NULL,
 student_id INT NOT NULL,
 terminated BIT(1) NOT NULL
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (id);


CREATE TABLE sibling (
 student_id INT NOT NULL,
 sibling_id INT NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (student_id,sibling_id);


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (genre_id) REFERENCES genre (id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_2 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_3 FOREIGN KEY (pricing_scheme_id) REFERENCES pricing_scheme (id);


ALTER TABLE schedule ADD CONSTRAINT FK_schedule_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (contact_person_id) REFERENCES contact_person (id);


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE teaching_instruments ADD CONSTRAINT FK_teaching_instruments_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE teaching_instruments ADD CONSTRAINT FK_teaching_instruments_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (instrument_id) REFERENCES instrument (id);
ALTER TABLE rental ADD CONSTRAINT FK_rental_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE sibling ADD CONSTRAINT FK_sibling_1 FOREIGN KEY (sibling_id) REFERENCES student (id);


