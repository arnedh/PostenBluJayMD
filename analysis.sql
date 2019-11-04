--run exports from drm
--convert files to ANSI: Notepad++, encode, save

.header on
--.mode tabs
.mode csv
.separator ";"




drop table if exists CustomerOld;

.import "PB_EXTRACT_ERPPROD_190206.csv.csv" CustomerOld

drop table if exists CustomerNew;

.mode quote
.separator ","

.import "Customer_extract_utf.csv" CustomerNew  
--should be run through linux commands to convert to correct codepage/encoding: UTF-8, not ANSI


.header on
--.mode tabs
.mode csv
.separator ";"

.import "supplier_extract_modified.csv" SupplierNew  
.import "Vendor_extract_ERPPROD_190131.csv" SupplierOld 

--.import "shortCustExt.csv" CustomerNew;

create table UniqueCust as select distinct 
ACCOUNT_NUMBER,PARTY_TYPE,ORGANIZATION_NAME,PERSON_FIRST_NAME,ACCOUNT_NAME,PERSON_MIDDLE_NAME,PERSON_LAST_NAME,TAX_REFERENCE,EMAIL,PHONE,ATTRIBUTE10_CURRENCY,ATTRIBUTE2_CURRENCY,DEPARTMENT_NUMBER,EABN_CODE,CREDIT_HOLD,STANDARD_TERM,ORGANIZATION_NUMBER,STATUS,SITE_USE_CODE,ADDRESS1,ADDRESS2,ADDRESS3,POSTAL_CODE,CITY,COUNTRY
from CustomerNew


select distinct 
  "VENDOR_NAME",
  "VENDOR_NUMBER",
  "VENDOR_TYPE_LOOKUP_CODE",
  "TAX_PAYER_ID",

  "ATTRIBUTE4",
  "ATTRIBUTE5",

  "VAT_REGISTRATION_NUM",

  "ECE_TP_LOCATION_CODE",

  "ADDRESS_STYLE",
  "ADDRESS_LINE1",
  "ADDRESS_LINES_ALT",
  "ADDRESS_LINE2",
  "ADDRESS_LINE3",
  "CITY",
  "STATE",
  "ZIP",
  "PROVINCE",
  "COUNTRY",
  "PHONE"
  from SupplierNew;



select count(*) from (select account_number from CustomerNew union select vendor_number from SupplierNew);












select count(*) from CustomerOld;
.schema CustomerNew
select count(*) from CustomerNew;
     
select distinct account_number, department_number from CustomerNew where department_number <> "" and account_number in (select account_number from CustomerOld); 

.once _registrations2.csv

select distinct
ACCOUNT_NUMBER as Relationnumber,
"1002" as Type,
department_number as Value
from CustomerNew where department_number <> "" and account_number in (select account_number from CustomerOld); 
