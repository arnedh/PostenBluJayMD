 ---adapted from 5-create-scheduled-bases
drop table if exists typer; 
.import typer.csv typer

drop table if exists basisalystra1;
create table basisalystra1 as
  with dist as (select distinct 
 "ENHETVAKT", "ORDRENUMMER","ENHETAVTALE", "AVTALENUMMER",  "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from AlystraShifts)
 select
 --dense_rank() over win r6,
 (case when (tf.sentralisering - tt.sentralisering)>=0  then 'f' else 'g' end) as "HandlingCode",
 --(tf.sentralisering - tt.sentralisering) as diff, 
 "ENHETVAKT", "ORDRENUMMER","ENHETAVTALE", "AVTALENUMMER",  "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from dist, 
 typer as tf, 
 typer as tt
where dist.type_fra = tf.type and dist.type_til = tt.type
 -- window win as (partition by "ENHETVAKT", "ORDRENUMMER","ENHETAVTALE", "AVTALENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL" order by "ANTALL", "LASTB")
 order by "ENHETVAKT", "ORDRENUMMER","ENHETAVTALE", "AVTALENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB";
  
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
"SENEST SONDAG_HENT"
from AmphoraTrips a, AmphoraDepts adepts , depts
where 
a.AGENT_NR = adepts.AGENT_NR
and adepts.BluJayDept = depts.Dept;

drop table if exists basisamphora2;
create table basisamphora2 as 
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"1" as day, substr("KLAR MANDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST MANDAG_HENT",12) as PickupTillTime from basisamphora1  where "KLAR MANDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"2" as day, substr("KLAR TIRSDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST TIRSDAG_HENT",12) as PickupTillTime from basisamphora1  where "KLAR TIRSDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"3" as day, substr("KLAR ONSDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST ONSDAG_HENT",12) as PickupTillTime from basisamphora1  where "KLAR ONSDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"4" as day, substr("KLAR TORSDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST TORSDAG_HENT",12) as PickupTillTime from basisamphora1  where "KLAR TORSDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"5" as day, substr("KLAR FREDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST FREDAG_HENT",12) as PickupTillTime from basisamphora1  where "KLAR FREDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"6" as day, substr("KLAR LORDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST LORDAG_HENT",12) as PickupTillTime from basisamphora1 where "KLAR LORDAG_HENT"!=""
union
select pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "RefBase","PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate","NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays",
"7" as day, substr("KLAR SONDAG_KLOKKEN",12) as PickupFromTime, substr("SENEST SONDAG_HENT",12) as PickupTillTime from basisamphora1 where "KLAR SONDAG_HENT"!="";


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
"UnloadPlusDays", group_concat(day,"") as ukedagordre 
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
"UnloadPlusDays"
--window win as (partition by "ref" order by pu_nameLine1, pu_addressLine1, pu_postalCode, pu_CITY, "PossPrincipal","Department","HandlingCode", "Service","Priority","TerminalSearchName","PickupDate", PickupFromTime,PickupTillTime,"NumberOfPackages","PackageType","GrossWeight","Pallets","LoadingMeters","IsThermoGoods","TemperatureFrom","TemperatureTo","StartingDate","ExpiryDate","LoadPlusDays","UnloadPlusDays")
;

drop table if exists basisalystra2;
create table basisalystra2 as select 
a.*,
--a."ENHETVAKT"||"/"||"ORDRENUMMER"||"-"||r6 as "Reference",
a."ENHETVAKT"||"/"||"ORDRENUMMER" as RefBase,
adepts.Column1 as "Department",
depts.TermRel as "TerminalSearchName",
p.package as "PackageType",
p."KONTAINERFAKTOR" as kontainerfaktor
from basisalystra1 a, LastbPackage p, AlystraDepts adepts, depts
where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept
and a.lastb = p.lastb;
 
 
drop table if exists basisalystra3;
create table basisalystra3 as select distinct "RefBase", "HandlingCode", "Department", "TerminalSearchName","AKTOERNR", "UKEDAGORDRE",
"ENHETVAKT", "ORDRENUMMER",--added
 "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA",
 "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB", kontainerfaktor, PackageType,
 coalesce(r.relationNumber,99999998) as "Principal" 
from basisalystra2 left join relations r
on AKTOERNR = r.relationNumber;

drop table if exists basisamphora4;
create table basisamphora4 as select 
	ba3.*, 
	coalesce(r.relationNumber,99999998) as "Principal"
	--ref||"-"||ind as OrderTemplateNumber
from basisamphora3 ba3 left join relations r
on "PossPrincipal" = r.relationNumber;