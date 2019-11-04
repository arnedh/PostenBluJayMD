--run exports from drm
--convert files to ANSI: Notepad++, encode, save

.header on
--.mode tabs
.mode csv
.separator ";"

--section: load DRM"
--drop table NPBP7_Selskap;
--.import NPBP7_Selskap.csv NPBP7_Selskap 


drop table Supplier;
drop table Customer;


.header on
.mode csv
.separator ";"

.import "Vendor_extract_ERPPROD_190131.csv" Supplier 

.import "PB_EXTRACT_ERPPROD_190206.csv.csv" Customer

drop table NPBP7_Enhet;
drop table NPBP7_Person;--selskap abbrev mappingtabell
drop table NPBP7_Adresse; --+Adresse.adrLandKode

.header on
.mode tabs

.import "NPBP7_Enhet.txt" NPBP7_Enhet 
.import "NPBP7_Person.txt" NPBP7_Person 
.import "NPBP7_Adresse.txt" NPBP7_Adresse

.mode csv
.separator ";"





drop table AlystraShifts;


----don't encode, convert, save
.import "Strategisk-OttarView-101-2019-01-18-1400.txt" AlystraShifts                          
.import "Strategisk-OttarView-102-2019-01-18-1400.txt" AlystraShifts                                       
.import "Strategisk-OttarView-103-2019-01-18-1401.txt" AlystraShifts                                       
.import "Strategisk-OttarView-104-2019-01-18-1404.txt" AlystraShifts                                       
.import "Strategisk-OttarView-105-2019-01-18-1405.txt" AlystraShifts                                       
.import "Strategisk-OttarView-106-2019-01-18-1405.txt" AlystraShifts                                       
.import "Strategisk-OttarView-107-2019-01-18-1406.txt" AlystraShifts                                       
.import "Strategisk-OttarView-108-2019-01-18-1407.txt" AlystraShifts                                       
.import "Strategisk-OttarView-109-2019-01-18-1407.txt" AlystraShifts                                       
.import "Strategisk-OttarView-110-2019-01-18-1409.txt" AlystraShifts                                       
.import "Strategisk-OttarView-112-2019-01-18-1409.txt" AlystraShifts    


.mode csv
.separator ";"

select distinct VAKTNR from AlystraShifts;
select distinct "Navn 4. Ledd", Beskrivelse from NPBP7_Enhet;
select distinct VAKTNR, "Navn 4. Ledd", Beskrivelse from NPBP7_Enhet, AlystraShifts where VAKTNR = "Navn 4. Ledd";

select distinct enhetvakt, "Navn 4. Ledd", Beskrivelse from  AlystraShifts left outer join NPBP7_Enhet  where enhetvakt = "Navn 4. Ledd"

SELECT columns
FROM table1
LEFT [OUTER] JOIN table2
ON table1.column = table2.column;

create table Paths as with recursive pairs as
(select a."Name", a."Parent Node", a.Beskrivelse, 1 as d, (a.Name || char(9) ||a.Beskrivelse) as "path"
from NPBP7_Enhet as a 
where a."Parent Node"="None" 
union all
select a.Name, a."Parent Node", a.Beskrivelse, 1+p.d as d,  ("path"||char(9)||a.Name||char(9)||a.Beskrivelse) as "path"
from NPBP7_Enhet as a, pairs as p 
where a."Parent Node"=p.Name )
select * from pairs;

create table Paths2 as with recursive pairs as
(select a."Name", a."Navn 4. Ledd", a."Parent Node", a.Beskrivelse, 1 as d, (a.Name || char(9) ||a.Beskrivelse) as "path"
from NPBP7_Enhet as a 
where a."Parent Node"="None" 
union all
select a.Name, a."Navn 4. Ledd",a."Parent Node", a.Beskrivelse, 1+p.d as d,  ("path"||char(9)||a.Name||char(9)||a.Beskrivelse) as "path"
from NPBP7_Enhet as a, pairs as p 
where a."Parent Node"=p.Name )
select * from pairs;

select distinct VAKTNR, "Navn 4. Ledd", Beskrivelse, "path" from  AlystraShifts left outer join Paths2  where VAKTNR = "Navn 4. Ledd"
select distinct VAKTNR, "Navn 4. Ledd", Beskrivelse, "path" from  AlystraShifts left  join Paths2  where VAKTNR = "Navn 4. Ledd"

select count(VAKTNR) from AlystraShifts;

.once "cust+supp.csv"
select distinct "Supplier" as Kind, "Vendor Name" as "N",
 "Vendor Number" as Num, "Oraganization Number" as ID , "ZIP" as Zip, "COUNTRY" as Country from Supplier 
 UNION
select distinct "Customer" as Kind, "PARTY_NAME" as "N",
 "ACCOUNT_NUMBER" as Num, "JGZZ_FISCAL_CODE" as ID , "POSTAL_CODE" as Zip, "COUNTRY" as Country from Customer where "SITE_USE_CODE" ="BILL_TO"
 
 select distinct "Customer" as Kind, "PARTY_NAME" as "N",
 "ACCOUNT_NUMBER" as Num, "JGZZ_FISCAL_CODE" as ID , "POSTAL_CODE" as Zip, "COUNTRY" as Country from Customer where "SITE_USE_CODE" ="BILL_TO"
 union all
select distinct "Supplier" as Kind, "Vendor Name" as "N",
 "Vendor Number" as Num, "Oraganization Number" as ID , "ZIP" as Zip, "COUNTRY" as Country from Supplier 

select count(*), "Customer" as Kind, "PARTY_NAME" as "N",
 "ACCOUNT_NUMBER" as Num, "JGZZ_FISCAL_CODE" as ID , "POSTAL_CODE" as Zip, "COUNTRY" as Country from Customer where "SITE_USE_CODE" ="BILL_TO"
 group by Kind, N, Num, ID, Zip, Country
 union all
 select count(*), "Supplier" as Kind, "Vendor Name" as "N",
 "Vendor Number" as Num, "Oraganization Number" as ID , "ZIP" as Zip, "COUNTRY" as Country from Supplier 
  group by Kind, N, Num, ID, Zip, Country

  
  
  
  
select distinct
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
from Customer where "SITE_USE_CODE" ="BILL_TO"
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
from Supplier
--------------------

select distinct
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
from Customer where "SITE_USE_CODE" ="BILL_TO"


