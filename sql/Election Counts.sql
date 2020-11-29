/* Determining Win Number - Regress from prevoius and add Coronavirus "involved citizens" acceleration factor */
SELECT 
	COUNT(*) 'Total Voters'
	, COUNT(if(SUBSTR(political_party, 1, 1) = 'D', 1, NULL)) 'Dems'
	, COUNT(if(SUBSTR(political_party, 1, 1) = 'D', NULL, 1)) 'Not Dems'
	, election_date 'Election Date'
	, election_type 'Election Type'
FROM 
	history_full 
WHERE
--	election_Date > '2009-01-01' and
	combined_district IN 
		('30035','30060','30061','30064','30078','30082','34010','34011','34039','34040','34041','34042','34073','35049','35050','36001','36002','36003','36004','36005','36006','36007','36008','36009','36010','36011','36012','36013','36014','36015','36016','36017','36018','36019','36020','36021','36022','36023','36024','36025','36027','36029','36030','36031','36032','36033','36034','36035','36036','36037','36038','36039','36040','36041','36042','36043','36045','36046','36047','36048','36049','36050','36051','36052','36053','36054','36055','36056','36057','36058','36059','36060','36061','36062','36063','36066','36067','36072','36073','36074','36075','36076','36077','36078','36079','36080','36081','36082','36083','37001','37002','37003','37004')
GROUP BY 
	election_date
	, election_type
-- ORDER BY election_date Desc
   ORDER BY COUNT(*) desc
;