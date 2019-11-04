--run exports from drm
--convert files to ANSI: Notepad++, encode, save

.header on
--.mode tabs
.mode csv
.separator ";"



drop table Supplier;
drop table Customer;


.header on
.mode csv
.separator ";"

.import "Vendor_extract_ERPPROD_190131.csv" Supplier 

.import "PB_EXTRACT_ERPPROD_190206.csv.csv" Customer



.header on
.mode tabs


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

drop table AmphoraCustomerNumbers;
.import "Amphora customer numbers.csv" AmphoraCustomerNumbers       


drop table AmphoraTrips;
.import "Fixed pickup orders from Amphora_2.csv" AmphoraTrips     

drop table AmphoraDepts;
.import "AmphoraDepts.csv" AmphoraDepts

drop table AlystraDepts;
.import "AlystraDepts.csv" AlystraDepts

drop table LastbPackage;
.import "LastbPackage.csv" LastbPackage

drop table depts;
.import "depts.csv" depts


.header on
.mode tabs
.separator "\t"

drop table Enhet;
drop table Adresse;
.import "20190508102014_NPBP7_EnhetFO.txt" Enhet
.import "20190508092200_NPBP7_Adresse.txt" Adresse

.mode csv
.separator ";"

--------------------------