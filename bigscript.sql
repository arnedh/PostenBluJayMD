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


.header on
.mode tabs
.separator "\t"

drop table Enhet;
drop table Adresse;
.import "20190508102014_NPBP7_EnhetFO.txt" Enhet
.import "20190508092200_NPBP7_Adresse.txt" Adresse

--------------------------


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

.output stdout

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


--------------------------------

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


create table amphoraBasis as select 
a.agent_nr||"_"||kunde_nr  as "OrderTemplateNumber",
NPB_OEBS_ACCOUNTNUMBER as  "Principal",
adepts.BluJayDept as  "Department",
"f" as "HandlingCode",
a.agent_nr||"_"||kunde_nr as Reference, 
"" as "Service",
"" as "Priority",
depts.TermRel as "TerminalSearchName",
adr.searchname as "PickUpSearchName",
"" as "PickupDate",
substr("SENEST MANDAG_HENT", 12) as PickupTime, 
"" as "DeliverySearchName",
"" as "DeliveryDate",
"" as "DeliveryTime",
ANT_KOLLI as  "NumberOfPackages",
"PP" as "PackageType",
VEKT as "GrossWeight",
ANT_PALLER as "Pallets",
LASTEMETER as "LoadingMeters",
"" as "IsThermoGoods",
"" as "TemperatureFrom",
"" as "TemperatureTo",
"01.01.2019" as "StartingDate",
"31.12.2099" as "ExpiryDate",
"" as "LoadPlusDays",
"" as "UnloadPlusDays",
"SENEST MANDAG_HENT",
"SENEST TIRSDAG_HENT",
"SENEST ONSDAG_HENT",
"SENEST TORSDAG_HENT",
"SENEST FREDAG_HENT",
"SENEST LORDAG_HENT",	
"SENEST SONDAG_HENT"
from AmphoraTrips a, AmphoraDepts adepts , addresses adr, depts
where 
a.AGENT_NR = adepts.AGENT_NR
and adepts.BluJayDept = depts.Dept
and a.NAVN = adr.nameLine1 
and a.ADRESSE_1 = adr.addressLine1 
and printf("%04d", a.POSTNR) = adr.postalCode 
and a.POSTSTED = adr.city;

create table basis as 
select "OrderTemplateNumber","Principal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickUpSearchName","PickupDate","DeliverySearchName","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"1" as day, substr("SENEST MANDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST MANDAG_HENT"!=""
union
select "OrderTemplateNumber","Principal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickUpSearchName","PickupDate","DeliverySearchName","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"2" as day, substr("SENEST TIRSDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST TIRSDAG_HENT"!=""
union
select "OrderTemplateNumber","Principal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickUpSearchName","PickupDate","DeliverySearchName","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"3" as day, substr("SENEST ONSDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST ONSDAG_HENT"!=""
union
select "OrderTemplateNumber","Principal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickUpSearchName","PickupDate","DeliverySearchName","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"4" as day, substr("SENEST TORSDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST TORSDAG_HENT"!=""
union
select "OrderTemplateNumber","Principal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickUpSearchName","PickupDate","DeliverySearchName","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"5" as day, substr("SENEST FREDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST FREDAG_HENT"!=""
union
select "OrderTemplateNumber","Principal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickUpSearchName","PickupDate","DeliverySearchName","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"6" as day, substr("SENEST LORDAG_HENT",12) as PickupTime from amphoraBasis where "SENEST LORDAG_HENT"!=""
union
select "OrderTemplateNumber","Principal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickUpSearchName","PickupDate","DeliverySearchName","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"7" as day, substr("SENEST SONDAG_HENT",12) as PickupTime from amphoraBasis where "SENEST SONDAG_HENT"!="";




create table basis2 as select "OrderTemplateNumber","Principal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickUpSearchName","PickupDate", PickupTime,
"DeliverySearchName","DeliveryDate",
"DeliveryTime","NumberOfPackages",
"PackageType","GrossWeight",
"Pallets","LoadingMeters",
"IsThermoGoods","TemperatureFrom",
"TemperatureTo","StartingDate",
"ExpiryDate","LoadPlusDays",
"UnloadPlusDays", group_concat(day,"") as ukedagordre 
from basis 
group by "OrderTemplateNumber","Principal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickUpSearchName","PickupDate", PickupTime,
"DeliverySearchName","DeliveryDate",
"DeliveryTime","NumberOfPackages",
"PackageType","GrossWeight",
"Pallets","LoadingMeters",
"IsThermoGoods","TemperatureFrom",
"TemperatureTo","StartingDate",
"ExpiryDate","LoadPlusDays",
"UnloadPlusDays"
union all
select distinct
vaktnr||"_"||rutenr||"-"||seq_load_event as "OrderTemplateNumber",
aktoernr as "Principal",
adepts.Column1 as "Department",
"f" as "HandlingCode",
ordrenummer as "Reference",
"" as "Service",
"" as "Priority",
depts.TermRel as "TerminalSearchName",
adr.searchname as "PickUpSearchName",
"" as "PickupDate",
AVGANGSTID_FRA as "PickupTime",
"" as "DeliverySearchName",
"" as "DeliveryDate",
"" as "DeliveryTime",
antall as "NumberOfPackages",
p.package as "PackageType",
"" as "GrossWeight",
"" as "Pallets",
"" as "LoadingMeters",
"" as "IsThermoGoods",
"" as "TemperatureFrom",
"" as "TemperatureTo",
"01.01.2019" as "StartingDate",
"31.12.2099" as "ExpiryDate",
"" as "LoadPlusDays",
"" as "UnloadPlusDays",
"ukedagordre" as ukedagordre
from AlystraShifts a, LastbPackage p, AlystraDepts adepts, depts,  addresses adr
where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept
and a.lastb = p.lastb
and a.hentenavn = adr.nameline1 
and a.GATEADRESSE_FRA = adr.addressLine1
and a.POSTNR_FRA = adr.postalCode
and a.POSTSTED_FRA = adr.CITY--- og samme for "til"

union all
select distinct
vaktnr||"_"||rutenr||"-"||seq_load_event as "OrderTemplateNumber",
aktoernr as "Principal",
adepts.Column1 as "Department",
"g" as "HandlingCode",
ordrenummer as "Reference",
"" as "Service",
"" as "Priority",
depts.TermRel as "TerminalSearchName",
"" as "PickUpSearchName",
"" as "PickupDate",
"" as "PickupTime",
adr.searchname as "DeliverySearchName",
"" as "DeliveryDate",
AVGANGSTID_TIL as "DeliveryTime",
antall as "NumberOfPackages",
p.package as "PackageType",
"" as "GrossWeight",
"" as "Pallets",
"" as "LoadingMeters",
"" as "IsThermoGoods",
"" as "TemperatureFrom",
"" as "TemperatureTo",
"01.01.2019" as "StartingDate",
"31.12.2099" as "ExpiryDate",
"" as "LoadPlusDays",
"" as "UnloadPlusDays",
"ukedagordre" as ukedagordre
from AlystraShifts a, LastbPackage p, AlystraDepts adepts, depts, addresses adr
where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept
and a.lastb = p.lastb
and a.bringenavn = adr.nameline1 
and a.GATEADRESSE_til = adr.addressLine1
and a.POSTNR_til = adr.postalCode
and a.POSTSTED_til = adr.CITY; 


.once scheduledTemplates.csv
select distinct
"OrderTemplateNumber",
"Principal",
 "Department",
 "HandlingCode",
 "Reference",
"Priority",
 "TerminalSearchName",
 "PickUpSearchName",
 "PickupDate",
"PickupTime",
"DeliverySearchName",
"DeliveryDate",
"DeliveryTime",
"NumberOfPackages",
 "PackageType",
 "GrossWeight",
"Pallets",
"LoadingMeters",
"IsThermoGoods",
"TemperatureFrom",
 "TemperatureTo",
 "StartingDate",
"ExpiryDate",
"LoadPlusDays",
"UnloadPlusDays",
(instr("ukedagordre", "1") > 0) as IsMonday,
(instr("ukedagordre", "2") > 0) as IsTuesday,
(instr("ukedagordre", "3") > 0) as IsWednesDay,
(instr("ukedagordre", "4") > 0) as IsThursday,
(instr("ukedagordre", "5") > 0) as IsFriday,
(instr("ukedagordre", "6") > 0) as IsSaturday,
(instr("ukedagordre", "7") > 0) as IsSunday
from basis2;



.once schedule_shift_template.csv
select distinct 
"20190401"||printf("%06d",Dept)||"_"||printf("%06d",VAKTNR) as id,
"20190401"||printf("%06d",Dept)||"_"||printf("%06d",VAKTNR) as code,
Short||"_"||printf("%06d",VAKTNR) as name,
'TRUE' as active,
"20190401"||printf("%06d",Dept) as schedule_template_code,
printf("%06d",VAKTNR) as template_code,
Short as department_code,
min(VAKT_FRAKL) as from_time,
0 as from_offset,
max(VAKT_TILKL) as to_time,
VAKT_FRAKL>VAKT_TILKL as till_offset,
 printf("%06d",a.ENHETVAKT) as udf_unitNumber
from AlystraShifts a, AlystraDepts adepts, depts where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept
group by VAKTNR, Short,a.ENHETVAKT
order by VAKTNR, Short,a.ENHETVAKT;

.once schedule_template.csv
select distinct 
"20190401"||printf("%06d",Dept) as code,
Short||" shift plan" as name,
"20190401" as start_date,
"2" as number_of_days,
"00000000" as comment
from AlystraShifts a, AlystraDepts adepts, depts where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept;










