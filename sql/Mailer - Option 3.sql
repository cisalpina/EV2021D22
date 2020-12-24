/*
Options
 1) Generic 'name' for multi-households
 2) Fit all names into the name field if they fit
    2a) For those that don't fit all voters, use just one name + string (such as other democratic voters)
    2b) For those that don't fit all voters, just go to the generic string (avoids de-personalizing the unnamed voters)
	x) Option for 2): for cases of two-voter households, use " &" seperator - Reads more "correct", but does it imply association of the two voters?
y) Proper case all names (and rest of address, for that matter)...

I'll do all.  That's
	1)
	2a)
	2b)
	Proper Case ALL of them
	will use "/" seperator instead of ", ".  Saves characaters and doesn't as strongly imply association
*/

-- Create function to convert to proper/camelcase
DROP FUNCTION IF EXISTS proper;
SET GLOBAL  log_bin_trust_function_creators=TRUE;
DELIMITER |
CREATE FUNCTION proper( str VARCHAR(128) )
RETURNS VARCHAR(128)
BEGIN
DECLARE c CHAR(1);
DECLARE s VARCHAR(128);
DECLARE i INT DEFAULT 1;
DECLARE bool INT DEFAULT 1;
DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';
SET s = LCASE( str );
WHILE i <= LENGTH( str ) DO   
    BEGIN
SET c = SUBSTRING( s, i, 1 );
IF LOCATE( c, punct ) > 0 THEN
SET bool = 1;
ELSEIF bool=1 THEN
BEGIN
IF c >= 'a' AND c <= 'z' THEN
BEGIN
SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));
SET bool = 0;
END;
ELSEIF c >= '0' AND c <= '9' THEN
SET bool = 0;
END IF;
END;
END IF;
SET i = i+1;
END;
END WHILE;
RETURN s;
END;
|
DELIMITER ;

-- SELECT 'Total Democratic Voters', COUNT(*) FROM voters WHERE party = 'DEM';
-- SELECT 'Total Democratic households', count(DISTINCT house_number, street_name, apartment_number) FROM voters WHERE party = 'DEM';


/* Option 3 - All names, regardless, period */

SELECT 'Name', 'Street Address', 'Apartment Number', 'City', 'State', 'Zip', 'Voters at Address', 'Names at address - Info Only'
UNION
( 
	SELECT 
		GROUP_CONCAT(distinct CONCAT(left(v.first_name,1), ' ', proper(v.last_name)) order BY v.year_last_voted desc, v.last_name, v.first_name SEPARATOR '/') AS name, 
		concat(v.House_number, v.house_number_suffix, ' ', proper(v.street_name)) AS 'Street Address', v.apartment_number AS 'Apartment Number', proper(v.city) AS City, 'New York' AS State, v.zip_code AS Zip,
		COUNT(*) VatAddr,
		GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) order BY v.last_name, v.first_name SEPARATOR ', ') AS FullName
	FROM 
		voters v 
	WHERE 
		v.party = 'DEM' and
		v.last_name != 'BULLARO' and
		v.id NOT IN ( '410780117' /*CABAN */, '304564442' /* Evie */, '305408196', '900100558' /*Litza & Aryeh */, '300541234', '306097826' /*George, Geraldine */ )
	GROUP BY 
		v.House_number, v.street_name, v.apartment_number, v.house_number_suffix
)
ORDER BY 7 desc
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export/Mailer Option 3.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n'
;
