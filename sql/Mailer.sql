/* // https://stackoverflow.com/questions/276927/can-i-concatenate-multiple-mysql-rows-into-one-field */ 
SELECT COUNT(*) FROM voters WHERE party = 'DEM';
SELECT count(DISTINCT house_number, street_name, apartment_number) FROM voters WHERE party = 'DEM';
SELECT GROUP_CONCAT(CONCAT(v.first_name, ' ', v.last_name) SEPARATOR ', '), v.House_number, v.street_name, v.apartment_number, COUNT(*) FROM voters v WHERE party = 'DEM' GROUP BY House_number, street_name, apartment_number ORDER BY COUNT(*) desc;