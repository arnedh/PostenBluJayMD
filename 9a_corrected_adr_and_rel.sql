drop table if exists logRel;
create table logRel as select
searchnamedef as Searchname,
relationnumber as "Relation number", 
in_name as "Name line 1",
 "" as "Name line 2",
 "" as "Name line 3",
 out_addr1 as "Address line 1",
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
"3" as   "Type of address" ,
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
from logisticsadresses
where relationnumber != "";

drop table if exists logNonRel;
create table logNonRel as
select
searchnamedef as Searchname,
'99999998' as "Relation number", 
in_name as "Name line 1",
 "" as "Name line 2",
 "" as "Name line 3",
 out_addr1 as "Address line 1",
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
"3" as   "Type of address" ,
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
from logisticsadresses
where relationnumber = "";


create table busrel2 as
select 
 searchname,
  relationNumber ,
  trim(replace(replace(nameLine1,char(9),""),char(34),"")) as nameLine1,
  trim(replace(replace(nameLine2,char(9),""),char(34),"")) as nameLine2,
  nameLine3,
  addressLine1 ,
  addressLine2 ,
  addressLine3 ,
  case
	when countryCode='NO' then printf("%04d",postalCode) else postalCode
end as  postalcode,
  city ,
  case when length(countryCode)>2 then 'NO' else countryCode end as countryCode2 ,
  subentityCode,
  postOfficeBox,
  postOfficeBoxPostalcode,
  postOfficeBoxCity,
  postOfficeBoxCountry,
  telephoneNumber,
  telefaxNumber,
  emailAddress,
  internetAddress,
  contactPerson,
  typeOfRelation,
  currencyCode,
  vatCode,
  languageCode,
  relationGroup,
  paymentTerm,
  creditLimit,
  vatNumberOrg ,
  vatNumber
   from relations;
   
.once _businessrelationsMain.csv
select 
  searchname,
  relationNumber ,
  substr((case when length("nameLine1")=0 then '-' else "nameLine1" end),1,35) as nameLine1,
  substr((case when length("nameLine2")=0 then '-' else "nameLine2" end),1,35) as nameLine2,
  nameLine3,
  substr((case when length("addressLine1")=0 then '-' else "addressLine1" end),1,35) as addressLine1,
  addressLine2 ,
  addressLine3 ,
  postalcode as postalCode,
  city ,
  countryCode2 as countryCode,
  subentityCode,
  postOfficeBox,
  postOfficeBoxPostalcode,
  postOfficeBoxCity,
  postOfficeBoxCountry,
  telephoneNumber,
  telefaxNumber,
  emailAddress,
  internetAddress,
  contactPerson,
  typeOfRelation,
  currencyCode,
  vatCode,
  languageCode,
  relationGroup,
  paymentTerm,
  creditLimit,
  vatNumberOrg ,
  vatNumber
from busrel2; 
