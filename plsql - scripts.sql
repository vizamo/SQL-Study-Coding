"""---- Check Library Books Rents ----"""


SET SERVEROUTPUT ON

CREATE OR REPLACE PACKAGE volgu_otsing IS
  volgu_maar NUMBER := 0.005;
  PROCEDURE volgu_maaramine
  (l_isikukood IN VARCHAR2);
END volgu_otsing;
/

CREATE OR REPLACE PACKAGE BODY volgu_otsing IS
  FUNCTION volgu_suurus
    (l_isikukood IN VARCHAR2)
    RETURN NUMBER
  IS
    l_volg NUMBER;
  BEGIN
    SELECT SUM(((sysdate - l.laenutamise_kuupaev) * volgu_maar * r.hind))
    INTO l_volg
    FROM laenustused l, raamatud r
    WHERE l.shiffer = r.shiffer
    AND l.tagastamise_kuupaev IS NULL
    AND (sysdate - l.laenutamise_kuupaev) > 14
    AND l_isikukood = l.isikukood;
    RETURN (l_volg);
  END volgu_suurus;

  PROCEDURE volgu_maaramine
    (l_isikukood IN VARCHAR2)
  IS
  BEGIN
    IF volgu_suurus(l_isikukood) IS NULL
    THEN
        dbms_output.put_line('Sellisel lugejal pole võlgu.');
    ELSE
        dbms_output.put_line
        ('Sellise lugeja võlg on '||
        ROUND(volgu_suurus(l_isikukood), 2) ||' eurot.');
    END IF;
  END volgu_maaramine;
END volgu_otsing;
/


"""---- Email Validation ----"""


CREATE OR REPLACE PROCEDURE email_validation
IS
  t_eesnimi varchar2(40);
  t_perenimi varchar2(40);
  eesnimi_first_letter varchar2(1);
  eesnimi_second_letter varchar2(2);
  user_email varchar (40);
  does_exist char(1);
  invalid_email EXCEPTION;

  CURSOR tootaja IS SELECT * FROM tootajad;
  t_kirje tootaja%ROWTYPE;

  PROCEDURE letters_correlation IS BEGIN
    t_eesnimi := TRANSLATE(t_eesnimi, 'öäüõÖÄÜÕžŽ', 'oauoOAUOzZ');
    t_perenimi := TRANSLATE(t_perenimi, 'öäüõÖÄÜÕžŽ', 'oauoOAUOzZ');
  END letters_correlation;

  PROCEDURE eesnimi_f_correlation IS BEGIN
    eesnimi_first_letter := SUBSTR(t_eesnimi, 1, 1);
  END eesnimi_f_correlation;

  PROCEDURE eesnimi_s_correlation IS BEGIN
    eesnimi_second_letter := SUBSTR(t_eesnimi, 1, 2);
  END eesnimi_s_correlation;

  PROCEDURE merge_f_eesnimi_perenimi IS BEGIN
    user_email := LOWER(CONCAT(eesnimi_first_letter,t_perenimi));
    IF LENGTH(user_email) > 8
      THEN
        user_email := SUBSTR(user_email, 1, 8);
      END IF;
  END merge_f_eesnimi_perenimi;

  PROCEDURE merge_s_eesnimi_perenimi IS BEGIN
    user_email := LOWER(CONCAT(eesnimi_second_letter,t_perenimi));
    IF LENGTH(user_email) > 8
      THEN
        user_email := SUBSTR(user_email, 1, 8);
      END IF;
  END merge_s_eesnimi_perenimi;

BEGIN
  FOR t_kirje IN tootaja LOOP
    t_eesnimi := t_kirje.eesnimi;
    t_perenimi := t_kirje.perenimi;
    letters_correlation;
    eesnimi_f_correlation;
    merge_f_eesnimi_perenimi;

    SELECT COUNT(*) INTO does_exist FROM tootajad
    WHERE email LIKE CONCAT(user_email, '@itcollege.ee');
    IF does_exist != 0
      THEN
        eesnimi_s_correlation;
        merge_s_eesnimi_perenimi;
        SELECT COUNT(*) INTO does_exist FROM tootajad
        WHERE email LIKE CONCAT(user_email, '@itcollege.ee');
        IF does_exist != 0
        THEN
          RAISE invalid_email;
        END IF;
    END IF;

    user_email := CONCAT(user_email, '@itcollege.ee');

    UPDATE tootajad
    SET email = user_email
    WHERE eesnimi = t_kirje.eesnimi AND perenimi = t_kirje.perenimi;
    END LOOP;

    EXCEPTION
      WHEN invalid_email THEN
        dbms_output.put_line('Invalid email (too many same emails): ' || user_email);

END email_validation;
/


"""---- Students exams results validation ----"""


SET FEEDBACK OFF
SET PAGESIZE 20
SET VERIFY OFF
SET SERVEROUTPUT ON

DECLARE
 c char(1);
 i integer;
 id_is_not_exist integer := 1;
 id_right_type integer := 1;
 eksam_range integer := 0;

BEGIN

SELECT count(*) INTO id_is_not_exist
FROM kandidaadid
WHERE id = '&a_id';
IF id_is_not_exist = 1
THEN
dbms_output.put_line('ERROR: Selline kandidaat on juba olemas');
END IF;

IF LENGTH('&a_id') != 11
THEN dbms_output.put_line(
    'ERROR: Vale isikukoodi pikkus!');
    id_right_type := 0;
END IF;
FOR i IN 1 .. LENGTH('&a_id')
LOOP
  c:=SUBSTR('&a_id',i,1);
  IF c NOT IN ('1','2','3','4','5','6','7', '8', '9', '0')
    THEN dbms_output.put_line(
    'ERROR: Vale isikukood! '||i||'. sümbol on '||c);
    id_right_type := 0;
  END IF;
END LOOP;

IF &&a_mat >= 0 and &a_mat <= 100
AND &&a_vk >= 0 and &a_vk <= 100
AND &&a_ek >= 0 and &a_ek <= 100
THEN
eksam_range := 1;
ELSE
dbms_output.put_line('ERROR: Valed eksami punkti andmed!');
eksam_range := 0;
END IF;

IF id_right_type = 1 -- Check, does id have only 11 numbers
AND id_is_not_exist = 0 -- Check, does id is not already exist
AND eksam_range = 1 -- Check, does 3 exams have values in range 0-100
THEN GOTO insert_kandidaat;
ELSE
dbms_output.put_line('Please try again!');
END IF;
GOTO lopp;
<<insert_kandidaat>>
dbms_output.put_line('INSERTING');
INSERT INTO kandidaadid
(id, eesnimi, perenimi, matemaatika, voorkeel, emakeel)
VALUES
('&a_id', '&a_eesnimi', '&a_perenimi', '&a_mat', '&a_vk', '&a_ek');
<<lopp>>
null;
END;
/

CLEAR COLUMN
SET FEEDBACK ON


"""---- Student tasks completed check ----"""

ACCEPT nimi PROMPT 'Õppija eesniminimi ja perenimi (nagu Eesnimi Perenimi): '
ACCEPT aine PROMPT 'Õppeaine nimetus: '

SET FEEDBACK OFF
SET PAGESIZE 20
SET VERIFY OFF
SET SERVEROUTPUT ON

DECLARE
v_punkte number(5,2);
v_tood number (3,0);

BEGIN

SELECT SUM(k.punktid) INTO v_punkte
FROM lepikult.oppeained o, lepikult.yliopilased y,
(SELECT kursusekood, yliopilase_id, too_nr, MAX(punktid) as punktid
FROM lepikult.koduylesanded
GROUP BY yliopilase_id, kursusekood, too_nr) k
WHERE k.yliopilase_id = y.id
AND k.kursusekood = o.kood
AND upper(y.eesnimi ||' '|| y.perenimi) = upper('&nimi')
AND instr(upper(o.nimetus),upper('&aine')) > 0
GROUP BY y.id, y.eesnimi, y.perenimi;

SELECT COUNT(k.too_nr) INTO v_tood
FROM lepikult.oppeained o, lepikult.yliopilased y,
(SELECT kursusekood, yliopilase_id, too_nr, MAX(punktid) as punktid
FROM lepikult.koduylesanded
GROUP BY yliopilase_id, kursusekood, too_nr) k
WHERE k.yliopilase_id = y.id
AND k.kursusekood = o.kood
AND upper(y.eesnimi ||' '|| y.perenimi) = upper('&nimi')
AND instr(upper(o.nimetus),upper('&aine')) > 0
GROUP BY y.id, y.eesnimi, y.perenimi;

dbms_output.put_line(
'On saadetud: '||TO_CHAR(v_tood)||' tööd ning kokku on saanud '||
TO_CHAR(v_punkte)||' punkte');

END;
/
CLEAR COLUMN
SET FEEDBACK ON