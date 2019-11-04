--recast amphoradata to form scheduled orders, with address fields
--recast alystradata to form scheduled orders, with address fields

--create table scheduledordersbasis

--compared to bigscript, 
--use alystraBasis2 not alystraBasis
--use scoredAddresses, not addresses

--fix searchname
drop table amphoraBasis;
create table amphoraBasis as select 
a.NAVN as pu_nameLine1,
 a.ADRESSE_1 as pu_addressLine1,
 printf("%04d", a.POSTNR)as pu_postalCode,
 a.POSTSTED as pu_CITY,
 "" as del_nameLine1,
 "" as del_addressLine1,
 "" as del_postalCode,
 "" as del_CITY,
 a.agent_nr||"_"||kunde_nr  as "OrderTemplateNumber",
NPB_OEBS_ACCOUNTNUMBER as  "PossPrincipal",
adepts.BluJayDept as  "Department",
"f" as "HandlingCode",
a.agent_nr||"_"||kunde_nr as Reference, 
"" as "Service",
"" as "Priority",
depts.TermRel as "TerminalSearchName",
--adr.searchname as "PickUpSearchName",
"" as "PickupDate",
substr("SENEST MANDAG_HENT", 12) as PickupTime, 
--"" as "DeliverySearchName",
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
from AmphoraTrips a, AmphoraDepts adepts , depts
where 
a.AGENT_NR = adepts.AGENT_NR
and adepts.BluJayDept = depts.Dept;
drop table basis;
create table basis as 
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, del_nameLine1, del_addressLine1, del_postalCode, del_CITY,"OrderTemplateNumber","PossPrincipal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickupDate","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"1" as day, substr("SENEST MANDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST MANDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, del_nameLine1, del_addressLine1, del_postalCode, del_CITY,"OrderTemplateNumber","PossPrincipal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickupDate","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"2" as day, substr("SENEST TIRSDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST TIRSDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, del_nameLine1, del_addressLine1, del_postalCode, del_CITY,"OrderTemplateNumber","PossPrincipal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickupDate","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"3" as day, substr("SENEST ONSDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST ONSDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, del_nameLine1, del_addressLine1, del_postalCode, del_CITY,"OrderTemplateNumber","PossPrincipal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickupDate","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"4" as day, substr("SENEST TORSDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST TORSDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, del_nameLine1, del_addressLine1, del_postalCode, del_CITY,"OrderTemplateNumber","PossPrincipal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickupDate","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"5" as day, substr("SENEST FREDAG_HENT",12) as PickupTime from amphoraBasis  where "SENEST FREDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, del_nameLine1, del_addressLine1, del_postalCode, del_CITY,"OrderTemplateNumber","PossPrincipal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickupDate","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"6" as day, substr("SENEST LORDAG_HENT",12) as PickupTime from amphoraBasis where "SENEST LORDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, del_nameLine1, del_addressLine1, del_postalCode, del_CITY,"OrderTemplateNumber","PossPrincipal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickupDate","DeliveryDate",
"DeliveryTime","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"7" as day, substr("SENEST SONDAG_HENT",12) as PickupTime from amphoraBasis where "SENEST SONDAG_HENT"!="";


drop table basis2;
create table basis2 as select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, del_nameLine1, del_addressLine1, del_postalCode, del_CITY,"OrderTemplateNumber","PossPrincipal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickupDate", PickupTime,
"DeliveryDate",
"DeliveryTime","NumberOfPackages",
"PackageType","GrossWeight",
"Pallets","LoadingMeters",
"IsThermoGoods","TemperatureFrom",
"TemperatureTo","StartingDate",
"ExpiryDate","LoadPlusDays",
"UnloadPlusDays", group_concat(day,"") as ukedagordre 
from basis 
group by pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, del_nameLine1, del_addressLine1, del_postalCode, del_CITY,"OrderTemplateNumber","PossPrincipal","Department","HandlingCode",Reference, "Service","Priority","TerminalSearchName","PickupDate", PickupTime,
"DeliveryDate",
"DeliveryTime","NumberOfPackages",
"PackageType","GrossWeight",
"Pallets","LoadingMeters",
"IsThermoGoods","TemperatureFrom",
"TemperatureTo","StartingDate",
"ExpiryDate","LoadPlusDays",
"UnloadPlusDays"
union all
select distinct
a.hentenavn as pu_nameline1 ,
a.GATEADRESSE_FRA as pu_addressLine1,
a.POSTNR_FRA as pu_postalCode,
a.POSTSTED_FRA as pu_CITY,
"" as del_nameLine1, 
"" as del_addressLine1, 
"" as del_postalCode, 
"" as del_CITY,
vaktnr||"_"||rutenr||"-"||seq_load_event as "OrderTemplateNumber",
aktoernr as "PossPrincipal",
adepts.Column1 as "Department",
"f" as "HandlingCode",
ordrenummer as "Reference",
"" as "Service",
"" as "Priority",
depts.TermRel as "TerminalSearchName",
"" as "PickupDate",
RAMMETIDFRAKL_FRA as "PickupTime",  
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
from AlystraShifts a, LastbPackage p, AlystraDepts adepts, depts
where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept
and a.lastb = p.lastb
union all
select distinct
"" as pu_nameLine1, 
"" as pu_addressLine1, 
"" as pu_postalCode, 
"" as pu_CITY,
a.bringenavn as del_nameline1 ,
a.GATEADRESSE_til as del_addressLine1,
a.POSTNR_til as del_postalCode,
a.POSTSTED_til as del_CITY,
vaktnr||"_"||rutenr||"-"||seq_load_event as "OrderTemplateNumber",
aktoernr as "PossPrincipal",
adepts.Column1 as "Department",
"g" as "HandlingCode",
ordrenummer as "Reference",
"" as "Service",
"" as "Priority",
depts.TermRel as "TerminalSearchName",
"" as "PickupDate",
"" as "PickupTime",
"" as "DeliveryDate",
RAMMETIDTILKL_TIL as "DeliveryTime",
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
from AlystraShifts a, LastbPackage p, AlystraDepts adepts, depts
where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept
and a.lastb = p.lastb;





