-----create relations

--find relations from supplier
--find relations from customer where id not in supplier

--set searchname prefix, join to max numbering in prefix, prefix + rank within prefix + existing max -> searchname

--export businessrelations.csv
--create businessrelationregistrations
--export businessrelationregistrations.csv

--update usedsearchname

drop table if exists supplierBasis;
create table supplierBasis as
select * from (
select row_number() over (partition by "Vendor Number" order by "Vendor Name" ,
ADDRESS_LINE1,
ADDRESS_LINE2,
Zip,
City,
country,
phone,
"payment_currency_code",
"terms",
"Oraganization Number" ) as r, 
"Vendor Number" ,
"Vendor Name" ,
ADDRESS_LINE1,
ADDRESS_LINE2,
Zip,
City,
country,
phone,
"payment_currency_code",
"" as "terms",
"Oraganization Number" 
from Supplier
where "Source Site"="TRANSPORT") where r=1;

drop table if exists customerBasis;
create table customerBasis as
select * from (
select row_number() over (partition by ACCOUNT_NUMBER order by ACCOUNT_NUMBER,
 PARTY_NAME ,
 ACCOUNT_NAME ,
 ADDRESS1 ,
 ADDRESS2,
 ADDRESS3 ,
 POSTAL_CODE ,
 CITY ,
 COUNTRY ,
 "JGZZ_FISCAL_CODE") as r, 
 ACCOUNT_NUMBER,
 PARTY_NAME ,
 ACCOUNT_NAME ,
 ADDRESS1 ,
 ADDRESS2,
 ADDRESS3 ,
 POSTAL_CODE ,
 CITY ,
 COUNTRY ,
 "JGZZ_FISCAL_CODE"
from Customer where "SITE_USE_CODE" ="BILL_TO" and ACCOUNT_NUMBER not in (select "Vendor Number" from supplierBasis)) where r=1;
/*
select searchName, substr(searchName,1,length(searchName)-4), substr(searchName,length(searchName)-3, length(searchName)), cast( substr(searchName,length(searchName)-3, length(searchName)) as int) from UsedSearchNames;
*/
drop table if exists relBasis;
create table relBasis as select distinct
 "" as searchName,
 ACCOUNT_NUMBER as relationNumber, 
 PARTY_NAME as nameLine1,
 ACCOUNT_NAME as nameLine2,
 "" as nameLine3,
 ADDRESS1 as addressLine1,
 ADDRESS2 as addressLine2,
 ADDRESS3 as addressLine3,
 POSTAL_CODE as postalCode,
 CITY as city,
 COUNTRY as countryCode,
"" as subentityCode,
"" as postOfficeBox,
"" as postOfficeBoxPostalcode,
"" as postOfficeBoxCity,
"" as postOfficeBoxCountry,
"" as telephoneNumber,
"" as telefaxNumber,
"" as emailAddress,
"" as internetAddress,
"" as contactPerson,
"1" as typeOfRelation,
"" as currencyCode,
"0" as vatCode,
"" as languageCode,
"1" as relationGroup,
"" as paymentTerm,
"" as creditLimit,
"JGZZ_FISCAL_CODE" as vatNumberOrg,
COUNTRY || JGZZ_FISCAL_CODE vatNumber
from customerBasis 
union all
select distinct
"" as searchName,
"Vendor Number" as relationNumber,
"Vendor Name" as nameLine1,
"" as nameLine2,
"" as nameLine3,
ADDRESS_LINE1 as addressLine1,
ADDRESS_LINE2 as addressLine2,
"" as addressLine3,
Zip as postalCode,
City as city,
country as countryCode,
"" as subentityCode,
"" as postOfficeBox,
"" as postOfficeBoxPostalcode,
"" as postOfficeBoxCity,
"" as postOfficeBoxCountry,
phone as telephoneNumber,
"" as telefaxNumber,
"" as emailAddress,
"" as internetAddress,
"" as contactPerson,
"2" as typeOfRelation,
"payment_currency_code" as currencyCode,
"" as vatCode,
"" as languageCode,
"1" as relationGroup,
"terms" as paymentTerm,
"" as creditLimit,
"Oraganization Number" as vatNumberOrg,
COUNTRY || "Oraganization Number" as vatNumber
from supplierBasis;


delete from usedSearchNames where relationNumber in (select id from bannedIds);
delete from usedSearchNames where searchName like "DKLOAD%";

drop table if exists relSN;
create table relSN as select *,replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(
sn1
,"ú","U") ,"í","I") ,"È","E") ,"í","I") ,"ó","O") ,"ã","A") 
,"î","I") ,"â","A") ,"ô","O") ,"è","E") ,"ò","O") ,"â","A")
,"ê","E") ,"á","A") ,"Á","A") ,"ý","Y") ,"û","U") ,"Â","A") as snbasis
from (select *, 
replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(
countryBase||nameBase||cityBase
,"Æ","A") ,"Ø","O") ,"Å","A") ,"Ö","O") ,"Ü","U") ,"Ä","A") 
,"æ","A") ,"ø","O") ,"å","A") ,"ö","O") ,"ü","U") ,"ä","A") 
,"ß","S") ,"é","E") ,"É","E") ,"Ú","U") ,"Ř","R") ,"Í","I") 
 as sn1
from
(select 
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
trim(upper(countryCode))," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"'",""),"?",""),"´",""),";",""),char(9),""),char(34),""),1,2) as countryBase,
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
trim(upper(nameLine1))," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"'",""),"?",""),"´",""),";",""),char(9),""),char(34),""),1,9) as nameBase,
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
trim(upper(city))," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"'",""),"?",""),"´",""),";",""),char(9),""),char(34),""),1,5) as cityBase,
*
from (select * from relBasis where relationNumber not in (select distinct relationNumber from usedsearchnames))));




drop table if exists usn; 
create table usn as select searchBase, max(num) as maxnum from (select searchName, 
substr(searchName,1,length(searchName)-4) as searchBase, 
substr(searchName,length(searchName)-3, length(searchName)) as numText, 
cast( substr(searchName,length(searchName)-3, length(searchName)) as int) as num
from UsedSearchNames) group by searchBase;

---what about those that exist already in USN?
drop table if exists relations;
create table relations as select snbasis||printf("%04d", coalesce(usn.maxnum,0)+row_number() over (partition by snBasis order by snBasis, relationNumber)) as searchname,
 relationNumber ,
  nameLine1 ,
  nameLine2 ,
  nameLine3,
  addressLine1 ,
  addressLine2 ,
  addressLine3 ,
  postalCode ,
  city ,
  countryCode ,
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
  vatNumber from relSN left join usn on relSN.snBasis = usn.searchBase ;
  
insert into relations select distinct * from (select  usedSearchNames.searchName,
  relBasis.relationNumber ,
  relBasis.nameLine1 ,
  nameLine2 ,
  nameLine3,
  addressLine1 ,
  addressLine2 ,
  addressLine3 ,
  postalCode ,
  city ,
  countryCode ,
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
from relBasis, usedSearchNames where relBasis.relationNumber = usedSearchNames.relationNumber);

  
.once _businessrelations.csv
select * from relations;

insert into UsedSearchNames select searchName, relationNumber, nameLine1 from relations;

.once _usedsearchname1.csv
select * from usedsearchnames;

drop table if exists usn2; 
create table usn2 as select searchBase, max(num) as maxnum from (select searchName, 
substr(searchName,1,length(searchName)-4) as searchBase, 
substr(searchName,length(searchName)-3, length(searchName)) as numText, 
cast( substr(searchName,length(searchName)-3, length(searchName)) as int) as num
from UsedSearchNames) group by searchBase;

.once _registrations.csv
select distinct
 ACCOUNT_NUMBER as Relationnumber,
"1000" as Type,
 "JGZZ_FISCAL_CODE" as Value
 from Customer where "SITE_USE_CODE" ="BILL_TO" and
trim( "JGZZ_FISCAL_CODE")<>""
union
select distinct
 "Vendor number" as Relationnumber,
"1000" as Type,
 "Oraganization Number" as Value
 from  Supplier
where "Source Site"="TRANSPORT" and
trim( "Oraganization Number")<>"";
