--join ordersbasis to washedaddresses, finding searchname

drop table washbasis;
create table washbasis as 
select distinct wa.in_name, wa.in_addr, wa.in_zip, wa.in_city, adrLookup.searchnameref  from washedaddresses wa, adrLookup 
where adrLookup.in_name = wa.in_name 
and adrLookup.out_addr1 = wa.out_addr1
and adrLookup.out_zip = wa.out_zip
and adrLookup.out_city = wa.out_city;



drop table basis3;



create table basis3 as select wb.searchnameref as "PickupSearchname", basis2.* from basis2 left join washbasis wb
on pu_nameLine1= wb.in_name 
and pu_addressLine1 = wb.in_addr
and pu_postalcode = wb.in_zip
and pu_city = wb.in_city;


drop table basis4;

create table basis4 as select wb.searchnameref  as "DeliverySearchname", basis3.* from basis3 left join washbasis wb
on del_nameLine1= wb.in_name 
and del_addressLine1 = wb.in_addr
and del_postalcode = wb.in_zip
and del_city = wb.in_city;

create table basis5 as select basis4.*, coalesce(r.relationNumber,99999998) as "Principal" 
from basis4 left join relations r
on PossPrincipal = r.relationNumber;



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
from basis5
order by OrderTemplateNumber;

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