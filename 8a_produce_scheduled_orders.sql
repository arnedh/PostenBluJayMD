--join ordersbasis to washedaddresses, finding searchname

drop table washbasis;
create table washbasis as 
select distinct wa.in_name, wa.in_addr, wa.in_zip, wa.in_city, adrLookup.searchnameref  from washedaddresses wa, adrLookup 
where adrLookup.in_name = wa.in_name 
and adrLookup.out_addr1 = wa.out_addr1
and adrLookup.out_zip = wa.out_zip
and adrLookup.out_city = wa.out_city;

drop table basisalystra4;
create table basisalystra4 as select wb.searchnameref as "PickupSearchname", ba3.* from basisalystra3 ba3 left join washbasis wb
on "HENTENAVN"= wb.in_name 
and "GATEADRESSE_FRA" = wb.in_addr
and "POSTNR_FRA" = wb.in_zip
and "POSTSTED_FRA" = wb.in_city;

drop table basisalystra5;
create table basisalystra5 as select wb.searchnameref as "DeliverySearchname", ba4.* from basisalystra4 ba4 left join washbasis wb
on "BRINGENAVN"= wb.in_name 
and "GATEADRESSE_TIL" = wb.in_addr
and "POSTNR_TIL" = wb.in_zip
and "POSTSTED_TIL" = wb.in_city;

drop table basisamphora5;
create table basisamphora5 as select wb.searchnameref as "PickupSearchname", ba4.* from basisamphora4 ba4 left join washbasis wb
on "pu_nameLine1"= wb.in_name 
and "pu_addressLine1" = wb.in_addr
and "pu_postalCode" = wb.in_zip
and "pu_CITY" = wb.in_city;

drop table basis5;
create table basis5 as select distinct
"OrderTemplateNumber",
"Principal",
"Department",
"HandlingCode",
"Reference",
"" as "Priority",
"TerminalSearchName", 
"PickUpSearchName",
"PickupDate",
"PickupFromTime",
"PickupTillTime",
"TerminalSearchName" as "DeliverySearchName",
"" as "DeliveryDate",
"" as "DeliveryFromTime",
"" as "DeliveryTillTime",
"01.01.2019" as "StartingDate",
"31.12.2099" as "ExpiryDate",
"" as "LoadPlusDays",
"" as "UnloadPlusDays",
"ukedagordre"
from basisamphora5
union all 
select 
"Reference" as OrderTemplateNumber, 
"Principal",
"Department",
"HandlingCode",
"Reference",
--"" as "Service",
"" as "Priority",
"TerminalSearchName",
"PickUpSearchName",
"" as "PickupDate",
RAMMETIDFRAKL_FRA as "PickupFromTime",
RAMMETIDTILKL_FRA"PickupTillTime",
"DeliverySearchName",
"" as "DeliveryDate",
RAMMETIDFRAKL_TIL as "DeliveryFromTime",
RAMMETIDTILKL_TIL as "DeliveryTillTime",
"01.01.2019" as "StartingDate",
"31.12.2099" as "ExpiryDate",
"" as "LoadPlusDays",
"" as "UnloadPlusDays",
"ukedagordre"
from basisalystra5;

.once _scheduledTemplates.csv
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
(instr("ukedagordre", "1") > 0) as IsMonday,
(instr("ukedagordre", "2") > 0) as IsTuesday,
(instr("ukedagordre", "3") > 0) as IsWednesDay,
(instr("ukedagordre", "4") > 0) as IsThursday,
(instr("ukedagordre", "5") > 0) as IsFriday,
(instr("ukedagordre", "6") > 0) as IsSaturday,
(instr("ukedagordre", "7") > 0) as IsSunday
from basis5
order by Reference;

.once _scheduledOrderLines.csv
select 
"Reference", 
ANTALL as "NumberOfPackages", 
"PackageType", 
"" as "GrossWeight",
"" as "Pallets",
"" as "LoadingMeters",
"" as "IsThermoGoods",
"" as "TemperatureFrom",
"" as "TemperatureTo" 
from basisAlystra2
union all
select 
"Reference",
"NumberOfPackages",
"PackageType", 
"GrossWeight",
"Pallets",
"LoadingMeters",
"" as "IsThermoGoods",
"" as "TemperatureFrom",
"" as "TemperatureTo"
from basisAmphora4;


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