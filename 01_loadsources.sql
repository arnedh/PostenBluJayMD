--run exports from drm
--convert files to ANSI: Notepad++, encode, save

.header on
--.mode tabs
.mode csv
.separator ";"



drop table if exists Supplier;
drop table if exists Customer;


.header on
.mode csv
.separator ";"

.import "Vendor_extract_ERPPROD_190131.csv" Supplier 

.import "PB_EXTRACT_ERPPROD_190206.csv.csv" Customer



.header on
.mode tabs


.mode csv
.separator ";"

drop table if exists AlystraShifts;


----don't encode, convert to UTF8, replace all " with '

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

drop table if exists AmphoraCustomerNumbers;
.import "Amphora customer numbers.csv" AmphoraCustomerNumbers       


drop table if exists AmphoraTrips;
.import "Fixed pickup orders from Amphora_2.csv" AmphoraTrips     

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
.import "20190508102014_NPBP7_EnhetFO.txt" Enhet
.import "20190508092200_NPBP7_Adresse.txt" Adresse

.mode csv
.separator ";"

--------------------------