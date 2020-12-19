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

-- Prototype Select
-- SELECT GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) SEPARATOR ', '), v.House_number, v.street_name, v.apartment_number, COUNT(*) FROM voters v WHERE party = 'DEM' GROUP BY House_number, street_name, apartment_number ORDER BY COUNT(*) DESC;

-- all sole voters in household
/* This exploits a mysql/mariadb quirk in that it selects columns - first_name and last_name - that are not 
   in the group by.  If there is more than one row in the group, the first_name and last_name are
	returned from the 'first' row. This is a syntatically inexpensive way to identify sole household 
	voters w/o joins or subqueries.  
*/
/* Option 1 - Generic Name for multi-households */
SELECT 'Name', 'Street Address', 'Apartment Number', 'City', 'State', 'Zip', 'Voters at Address', 'Names at address - Info Only'
UNION
( 
	-- Single household voters
	SELECT 
		proper(CONCAT(v.first_name, ' ', v.last_name)) AS Name, 
		concat(v.House_number, ' ', proper(v.street_name)) AS 'Street Address', v.apartment_number AS 'Apartment Number', proper(v.city) AS City, 'New York' AS State, v.zip_code AS Zip,
		COUNT(*),
      proper(CONCAT(v.first_name, ' ', v.last_name)) AS 'Names at address - Info Only'
	FROM 
		voters v 
	WHERE 
		party = 'DEM' 
	GROUP BY 
		v.House_number, v.street_name, v.apartment_number 
	HAVING COUNT(*) = 1 -- ORDER BY COUNT(*) DESC
UNION 
	-- all voters in household of more than 1 voter
	-- with generic name
	SELECT 
		'Democratic Voters at Residence', 
		concat(v.House_number, ' ', proper(v.street_name)) AS 'Street Address', v.apartment_number AS 'Apartment Number', proper(v.city) AS City, 'New York' AS State, v.zip_code AS Zip,
		COUNT(*),
		GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) order BY v.last_name, v.first_name SEPARATOR ', ') AS 'Names at address - Info Only'
	FROM 
		voters v 
	WHERE 
		party = 'DEM' 
	GROUP BY 
		House_number, street_name, apartment_number 
	HAVING 
		COUNT(*) > 1 
	ORDER BY 1
--		COUNT(*) DESC
)
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export/Mailer Option 1.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n'
;

/* Option 2 - Fit all names if they fit, otherwise, 1 name + Other Demo Voters 

SELECT 'Name', 'Street Address', 'Apartment Number', 'City', 'State', 'Zip', 'Voters at Address', 'Names at address - Info Only'
UNION
( 
	-- Single household voters
	SELECT 
		proper(CONCAT(v.first_name, ' ', v.last_name)) AS Name, 
		concat(v.House_number, ' ', proper(v.street_name)) AS 'Street Address', v.apartment_number AS 'Apartment Number', proper(v.city) AS City, 'New York' AS State, v.zip_code AS Zip,
		COUNT(*) ,
      CONCAT(v.first_name, ' ', v.last_name) AS 'Names at address - Info Only'
	FROM 
		voters v 
	WHERE 
		party = 'DEM' 
	GROUP BY 
		v.House_number, v.street_name, v.apartment_number 
	HAVING COUNT(*) = 1 -- ORDER BY COUNT(*) DESC
UNION 
	-- all voters in household of more than 1 voter
	-- with generic name
	SELECT 
		GROUP_CONCAT(CONCAT(proper(v.first_name), ' ', proper(v.last_name)) order BY v.last_name, v.first_name SEPARATOR '/') AS name, 
		concat(v.House_number, ' ', proper(v.street_name)) AS 'Street Address', v.apartment_number AS 'Apartment Number', proper(v.city) AS City, 'New York' AS State, v.zip_code AS Zip,
		COUNT(*),
		GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) order BY v.last_name, v.first_name SEPARATOR '/') AS FullName
	FROM 
		voters v 
	WHERE 
		party = 'DEM' 
	GROUP BY 
		v.House_number, v.street_name, v.apartment_number 
	HAVING 
		COUNT(*) > 1 and
		length(FullName) < 41
UNION 
	-- all voters in household of more than 1 voter
	-- with generic name
	SELECT 
		CONCAT(proper(v.first_name), ' ', proper(v.last_name), ' & other Democratic Residents') AS name, 
		concat(v.House_number, ' ', proper(v.street_name)) AS 'Street Address', v.apartment_number AS 'Apartment Number', proper(v.city) AS City, 'New York' AS State, v.zip_code AS Zip,
		COUNT(*),
		GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) order BY v.last_name, v.first_name SEPARATOR '/') AS 'FullName'
	FROM 
		voters v 
	WHERE 
		party = 'DEM' 
	GROUP BY 
		v.House_number, v.street_name, v.apartment_number 
	HAVING 
		COUNT(*) > 1 AND
		length(FullName) > 40
ORDER BY 1
)
;

/*













-- The above two cover all targeted voters
-- If we want more personalization for multi-households, this can be used to max out names that 'fit'
SELECT 'Name', 'Street Address', 'Apartment Number', 'City', 'State', 'Zip', 'Voters at Address', 'Names at address - Info Only'
UNION
( 
SELECT 
	GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) order BY v.last_name, v.first_name SEPARATOR ', ') AS name, 
	v.House_number, v.street_name, v.apartment_number, 
	COUNT(*) 
FROM 
	voters v 
WHERE 
	party = 'DEM' 
GROUP BY 
	House_number, street_name, apartment_number 
HAVING 
	COUNT(*) > 1 and length(NAME) < 41 
ORDER 
	BY COUNT(*) DESC;

-- couple the above with something like the below:
-- If all names in household don't fit, we can do one name + others
SELECT 
	CONCAT(v.first_name, ' ', v.last_name, ' and other Democratic Residents'), 
	GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) order BY v.last_name, v.first_name SEPARATOR ', ') AS NAME, 
	v.House_number, v.street_name, v.apartment_number, 
	COUNT(*) 
FROM 
	voters v 
WHERE 
	party = 'DEM' 
GROUP BY 
	House_number, street_name, apartment_number 
HAVING 
	COUNT(*) > 1 and 
	length(NAME) > 40 
ORDER BY 
	COUNT(*) DESC;
-- Can improve the above by selecting the voter with the most recent year_last_voted

-- If we want to use "&" or "and" seperator when there are only two, we can select those with just two voters in household
-- Note that seperator is longer than when we use ', ', which mmeans that what was under the max limit in previous SQL could be pushed over.
-- So we would need a companion SQL to pull those that get pushed to over the max limit
-- WOuld need to modify SQL that selects with ', ' to pull only those with 3 or more voters, instead of 2
SELECT 
	GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) order BY v.last_name, v.first_name SEPARATOR ' & ') AS name, 
	v.House_number, v.street_name, v.apartment_number, 
	COUNT(*)
FROM 
	voters v 
WHERE 
	party = 'DEM' 
GROUP BY 
	House_number, street_name, apartment_number 
HAVING 
	COUNT(*) = 2 AND 
	length(NAME) < 41 
ORDER BY 
	COUNT(*) DESC;

-- Companion SQL
SELECT 
	CONCAT(v.first_name, ' ', v.last_name, ' and other Democratic Residents'), 
	GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) order BY v.last_name, v.first_name SEPARATOR ' & ') AS name, 
	v.House_number, v.street_name, v.apartment_number, 
	COUNT(*)
FROM 
	voters v 
WHERE 
	party = 'DEM' 
GROUP BY 
	House_number, street_name, apartment_number 
HAVING 
	COUNT(*) = 2 AND 
	length(NAME) > 40 
ORDER BY 
	COUNT(*) DESC;
	
*/