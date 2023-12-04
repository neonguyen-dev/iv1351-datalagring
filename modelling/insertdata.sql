INSERT INTO person (person_number,first_name,last_name,street,zip,city,phone_number,email)
VALUES
  ('19560723-9968', 'Imani','Anderson','227-4401 Non Rd.','73875','Berdiansk','229-2895','lorem.fringilla@hotmail.couk'),
  ('19490320-4230', 'Palmer','Farrell','P.O. Box 166, 7766 Pharetra. Avenue','64868','Sokoto','744-5370','justo.nec@google.com'),
  ('20180303-9856','Lana','Dickson','Ap #227-6776 Cursus. Ave','2616','Koppervik','352-5928','arcu.aliquam@protonmail.couk'),
  ('20220527-4828','Belle','Key','Ap #629-2943 Bibendum Rd.','35224','Laon','1-571-722-0753','sed@google.net'),
  ('19420307-8367','Inga','Reilly','P.O. Box 679, 7167 Tortor. Rd.','9034','Vienna','1-685-286-9371','aenean@outlook.ca'),
  ('19830824-8577','Cedric','Mann','7944 Hendrerit. Av.','249424','Taunton','1-202-851-2831','lorem.eu@hotmail.org'),
  ('20160213-3157','Remedios','Shaffer','515-2891 Convallis Road','62634-444','Charleville-Mézières','633-0315','gravida.sit@aol.edu'),
  ('19350820-3068','Myles','Mullen','P.O. Box 518, 2564 Accumsan Street','4722','Lugo','1-697-251-8734','enim.condimentum@outlook.com'),
  ('19651104-8859','Demetrius','Vargas','768-6669 Justo Road','858164','Muno','463-9767','nostra.per@google.edu'),
  ('19770624-0210','Quamar','Taylor','Ap #101-5130 Dignissim. Street','5823','Alaminos','1-777-965-8684','gravida.molestie.arcu@google.org');

INSERT INTO instrument_type (instrument_name)
VALUES
  ('guitar'),
  ('drums'),
  ('piano'),
  ('bass'),
  ('flute'),
  ('triangle'),
  ('bongo-drums'),
  ('marackas'),
  ('electric guitar'),
  ('keyboard');

INSERT INTO genre (genre_name)
VALUES
    ('rock'),
    ('jazz'),
    ('punk'),
    ('techno'),
    ('country'),
    ('pop'),
    ('russian old style'),
    ('disco');

INSERT INTO contact_person (person_id)
VALUES
    ((SELECT id from person WHERE person_number='19560723-9968')),
    ((SELECT id from person WHERE person_number='20220527-4828')),
    ((SELECT id from person WHERE person_number='19490320-4230')),
    ((SELECT id from person WHERE person_number='19350820-3068'));
    
INSERT INTO instructor (employment_id, person_id)
VALUES
	('760685',(SELECT id from person WHERE person_number='20160213-3157')),
	('765609',(SELECT id from person WHERE person_number='19830824-8577'));

INSERT INTO instrument (brand,model,instrument_type_id,stored_quantity)
VALUES
    ('jamal', '123ad', (SELECT id from instrument_type WHERE instrument_name='guitar'), 10),
    ('diego', 'starter',(SELECT id from instrument_type WHERE instrument_name='drums'), 15),
    ('adidas','86tre', (SELECT id from instrument_type WHERE instrument_name='flute'), 7),
    ('yamaha', 'pejfbn56', (SELECT id from instrument_type WHERE instrument_name='piano'), 5),
    ('ajbanes', 'ihgre87', (SELECT id from instrument_type WHERE instrument_name='electric guitar'), 8),
    ('fenderbender', 'nleg8', (SELECT id from instrument_type WHERE instrument_name='bongo-drums'), 20);

INSERT INTO student (person_id, student_id, contact_person_id)
VALUES
    ((SELECT id from person WHERE person_number='19651104-8859'),'760059',(SELECT id from contact_person WHERE person_id=1)),
	((SELECT id from person WHERE person_number='19770624-0210'),'779991',(SELECT id from contact_person WHERE person_id=4)),
	((SELECT id from person WHERE person_number='19420307-8367'),'776141',(SELECT id from contact_person WHERE person_id=2)),
	((SELECT id from person WHERE person_number='20180303-9856'),'777382',(SELECT id from contact_person WHERE person_id=8));

INSERT INTO lesson (lesson_id, instrument_type_id, skill_level, type_of_lesson, minimum, maximum, time_slot, genre_id, instructor_id, pricing_scheme_id, seats_taken)
VALUES
    ('78342', (SELECT id from instrument_type WHERE instrument_name='guitar'), 1, 2, 5, 10, '2022-10-10 11:30:40', (SELECT id from genre WHERE genre_name='pop'), (SELECT id from instructor WHERE employment_id='760685'), NULL, 3),
    ('49805', (SELECT id from instrument_type WHERE instrument_name='drums'), 3, 1, NULL, NULL, '2023-12-10 10:50:45', (SELECT id from genre WHERE genre_name='rock'), (SELECT id from instructor WHERE employment_id='765609'), NULL, NULL),
    ('58763', (SELECT id from instrument_type WHERE instrument_name='flute'), 2, 3, 5, 10, '2023-12-07 11:30:40', (SELECT id from genre WHERE genre_name='disco'), (SELECT id from instructor WHERE employment_id='760685'), NULL, 7),
    ('02834', (SELECT id from instrument_type WHERE instrument_name='bongo-drums'), 2, 3, 2, 12, '2023-12-07 10:50:45', (SELECT id from genre WHERE genre_name='jazz'), (SELECT id from instructor WHERE employment_id='765609'), NULL, 5);

INSERT INTO pricing_scheme (skill_level_price, type_of_lesson_price, discount, student_pay, instructor_salary)
VALUES
    ('50', '20', 30, '49', '70'),
    ('150', '80', 20, '184', '230');

UPDATE lesson
SET pricing_scheme_id=(SELECT id from pricing_scheme WHERE skill_level_price='50' AND type_of_lesson_price='20')
WHERE skill_level=1 AND type_of_lesson=2;
UPDATE lesson
SET pricing_scheme_id=(SELECT id from pricing_scheme WHERE skill_level_price='150' AND type_of_lesson_price='80')
WHERE skill_level=3 AND type_of_lesson=1;

INSERT INTO schedule (instructor_id, available_from, available_to)
VALUES
    ((SELECT id from instructor WHERE employment_id='760685'), '2022-08-15 08:30:34', '2022-10-10 11:30:40'),
    ((SELECT id from instructor WHERE employment_id='765609'), '2023-11-10 10:45:45', '2023-12-10 10:50:45');

INSERT INTO student_lesson (student_id, lesson_id)
VALUES
   ((SELECT id from student WHERE student_id='760059'), (SELECT id from lesson WHERE lesson_id='78342')), 
   ((SELECT id from student WHERE student_id='779991'), (SELECT id from lesson WHERE lesson_id='49805'));

INSERT INTO teaching_instruments (instructor_id, instrument_type_id)
VALUES
   ((SELECT id from instructor WHERE employment_id='765609'), (SELECT id from instrument_type WHERE instrument_name='drums')), 
   ((SELECT id from instructor WHERE employment_id='760685'), (SELECT id from instrument_type WHERE instrument_name='guitar'));

INSERT INTO rental (instrument_id, start_date, end_date, monthly_fee, student_id, terminated)
	VALUES
	((SELECT id from instrument where brand='fenderbender' AND model='nleg8'), '2022-01-24', '2023-01-24', '500', (SELECT id from student WHERE student_id='760059'), '1'),
	((SELECT id from instrument where brand='jamal' AND model='123ad'), '2023-01-24', '2024-01-24', '200', (SELECT id from student WHERE student_id='760059'), '0');

INSERT INTO sibling (student_id, sibling_id)
VALUES
    ((SELECT id from student WHERE person_id=3), NULL),
    ((SELECT id from student WHERE person_id=5), NULL),
    ((SELECT id from student WHERE person_id=9), (SELECT id from student WHERE person_id=10)),
    ((SELECT id from student WHERE person_id=10), (SELECT id from student WHERE person_id=9));