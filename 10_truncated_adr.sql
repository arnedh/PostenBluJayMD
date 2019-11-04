
.header on
--.mode tabs

.separator "\t"
.mode tabs
.import _logisticsadressesNonRel.csv logNonRel
.import _logisticsadressesRel.csv logRel
.once _logAdrNonRelTrunc.txt
select 
"Searchname","Relation number",substr((case when length("Name line 1")=0 then '-' else "Name line 1" end),1,35) as "Name line 1","Name line 2","Name line 3",substr((case when length("Address line 1")=0 then '-' else "Address line 1" end),1,35) as "Address line 1","Address line 2","Address line 3",case when length("Postal code")=0 then '-' else "Postal code" end as "Postal code",case when length("City")=0 then '-' else "City" end as "City","Country","District code","Contact person","Telephone number","Telex number","Fax number","Language code","E-mail address","Internet Address","Select for planning characteristics","Type of address","Destination code","City2","AGP licence number","EAN relation number","Indication fiscal representation","VAT ID number","Base stop time","Pickup scan required","Order delivery type","Order collect type"
from logNonRel;

.once _logAdrRelTrunc.txt
select 
"Searchname",
"Relation number",
substr((case when length("Name line 1")=0 then '-' else "Name line 1" end),1,35) as "Name line 1",
"Name line 2",
"Name line 3",
substr((case when length("Address line 1")=0 then '-' else "Address line 1" end),1,35) as "Address line 1",
"Address line 2",
"Address line 3",
case when length("Postal code")=0 then '-' else "Postal code" end as "Postal code",
case when length("City")=0 then '-' else "City" end as "City",
"Country",
"District code",
"Contact person",
"Telephone number",
"Telex number",
"Fax number",
"Language code",
"E-mail address",
"Internet Address",
"Select for planning characteristics",
"Type of address",
"Destination code",
"City2",
"AGP licence number",
"EAN relation number",
"Indication fiscal representation",
"VAT ID number",
"Base stop time",
"Pickup scan required",
"Order delivery type",
"Order collect type"
from logRel;
