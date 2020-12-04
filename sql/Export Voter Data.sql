Select 'id','last_name ','first_name ','middle_initial ','street_address','apartment_number ','city ','zip_code ','zip_code_plus4 ','birth_date ','gender ','party ','party_other ','election_district ','assembly_district ','registration_date ','year_last_voted ','telephone ','email ','age ','SuperTriplePrime ','SuperTriplePrimeAtLocation ','TriplePrime ','TriplePrimeAtLocation ','DoublePrime ','DoublePrimeAtLocation ','Prime ','PrimeAtLocation ','ExtendedPrime ','ExtendedPrimeAtLocation'
union
SELECT 
id,
last_name, 
first_name, 
middle_initial, 
concat(house_number, " ", street_name),
apartment_number, 
city, 
zip_code, 
zip_code_plus4, 
birth_date, 
gender, 
party, 
party_other, 
election_district, 
assembly_district, 
registration_date, 
year_last_voted, 
telephone, 
email, 
age, 
SuperTriplePrime, 
SuperTriplePrimeAtLocation, 
TriplePrime, 
TriplePrimeAtLocation, 
DoublePrime, 
DoublePrimeAtLocation, 
Prime, 
PrimeAtLocation, 
ExtendedPrime, 
ExtendedPrimeAtLocation
FROM voters
INTO OUTFILE 'C:/Users/georg/OneDrive/Desktop/VoteSQL/github/EV2021D22/sql/Export/Voter Data Export.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';