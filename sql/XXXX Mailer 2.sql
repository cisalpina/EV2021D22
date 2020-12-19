/* Triple Prime Density Identifier */
SELECT 
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
ORDER BY COUNT(*) DESC;

SET PASSWORD FOR root@localhost = PASSWORD('3vie4EvahNEvah');
SET PASSWORD FOR root@127.0.0.1 = PASSWORD('3vie4EvahNEvah');
SET PASSWORD FOR root@'desktop-iiiod0h' = PASSWORD('3vie4EvahNEvah');

SELECT * FROM mysql.user;voters