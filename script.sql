.header on
.mode tabs

.import "NPBP7_Enhet.txt" NPBP7_Enhet 
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
 

.import "PostcodeRanges.csv" PostcodeRanges



select distinct * from (select distinct HENTENAVN as N, 	TYPE_FRA as type,	POSTNR_FRA as postnr,	POSTSTED_FRA as poststed,	
GATEADRESSE_FRA as gateadresse,
PICKUP_X as x,	PICKUP_Y as y from AlystraShifts
union 
select distinct BRINGENAVN as N, 	TYPE_TIL as type,	POSTNR_TIL as postnr,	POSTSTED_TIL as poststed,
	GATEADRESSE_TIL as gateadresse, 
delivery_X as x,	delivery_y as y from AlystraShifts) adresser, PostcodeRanges pcr  where postnr >= pcr.rangeFrom and postnr <= pcr.rangeTo 

select searchname||
 printf("%04d", 
row_number() over (partition by searchname
order by searchname,gateadresse))
, n, postnr, poststed, gateadresse
from (

 select distinct "NO"||substr(replace(trim(upper(HENTENAVN)), " ", ""),1,9)||substr(replace(trim(upper(POSTSTED_FRA)), " ", ""),1,5) as searchname,
HENTENAVN as N, POSTNR_FRA as postnr,	POSTSTED_FRA as poststed,	
GATEADRESSE_FRA as gateadresse
 from AlystraShifts
 group by searchname, hentenavn, postnr_fra, poststed_fra, gateadresse_fra
);

select distinct HENTENAVN as N, 	TYPE_FRA as type,	POSTNR_FRA as postnr,	POSTSTED_FRA as poststed,	
GATEADRESSE_FRA as gateadresse,
PICKUP_X as x,	PICKUP_Y as y from AlystraShifts
union 
select distinct BRINGENAVN as N, 	TYPE_TIL as type,	POSTNR_TIL as postnr,	POSTSTED_TIL as poststed,
	GATEADRESSE_TIL as gateadresse, 
delivery_X as x,	delivery_y as y from AlystraShifts;


select distinct
vaktnr||"_"||rutenr||"-"||seq_load_event as OrderTemplateNumber,
aktoernr as Principal,
pcr.Dept as Department,
"d" as HandlingCode,
ordrenummer as Reference,
/*Service lookup fra produktkode
Priority*/
pcr.searchname as TerminalSearchName,
/*
PickUpSearchName
PickupDate*/
AVGANGSTID_FRA as PickupTime,
/*
DeliverySearchName
DeliveryDate
DeliveryTime*/
antall as NumberOfPackages,
/*
PackageType lookup fra lastb
GrossWeight
Pallets 
LoadingMeters
IsThermoGoods
TemperatureFrom
TemperatureTo
StartingDate
ExpiryDate
LoadPlusDays
UnloadPlusDays */
(instr("ukedagordre", "1") > 0) as  IsMonday,
(instr("ukedagordre", "2") > 0) as IsTuesday,
(instr("ukedagordre", "3") > 0) as IsWednesDay,
(instr("ukedagordre", "4") > 0) as IsThursday,
(instr("ukedagordre", "5") > 0) as IsFriday,
(instr("ukedagordre", "6") > 0) as IsSaturday,
(instr("ukedagordre", "7") > 0) as IsSunday
from AlystraShifts, 
PostcodeRanges pcr  where POSTNR_FRA >= pcr.rangeFrom and POSTNR_FRA <= pcr.rangeTo 



select distinct "P" as task, KUNDE, AKTOERNR, ERPOSTAL, ERBEDRIFT, HENTENAVN as N, 	TYPE_FRA as type, KUNDE_FRA as "kunde?", 	POSTNR_FRA as postnr,	POSTSTED_FRA as poststed,	
GATEADRESSE_FRA as gateadresse from AlystraShifts
union 
select distinct "D" as task, KUNDE, AKTOERNR, ERPOSTAL, ERBEDRIFT, BRINGENAVN as N, TYPE_TIL as type,	KUNDE_TIL as "kunde?", POSTNR_TIL as postnr,	POSTSTED_TIL as poststed,
	GATEADRESSE_TIL as gateadresse from AlystraShifts;

