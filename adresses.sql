--run exports from drm
--convert files to ANSI: Notepad++, encode, save

.header on
--.mode tabs
.mode csv
.separator ";"

--section: load DRM"
--drop table NPBP7_Selskap;
--.import NPBP7_Selskap.csv NPBP7_Selskap 


drop table Customer;


.header on
.mode csv
.separator ";"

.import "PB_EXTRACT_ERPPROD_190206.csv.csv" Customer


drop table AmphoraTrips;
.import "Fixed pickup orders from Amphora_2.csv" AmphoraTrips              




select distinct
 "" as searchName,
 ACCOUNT_NUMBER as relationNumber, 
 PARTY_NAME as nameLine1,
 ACCOUNT_NAME as nameLine2,
 "" as nameLine3,
 ADDRESS1 as addressLine1,
 ADDRESS2 as addressLine2,
 ADDRESS3 as addressLine3,
 POSTAL_CODE as postalCode,
 CITY as city,
 COUNTRY as countryCode
from Customer where "SITE_USE_CODE" ="SHIP_TO";

select distinct
 "" as searchName, 
 NPB_OEBS_ACCOUNTNUMBER as relationNumber, 
NAVN as nameLine1,
ADRESSE_1 as addressLine1,
ADRESSE_2 as addressLine2,
EKSP_LAND_KODE as countryCode,
POSTNR as postalCode,
POSTSTED  as city

from AmphoraTrips; 


select distinct HENTENAVN as N, 	TYPE_FRA as type,	POSTNR_FRA as postnr,	POSTSTED_FRA as poststed,	
GATEADRESSE_FRA as gateadresse from AlystraShifts

union 
select distinct BRINGENAVN as N, 	TYPE_TIL as type,	POSTNR_TIL as postnr,	POSTSTED_TIL as poststed,
	GATEADRESSE_TIL as gateadresse from AlystraShifts;

.import "Fishery_establishments manip.csv" AdresserFisk
select * from AdresserFisk

---------------------------
.once allAddresses.csv
select * from (

select distinct
 "" as searchName,
 ACCOUNT_NUMBER as relationNumber, 
 PARTY_NAME as nameLine1,
 ACCOUNT_NAME as nameLine2,
 "" as nameLine3,
 ADDRESS1 as addressLine1,
 ADDRESS2 as addressLine2,
 ADDRESS3 as addressLine3,
 POSTAL_CODE as postalCode,
 CITY as city,
 COUNTRY as countryCode
from Customer where "SITE_USE_CODE" ="SHIP_TO"
union
select distinct
 "" as searchName, 
 NPB_OEBS_ACCOUNTNUMBER as relationNumber, 
NAVN as nameLine1,
 "" as nameLine2,
  "" as nameLine3,
ADRESSE_1 as addressLine1,
ADRESSE_2 as addressLine2,
"" as addressLine3,
POSTNR as postalCode,
POSTSTED  as city,
EKSP_LAND_KODE as countryCode
from AmphoraTrips
union 
select "" as searchname,
 "" as relationNumber, 
 N as nameLine1,
 "" as nameLine2,
 "" as nameLine3,
 gateadresse as addressLine1,
 "" as addressLine2,
 "" as addressLine3,
 postnr as postalCode,
 poststed as city,
 "NO" as countryCode
 from (
select distinct HENTENAVN as N, 	TYPE_FRA as type,	POSTNR_FRA as postnr,	POSTSTED_FRA as poststed,	
GATEADRESSE_FRA as gateadresse from AlystraShifts

union 
select distinct BRINGENAVN as N, 	TYPE_TIL as type,	POSTNR_TIL as postnr,	POSTSTED_TIL as poststed,
	GATEADRESSE_TIL as gateadresse from AlystraShifts)
union 
select "" as searchname,
 "" as relationNumber, 
 "Factory name" as nameLine1,
 "Approval number" as nameLine2,
 "Production codes" as nameLine3,
 Address as addressLine1,
 "" as addressLine2,
 "" as addressLine3,
 "Postal code" as postalCode,
 City as city,
 "NO" as countryCode
from AdresserFisk
);


