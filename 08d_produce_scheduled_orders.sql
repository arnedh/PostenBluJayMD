--join ordersbasis to washedaddresses, finding searchname

drop table if exists washbasis;
create table washbasis as 
select distinct * from (select wa.in_name, wa.in_addr, wa.in_zip, wa.in_city, adrLookup.searchnameref  from washedaddresses wa, adrLookup 
where adrLookup.in_name = wa.in_name 
and adrLookup.out_addr1 = wa.out_addr1
and adrLookup.out_zip = wa.out_zip
and adrLookup.out_city = wa.out_city
union 
select distinct wa.in_name, wa.in_addr, printf("%04d",wa.in_zip) as in_zip, wa.in_city, adrLookup.searchnameref  from washedaddresses wa, adrLookup 
where adrLookup.in_name = wa.in_name 
and adrLookup.out_addr1 = wa.out_addr1
and adrLookup.out_zip = wa.out_zip
and adrLookup.out_city = wa.out_city);


drop table if exists basisalystra4;
create table basisalystra4 as select wb.searchnameref as "PickupSearchname", ba3.* from basisalystra3 ba3 left join washbasis wb
on "HENTENAVN"= wb.in_name 
and "GATEADRESSE_FRA" = wb.in_addr
and "POSTNR_FRA" = wb.in_zip
and "POSTSTED_FRA" = wb.in_city;

drop table if exists basisalystra5;
create table basisalystra5 as select wb.searchnameref as "DeliverySearchname", ba4.* from basisalystra4 ba4 left join washbasis wb
on "BRINGENAVN"= wb.in_name 
and "GATEADRESSE_TIL" = wb.in_addr
and "POSTNR_TIL" = wb.in_zip
and "POSTSTED_TIL" = wb.in_city;

drop table if exists basisamphora5;
create table basisamphora5 as select wb.searchnameref as "PickupSearchname", ba4.* from basisamphora4 ba4 left join washbasis wb
on "pu_nameLine1"= wb.in_name 
and "pu_addressLine1" = wb.in_addr
and "pu_postalCode" = wb.in_zip
and "pu_CITY" = wb.in_city;

drop table if exists basis5;
create table basis5 as select distinct
--"OrderTemplateNumber",
"Principal",
"Department",
"HandlingCode",
"RefBase",
"" as "Priority",
"TerminalSearchName", 
"PickUpSearchName",
"01.01.2019" as "PickupDate",
case when length(PickupFromTime)=0 then '08:00' else PickupFromTime end as "PickupFromTime",
case when length(PickupTillTime)=0 then '16:00' else PickupTillTime end as "PickupTillTime",
"TerminalSearchName" as "DeliverySearchName",
"01.01.2019"  as "DeliveryDate",
'08:00' as "DeliveryFromTime",
'17:00' "DeliveryTillTime",
"01.01.2019" as "StartingDate",
"31.12.2099" as "ExpiryDate",
"" as "LoadPlusDays",
"" as "UnloadPlusDays",
"ukedagordre",
case when length("NumberOfPackages")=0 then '1' else "NumberOfPackages" end as "NumberOfPackages",
"PackageType", 
"GrossWeight",
"Pallets",
"LoadingMeters",
"" as "IsThermoGoods",
"" as "TemperatureFrom",
"" as "TemperatureTo",
_prodcat
from basisamphora5
union all 
select 
--"Reference" as OrderTemplateNumber, 
"Principal",
"Department",
"HandlingCode",
"RefBase",
--"" as "Service",
"" as "Priority",
"TerminalSearchName",
"PickUpSearchName",
"01.01.2019" as "PickupDate",
RAMMETIDFRAKL_FRA as "PickupFromTime",
RAMMETIDTILKL_FRA"PickupTillTime",
"DeliverySearchName",
"01.01.2019" as "DeliveryDate",
RAMMETIDFRAKL_TIL as "DeliveryFromTime",
RAMMETIDTILKL_TIL as "DeliveryTillTime",
"01.01.2019" as "StartingDate",
"31.12.2099" as "ExpiryDate",
"" as "LoadPlusDays",
"" as "UnloadPlusDays",
"ukedagordre",
ANTALL as "NumberOfPackages", 
"PackageType", 
ANTALL*250*KONTAINERFAKTOR as "GrossWeight",
ANTALL*KONTAINERFAKTOR as "Pallets",
"" as "LoadingMeters",
"" as "IsThermoGoods",
"" as "TemperatureFrom",
"" as "TemperatureTo" ,
_prodcat
from basisalystra5;

----Reference : partition per RefBase, most others above package level
--Must expand to include all package inf
drop table if exists basis;
create table basis as 

select 
dense_rank() over win ind,
RefBase,
"Principal",
"Department",
"HandlingCode",
"Priority",
"TerminalSearchName",
"PickUpSearchName",
"PickupDate",
"PickupFromTime",
"PickupTillTime",
"DeliverySearchName",
"DeliveryDate",
"DeliveryFromTime",
"DeliveryTillTime",
"StartingDate",
"ExpiryDate",
"LoadPlusDays",
"UnloadPlusDays",
case when instr("ukedagordre", "1")>0 then "TRUE" else "FALSE" end as IsMonday,
case when instr("ukedagordre", "2")>0 then "TRUE" else "FALSE" end as IsTuesday,
case when instr("ukedagordre", "3")>0 then "TRUE" else "FALSE" end as IsWednesDay,
case when instr("ukedagordre", "4")>0 then "TRUE" else "FALSE" end as IsThursday,
case when instr("ukedagordre", "5")>0 then "TRUE" else "FALSE" end as IsFriday,
case when instr("ukedagordre", "6")>0 then "TRUE" else "FALSE" end as IsSaturday,
case when instr("ukedagordre", "7")>0 then "TRUE" else "FALSE" end as IsSunday,
"NumberOfPackages", 
"PackageType", 
"GrossWeight",
"Pallets",
"LoadingMeters",
"IsThermoGoods",
"TemperatureFrom",
"TemperatureTo", 
_prodcat
from basis5
window win as (partition by "RefBase" order by "Principal","Department","PickUpSearchName",
"PickupDate",
"PickupFromTime",
"PickupTillTime",
"DeliverySearchName",
"DeliveryDate",
"DeliveryFromTime",
"DeliveryTillTime", 
_prodcat)
;

.once _scheduledOrders.csv
select distinct
RefBase||"-"||ind as OrderTemplateNumber,
"Principal",
"Department",
"HandlingCode",
RefBase||"-"||ind as Reference,
"Priority",
"TerminalSearchName",
"PickUpSearchName",
"PickupDate",
"PickupFromTime",
"PickupTillTime",
"DeliverySearchName",
"DeliveryDate",
"DeliveryFromTime",
"DeliveryTillTime",
"StartingDate",
"ExpiryDate",
"LoadPlusDays",
"UnloadPlusDays",
IsMonday,
IsTuesday,
IsWednesDay,
IsThursday,
IsFriday,
IsSaturday,
IsSunday, 
_prodcat
from basis;

drop table if exists basisLines;
create table basisLines as  
select 
RefBase||"-"||ind as Reference,
"NumberOfPackages", 
"PackageType", 
"GrossWeight",
"Pallets",
"LoadingMeters",
"IsThermoGoods",
"TemperatureFrom",
"TemperatureTo" 
from basis;

.once _scheduledOrderLines.csv
select * from basisLines;


.once _schedule_shift_template.csv
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

.once _schedule_template.csv
select distinct 
"20190401"||printf("%06d",Dept) as code,
Short||" shift plan" as name,
"20190401" as start_date,
"2" as number_of_days,
"00000000" as comment
from AlystraShifts a, AlystraDepts adepts, depts where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept;


.once _ordersWithOrderLines.csv
select 
RefBase||"-"||ind as OrderTemplateNumber,
"Principal",
"Department",
"HandlingCode",
RefBase||"-"||ind as Reference,
"Priority",
"TerminalSearchName",
"PickUpSearchName",
"PickupDate",
"PickupFromTime",
"PickupTillTime",
"DeliverySearchName",
"DeliveryDate",
"DeliveryFromTime",
"DeliveryTillTime",
"StartingDate",
"ExpiryDate",
"LoadPlusDays",
"UnloadPlusDays",
IsMonday,
IsTuesday,
IsWednesDay,
IsThursday,
IsFriday,
IsSaturday,
IsSunday,
"NumberOfPackages",
"PackageType", 
"GrossWeight",
"Pallets",
"LoadingMeters",
_prodcat
from basis;


.mode quote
.once _conflatedScheduledOrders.csv
select 
RefBase||"-"||ind as OrderTemplateNumber,
"Principal",
"Department",
"HandlingCode",
RefBase||"-"||ind as Reference,
"Priority",
"TerminalSearchName",
"PickUpSearchName",
"PickupDate",
"PickupFromTime",
"PickupTillTime",
"DeliverySearchName",
"DeliveryDate",
"DeliveryFromTime",
"DeliveryTillTime",
"StartingDate",
"ExpiryDate",
"LoadPlusDays",
"UnloadPlusDays",
IsMonday,
IsTuesday,
IsWednesDay,
IsThursday,
IsFriday,
IsSaturday,
IsSunday,
_prodcat,
group_concat(cast("NumberOfPackages" as string),";") as "NumberOfPackages",
group_concat("PackageType",";") as "PackageType", 
group_concat(cast("GrossWeight" as string),";") as "GrossWeight",
group_concat(cast("Pallets" as string), ";") as  "Pallets",
group_concat(cast("LoadingMeters" as string), ";") as  "LoadingMeters",
count(*) as ct
from basis 
group by 
"OrderTemplateNumber",
"Principal",
"Department",
"HandlingCode",
"Priority",
"TerminalSearchName",
"PickUpSearchName",
"PickupDate",
"PickupFromTime",
"PickupTillTime",
"DeliverySearchName",
"DeliveryDate",
"DeliveryFromTime",
"DeliveryTillTime",
"StartingDate",
"ExpiryDate",
"LoadPlusDays",
"UnloadPlusDays",
IsMonday,
IsTuesday,
IsWednesDay,
IsThursday,
IsFriday,
IsSaturday,
IsSunday , 
_prodcat;

.mode csv
