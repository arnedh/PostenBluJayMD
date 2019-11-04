--run exports from drm
--convert files to ANSI: Notepad++, encode, save

.header on
--.mode tabs
.mode csv
.separator ";"



drop table Supplier;
drop table Customer;


.header on
.mode csv
.separator ";"

.import "Vendor_extract_ERPPROD_190131.csv" Supplier 

.import "PB_EXTRACT_ERPPROD_190206.csv.csv" Customer

.mode csv
.separator ";"

create table relations as select distinct
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
 COUNTRY as countryCode,
"" as subentityCode,
"" as postOfficeBox,
"" as postOfficeBoxPostalcode,
"" as postOfficeBoxCity,
"" as postOfficeBoxCountry,
"" as telephoneNumber,
"" as telefaxNumber,
"" as emailAddress,
"" as internetAddress,
"" as contactPerson,
"1" as typeOfRelation,
"" as currencyCode,
"0" as vatCode,
"" as languageCode,
"1" as relationGroup,
"" as paymentTerm,
"" as creditLimit,
"JGZZ_FISCAL_CODE" as vatNumberOrg,
COUNTRY || JGZZ_FISCAL_CODE vatNumber
from Customer where "SITE_USE_CODE" ="BILL_TO"
union all
select distinct
"" as searchName,
"Vendor Number" as relationNumber,
"Vendor Name" as nameLine1,
"" as nameLine2,
"" as nameLine3,
ADDRESS_LINE1 as addressLine1,
ADDRESS_LINE2 as addressLine2,
"" as addressLine3,
Zip as postalCode,
City as city,
country as countryCode,
"" as subentityCode,
"" as postOfficeBox,
"" as postOfficeBoxPostalcode,
"" as postOfficeBoxCity,
"" as postOfficeBoxCountry,
phone as telephoneNumber,
"" as telefaxNumber,
"" as emailAddress,
"" as internetAddress,
"" as contactPerson,
"2" as typeOfRelation,
"payment_currency_code" as currencyCode,
"" as vatCode,
"" as languageCode,
"1" as relationGroup,
"terms" as paymentTerm,
"" as creditLimit,
"Oraganization Number" as vatNumberOrg,
COUNTRY || "Oraganization Number" as vatNumber
from Supplier;

.once relationsOut.csv

select * from relations;


create table addressesCDH as
select 
 "" as searchName,
b.ACCOUNT_NUMBER as relationNumber, 
 b.PARTY_NAME as nameLine1,
 b.ACCOUNT_NAME as nameLine2,
 "" as nameLine3,
 b.ADDRESS1 as addressLine1,
 b.ADDRESS2 as addressLine2,
 b.ADDRESS3 as addressLine3,
 b.POSTAL_CODE as postalCode,
 b.CITY as city,
 b.COUNTRY as countryCode,
 "" as subentityCode,
 "" as contactPerson,
"" as telephoneNumber,
"" as telexNumber,
"" as telefaxNumber,
"" as languageCode,
"" as emailAddress,
"" as internetAddress,
"" as "Select for planning characteristics" ,
"" as   "Type of address" ,
"" as   "Destination code" ,
"" as   "City2" ,
"" as   "AGP licence number" ,
"" as   "EAN relation number" ,
"" as   "Indication fiscal representation" ,
"" as   "VAT ID number" ,
"" as   "Base stop time" ,
"" as   "Pickup scan required" ,
"" as   "Order delivery type" ,
"" as   "Order collect type" from 
(select distinct
 account_number,
 PARTY_NAME ,
 account_name, 
 ADDRESS1,
 address2, 
 address3, 
 POSTAL_CODE,
 CITY as city, 
 Country as country
from Customer where "SITE_USE_CODE" ="BILL_TO") as a,
(select distinct
 account_number,
 PARTY_NAME ,
 account_name, 
 ADDRESS1,
 address2, 
 address3, 
 POSTAL_CODE,
 CITY as city, 
 Country as country
from Customer where "SITE_USE_CODE" ="SHIP_TO") as b
where a.account_number = b.account_number and a.address1!=b.address1;

.once addressesCDH.csv

select * from addressesCDH;
--------------------

.header on
.mode tabs


.mode csv
.separator ";"

drop table AlystraShifts;


----don't encode, convert, save
.import "Strategisk-OttarView-101-2019-01-18-1400.txt" AlystraShifts                          
.import "Strategisk-OttarView-102-2019-01-18-1400.txt" AlystraShifts                                       
.import "Strategisk-OttarView-103-2019-01-18-1401.txt" AlystraShifts                                       
.import "Strategisk-OttarView-104-2019-01-18-1404.txt" AlystraShifts                                       
.import "Strategisk-OttarView-105-2019-01-18-1405.txt" AlystraShifts                                       
.import "Strategisk-OttarView-106-2019-01-18-1405.txt" AlystraShifts                                       
.import "Strategisk-OttarView-107-2019-01-18-1406.txt" AlystraShifts                                       
.import "Strategisk-OttarView-108-2019-01-18-1407.txt" AlystraShifts                                       
.import "Strategisk-OttarView-109-2019-01-18-1407.txt" AlystraShifts                                       
.import "Strategisk-OttarView-110-2019-01-18-1409.txt" AlystraShifts                                       
.import "Strategisk-OttarView-112-2019-01-18-1409.txt" AlystraShifts    

drop table AmphoraCustomerNumbers;
.import "Amphora customer numbers.csv" AmphoraCustomerNumbers       


drop table AmphoraTrips;
.import "Fixed pickup orders from Amphora_2.csv" AmphoraTrips     

drop table AmphoraDepts;
.import "AmphoraDepts.csv" AmphoraDepts

drop table AlystraDepts;
.import "AlystraDepts.csv" AlystraDepts

drop table LastbPackage;
.import "LastbPackage.csv" LastbPackage

drop table depts;
.import "depts.csv" depts

create table addresses as select searchBase||printf("%04d", row_number() over (partition by searchBase order by searchBase, addressLine1)) as searchname
, nameLine1, addressLine1, postalCode, city, country
from (
select *, country||nameBase||cityBase as searchBase from (
select *, 
substr(replace(replace(replace(replace(replace(replace(replace(replace(
replace(replace(replace(
replace(replace(replace(replace(replace(replace(replace(trim(upper(nameLine1)),
"Æ","A") ,"Ø","O") ,"Å","A") ,"Ö","O") ,"Ü","U") ,"Ä","A") ," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"\'",""),1,9) as nameBase, 
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(trim(upper(city))
,"Æ","A") ,"Ø","O") ,"Å","A") ,"Ö","O") ,"Ü","U") ,"Ä","A")  ," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"\'",""),1,5) as cityBase
from (select distinct HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, 		POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY,	"NO" as country from AlystraShifts
union select distinct BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,		POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,	 "NO" as country from AlystraShifts
union select distinct a.NAVN as nameLine1, a.ADRESSE_1 as addressLine1 ,  printf("%04d", a.POSTNR) as postalCode, a.POSTSTED as city ,"EKSP_LAND_KODE" as Country from AmphoraTrips a)));

.once "addresses.csv"
select * from addresses;


.header on
.mode tabs
.separator "\t"

.import "20190508102014_NPBP7_EnhetFO.txt" Enhet
.import "20190508092200_NPBP7_Adresse.txt" Adresse

select count(*),"Organisasjonstype" from Enhet where "Operativ tom Dato">"31.12.2019" and Organisasjonstype in (35, 19, 10, 18) group by "Organisasjonstype";

select count(*),"Organisasjonstype", "Organisasjonstype kode" from Enhet where "Operativ tom Dato">"31.12.2019" and "Organisasjonstype kode" in ("035", "019", "010", "018")group by "Organisasjontype", "Organisasjonstype kode";

select Enhet."Navn 4. Ledd", Enhet."Beskrivelse", Adresse."Gatenavn", Adresse."Gatenummer", Adresse."Postnummer", Adresse."Poststed" from Enhet, Adresse where Enhet."Leveringsadresse-Enhet kobling" = Adresse.Name and "Operativ tom Dato">"31.12.2019" and "Organisasjonstype kode" in ("035", "019", "010", "018")

.schema Adresse

-------
select distinct RELATION_NAME, ADDRESS_LINE_1 as adr1, ADDRESS_LINE_2 as adr2, "NO" as country,  ZIP, CITY from AmphoraCustomerNumbers;
select distinct "RELATION_NAME", "PICKUP_DELIVERY_ADR_1" as adr1, "PICKUP_DELIVERY_ADR_2" as adr2,"COUNTRY_CODE" as country,"POSTAL_NUMBER" as ZIP, POSTAL_CITY as CITY from AmphoraCustomerNumbers;

select distinct HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, 		POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY,	"NO" as country from AlystraShifts
union select distinct BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,		POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,	 "NO" as country from AlystraShifts

select distinct AKTOERNR,KUNDE,ERPOSTAL,ERBEDRIFT,HENTENAVN,KUNDE_FRA,TYPE_FRA,POSTNR_FRA,POSTSTED_FRA,GATEADRESSE_FRA from AlystraShifts;

ERBEDRIFT = 1, TYPE_FRA = BEDRIFT -> bedriftsadresse
ERBEDRIFT = 0, TYPE_FRA = POST I BUTIKK -> pib


-------------------------------------
.output alladdr.csv

 select distinct relation_name, address_line_1, zip, city, country_code from AmphoraCustomerNumbers 
 union all
 select distinct relation_name, PICKUP_DELIVERY_ADR_1, postal_number, postal_city, country_code from AmphoraCustomerNumbers where PICKUP_DELIVERY_ADR_1 <>"" 
 union all
 select Enhet."Beskrivelse", Adresse."Gatenavn"||" "||Adresse."Gatenummer", Adresse."Postnummer", Adresse."Poststed", Adresse.adrLandKode from Enhet, Adresse where Enhet."Leveringsadresse-Enhet kobling" = Adresse.Name and "Operativ tom Dato">"31.12.2019" and "Organisasjonstype kode" in ("035", "019", "010", "018");
 
 
 select distinct
 PARTY_NAME ,
 ADDRESS1,
 POSTAL_CODE,
 CITY as city, 
 Country as country
 from Customer;
 
 select distinct
"Vendor Name" as nameLine1,
ADDRESS_LINE1 as addressLine1,
Zip as postalCode,
City as city,
country as countryCode
from Supplier;

select distinct HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, 		POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY,	"NO" as country from AlystraShifts
union select distinct BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,		POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,	 "NO" as country from AlystraShifts;

select distinct a.NAVN as nameLine1, a.ADRESSE_1 as addressLine1 ,  printf("%04d", a.POSTNR) as postalCode, a.POSTSTED as city ,"EKSP_LAND_KODE" as Country from AmphoraTrips a;


-------------------------------------

 create table cdh as select distinct
 ACCOUNT_NUMBER as org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 CITY as city, 
 Country as country,
 "SITE_USE_CODE"
 from Customer;
 
create table alystrabasis  as 
select distinct *, (ERBEDRIFT =1) and (adrType = "BEDRIFT") as bedrift,
(ERBEDRIFT =0) and (adrType = "POST I BUTIKK") as pib
from 
(select  AKTOERNR,KUNDE,ERBEDRIFT,HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, TYPE_FRA as adrtype,	POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY,	"NO" as country from AlystraShifts
union select  AKTOERNR,KUNDE,ERBEDRIFT,BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,	TYPE_TIL as adrtype,	POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,	 "NO" as country from AlystraShifts);

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
 


.output alladdr.csv

 select distinct "amphora" as source, 'customer' as kind, "oebs_account" as org_id, relation_name, address_line_1, zip, city, country_code from AmphoraCustomerNumbers;
 select distinct "amphora" as source, 'adresses' as kind, "oebs_account" as org_id, relation_name, PICKUP_DELIVERY_ADR_1, postal_number, postal_city, country_code from AmphoraCustomerNumbers where postal_city <>"" ;
 select distinct "amphora" as source, 'pick/del' as kind, "NPB_OEBS_ACCOUNTNUMBER" as org_id, a.NAVN as nameLine1, a.ADRESSE_1 as addressLine1 ,  printf("%04d", a.POSTNR) as postalCode, a.POSTSTED as city ,"EKSP_LAND_KODE" as Country from AmphoraTrips a;
 select distinct "drm" as source, 'pib-pk' as kind, Enhet."Navn 4. Ledd",
	 Enhet."Beskrivelse", Adresse."Gatenavn"||" "||Adresse."Gatenummer", Adresse."Postnummer", 
	 Adresse."Poststed", Adresse.adrLandKode from Enhet, Adresse 
 where 
	Enhet."Leveringsadresse-Enhet kobling" = Adresse.Name 
	and "Operativ tom Dato">"31.12.2019" 
	and "Organisasjonstype kode" in ("035", "019", "010", "018");
 select distinct
	"supplier" as source, 'supplier' as kind, "Vendor Number" as org_id,
	"Vendor Name" as nameLine1,
	ADDRESS_LINE1 as addressLine1,
	Zip as postalCode,
	City as city,
	country as countryCode
from Supplier;
 

select distinct "alystra" as source, 'customer' as kind, "Aktoernr" as org_id, nameLine1, addressLine1,postalCode,CITY,country  from alystrabasis where bedrift;
select distinct "alystra" as source, 'pib' as kind, "Aktoernr" as org_id, nameLine1, addressLine1,postalCode,CITY,country  from alystrabasis where pib;
select distinct "alystra" as source, adrtype as kind, "" as org_id, nameLine1, addressLine1,postalCode,CITY,country  from alystrabasis where not pib and not bedrift;
select "cdh" as source, "ship" as kind, org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 city, 
 country from cdh where s_or_b = 1;
select "cdh" as source, "bill" as kind, org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 city, 
 country from cdh where s_or_b = 10;
 select "cdh" as source, "ship&bill" as kind, org_id,
 PARTY_NAME,
 ADDRESS1,
 POSTAL_CODE,
 city, 
 country from cdh where s_or_b = 11;
 
 
 ---------------------------------------------------------
 
 select count(*), nameLine1, addressLine1, postalCode, city, country from ( 
 select HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, 		POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY,	"NO" as country from AlystraShifts 
union all select  BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,		POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,	 "NO" as country from AlystraShifts)
group by nameLine1, addressLine1, postalCode, city, country ;

 select count(*), a.NAVN as nameLine1, a.ADRESSE_1 as addressLine1 ,  printf("%04d", a.POSTNR) as postalCode, a.POSTSTED as city ,"EKSP_LAND_KODE" as Country from AmphoraTrips a group by nameLine1, addressLine1, postalCode, city, country;



.





select distinct
 ACCOUNT_NUMBER as org_id,
 Account_name,
 PARTY_NAME,
 ADDRESS1,
  ADDRESS2,
 POSTAL_CODE,
 CITY as city, 
 Country as country,
 "SITE_USE_CODE"
 from Customer;


