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
Dept;Description;Cost centre;Division;Branch;TermRel;Term;Short
 code	name	start_date	number_of_days	comment

