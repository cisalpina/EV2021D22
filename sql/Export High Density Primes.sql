/* Super Triple Prime Density Identifier */
SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	Primes.votercount VoterCountAtAddress
	FROM voters v,
	 ( SELECT 
		house_number, 
		street_name, 
		zip_code,
		COUNT(*) votercount
	FROM 
		voters 
	WHERE
	 	SuperTriplePrime = 'Y' 
	GROUP BY 
		house_number, street_name, zip_code 
	HAVING 
		COUNT(*) > 3
	) Primes
WHERE 
	Primes.house_number = v.house_number and
	Primes.street_name   = v.street_name and
	Primes.zip_code     = v.zip_code and
	v.SuperTriplePrime = 'Y'
ORDER BY Primes.votercount DESC
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export High Density Super Triple Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

/* Triple Prime Density Identifier */
SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	Primes.votercount VoterCountAtAddress
	FROM voters v,
	 ( SELECT 
		house_number, 
		street_name, 
		zip_code,
		COUNT(*) votercount
	FROM 
		voters 
	WHERE
	 	TriplePrime = 'Y' 
	GROUP BY 
		house_number, street_name, zip_code 
	HAVING 
		COUNT(*) > 3
	) Primes
WHERE 
	Primes.house_number = v.house_number and
	Primes.street_name   = v.street_name and
	Primes.zip_code     = v.zip_code and
	v.TriplePrime = 'Y'
ORDER BY Primes.votercount DESC
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export High Density Triple Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

/* Double Prime Density Identifier */
SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	Primes.votercount VoterCountAtAddress
	FROM voters v,
	 ( SELECT 
		house_number, 
		street_name, 
		zip_code,
		COUNT(*) votercount
	FROM 
		voters 
	WHERE
	 	DoublePrime = 'Y' 
	GROUP BY 
		house_number, street_name, zip_code 
	HAVING 
		COUNT(*) > 3
	) Primes
WHERE 
	Primes.house_number = v.house_number and
	Primes.street_name   = v.street_name and
	Primes.zip_code     = v.zip_code and
	v.DoublePrime = 'Y'
ORDER BY Primes.votercount DESC
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export High Density Double Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

/* Standard Prime Density Identifier */
SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	Primes.votercount VoterCountAtAddress
	FROM voters v,
	 ( SELECT 
		house_number, 
		street_name, 
		zip_code,
		COUNT(*) votercount
	FROM 
		voters 
	WHERE
	 	Prime = 'Y' 
	GROUP BY 
		house_number, street_name, zip_code 
	HAVING 
		COUNT(*) > 3
	) Primes
WHERE 
	Primes.house_number = v.house_number and
	Primes.street_name   = v.street_name and
	Primes.zip_code     = v.zip_code and
	v.Prime = 'Y'
ORDER BY Primes.votercount DESC
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export High Density Standard Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

/* Standard ExtendedPrime Density Identifier */
SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	CONCAT(v.zip_code, " ", v.zip_code_plus4) Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Group',
	CONCAT ("Party: ", v.party) URL,
	v.email Email,
	Primes.votercount VoterCountAtAddress
	FROM voters v,
	 ( SELECT 
		house_number, 
		street_name, 
		zip_code,
		COUNT(*) votercount
	FROM 
		voters 
	WHERE
	 	ExtendedPrime = 'Y' 
	GROUP BY 
		house_number, street_name, zip_code 
	HAVING 
		COUNT(*) > 3
	) Primes
WHERE 
	Primes.house_number = v.house_number and
	Primes.street_name   = v.street_name and
	Primes.zip_code     = v.zip_code and
	v.ExtendedPrime = 'Y'
ORDER BY Primes.votercount DESC
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export High Density Extended Primes.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';