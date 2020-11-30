ALTER TABLE `voters` 
ADD COLUMN SuperTriplePrime VARCHAR(1) CHARACTER SET utf8 COLLATE UTF8_BIN,
ADD COLUMN TriplePrime VARCHAR(1) CHARACTER SET utf8 COLLATE UTF8_BIN,
ADD COLUMN DoublePrime VARCHAR(1) CHARACTER SET utf8 COLLATE UTF8_BIN,
ADD COLUMN Prime VARCHAR(1) CHARACTER SET utf8 COLLATE UTF8_BIN,
ADD COLUMN ExtendedPrime VARCHAR(1) CHARACTER SET utf8 COLLATE UTF8_BIN
;

UPDATE voters SET SuperTriplePrime = 'N';
UPDATE voters SET TriplePrime = 'N';
UPDATE voters SET DoublePrime = 'N';
UPDATE voters SET Prime = 'N';
UPDATE voters SET ExtendedPrime = 'N';

UPDATE voters SET SuperTriplePrime = 'Y' WHERE id IN 
(
	SELECT
		v.id
	FROM
		voters v,
		history h
	WHERE 
		h.voter_id = v.id and
		h.election_type IN ('PP', 'PR') and
		h.election_date > '2018-01-01'
		and v.party IN ('DEM', 'D')
	GROUP BY 
		v.id
	HAVING
		COUNT(*) > 2
);

UPDATE voters SET TriplePrime = 'Y' WHERE id IN 
(
	SELECT
		v.id
	FROM
		voters v,
		history h
	WHERE 
		h.voter_id = v.id and
		h.election_type IN ('PP', 'PR') and
		h.election_date > '2008-01-01'
		and v.party IN ('DEM', 'D')
	GROUP BY 
		v.id
	HAVING
		COUNT(*) > 2
);

UPDATE voters SET DoublePrime = 'Y' WHERE id IN 
(
	SELECT
		v.id
	FROM
		voters v,
		history h
	WHERE 
		h.voter_id = v.id and
		h.election_type IN ('PP', 'PR') and
		h.election_date > '2008-01-01'
		and v.party IN ('DEM', 'D')
	GROUP BY 
		v.id
	HAVING
		COUNT(*) > 1
);

UPDATE voters SET Prime = 'Y' WHERE id IN 
(
	SELECT
		v.id
	FROM
		voters v,
		history h
	WHERE 
		h.voter_id = v.id and
		h.election_type IN ('PP', 'PR') -- AND
--		h.election_date > '2008-01-01'
		and v.party IN ('DEM', 'D')
	GROUP BY 
		v.id
	HAVING
		COUNT(*) > 0
);

UPDATE voters SET ExtendedPrime = 'Y' WHERE id IN 
(
	SELECT
		v.id
	FROM
		voters v,
		history h
	WHERE 
		h.voter_id = v.id and
		h.election_type IN ('PP', 'PR') and
		h.election_date > '2005-01-01'
		and v.party IN ('DEM', 'D')
	GROUP BY 
		v.id
	HAVING
		COUNT(*) > 0
);

/* Triple Prime Density Identifier */
sSELECT 
	house_number, 
	street_name, 
	zip_code,
	COUNT(*)
FROM 
	voters 
WHERE
 	SuperTriplePrime = 'Y' 
GROUP BY 
	house_number, street_name, zip_code 
HAVING 
	COUNT(*) > 3
ORDER BY COUNT(*) Desc;