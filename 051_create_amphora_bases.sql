
drop table if exists basisamphora1;
create table basisamphora1 as select 
a.NAVN as pu_nameLine1,
a.ADRESSE_1 as pu_addressLine1,
printf("%04d", a.POSTNR)as pu_postalCode, --??
a.POSTSTED as pu_CITY,
a.agent_nr||"_"||kunde_nr as "RefBase",
NPB_OEBS_ACCOUNTNUMBER as  "PossPrincipal",
adepts.BluJayDept as  "Department",
"f" as "HandlingCode",
"" as "Service",
"" as "Priority",
depts.TermRel as "TerminalSearchName",
--adr.searchname as "PickUpSearchName",
"" as "PickupDate",
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
"KLAR MANDAG_KLOKKEN",
"KLAR TIRSDAG_KLOKKEN",
"KLAR ONSDAG_KLOKKEN",
"KLAR TORSDAG_KLOKKEN",
"KLAR FREDAG_KLOKKEN",
"KLAR LORDAG_KLOKKEN",
"KLAR SONDAG_KLOKKEN",
"SENEST MANDAG_HENT",
"SENEST TIRSDAG_HENT",
"SENEST ONSDAG_HENT",
"SENEST TORSDAG_HENT",
"SENEST FREDAG_HENT",
"SENEST LORDAG_HENT",	
"SENEST SONDAG_HENT",
"PRGR_KODE"
from AmphoraTrips a, AmphoraDepts adepts , depts
where 
a.AGENT_NR = adepts.AGENT_NR
and adepts.BluJayDept = depts.Dept;

drop table if exists basisamphora1a;
create table basisamphora1a as select ba.*, ap.prodkat as _prodcat from basisamphora1 ba left join amphoraprgr ap on ba.PRGR_KODE = ap.PRGR_KODE;


drop table if exists basisamphora2;
create table basisamphora2 as 
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays", _prodcat,
"1" as day, substr("KLAR MANDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST MANDAG_HENT",12) as PickupTillTime from basisamphora1a  where "KLAR MANDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",_prodcat,
"2" as day, substr("KLAR TIRSDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST TIRSDAG_HENT",12) as PickupTillTime from basisamphora1a  where "KLAR TIRSDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",_prodcat,
"3" as day, substr("KLAR ONSDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST ONSDAG_HENT",12) as PickupTillTime from basisamphora1a  where "KLAR ONSDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",_prodcat,
"4" as day, substr("KLAR TORSDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST TORSDAG_HENT",12) as PickupTillTime from basisamphora1a  where "KLAR TORSDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",_prodcat,
"5" as day, substr("KLAR FREDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST FREDAG_HENT",12) as PickupTillTime from basisamphora1a  where "KLAR FREDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",_prodcat,
"6" as day, substr("KLAR LORDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST LORDAG_HENT",12) as PickupTillTime from basisamphora1a where "KLAR LORDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",_prodcat,
"7" as day, substr("KLAR SONDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST SONDAG_HENT",12) as PickupTillTime from basisamphora1a where "KLAR SONDAG_HENT"!="";


drop table if exists basisamphora3;
create table basisamphora3 as select 
--dense_rank() over win ind,
pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY,"RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate", 
PickupFromTime,
PickupTillTime,
"NumberOfPackages",
"PackageType","GrossWeight",
"Pallets","LoadingMeters",
"IsThermoGoods","TemperatureFrom",
"TemperatureTo","StartingDate",
"ExpiryDate","LoadPlusDays",
"UnloadPlusDays", group_concat(day,"") as ukedagordre ,_prodcat
from basisamphora2 
group by pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "PossPrincipal","Department","HandlingCode","RefBase", "Service","Priority","TerminalSearchName","PickupDate", 
PickupFromTime,
PickupTillTime,
"NumberOfPackages",
"PackageType","GrossWeight",
"Pallets","LoadingMeters",
"IsThermoGoods","TemperatureFrom",
"TemperatureTo","StartingDate",
"ExpiryDate","LoadPlusDays",
"UnloadPlusDays", _prodcat
--window win as (partition by "ref" order by pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate", PickupFromTime,PickupTillTime,"NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays")
;



drop table if exists basisamphora4;
create table basisamphora4 as select 
	ba3.*, 
	coalesce(r.relationNumber,999999000000) as "Principal"
	--ref||"-"||ind as OrderTemplateNumber
from basisamphora3 ba3 left join relations r
on "PossPrincipal" = r.relationNumber;