
CREATE TABLE koht (
koht_id integer not null primary key,
maakond varchar(50) not null,
linn_kula varchar(50) null,
tanav varchar(50) null,
maja varchar(50) null,
korter_ruum varchar(50) null 
);

CREATE TABLE isik (
isik_id integer not null primary key,
eesnimi varchar(50) not null,
perekonnanimi varchar(50) not null,
sunnipaev date null,
surmapaev date null,
telefoni_number varchar(20) null, 
e_mail varchar(50) null,
koht_id integer null,
FOREIGN KEY (koht_id)  
  REFERENCES koht (koht_id)
);

CREATE TABLE koer (
koer_id integer not null primary key,
nimi varchar(100) null,
huudnimi varchar(50) not null,
toug varchar(100) not null,
reg_kood varchar(50) null,
sugu character not null,
esimene_vaktsiin character not null,
teine_vaktsiin character not null,
sunnipaev date null,
surmapaev date null
);

CREATE TABLE roll (
roll_id integer not null primary key,
kood varchar(50) not null,
nimetus varchar(50) not null,
tuup varchar(50) not null
);

CREATE TABLE koer_isikul (
koer_isikul_id integer not null primary key,
alates date not null,
kuni date null,
koer_id integer not null,
isik_id integer not null,
roll_id integer not null,
FOREIGN KEY (koer_id)  
  REFERENCES koer (koer_id),
FOREIGN KEY (isik_id)  
  REFERENCES isik (isik_id),  
FOREIGN KEY (roll_id)  
  REFERENCES roll (roll_id)    
);
CREATE TABLE isik_rollis (
isik_rollis_id integer not null primary key,
alates date not null,
kuni date null,
roll_id integer not null,
isik_id integer not null,
FOREIGN KEY (roll_id)  
  REFERENCES roll (roll_id),
FOREIGN KEY (isik_id)  
  REFERENCES isik (isik_id)  
);

CREATE TABLE tegevus (
tegevus_id integer not null primary key,
kood varchar(50) not null,
nimetus varchar(50) not null,
kirjeldus varchar(2000) null
);

CREATE TABLE rolli_tegevus (
rolli_tegevus_id integer not null primary key,
alates date not null,
kuni date null,
roll_id integer not null,
tegevus_id integer not null,
FOREIGN KEY (roll_id)  
  REFERENCES roll (roll_id),
FOREIGN KEY (tegevus_id)  
  REFERENCES tegevus (tegevus_id)  
);

CREATE TABLE makse_tuup (
makse_tuup_id integer not null primary key,
kood varchar(50) not null,
nimetus varchar(50) not null,
kommentaar varchar(50) null
);

CREATE TABLE arve (
arve_id integer not null primary key,
nr varchar(20) not null,
klient varchar(50) not null,
kuupaev date not null,
tahtaeg date not null,
summa_kmta decimal not null, 
allahindlus_kmta decimal not null, 
summa_allahindlusega_kmta decimal not null, 
km decimal not null, 
summa_allahindlusega_kmga decimal not null, 
isik_id integer null,
FOREIGN KEY (isik_id)  
  REFERENCES isik (isik_id)
);

CREATE TABLE urituse_tuup (
urituse_tuup_id integer not null primary key,
nimetus varchar(100) not null,
kood varchar(50) not null,
tundide_arv integer null,
programm varchar(2000) null,
noutav_urituse_tuup_id integer null,
FOREIGN KEY (noutav_urituse_tuup_id)  
  REFERENCES urituse_tuup (urituse_tuup_id)
);

CREATE TABLE uritus (
uritus_id integer not null primary key,
nimetus varchar(100) not null,
kood varchar(50) not null,
liik varchar(20) not null,
tundi_formaat character not null,
avatud character not null,
osalejate_min integer not null,
osalejate_maks integer null,
kirjeldus varchar(2000) null,
alates timestamp not null,
kuni timestamp not null,
koht_id integer null,
urituse_tuup_id integer not null,
FOREIGN KEY (koht_id)  
  REFERENCES koht (koht_id),
FOREIGN KEY (urituse_tuup_id)  
  REFERENCES urituse_tuup (urituse_tuup_id)
);

CREATE TABLE arve_makse (
arve_makse_id integer not null primary key,
kood varchar(50) not null,
maksmise_aeg date not null,
summa decimal not null,
arve_id integer not null,
makse_tuup_id integer not null,
isik_id integer null,
FOREIGN KEY (arve_id)  
  REFERENCES arve (arve_id),
FOREIGN KEY (makse_tuup_id)  
  REFERENCES makse_tuup (makse_tuup_id),  
FOREIGN KEY (isik_id)  
  REFERENCES isik (isik_id)    
);

CREATE TABLE arve_rida (
arve_rida_id integer not null primary key,
rea_kirjeldus varchar(2000) not null,
hind_kmta decimal not null,
kogus decimal not null, 
summa_kmta decimal not null, 
allahindluse_prots decimal not null, 
allahindlus_kmta decimal not null, 
summa_allahindlusega_kmta decimal not null, 
km_prots decimal not null, 
km decimal not null, 
summa_allahindlusega_kmga decimal not null, 
arve_id integer not null,
uritus_id integer null,
FOREIGN KEY (arve_id)  
  REFERENCES arve (arve_id),
FOREIGN KEY (uritus_id)  
  REFERENCES uritus (uritus_id)    
);

CREATE TABLE hind (
hind_id integer not null primary key,
hind decimal not null,
alates date not null,
kuni date null,
uritus_id integer not null,
FOREIGN KEY (uritus_id)  
  REFERENCES uritus (uritus_id)   
);

CREATE TABLE registreerimine (
registreerimine_id integer not null primary key,
kood varchar(50) not null,
soovitav_algus timestamp null,
soovitav_lopp timestamp null,
kommentaar varchar(2000) null,
roll_id integer not null,
koer_id integer null,
reg_isik_id integer not null,
osalev_isik_id integer not null,
uritus_id integer not null,
FOREIGN KEY (roll_id)  
  REFERENCES roll (roll_id),
FOREIGN KEY (koer_id)  
  REFERENCES koer (koer_id),  
FOREIGN KEY (reg_isik_id)  
  REFERENCES isik (isik_id),  
FOREIGN KEY (osalev_isik_id)  
  REFERENCES isik (isik_id),  
FOREIGN KEY (uritus_id)  
  REFERENCES uritus (uritus_id)    
);

commit;
rollback;
INSERT INTO koht 
    (koht_id, maakond, linn_kula, tanav, maja, korter_ruum) 
WITH names AS (
    SELECT 1, 'Ida-Virumaa', 'Narva', 'Moisa', '1', null FROM dual UNION ALL
    SELECT 2, 'Ida-Virumaa', 'Narva', 'Paul Kerese', '20', '12' FROM dual UNION ALL
    SELECT 3, 'Ida-Virumaa', 'Narva', 'Rakvere', '22', null FROM dual UNION ALL    
    SELECT 4, 'Ida-Virumaa', 'Narva', 'Hariduse', '22', null FROM dual
) 
SELECT * FROM names;

INSERT INTO roll 
    (roll_id, kood, nimetus, tuup) 
WITH names AS (
    SELECT 1, 'org-1', 'korraldaja', 'klubis' FROM dual UNION ALL
    SELECT 2, 'org-2', 'treener', 'klubis' FROM dual UNION ALL
    SELECT 3, 'kl-1', 'klubi liikme', 'klubis' FROM dual UNION ALL  
    SELECT 4, 'kl-0', 'osaleja', 'klubis' FROM dual UNION ALL  
    SELECT 5, 'k-1', 'omanik', 'koeraga' FROM dual UNION ALL  
    SELECT 6, 'k-2', 'kaasomanik', 'koeraga' FROM dual UNION ALL              
    SELECT 7, 'k-3', 'tegelev isik', 'koeraga' FROM dual
) 
SELECT * FROM names;

INSERT INTO isik 
    (isik_id, eesnimi, perekonnanimi, sunnipaev, surmapaev, telefoni_number, e_mail, koht_id) 
WITH names AS (
    SELECT 1, 'Tatjana', 'Zamorskaja', '18.12.1980', (null), '+37223643784', 'tatjana@gmail.com', NULL FROM dual UNION ALL
    SELECT 2, 'Vitali', 'Zamorski', '05.10.2001', NULL, '+3722365342', 'vitali@gmail.com', NULL FROM dual UNION ALL
    SELECT 3, 'Jose', 'Hawkins', '23.04.1986', NULL, '+372643176', 'jose@gmail.com', NULL FROM dual UNION ALL
    SELECT 4, 'Wayne', 'Lee', '11.02.1989', NULL, '+372368235', 'wayne@gmail.com', NULL FROM dual UNION ALL
    SELECT 5, 'Roberto', 'Rodriguez', '13.12.1980', NULL, '+3725223731', 'roberto@gmail.com', NULL FROM dual UNION ALL
    SELECT 6, 'Allen', 'Moody', '22.12.1980', NULL, '+372872154', 'allen@gmail.com', NULL FROM dual UNION ALL
    SELECT 7, 'Ralph', 'Valdez', '26.12.1980', NULL, '+372232363', 'ralph@gmail.com', NULL FROM dual UNION ALL
    SELECT 8, 'Duane', 'Hall', '03.12.1980', NULL, '+3729871234', 'duane@gmail.com', NULL FROM dual UNION ALL
    SELECT 9, 'Steven', 'Moreno', '14.12.1980', NULL, '+372631742', 'steven@gmail.com', NULL FROM dual UNION ALL
    SELECT 10, 'Robert', 'Johnson', '06.12.1980', NULL, '+3721142742', 'robert@gmail.com', NULL FROM dual UNION ALL
    SELECT 11, 'Ryan', 'Silva', '06.12.1980', NULL, '+372880923', 'ryan@gmail.com', NULL FROM dual
) 
SELECT * FROM names;

INSERT INTO koer 
    (koer_id, nimi, huudnimi, toug, reg_kood, sugu, esimene_vaktsiin, teine_vaktsiin, sunnipaev, surmapaev) 
WITH names AS (
    SELECT 1, 'Baltic Toy Star Flash', 'Isaac', 'Inglise Springerspanjel', '233026978028934', 
    'F', 'Y', 'N', '05.06.2020', (null) FROM dual UNION ALL     
    SELECT 2, 'Elfborg Zanzibar', 'Avery', 'Lhasa Apso', '643094100536959', 
    'M', 'Y', 'Y', '03.12.2018', (null) FROM dual UNION ALL          
    SELECT 3, 'Blue Sirius Make a Memory', 'Bernard', 'Papillon', '233026978018802', 
    'F', 'Y', 'Y', '01.02.2019', (null) FROM dual UNION ALL          
    SELECT 4, 'Astersland Orange Ocean', 'Brownie', 'Cavalier King Charles Spanjel', '233026978019793', 
    'M', 'Y', 'Y', '13.03.2020', (null) FROM dual UNION ALL          
    SELECT 5, 'Allie Valencia', 'Chaser', 'Havanna Bichon', '112060000056647', 
    'F', 'Y', 'N', '20.02.2020', (null) FROM dual UNION ALL          
    SELECT 6, 'Inkery Line Marissa Berrenson', 'Collin', 'Prantsuse Buldog', '643094800090125', 
    'F', 'Y', 'Y', '22.11.2018', (null) FROM dual UNION ALL          
    SELECT 7, 'Percoro Solare Amore Mio', 'Donald', 'Eesti Hagijas', '528140000787857', 
    'M', 'N', 'N', '15.08.2020', (null) FROM dual UNION ALL          
    SELECT 8, 'On-the Rise Ingrid', 'Dylan', 'Beagle', '233098100013565', 
    'F', 'Y', 'Y', '26.12.2018', (null) FROM dual UNION ALL          
    SELECT 9, 'Elga Star Kassandra', 'Ember', 'Vene-Euroopa Laika', '380260101178333', 
    'F', 'Y', 'Y', '26.06.2020', (null) FROM dual UNION ALL          
    SELECT 10, 'Ruta Del SOL Sahara Sun', 'Everet', 'Samojeedi Koer', '440078999002000', 
    'F', 'Y', 'Y', '04.07.2019', (null) FROM dual UNION ALL          
    SELECT 11, 'Vinzenta Temi Valiant Gio Philippe', 'Fletcher', 'Keeshond Wolfspitz', '978101082590186', 
    'M', 'Y', 'Y', '12.07.2017', (null) FROM dual UNION ALL          
    SELECT 12, 'Bonwinner Intriga Svetol', 'Fury', 'Basenji', '752093200158633', 
    'F', 'Y', 'Y', '01.08.2020', (null) FROM dual UNION ALL          
    SELECT 13, 'Tati From House Snickers', 'Gibson', 'Jack Russell’I Terjer', '616099120028048', 
    'M', 'Y', 'Y', '14.01.2017', (null) FROM dual UNION ALL          
    SELECT 14, 'Vinzenta Temi Orlando Bloom', 'Gustav', 'Hispaania Veekoer', '945000005139961', 
    'M', 'Y', 'Y', '19.12.2018', (null) FROM dual UNION ALL          
    SELECT 15, 'Cavatier Allen-Batist', 'Hodor', 'Lakelandi Terjer', '934000011246578', 
    'M', 'Y', 'Y', '24.12.2010', (null) FROM dual UNION ALL          
    SELECT 16, 'Milbu Tucker King', 'Hartford', 'Siledakarvaline Retriiver', '392146000544000',
    'M', 'Y', 'Y', '31.10.2018', (null) FROM dual UNION ALL          
    SELECT 17, 'Jazz Band Dummles', 'Abbot', 'Welsh Corgi Cardigan', '616093900890283', 
    'M', 'Y', 'Y', '07.07.2019', (null) FROM dual UNION ALL      
    SELECT 18, 'Carmina Gadelica Lucky Luna', 'Joker', 'Shiba', '112060000036753', 
    'M', 'Y', 'Y', '15.03.2016', (null) FROM dual UNION ALL              
    SELECT 19, 'Cheeryflame Lilu', 'Laser', 'Ameerika Akita', '992000000076095', 
    'F', 'Y', 'Y', '22.11.2020', (null) FROM dual
) 
SELECT * FROM names;

INSERT INTO koer_isikul(koer_isikul_id, alates, kuni, roll_id, koer_id, isik_id) 
VALUES 
(1, '07.06.2020', null, 5, 1, 3);
INSERT INTO koer_isikul(koer_isikul_id, alates, kuni, roll_id, koer_id, isik_id) 
VALUES 
(2, '05.12.2018', null, 6, 2, 2);
INSERT INTO koer_isikul(koer_isikul_id, alates, kuni, roll_id, koer_id, isik_id) 
VALUES 
(3, '05.12.2018', null, 6, 2, 4);
INSERT INTO koer_isikul(koer_isikul_id, alates, kuni, roll_id, koer_id, isik_id) 
VALUES 
(4, '20.06.2021', null, 7, 4, 5);
INSERT INTO koer_isikul(koer_isikul_id, alates, kuni, roll_id, koer_id, isik_id) 
VALUES 
(5, '01.02.2019', null, 5, 5, 1);
INSERT INTO koer_isikul(koer_isikul_id, alates, kuni, roll_id, koer_id, isik_id) 
VALUES 
(6, '19.06.2019', null, 5, 6, 1);
INSERT INTO koer_isikul(koer_isikul_id, alates, kuni, roll_id, koer_id, isik_id) 
VALUES 
(7, '10.10.2020', null, 5, 7, 1);
INSERT INTO koer_isikul(koer_isikul_id, alates, kuni, roll_id, koer_id, isik_id) 
VALUES 
(8, '01.09.2019', null, 7, 10, 6);
INSERT INTO koer_isikul(koer_isikul_id, alates, kuni, roll_id, koer_id, isik_id) 
VALUES 
(9, '19.08.2015', null, 7, 15, 9);

INSERT INTO urituse_tuup 
    (urituse_tuup_id, nimetus, kood, programm, tundide_arv, noutav_urituse_tuup_id) 
WITH names AS (
    SELECT 1, 'Baaskursus', 'BK-0', 'kontakt koeraga segavate tegurite ja stiimulite ajal, 
    vahese treeningu korral, istuge vahese kokkupuutega, lamage 
    vahese kokkupuutega, barjaar', '36', null FROM dual UNION ALL
    SELECT 2, 'Sotsialisatsioon', 'S-0', 'suhtlemine omasugustega treeneri 
    kae all - opime ara tundma teiste koerte marke ja 
    rahumeelselt suhtlema, erinevate objektide ja pindadega tutvust, 
    takistuste uletamist ja enesekindluse tostmist', '24', null FROM dual UNION ALL  
    SELECT 3, 'Tantsid koeraga', 'F-3', null, '24', 1 FROM dual UNION ALL 
    SELECT 4, 'Mini-agility', 'F-4', 'Agility on spordiv?istluste kompleks, mis koosneb takistusraja 
    kiirest labimisest. Nii harjutusi sooritav lemmikloom kui omanik on vahetult seotud voistlustega, 
    andes testide ja haalega kasklusi ning juhendades oma hoolealust, seetottu on sellised 
    uritused meeskondliku iseloomuga.', '15', null FROM dual UNION ALL 
    SELECT 5, 'Advanced Baaskursus', 'BK-1', 'kontakt koeraga vooraste koerte ja inimeste l?henemisel, 
    harjutus korvuti parema lahenemise arendamiseks, istuda hea vastupidavusega pluss liikumisest, 
    lamamine hea vastupidavusega pluss liikumisest', '36', 1 FROM dual UNION ALL              
    SELECT 6, 'Fuusiline areng', 'F-5', '?petame koera tundma oma keha, opetame taluma igasuguseid 
    puudutusi ja protseduure, opime erinevaid pindu ja takistusi, jahutame ja soojendame, harjutusi 
    koera fuusiliseks arendamiseks kodus voi tanaval', '24', null FROM dual UNION ALL  
    SELECT 7, '0', '0', null, null, null FROM dual    
) 
SELECT * FROM names;

INSERT INTO uritus(uritus_id, nimetus, kood, liik, tundi_formaat, avatud, 
osalejate_min, osalejate_maks, kirjeldus, alates, kuni, koht_id, urituse_tuup_id) 
VALUES 
(1, 'Kutsikate Baaskursus', 'BK-0-K-10/12/21', 'kursus', 'M', 'C', 3, 15, (null), '10.12.2021 18:00:00', '05.01.2022 21:00:00', 1, 2);
INSERT INTO uritus(uritus_id, nimetus, kood, liik, tundi_formaat, avatud, 
osalejate_min, osalejate_maks, kirjeldus, alates, kuni, koht_id, urituse_tuup_id) 
VALUES 
(2, 'Kutsikate Baaskursus', 'BK-0-K-03/01/22', 'kursus', 'M', 'C', 3, 15, (null), '03.01.22 16:00:00', '22.01.22 19:00:00', 1, 1);
INSERT INTO uritus(uritus_id, nimetus, kood, liik, tundi_formaat, avatud, 
osalejate_min, osalejate_maks, kirjeldus, alates, kuni, koht_id, urituse_tuup_id) 
VALUES 
(3, 'BK-0-K-10/12/21 Treening 6', 'BK-0-K-T-10/12/21', 'treening', 'P', 'C', 3, 15, (null), '23.12.21 18:00:00', '23.12.21 21:00:00', 1, 7);
INSERT INTO uritus(uritus_id, nimetus, kood, liik, tundi_formaat, avatud, 
osalejate_min, osalejate_maks, kirjeldus, alates, kuni, koht_id, urituse_tuup_id) 
VALUES 
(4, 'BK-0-K-10/12/21 Treening 7', 'BK-0-K-T-10/12/21', 'treening', 'P', 'C', 3, 15, (null), '25.12.21 18:00:00', '25.12.21 21:00:00', 1, 7);
INSERT INTO uritus(uritus_id, nimetus, kood, liik, tundi_formaat, avatud, 
osalejate_min, osalejate_maks, kirjeldus, alates, kuni, koht_id, urituse_tuup_id) 
VALUES 
(5, 'BK-0-K-03/01/21 Treening 1', 'BK-0-K-T-03/01/21', 'treening', 'L', 'C', 3, 15, (null), '03.01.22 16:00:00', '03.01.22 19:00:00', 1, 7);
INSERT INTO uritus(uritus_id, nimetus, kood, liik, tundi_formaat, avatud, 
osalejate_min, osalejate_maks, kirjeldus, alates, kuni, koht_id, urituse_tuup_id) 
VALUES 
(6, 'Kl?psajate koolitus', 'SR-L-13', 'seminar', 'L', 'C', 5, 60, 'Kl?psukoolitus algajatele Svetlana Zolotnikovaga', 
    '16.12.21 11:30:00', '16.12.21 17:00:00', 2, 7);
INSERT INTO uritus(uritus_id, nimetus, kood, liik, tundi_formaat, avatud, 
osalejate_min, osalejate_maks, kirjeldus, alates, kuni, koht_id, urituse_tuup_id) 
VALUES 
(7, 'Hasky Grooming', 'T-GR-256', 'teenus', 'M', 'C', 1, 1, (null), '22.12.21 15:30:00', '22.12.21 17:00:00', 1, 7);
INSERT INTO uritus(uritus_id, nimetus, kood, liik, tundi_formaat, avatud, 
osalejate_min, osalejate_maks, kirjeldus, alates, kuni, koht_id, urituse_tuup_id) 
VALUES 
(8, 'Konsultatsioon', 'T-KL-134', 'teenus', 'L', 'C', 1, 3, (null), '22.12.21 11:00:00', '22.12.21 12:30:00', (null), 7);
INSERT INTO uritus(uritus_id, nimetus, kood, liik, tundi_formaat, avatud, 
osalejate_min, osalejate_maks, kirjeldus, alates, kuni, koht_id, urituse_tuup_id) 
VALUES 
(9, 'Seminar "Kuulekuse tehniline pool"', 'SR-P-14', 'seminar', 'P', 'O', 5, 35, (null), '27.12.21 14:00:00', '27.12.21 20:00:00', 1, 7);

INSERT INTO registreerimine(registreerimine_id, kood, soovitav_algus, soovitav_lopp, kommentaar, 
roll_id, koer_id, reg_isik_id, osalev_isik_id, uritus_id) 
VALUES 
(1, 'REG-21-348', null, null, null, 2, null, 1, 2, 1);
INSERT INTO registreerimine(registreerimine_id, kood, soovitav_algus, soovitav_lopp, kommentaar, 
roll_id, koer_id, reg_isik_id, osalev_isik_id, uritus_id) 
VALUES 
(2, 'REG-21-353', null, null, null, 2, null, 1, 3, 2);
INSERT INTO registreerimine(registreerimine_id, kood, soovitav_algus, soovitav_lopp, kommentaar, 
roll_id, koer_id, reg_isik_id, osalev_isik_id, uritus_id) 
VALUES 
(3, 'REG-21-357', null, null, null, 4, null, 5, 5, 6);
INSERT INTO registreerimine(registreerimine_id, kood, soovitav_algus, soovitav_lopp, kommentaar, 
roll_id, koer_id, reg_isik_id, osalev_isik_id, uritus_id) 
VALUES 
(4, 'REG-21-358', '22.12.2021 15:00:00', null, null, 4, 15, 9, 9, 7);
INSERT INTO registreerimine(registreerimine_id, kood, soovitav_algus, soovitav_lopp, kommentaar, 
roll_id, koer_id, reg_isik_id, osalev_isik_id, uritus_id) 
VALUES 
(5, 'REG-21-360', '22.12.2021 11:00:00', '22.12.21 13:00:00', 'Kusimused ringikorraldaja kohta ja kenneliit oppemisega', 4, null, 11, 11, 8);
INSERT INTO registreerimine(registreerimine_id, kood, soovitav_algus, soovitav_lopp, kommentaar, 
roll_id, koer_id, reg_isik_id, osalev_isik_id, uritus_id) 
VALUES 
(6, 'REG-21-366', null, null, null, 4, 10, 10, 6, 9);
INSERT INTO registreerimine(registreerimine_id, kood, soovitav_algus, soovitav_lopp, kommentaar, 
roll_id, koer_id, reg_isik_id, osalev_isik_id, uritus_id) 
VALUES 
(7, 'REG-21-369', null, null, null, 4, 2, 4, 6, 1);
INSERT INTO registreerimine(registreerimine_id, kood, soovitav_algus, soovitav_lopp, kommentaar, 
roll_id, koer_id, reg_isik_id, osalev_isik_id, uritus_id) 
VALUES 
(8, 'REG-21-375', null, null, null, 4, 1, 1, 3, 1);

SELECT uritus_id, nimetus, kood, liik, avatud, tundi_formaat, alates, kuni 
FROM uritus
WHERE koht_id = '1' and alates > '23.12.2021 00:00:00' and kuni < '31.01.2022 00:00:00'
ORDER BY alates;

SELECT r.kood, r.uritus_id, r.soovitav_algus, r.soovitav_lopp,
i.eesnimi || ' ' || i.perekonnanimi AS isiku_nimi, 
i.telefoni_number, i.e_mail, r.koer_id, r.kommentaar
FROM registreerimine r, isik i
WHERE i.isik_id = r.osalev_isik_id and r.roll_id = '4'
ORDER BY r.uritus_id;

SELECT ki.isik_id, r.nimetus, ki.alates,
k.koer_id, k.nimi, k.huudnimi, k.toug, k.sugu
FROM koer_isikul ki, roll r, koer k
WHERE k.koer_id = ki.koer_id and r.roll_id = ki.roll_id
and k.surmapaev IS NULL and r.tuup = 'koeraga' and ki.kuni IS NULL
ORDER BY ki.isik_id;

DROP TABLE registreerimine;
DROP TABLE hind;
DROP TABLE arve_rida;
DROP TABLE arve_makse;
DROP TABLE uritus;
DROP TABLE urituse_tuup;
DROP TABLE arve;
DROP TABLE makse_tuup;
DROP TABLE rolli_tegevus;
DROP TABLE tegevus;
DROP TABLE isik_rollis;
DROP TABLE koer_isikul;
DROP TABLE roll;
DROP TABLE koer;
DROP TABLE isik;
DROP TABLE koht;

