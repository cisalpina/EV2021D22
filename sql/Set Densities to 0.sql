SELECT COUNT(*) FROM voters WHERE SuperTriplePrimeAtLocation IS NULL;
SELECT COUNT(*) FROM voters;

UPDATE voters SET SuperTriplePrimeAtLocation = 0 WHERE SuperTriplePrimeAtLocation IS NULL;
UPDATE voters SET TriplePrimeAtLocation = 0 WHERE TriplePrimeAtLocation IS NULL;
UPDATE voters SET DoublePrimeAtLocation = 0 WHERE DoublePrimeAtLocation IS NULL;
UPDATE voters SET PrimeAtLocation = 0 WHERE PrimeAtLocation IS NULL;
UPDATE voters SET ExtendedPrimeAtLocation = 0 WHERE ExtendedPrimeAtLocation IS NULL;