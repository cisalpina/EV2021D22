/* 
Data Set Provided by Litza has three "history" tables
	- source data (history_full)
	- cleansed data (history, in which ... have been removed)
	- history_district - D22

/* 1) 529,695 */
SELECT COUNT(*) FROM history_district;

/* 2) 529,695 - confirms all data in history_district is for election/assembly districts in voters data*/
SELECT 
	COUNT(*)
FROM 
	history_district h
WHERE
	(lpad(h.assembly_district, 2, "0"), lpad(h.election_district, 3, "0")) in
	(SELECT distinct lpad(v.assembly_district, 2, "0"), lpad(v.election_district, 3, "0") FROM voters v);
	
/* 3) 404,154 - How many records in history_distirct are from *current* district voters? */
/*    Meaning (529,695 - 404,154 records are from voters who have moved out              */
SELECT 
	COUNT(*)
FROM 
	history_district h
WHERE
	voter_id in
	(SELECT id FROM voters v);

/* 4) 540,638  - why a larger number if just limited to district voter records?  People who moved *in* to district?*/
SELECT COUNT(*) FROM history;

/* 5) 540,638  - confirms that all records are from voters in voters data */
SELECT 
	COUNT(*)
FROM 
	history h
WHERE
	voter_id in
	(SELECT id FROM voters v);

/* 6) 404,154 - Presumably smaller because voters in district lived elsewhere previously and voted in diff districts */
SELECT 
	COUNT(*)
FROM 
	history h
WHERE
	(lpad(h.assembly_district, 2, "0"), lpad(h.election_district, 3, "0")) in
	(SELECT distinct lpad(v.assembly_district, 2, "0"), lpad(v.election_district, 3, "0") FROM voters v);
	
/* 7) 125,541 Identification of rows in history_district, but not in history */	
/*     Note that the count returned is precisely the difference in count between history_district (529,695) and history (404,154) that are in district */
SELECT 
   COUNT(*) /*,
	hd.voter_id,
	hd.boro, 
	hd.assembly_district, 
	hd.election_district, 
	hd.political_party, 
	hd.election_date_original, 
	hd.election_type, 
	hd.voter_type,
	hd.voting_method*/
FROM history_district hd 
WHERE 
	 ( 
	 	hd.voter_id,
		hd.boro, 
		lpad(hd.assembly_district, 2, "0"),
		lpad(hd.election_district, 3, "0"),
		hd.political_party, 
		hd.election_date_original, 
		hd.election_type, 
		hd.voter_type,
		hd.voting_method 
	  )
	NOT IN 
	 	( SELECT
		 			h.voter_id,
					h.boro, 
					lpad(h.assembly_district, 2, "0"), 
					lpad(h.election_district, 3, "0"),
					h.political_party, 
					h.election_date_original, 
					h.election_type, 
					h.voter_type,
					h.voting_method  
			FROM 
 				history h);

/* 8) 136,484 prove theorem that in-district voters are carrying their history into the history table, even if out-of district */
/*    This number is the exsact difference between rows in history (540,638) and history but in a different district (404,154)                    */
SELECT 
	COUNT(*)
FROM 
	history h
WHERE
	(lpad(h.assembly_district, 2, "0"), lpad(h.election_district, 3, "0")) not in
	(SELECT distinct lpad(v.assembly_district, 2, "0"), lpad(v.election_district, 3, "0") FROM voters v);
	 
 /* 99) Now do the same against history_full - number ties out 529,695 - gives confidence in history_district table. Understand from LS how history is derived and whether mean*/
SELECT  
	COUNT(*)
FROM 
	history_full h
WHERE
	(lpad(h.assembly_district, 2, "0"), lpad(h.election_district, 3, "0")) in
	(SELECT distinct lpad(v.assembly_district, 2, "0"), lpad(v.election_district, 3, "0") FROM voters v);
