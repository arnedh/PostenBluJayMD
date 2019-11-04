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


select adr.searchname, p.package, depts.Column1,  a.* from AlystraShifts a, LastbPackage p, AlystraDepts depts, addresses adr
where a.enhetvakt = depts.enhetvakt 
and a.lastb = p.lastb
and a.hentenavn = adr.nameline1 
and a.GATEADRESSE_FRA = adr.addressLine1
and a.POSTNR_FRA = adr.postalCode
and a.POSTSTED_FRA = adr.CITY; --- og samme for "til"

select depts.BluJayDept, adr.searchname, a.* from AmphoraTrips a, AmphoraDepts depts , addresses adr
where 
a.AGENT_NR = depts.AGENT_NR
and a.NAVN = adr.nameLine1 
and a.ADRESSE_1 = adr.addressLine1 
and printf("%04d", a.POSTNR) = adr.postalCode 
and a.POSTSTED = adr.city


select distinct
vaktnr||"_"||rutenr||"-"||seq_load_event as "OrderTemplateNumber",
aktoernr as "Principal",
adepts.Column1 as "Department",
"fg" as "HandlingCode",
ordrenummer as "Reference",
"" as "Service",
"" as "Priority",
depts.TermRel as "TerminalSearchName",
"" as "PickUpSearchName",
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
(instr("ukedagordre", "1") > 0) as IsMonday,
(instr("ukedagordre", "2") > 0) as IsTuesday,
(instr("ukedagordre", "3") > 0) as IsWednesDay,
(instr("ukedagordre", "4") > 0) as IsThursday,
(instr("ukedagordre", "5") > 0) as IsFriday,
(instr("ukedagordre", "6") > 0) as IsSaturday,
(instr("ukedagordre", "7") > 0) as IsSunday
from AlystraShifts a, LastbPackage p, AlystraDepts adepts, depts
where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept
and a.lastb = p.lastb;



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
(instr("ukedagordre", "1") > 0) as IsMonday,
(instr("ukedagordre", "2") > 0) as IsTuesday,
(instr("ukedagordre", "3") > 0) as IsWednesDay,
(instr("ukedagordre", "4") > 0) as IsThursday,
(instr("ukedagordre", "5") > 0) as IsFriday,
(instr("ukedagordre", "6") > 0) as IsSaturday,
(instr("ukedagordre", "7") > 0) as IsSunday
from AlystraShifts a, LastbPackage p, AlystraDepts adepts, depts, addresses adr
where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept
and a.lastb = p.lastb
and a.hentenavn = adr.nameline1 
and a.GATEADRESSE_FRA = adr.addressLine1
and a.POSTNR_FRA = adr.postalCode
and a.POSTSTED_FRA = adr.CITY; --- og samme for "til"

select 
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
("SENEST MANDAG_HENT"="") as IsMonday
--SENEST TIRSDAG_HENT	
--SENEST ONSDAG_HENT	
--SENEST TORSDAG_HENT	
--SENEST FREDAG_HENT	
--SENEST LORDAG_HENT	
--SENEST SONDAG_HENT
from AmphoraTrips a, AmphoraDepts adepts , addresses adr, depts
where 
a.AGENT_NR = adepts.AGENT_NR
and adepts.BluJayDept = depts.Dept
and a.NAVN = adr.nameLine1 
and a.ADRESSE_1 = adr.addressLine1 
and printf("%04d", a.POSTNR) = adr.postalCode 
and a.POSTSTED = adr.city


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