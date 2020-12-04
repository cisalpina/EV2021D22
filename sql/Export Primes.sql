/* Voted in last three primaries - Super Triple Prime */	
SELECT
	'Address', 'City', 'State', 'Zipcode', 'Name', 'Phone Number', 'Group', 'URL', 'Email', 'Election District', 'Assembly District'
	UNION
( SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	v.zip_code Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	v.election_district 'Election District',
	v.assembly_district 'Assembly District'
FROM
	voters v
WHERE 
	SuperTriplePrime = 'Y' 
) 
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export/Export Super Triple Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
	
/* Triple Prime */	
SELECT
	'Address', 'City', 'State', 'Zipcode', 'Name', 'Phone Number', 'Group', 'URL', 'Email', 'Election District', 'Assembly District'
	UNION
( SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	v.zip_code Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	v.election_district 'Election District',
	v.assembly_district 'Assembly District'
FROM
	voters v
WHERE 
	TriplePrime = 'Y' 
 ) 
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export/Export Triple Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
	
/* Double Prime */	
SELECT
	'Address', 'City', 'State', 'Zipcode', 'Name', 'Phone Number', 'Group', 'URL', 'Email', 'Election District', 'Assembly District'
	UNION
( SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	v.zip_code Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	v.election_district 'Election District',
	v.assembly_district 'Assembly District'
FROM
	voters v
WHERE 
	DoublePrime = 'Y' 
 ) 
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export/Export Double Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
	
/* Standard Prime */	
SELECT
	'Address', 'City', 'State', 'Zipcode', 'Name', 'Phone Number', 'Group', 'URL', 'Email', 'Election District', 'Assembly District'
	UNION
( SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	v.zip_code Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	v.election_district 'Election District',
	v.assembly_district 'Assembly District'
FROM
	voters v
WHERE 
    Prime = 'Y' 
 )
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export/Export Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
	
/* Extended Prime */	
SELECT
	'Address', 'City', 'State', 'Zipcode', 'Name', 'Phone Number', 'Group', 'URL', 'Email', 'Election District', 'Assembly District'
	UNION
( SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	v.zip_code Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	v.election_district 'Election District',
	v.assembly_district 'Assembly District'
FROM
	voters v
WHERE 
    ExtendedPrime = 'Y' 
)
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export/Export Extended Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';