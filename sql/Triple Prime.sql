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
	h.election_date IN ('2020-06-23', '2019-06-25', '2018-09-23', '2018-06-26')
	and v.party IN ('DEM', 'D')
GROUP BY 
	v.id
HAVING
	COUNT(*) > 2
ORDER BY
	COUNT(*) desc
	
	