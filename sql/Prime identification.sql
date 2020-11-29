/* Voted in last three primaries - Super Triple Prime */	
SELECT 
/*	v.id,
	v.last_name,
	v.first_name,
	v.middle_initial,
	v.name_suffix,
	v.house_number,
	v.house_number_suffix,
	v.apartment_number,
	v.street_name,
	v.city,
	v.zip_code,
	v.zip_code_plus4,
	v.address_1,
	v.address_2,
	v.address_3,
	v.address_4,
	v.birth_date,
	v.telephone,
	v.email,
	COUNT(*), */
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email
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
ORDER BY
	COUNT(*) DESC;
	
/* Triple Prime */	
SELECT 
/*	v.id,
	v.last_name,
	v.first_name,
	v.middle_initial,
	v.name_suffix,
	v.house_number,
	v.house_number_suffix,
	v.apartment_number,
	v.street_name,
	v.city,
	v.zip_code,
	v.zip_code_plus4,
	v.address_1,
	v.address_2,
	v.address_3,
	v.address_4,
	v.birth_date,
	v.telephone,
	v.email,
	COUNT(*), */
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email
FROM
	voters v,
	history h
WHERE 
	h.voter_id = v.id and
	h.election_type IN ('PP', 'PR') AND
	h.election_date > '2008-01-01'
	and v.party IN ('DEM', 'D')
GROUP BY 
	v.id
HAVING
	COUNT(*) > 2
ORDER BY
	COUNT(*) DESC;
	
/* Double Prime */	
SELECT 
/*	v.id,
	v.last_name,
	v.first_name,
	v.middle_initial,
	v.name_suffix,
	v.house_number,
	v.house_number_suffix,
	v.apartment_number,
	v.street_name,
	v.city,
	v.zip_code,
	v.zip_code_plus4,
	v.address_1,
	v.address_2,
	v.address_3,
	v.address_4,
	v.birth_date,
	v.telephone,
	v.email,
	COUNT(*), */
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email
FROM
	voters v,
	history h
WHERE 
	h.voter_id = v.id and
	h.election_type IN ('PP', 'PR') AND
	h.election_date > '2008-01-01'
	and v.party IN ('DEM', 'D')
GROUP BY 
	v.id
HAVING
	COUNT(*) > 1
ORDER BY
	COUNT(*) DESC;
	
/* Standard Prime */	
SELECT 
/*	v.id,
	v.last_name,
	v.first_name,
	v.middle_initial,
	v.name_suffix,
	v.house_number,
	v.house_number_suffix,
	v.apartment_number,
	v.street_name,
	v.city,
	v.zip_code,
	v.zip_code_plus4,
	v.address_1,
	v.address_2,
	v.address_3,
	v.address_4,
	v.birth_date,
	v.telephone,
	v.email,
	COUNT(*), */
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email
FROM
	voters v,
	history h
WHERE 
	h.voter_id = v.id and
	h.election_type IN ('PP', 'PR') AND
	h.election_date > '2008-01-01'
	and v.party IN ('DEM', 'D')
-- GROUP BY 
--	v.id
-- HAVING
--	COUNT(*) > 1
ORDER BY
	COUNT(*) DESC;
	
/* Extended Prime */	
SELECT 
/*	v.id,
	v.last_name,
	v.first_name,
	v.middle_initial,
	v.name_suffix,
	v.house_number,
	v.house_number_suffix,
	v.apartment_number,
	v.street_name,
	v.city,
	v.zip_code,
	v.zip_code_plus4,
	v.address_1,
	v.address_2,
	v.address_3,
	v.address_4,
	v.birth_date,
	v.telephone,
	v.email,
	COUNT(*), */
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email
FROM
	voters v,
	history h
WHERE 
	h.voter_id = v.id and
	h.election_type IN ('PP', 'PR') AND
	h.election_date > '2005-01-01'
	and v.party IN ('DEM', 'D')
-- GROUP BY 
--	v.id
-- HAVING
--	COUNT(*) > 1
ORDER BY
	COUNT(*) DESC;