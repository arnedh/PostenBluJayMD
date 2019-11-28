--run exports from drm
--convert files to ANSI: Notepad++, encode, save

.header on
--.mode tabs
.mode csv
.separator ";"



drop table if exists Supplier;
drop table if exists Customer;

drop table if exists PreSupplier;
drop table if exists PreCustomer;


.header on
.mode csv
.separator ";"
/*
.import "Vendor_extract_ERPPROD_190131.csv" Supplier 
*/

.import "201911\\supplier_extract_modified.csv" PreSupplier

/*
.import "PB_EXTRACT_ERPPROD_190206.csv.csv" Customer

*/
.mode quote
.separator ","
.import "201911\\Customer_extract_utf.csv" PreCustomer


.header on

.mode csv
.separator ";"

drop table if exists AlystraShifts;


----don't encode, convert to UTF8, replace all " with '
/*
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
.import "Strategisk-OttarView-112-2019-01-18-1409.txt" AlystraShifts    */


.import "201911\\_Strategisk-OttarView-101-2019-11-08-1400.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-102-2019-11-08-1400.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-103-2019-11-08-1400.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-104-2019-11-08-1404.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-105-2019-11-08-1405.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-106-2019-11-08-1405.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-107-2019-11-08-1406.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-108-2019-11-08-1406.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-109-2019-11-08-1407.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-110-2019-11-08-1407.txt" AlystraShifts
.import "201911\\_Strategisk-OttarView-112-2019-11-08-1408.txt" AlystraShifts

.mode csv
.separator ";"

--in original, fails on duplicate fields zip&city, previous uses POSTAL_NUMBER;POSTAL_CITY in second occurrence
drop table if exists AmphoraCustomerNumbers;
--.import "Amphora customer numbers.csv" AmphoraCustomerNumbers       
.import "201911\\Amphora customer numbers 26.11.2019.csv" AmphoraCustomerNumbers       


drop table if exists AmphoraTrips;
--.import "Fixed pickup orders from Amphora_2.csv" AmphoraTrips    

.import "201911\\Fixed pickup orders from Amphora 26.11.2019.csv" AmphoraTrips    

drop table if exists AmphoraDepts;
.import "AmphoraDepts.csv" AmphoraDepts

drop table if exists AlystraDepts;
.import "AlystraDepts.csv" AlystraDepts

drop table if exists LastbPackage;
.import "LastbPackage.csv" LastbPackage

drop table if exists depts;
.import "depts.csv" depts


.header on
.mode tabs
.separator "\t"

drop table if exists Enhet;
drop table if exists Adresse;
--.import "20190508102014_NPBP7_EnhetFO.txt" Enhet
.import "201911\\20191120152405_NPBP7_EnhetFO.txt" Enhet
--.import "20190508092200_NPBP7_Adresse.txt" Adresse
.import "201911\\20191120152440_NPBP7_Adresse.txt" Adresse
.mode csv
.separator ";"

create table Customer as 
select distinct organization_number as jgzz_fiscal_code, organization_name as party_name, account_number ,account_name,  address1,address2, address3, "" as address4, city, postal_code, country, attribute10_currency, department_number, standard_term, site_use_code
from PreCustomer;


create table Supplier as 
select distinct 
VENDOR_NAME as "Vendor Name",
VENDOR_NUMBER as "Vendor Number",
ADDRESS_LINE1,
ADDRESS_LINE2,
CITY,
ZIP,
COUNTRY,
PHONE,
PAYMENT_CURRENCY_CODE,
NAME as terms,
VAT_REGISTRATION_NUM as "Oraganization Number"
--Source Site??
from PreSupplier;


.mode csv
.separator ";"
drop table if exists BREnheter;
.import "201911\\enheter_alle.csv" BREnheter
drop table if exists BRUnderenheter;
.import "201911\\underenheter_alle.csv" BRUnderenheter
drop table if exists FARAddresses;
.import "201911\\CUST_EXTRACT.csv" FARAddresses


drop table if exists terms; 
.import terms.csv terms

--anticipated from others
drop table if exists typer; 
.import typer.csv typer




--.save Loaded.db

--------------------------