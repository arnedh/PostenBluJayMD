select searchname||
 printf("%04d", 
row_number() over (partition by searchname
order by searchname,gateadresse))
, n, postnr, poststed, gateadresse
from (

 select distinct "NO"||substr(replace(trim(upper(HENTENAVN)), " ", ""),1,9)||substr(replace(trim(upper(POSTSTED_FRA)), " ", ""),1,5) as searchname,
HENTENAVN as N, POSTNR_FRA as postnr,	POSTSTED_FRA as poststed,	
GATEADRESSE_FRA as gateadresse
 from AlystraShifts
 group by searchname, hentenavn, postnr_fra, poststed_fra, gateadresse_fra
);

--------------------

drop table AmphoraTrips;
.import "Fixed pickup orders from Amphora_2.csv" AmphoraTrips     
drop table AdresserFisk;
.import "Fishery_establishments manip.csv" AdresserFisk
.mode tabs

 select distinct HENTENAVN as nameLine1, 		POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY,	
GATEADRESSE_FRA as addressLine1, "NO" as country, 
 "Alystra" as source
from AlystraShifts
union 
select distinct BRINGENAVN as nameLine1, 		POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,
	GATEADRESSE_TIL as addressLine1, "NO" as country,
	 "Alystra" as source
	from AlystraShifts
union 
select distinct

 PARTY_NAME as nameLine1,
  ADDRESS1 as addressLine1,
 POSTAL_CODE as postalCode,
 CITY as city, Country as country,
 "CDH Bill to" as source
from Customer where "SITE_USE_CODE" ="BILL_TO"
union
select distinct

 PARTY_NAME as nameLine1,
  ADDRESS1 as addressLine1,
 POSTAL_CODE as postalCode,
 CITY as city, Country as country, "CDH Ship to" as source
from Customer where "SITE_USE_CODE" ="SHIP_TO"

union 
select distinct
"Vendor Name" as nameLine1,
ADDRESS_LINE1 as addressLine1,
Zip as postalCode,
City as city,Country as country,
"supplier billto" as source
from Supplier
union
select distinct a.NAVN as nameLine1, a.ADRESSE_1 as addressLine1 , a.POSTNR as postalCode, a.POSTSTED as city ,"EKSP_LAND_KODE" as Country, "amphora" as source from AmphoraTrips a
union 
select distinct 
  "Factory name" as nameLine1,
  "Address" as addressLine1,
  "Postal Code"  as postalCode,
  "City"  as city,
  "NO" as country,
  "mattilsynet" as source
 from AdresserFisk
 
union
 select e.Beskrivelse as nameLine1, a.gatenavn  as addressLine1, a.postnummer as postalCode, a.poststed  as city, a."adrLandkode" as country, "DRM besøk" from NPBP7_Adresse a, NPBP7_Enhet e, NPBP7_Enhet parent where a.Name = 
 e."Besøksadresse-Enhet kobling" and  e."Parent Node" = parent.Name and e."Besøksadresse-Enhet kobling" != parent."Besøksadresse-Enhet kobling"
 
union
 
  select e.Beskrivelse as nameLine1, a.gatenavn  as addressLine1, a.postnummer as postalCode, a.poststed  as city, a."adrLandkode" as country, "DRM faktura" from NPBP7_Adresse a, NPBP7_Enhet e, NPBP7_Enhet parent where a.Name = 
 e."Fakturaadresse-Enhet kobling" and  e."Parent Node" = parent.Name and e."Fakturaadresse-Enhet kobling" != parent."Fakturaadresse-Enhet kobling";

 
 
