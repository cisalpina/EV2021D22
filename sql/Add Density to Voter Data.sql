CREATE INDEX IF NOT EXISTS STPAddress ON voters(house_number, street_name, zip_code, SuperTriplePrime);
CREATE INDEX IF NOT EXISTS TPAddress ON voters(house_number, street_name, zip_code, TriplePrime);
CREATE INDEX IF NOT EXISTS DPAddress ON voters(house_number, street_name, zip_code, DoublePrime);
CREATE INDEX IF NOT EXISTS PAddress ON voters(house_number, street_name, zip_code, Prime);
CREATE INDEX IF NOT EXISTS EPAddress ON voters(house_number, street_name, zip_code, ExtendedPrime);

Alter table `voters` drop column IF EXISTS SuperTriplePrimeAtLocation;
Alter table `voters` drop column IF EXISTS TriplePrimeAtLocation;
Alter table `voters` drop column IF EXISTS DoublePrimeAtLocation;
Alter table `voters` drop column IF EXISTS PrimeAtLocation;
Alter table `voters` drop column IF EXISTS ExtendedPrimeAtLocation;

ALTER TABLE `voters` 
ADD COLUMN SuperTriplePrimeAtLocation INTEGER(11) AFTER SuperTriplePrime, 
ADD COLUMN TriplePrimeAtLocation INTEGER(11) AFTER TriplePrime,
ADD COLUMN DoublePrimeAtLocation INTEGER(11) AFTER DoublePrime ,
ADD COLUMN PrimeAtLocation INTEGER(11) AFTER Prime ,
ADD COLUMN ExtendedPrimeAtLocation INTEGER(11) AFTER ExtendedPrime ;

Update 
	voters vu
Set 
	vu.SuperTriplePrimeAtLocation = 
	select 
		count(*) cnt 
	from 
		voters vs
	where 
		vs.house_number = vu.house_number and
		vs.street_name  = vu.street_name and
		vs.zip_code     = vu.zip_code and 
		SuperTriplePrime = 'Y'
	)
where 
	SuperTriplePrime = 'Y';
	
Update 
	voters vu
Set 
	vu.TriplePrimeAtLocation = 
	(select 
		count(*) 
	from 
		voters vs
	where 
		vs.house_number = vu.house_number and
		vs.street_name  = vu.street_name and
		vs.zip_code     = vu.zip_code and 
		TriplePrime = 'Y'
	)
where 
	TriplePrime = 'Y';

Update 
	voters vu
Set 
	vu.DoublePrimeAtLocation = 
	(select 
		count(*) 
	from 
		voters vs
	where 
		vs.house_number = vu.house_number and
		vs.street_name  = vu.street_name and
		vs.zip_code     = vu.zip_code and 
		DoublePrime = 'Y'
	)
where 
	DoublePrime = 'Y';
	
Update 
	voters vu
Set 
	vu.PrimeAtLocation = 
	(select 
		count(*) 
	from 
		voters vs
	where 
		vs.house_number = vu.house_number and
		vs.street_name  = vu.street_name and
		vs.zip_code     = vu.zip_code and 
		Prime = 'Y'
	)
where 
	Prime = 'Y';
	
Update 
	voters vu
Set 
	vu.ExtendedPrimeAtLocation = 
	(select 
		count(*) 
	from 
		voters vs
	where 
		vs.house_number = vu.house_number and
		vs.street_name  = vu.street_name and
		vs.zip_code     = vu.zip_code and 
		ExtendedPrime = 'Y'
	)
where 
	ExtendedPrime = 'Y';