SELECT
'Address', 'City', 'State', 'Zipcode', 'Name', 'Phone Number', 'Apartment', 'Email', 
	'DoublePrime',
	'DoublePrimeAtLocation',
	'TriplePrime',
	'TriplePrimeAtLocation', 
	'SuperTriplePrime',
	'SuperTriplePrimeAtLocation',
	'Election District', 
	'Assembly District',
	'Connection',
	'Connection Info'
UNION
( 

SELECT 
	concat(v.house_number, " ", v.street_name) Address,
	v.city City,
	"New York" State,
	v.zip_code Zipcode,
	CONCAT(v.first_name, " ", v.last_name, " ", v.name_suffix) Name,
	v.telephone 'Phone Number',
	If(LENGTH(v.apartment_number) > 0, CONCAT ("Apartment ", v.apartment_number), "") 'Apartment',
	v.email Email,
	DoublePrime DoublePrime,
	DoublePrimeAtLocation DoublePrimeAtLocation,
	TriplePrime TriplePrime,
	TriplePrimeAtLocation TriplePrimeAtLocation, 
	SuperTriplePrime SuperTriplePrime,
	SuperTriplePrimeAtLocation SuperTriplePrimeAtLocation, 
	v.election_district 'Election District',
	v.assembly_district 'Assembly District',
	Connection 'Connection',
	CONNECTIONInfo 'Connection Info'
FROM
	voters v
WHERE 
	DoublePrime = 'Y' 
)
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export/Double_Prime_or_Better_Plus_Density.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n'; 