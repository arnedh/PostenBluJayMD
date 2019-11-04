.once logAdrNonRelWSearchname.csv
select relations.searchname as Searchname,
la.relationnumber as "Relation number", 
la.in_name as "Name line 1",
 "" as "Name line 2",
 "" as "Name line 3",
la.out_addr1 as "Address line 1",
"" as "Address line 2",
 "" as "Address line 3",
 case
	when la.country='NO' then printf("%04d",la.out_zip) else la.out_zip
end as "Postal code",
la.out_city as City,
case when length(la.country)>2 then 'NO' else la.country end as Country,
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
 from logisticsadresses la, relations where la.relationnumber = relations.relationnumber and la.relationnumber != "";

 
.once ordersPointingToRelations.csv
 
select * from basis where "PickUpSearchName" in (select searchname from relations)
or "DeliverySearchName" in  (select searchname from relations);
