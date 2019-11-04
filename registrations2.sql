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

.import "Cusomter_extract.csv" CustomerNew  
--should be run through linux commands to convert to correct codepage/encoding: UTF-8, not ANSI


.header on
--.mode tabs
.mode csv
.separator ";"

.import "shortCustExt.csv" CustomerNew;

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
