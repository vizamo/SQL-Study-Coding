
CREATE TABLE dragon (
dragon_id integer not null primary key,
full_name varchar(50) not null,
nickname varchar(50) null,
color varchar(20) not null,
basic_element varchar(20) not null,
sex character(1) not null,
date_of_birth date not null,
date_of_death date null,
gold_reserve integer not null );

CREATE TABLE princess (
princess_id integer not null primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
kingdom varchar(50) not null,
date_of_birth date not null,
date_of_death date null,
hair_color varchar(20) not null );

CREATE TABLE dragon_princess (
dragon_princess_id integer not null primary key,
date_of_kidnapping date not null,
place_of_confinement varchar(100) not null,
date_of_liberation date null,
liberated_knight varchar(100) null );

ALTER TABLE dragon_princess 
   ADD dragon_id integer not null;

ALTER TABLE dragon_princess 
   ADD CONSTRAINT dragon_id
   FOREIGN KEY (dragon_id)
   REFERENCES dragon(dragon_id);
   
ALTER TABLE dragon_princess 
   ADD princess_id integer not null;

ALTER TABLE dragon_princess 
   ADD CONSTRAINT princess_id
   FOREIGN KEY (princess_id)
   REFERENCES princess(princess_id);   
   
commit;

INSERT INTO dragon 
    (dragon_id, full_name, nickname, color, basic_element, sex, 
    date_of_birth, date_of_death, gold_reserve) 
WITH names AS (
    SELECT 1, 'Antipodean Opaleye', 'Winter Death', 'white', 'fire', 'm',
    '12.07.1970', NULL, 250000 FROM dual UNION ALL
    SELECT 2, 'Chinese Fireball', 'Firelord', 'red', 'fire', 'm',
    '2.09.1222', '17.03.1504', 23450000 FROM dual UNION ALL
    SELECT 3, 'Hebridean Black', 'Nightmare', 'black', 'water',
    'f', '21.04.1567', '14.04.1699', 1223582 FROM dual UNION ALL
    SELECT 4, 'Ridgeback', 'Earthquake', 'green', 'earth', 'm',
    '14.01.920', '03.02.1021', 2357 FROM dual UNION ALL
    SELECT 5, 'Peruvian Vipertooth', 'Viper', 'green', 'air',
    'f', '30.08.1833', '15.12.1917', 34521 FROM dual UNION ALL
    SELECT 6, 'Carpathian Demon', 'Longhorn', 'purple', 'fire',
    'f', '07.07.1235', '29.05.1478', 244712 FROM dual UNION ALL
    SELECT 7, 'Swedish Ironhead', 'Short-Snout', 'gray', 'earth',
    'm', '26.02.1482', '23.03.1829', 236367414 FROM dual UNION ALL
    SELECT 8, 'Ancalagon The Black', 'End Is Here', 'black', 'fire',
    'm', '01.01.267', '31.12.1476', 999999 FROM dual
) 
SELECT * FROM names;

INSERT INTO princess 
    (princess_id, first_name, last_name, kingdom, date_of_birth, 
    date_of_death, hair_color) 
WITH names AS (
    SELECT 1, 'Luna', 'Burton', 'Arnor', '15.03.1886', '19.03.1893', 
    'white' FROM dual UNION ALL
    SELECT 2, 'Aurora', 'Caldwell', 'Gondor', '11.09.1015', '26.07.1099',
    'maroon' FROM dual UNION ALL
    SELECT 3, 'Daphne', 'Parsons', 'Rohan', '16.04.1889', '26.07.1912',
    'gray' FROM dual UNION ALL
    SELECT 4, 'Amelia', 'Maddox', 'Dale', '14.11.1300', '16.08.1369',
    'fuchsia' FROM dual UNION ALL
    SELECT 5, 'Genevieve', 'Stone', 'Mirkwood', '12.12.1999', NULL,
    'white' FROM dual UNION ALL
    SELECT 6, 'Hazel', 'Valenzuela', 'Haradrim', '09.10.1412', '13.11.1427',
    'orange' FROM dual UNION ALL
    SELECT 7, 'Brunhilda', 'Black', 'Mordor', '10.10.101', NULL,
    'black' FROM dual UNION ALL
    SELECT 8, 'Daisy', 'Underwood', 'Arnor', '01.07.1342', '30.12.1420',
    'gray' FROM dual UNION ALL
    SELECT 9, 'Millie', 'Navarro', 'Corona', '18.05.1792', '04.04.1833',
    'white' FROM dual UNION ALL
    SELECT 10, 'Calliope', 'Sullivan', 'Arendelle', '30.12.1001', '19.08.1028',
    'orange' FROM dual UNION ALL
    SELECT 11, 'Ella', 'Stephenson', 'Maldonia', '08.08.1658', '08.08.1703',
    'black' FROM dual UNION ALL
    SELECT 12, 'Mia', 'Huff', 'Arnor', '19.02.1969', NULL,
    'orange' FROM dual UNION ALL
    SELECT 13, 'Jasmine', 'Rose', 'Agrabah', '19.09.1601', '02.05.1725',
    'blue' FROM dual UNION ALL
    SELECT 14, 'Arwen', 'Munoz', 'Haradrim', '25.05.1480', '29.01.1509',
    'black' FROM dual UNION ALL
    SELECT 15, 'Odette', 'Donaldson', 'Arnor', '16.06.1250', '27.10.1307',
    'white' FROM dual
) 
SELECT * FROM names;

INSERT INTO dragon_princess 
    (dragon_princess_id, date_of_kidnapping, place_of_confinement, date_of_liberation, liberated_knight, dragon_id, princess_id) 
WITH names AS (
    SELECT 1, '14.12.1315', 'Eisonar Tower', NULL, NULL, 2, 4 FROM dual UNION ALL
    SELECT 2, '11.08.1427', 'The Pulse Spire', NULL, NULL, 6, 6 FROM dual UNION ALL
    SELECT 3, '23.04.1673', 'Feedback Lokout', NULL, NULL, 7, 11 FROM dual UNION ALL
    SELECT 4, '27.03.1904', 'Arch', NULL, NULL, 5, 3 FROM dual UNION ALL
    SELECT 5, '18.10.1495', 'Obelish Of Obivan', '17.03.1504', 'Addy the Selfish', 2, 14 FROM dual UNION ALL
    SELECT 6, '05.02.1686', 'Uknawahl Tower', '14.04.1699', 'Farmanus the Giant', 3, 13 FROM dual UNION ALL
    SELECT 7, '30.09.1020', 'Zipiryx', '03.02.1021', 'Mactildis the Handsome', 4, 2 FROM dual UNION ALL
    SELECT 8, '02.11.1901', 'Lonely Tower', '15.12.1917', 'Hugolinus the Sentinel', 5, 1 FROM dual UNION ALL
    SELECT 9, '11.07.1807', 'Burrowing Ton', '23.03.1829', 'Amelyn the Clumsy', 7, 9 FROM dual
) 
SELECT * FROM names;

commit;

INSERT INTO dragon_princess (dragon_princess_id, date_of_kidnapping, place_of_confinement, 
date_of_liberation, liberated_knight, dragon_id, princess_id) 
   VALUES (1, '14.12.1315', 'Eisonar Tower', NULL, NULL, 2, 4);
   
INSERT INTO dragon_princess (dragon_princess_id, date_of_kidnapping, place_of_confinement, 
date_of_liberation, liberated_knight, dragon_id, princess_id) 
   VALUES (2, '11.08.1427', 'The Pulse Spire', NULL, NULL, 6, 6);      

INSERT INTO dragon_princess (dragon_princess_id, date_of_kidnapping, place_of_confinement, 
date_of_liberation, liberated_knight, dragon_id, princess_id) 
   VALUES (3, '23.04.1673', 'Feedback Lokout', NULL, NULL, 7, 11);      
   
INSERT INTO dragon_princess (dragon_princess_id, date_of_kidnapping, place_of_confinement, 
date_of_liberation, liberated_knight, dragon_id, princess_id) 
   VALUES (4, '27.03.1904', 'Arch', NULL, NULL, 5, 3);    

INSERT INTO dragon_princess (dragon_princess_id, date_of_kidnapping, place_of_confinement, 
date_of_liberation, liberated_knight, dragon_id, princess_id) 
   VALUES (5, '18.10.1495', 'Obelish Of Obivan', '17.03.1504', 'Addy the Selfish', 2, 14);    


INSERT INTO dragon_princess (dragon_princess_id, date_of_kidnapping, place_of_confinement, 
date_of_liberation, liberated_knight, dragon_id, princess_id) 
   VALUES (6, '05.02.1686', 'Uknawahl Tower', '14.04.1699', 'Farmanus the Giant', 3, 13);    

INSERT INTO dragon_princess (dragon_princess_id, date_of_kidnapping, place_of_confinement, 
date_of_liberation, liberated_knight, dragon_id, princess_id) 
   VALUES (7, '30.09.1020', 'Zipiryx', '03.02.1021', 'Mactildis the Handsome', 4, 2);    

INSERT INTO dragon_princess (dragon_princess_id, date_of_kidnapping, place_of_confinement, 
date_of_liberation, liberated_knight, dragon_id, princess_id) 
   VALUES (8, '02.11.1901', 'Lonely Tower', '15.12.1917', 'Hugolinus the Sentinel', 5, 1);    
   
INSERT INTO dragon_princess (dragon_princess_id, date_of_kidnapping, place_of_confinement, 
date_of_liberation, liberated_knight, dragon_id, princess_id) 
   VALUES (9, '11.07.1807', 'Burrowing Ton', '23.03.1829', 'Amelyn the Clumsy', 7, 9);   
   
UPDATE princess SET kingdom = 'Euphiophea' WHERE first_name = 'Ella' and last_name = 'Stephenson';
   
UPDATE princess SET hair_color = 'gold' WHERE date_of_birth >= '01.01.1850';   

UPDATE dragon SET gold_reserve = gold_reserve * 0.1;

DELETE FROM princess WHERE first_name = 'Odette' and last_name = 'Donaldson';

DELETE FROM princess WHERE date_of_death is null;

DELETE FROM dragon_princess;

SELECT * FROM dragon_princess;

SELECT * FROM dragon;

SELECT date_of_birth, date_of_death, date_of_death - date_of_birth FROM princess;   

commit;

SELECT * FROM princess WHERE kingdom LIKE '_____';

SELECT full_name, color, gold_reserve, date_of_birth FROM dragon 
  WHERE date_of_birth > '01.01.1789' or date_of_birth <= '13.06.1239'
  ORDER BY date_of_death;

SELECT dragon_princess_id, place_of_confinement, liberated_knight FROM dragon_princess
  WHERE (dragon_id + princess_id)/2 != 3;


SELECT MAX(nickname) FROM dragon;

SELECT MAX(gold_reserve) FROM dragon 
  WHERE date_of_death - date_of_birth < 60000;

SELECT COUNT(*) FROM princess;

SELECT COUNT(date_of_death) FROM princess 
  WHERE hair_color != 'white';

SELECT MIN(liberated_knight) FROM dragon_princess;

SELECT MIN(date_of_liberation - date_of_kidnapping) 
  FROM dragon_princess 
  WHERE date_of_liberation is not null;
  
SELECT dragon.dragon_id, dragon.full_name, dragon.basic_element, 
dragon_princess.dragon_princess_id, dragon_princess.place_of_confinement,
dragon_princess.liberated_knight
  FROM dragon, dragon_princess 
  WHERE dragon.dragon_id = dragon_princess.dragon_id 
and dragon.basic_element = 'water';  

SELECT dp.date_of_liberation, dp.place_of_confinement,
d.full_name, d.nickname, d.basic_element, 
p.first_name, p.last_name, p.kingdom, p.hair_color, dp.liberated_knight
  FROM dragon d, dragon_princess dp, princess p 
  WHERE d.dragon_id = dp.dragon_id and p.princess_id = dp.princess_id
  and (dp.liberated_knight is null or 
(p.hair_color != 'black' and p.hair_color != 'white'))
  ORDER BY dp.date_of_liberation DESC;  
  
  
