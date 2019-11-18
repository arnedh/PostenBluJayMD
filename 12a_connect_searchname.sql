create table lanrws as select 
relations.searchname,
la.relationnumber,
la.in_name,
la.out_addr1, 
case when length(la.out_zip)=0 then '-' else la.out_zip end as "out_zip",
case when length(la.out_city)=0 then '-' else la.out_city end as "City",
la.out_city,
la.country
from logisticsadresses la, relations where la.relationnumber = relations.relationnumber and la.relationnumber != "";

.once logAdrNonRelWSearchname.csv

select 
 searchname as Searchname,
 relationnumber as "Relation number", 
 substr((case when length(in_name)=0 then '-' else in_name end),1,35) as "Name line 1",
 "" as "Name line 2",
 "" as "Name line 3",
 substr((case when length(out_addr1)=0 then '-' else out_addr1 end),1,35) as "Address line 1",
"" as "Address line 2",
 "" as "Address line 3",
 case
	when country='NO' then printf("%04d",out_zip) else out_zip
 end as "Postal code",
 out_city as City,
 case when length(country)>2 then 'NO' else country end as Country,
 "" as "District code",
 "" as "Contact person",
"" as "Telephone number",
"" as "Telex number",
"" as "Fax number",
"" as "Language code",
"" as "E-mail address",
"" as "Internet Address",
"" as "Select for planning characteristics" ,
"0" as   "Type of address" ,
"" as   "Destination code" ,
"" as   "City2" ,
"" as   "AGP licence number" ,
"" as   "EAN relation number" ,
"" as   "Indication fiscal representation" ,
"" as   "VAT ID number" ,
"" as   "Base stop time" ,
"" as   "Pickup scan required" ,
"" as   "Order delivery type" ,
"" as   "Order collect type" 
from lanrws;

 
.once ordersPointingToRelations.csv
 
select * from basis where "PickUpSearchName" in (select searchname from relations)
or "DeliverySearchName" in  (select searchname from relations);
