--run exports from drm
--convert files to ANSI: Notepad++, encode, save

.header on
.mode tabs
--.mode csv
--.separator "\t"

--section: load DRM"
--drop table NPBP7_Selskap;
--.import NPBP7_Selskap.csv NPBP7_Selskap 


drop table AlystraShifts;

drop table NPBP7_Enhet;


.header on
.mode tabs

.import "NPBP7_Enhet.txt" NPBP7_Enhet 
.mode csv
.separator ";"

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



drop table AmphoraTrips;
.import "Fixed pickup orders from Amphora_2.csv" AmphoraTrips     

.import "Fishery_establishments manip.csv" AdresserFisk
.mode tabs
drop table AmphoraAgents;
.import "Agenter Amphora.txt" AmphoraAgents    

.header on
.mode tabs

CREATE TABLE BluJayFixedOrders(
  "OrderTemplateNumber" TEXT,
"Principal" TEXT,
"Department" TEXT,
"HandlingCode" TEXT,
"Reference" TEXT,
"Service" TEXT,
"Priority" TEXT,
"TerminalSearchName" TEXT,
"PickUpSearchName" TEXT,
"PickupDate" TEXT,
"PickupTime" TEXT,
"DeliverySearchName" TEXT,
"DeliveryDate" TEXT,
"DeliveryTime" TEXT,
"NumberOfPackages" TEXT,
"PackageType" TEXT,
"GrossWeight" TEXT,
"Pallets" TEXT,
"LoadingMeters" TEXT,
"IsThermoGoods" TEXT,
"TemperatureFrom" TEXT,
"TemperatureTo" TEXT,
"StartingDate" TEXT,
"ExpiryDate" TEXT,
"LoadPlusDays" TEXT,
"UnloadPlusDays" TEXT,
"IsMonday" TEXT,
"IsTuesday" TEXT,
"IsWednesDay" TEXT,
"IsThursday" TEXT,
"IsFriday" TEXT,
"IsSaturday" TEXT,
"IsSunday" TEXT

);


insert into BluJayFixedOrders select NPB_OEBS_ACCOUNTNUMBER as Principal, 
NULL as OrderTemplateNumber,
NULL as Department,
NULL as HandlingCode,
NULL as Reference,
NULL as Service,
NULL as Priority,
NULL as TerminalSearchName,
NULL as PickUpSearchName,
NULL as PickupDate,
NULL as PickupTime,
NULL as DeliverySearchName,
NULL as DeliveryDate,
NULL as DeliveryTime,
NULL as NumberOfPackages,
NULL as PackageType,
NULL as GrossWeight,
NULL as Pallets,
NULL as LoadingMeters,
NULL as IsThermoGoods,
NULL as TemperatureFrom,
NULL as TemperatureTo,
NULL as StartingDate,
NULL as ExpiryDate,
NULL as LoadPlusDays,
NULL as UnloadPlusDays,
NULL as IsMonday,
NULL as IsTuesday,
NULL as IsWednesDay,
NULL as IsThursday,
NULL as IsFriday,
NULL as IsSaturday,
NULL as IsSunday
 from AmphoraTrips;
 
 NULL as OrderTemplateNumber,
NULL as Principal,
NULL as Department,
NULL as HandlingCode,
NULL as Reference,
NULL as Service,
NULL as Priority,
NULL as TerminalSearchName,
NULL as PickUpSearchName,
NULL as PickupDate,
NULL as PickupTime,
NULL as DeliverySearchName,
NULL as DeliveryDate,
NULL as DeliveryTime,
NULL as NumberOfPackages,
NULL as PackageType,
NULL as GrossWeight,
NULL as Pallets,
NULL as LoadingMeters,
NULL as IsThermoGoods,
NULL as TemperatureFrom,
NULL as TemperatureTo,
NULL as StartingDate,
NULL as ExpiryDate,
NULL as LoadPlusDays,
NULL as UnloadPlusDays,
NULL as IsMonday,
NULL as IsTuesday,
NULL as IsWednesDay,
NULL as IsThursday,
NULL as IsFriday,
NULL as IsSaturday,
NULL as IsSunday,

