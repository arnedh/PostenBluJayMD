--for all address types, add to big list, with scores
 drop table cdh;
 create table cdh as 
select 
 org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 city, 
 country,
 sum(("SITE_USE_CODE"="SHIP_TO")+10*("SITE_USE_CODE"="BILL_TO")) as s_or_b
 from (select distinct
 ACCOUNT_NUMBER as org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 CITY as city, 
 Country as country,
 "SITE_USE_CODE"
 from Customer)
 group by  org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 city, 
 country;

drop table alystrabasis2;
create table alystrabasis2  as 
select count(*) as weight, AKTOERNR,KUNDE,ERBEDRIFT,nameLine1, addressLine1, adrtype,	postalCode,	CITY,	country , 
(ERBEDRIFT =1) and (adrType = "BEDRIFT") as bedrift,
(ERBEDRIFT =0) and (adrType = "POST I BUTIKK") as pib
from 
(select  AKTOERNR,KUNDE,ERBEDRIFT,HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, TYPE_FRA as adrtype,	POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY,	"NO" as country from AlystraShifts
union select  AKTOERNR,KUNDE,ERBEDRIFT,BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,	TYPE_TIL as adrtype,	POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,	 "NO" as country from AlystraShifts)
group by AKTOERNR,KUNDE,ERBEDRIFT,nameLine1, addressLine1, adrtype,	postalCode,	CITY,	country , bedrift, pib ;

drop table scoredAddresses;
create table scoredAddresses as 
select  row_number() over (order by org_id) r, * from 
 (
select sum(weight) as weight, "alystra" as source, 'customer' as kind, "Aktoernr" as org_id, nameLine1, addressLine1,postalCode,CITY,country  from alystrabasis2 where bedrift group by source,kind,org_id,nameLine1, addressLine1,postalCode,CITY,country
union select  sum(weight) as weight,"alystra" as source, 'pib' as kind, "Aktoernr" as org_id, nameLine1, addressLine1,postalCode,CITY,country  from alystrabasis2 where pib group by source,kind,org_id,nameLine1, addressLine1,postalCode,CITY,country
union select  sum(weight) as weight, "alystra" as source, adrtype as kind, "" as org_id, nameLine1, addressLine1,postalCode,CITY,country  from alystrabasis2 where not pib and not bedrift group by source,kind,org_id,nameLine1, addressLine1,postalCode,CITY,country
 union
select 1 as weight, "amphora" as source, 'customer' as kind, "oebs_account" as org_id, relation_name as nameLine1, address_line_1 as addressLine1, zip as postalCode, city, country_code as country
 from AmphoraCustomerNumbers where postal_city <>"" group by source,kind,org_id,nameLine1, addressLine1,postalCode,CITY,country
 union
select count(*) as weight, "amphora" as source, 'adresses' as kind, "oebs_account" as org_id, relation_name as nameLine1, PICKUP_DELIVERY_ADR_1 as addressLine1, postal_number as postalCode, postal_city as city, country_code as country
 from AmphoraCustomerNumbers where postal_city <>"" group by source,kind,org_id,nameLine1, addressLine1,postalCode,CITY,country
 union
select  sum(
(length("KLAR MANDAG_KLOKKEN")>0)+(length("KLAR TIRSDAG_KLOKKEN")>0)+(length("KLAR ONSDAG_KLOKKEN")>0)+(length("KLAR TORSDAG_KLOKKEN")>0)
+(length("KLAR FREDAG_KLOKKEN")>0)+(length("KLAR LORDAG_KLOKKEN")>0)+(length("KLAR SONDAG_KLOKKEN")>0)) as weight,
"amphora" as source, 'pick/del' as kind, "NPB_OEBS_ACCOUNTNUMBER" as org_id, a.NAVN as nameLine1, a.ADRESSE_1 as addressLine1 ,  printf("%04d", a.POSTNR) as postalCode, a.POSTSTED as city ,"EKSP_LAND_KODE" as Country 
 from AmphoraTrips a group by source,kind,org_id,nameLine1, addressLine1,postalCode,CITY,country
union
select distinct 1 as weight, "drm" as source, 'pib-pk' as kind, Enhet."Navn 4. Ledd",
	 Enhet."Beskrivelse", Adresse."Gatenavn"||" "||Adresse."Gatenummer", Adresse."Postnummer", 
	 Adresse."Poststed", Adresse.adrLandKode from Enhet, Adresse 
 where 
	Enhet."Leveringsadresse-Enhet kobling" = Adresse.Name 
	and "Operativ tom Dato">"31.12.2019" 
	and "Organisasjonstype kode" in ("035", "019", "010", "018")
union 
select distinct 1 as weight, 
	"supplier" as source, 'supplier' as kind, "Vendor Number" as org_id,
	"Vendor Name" as nameLine1,
	ADDRESS_LINE1 as addressLine1,
	Zip as postalCode,
	City as city,
	country as countryCode
from Supplier
union 
select 2 as weight, "cdh" as source, "ship" as kind, org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 city, 
 country from cdh where s_or_b = 1
union select 1 as weight, "cdh" as source, "bill" as kind, org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 city, 
 country from cdh where s_or_b = 10
 union 
 select 3 as weight, "cdh" as source, "ship&bill" as kind, org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 city, 
 country from cdh where s_or_b = 11);



/*
select count(*) as weight, sum(
(length("KLAR MANDAG_KLOKKEN")>0)+(length("KLAR TIRSDAG_KLOKKEN")>0)+(length("KLAR ONSDAG_KLOKKEN")>0)+(length("KLAR TORSDAG_KLOKKEN")>0)
+(length("KLAR FREDAG_KLOKKEN")>0)+(length("KLAR LORDAG_KLOKKEN")>0)+(length("KLAR SONDAG_KLOKKEN")>0)) as weight2,
"amphora" as source, 'pick/del' as kind, "NPB_OEBS_ACCOUNTNUMBER" as org_id, a.NAVN as nameLine1, a.ADRESSE_1 as addressLine1 ,  printf("%04d", a.POSTNR) as postalCode, a.POSTSTED as city ,"EKSP_LAND_KODE" as Country 
 from AmphoraTrips a group by source,kind,org_id,nameLine1, addressLine1,postalCode,CITY,country
*/

 
.once scoredaddresses.csv
select * from scoredaddresses;
 
 ----------------------------