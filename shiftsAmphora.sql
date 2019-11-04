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

.mode tabs

drop table AmphoraTrips;
.import "Fixed pickup orders from Amphora.txt" AmphoraTrips              

drop table AmphoraAgents;
.import "Agenter Amphora.txt" AmphoraAgents    



.header on
.mode tabs


.once alystratrips.txt
select distinct
"" as 	OrderTemplateNumber	,
AKTOERNR as 	Principal	,
"" as 	Department	,
"f" as 	HandlingCode	,
"" as 	Reference	,
"" as 	Service	,
"" as 	Priority	,
"" as 	TerminalSearchName	,
Hentenavn||poststed_fra as 	PickUpSearchName	,
"" as 	PickupDate	,
RAMMETIDFRAKL_TIL as 	PickupTime	,
Bringenavn||poststed_til as 	DeliverySearchName	,
"" as 	DeliveryDate	,
AVGANGSTID_FRA as 	DeliveryTime	,
ANTALL as 	NumberOfPackages	,
LASTB  as 	PackageType	,
"" as 	GrossWeight	,
"" as 	Pallets	,
"" as 	LoadingMeters	,
"" as 	IsThermoGoods	,
"" as 	TemperatureFrom	,
"" as 	TemperatureTo	,
"" as 	StartingDate	,
"" as 	ExpiryDate	,
"" as 	LoadPlusDays	,
"" as 	UnloadPlusDays	,
(UKEDAG_VAKT =1) as 	IsMonday	,
(UKEDAG_VAKT =2) as 	IsTuesday	,
(UKEDAG_VAKT =3) as IsWednesDay	,
(UKEDAG_VAKT =4) as IsThursday	,
(UKEDAG_VAKT =5) as 	IsFriday	,
(UKEDAG_VAKT =6) as 	IsSaturday	,
(UKEDAG_VAKT =7)  as 	IsSunday	


from AlystraShifts limit 10;
/*
.once amphoratrips.txt
select distinct
"" as 	OrderTemplateNumber	,
NPB_OEBS_ACCOUNTNUMBER as 	Principal	,
"" as 	Department	,
"f" as 	HandlingCode	,
"" as 	Reference	,
"" as 	Service	,
"" as 	Priority	,
"" as 	TerminalSearchName	,
NAVN||postnr as 	PickUpSearchName	,
"" as 	PickupDate	,
RAMMETIDFRAKL_TIL as 	PickupTime	,
Bringenavn||poststed_til as 	DeliverySearchName	,
"" as 	DeliveryDate	,
AVGANGSTID_FRA as 	DeliveryTime	,
ANTALL as 	NumberOfPackages	,
LASTB  as 	PackageType	,
"" as 	GrossWeight	,
"" as 	Pallets	,
"" as 	LoadingMeters	,
"" as 	IsThermoGoods	,
"" as 	TemperatureFrom	,
"" as 	TemperatureTo	,
"" as 	StartingDate	,
"" as 	ExpiryDate	,
"" as 	LoadPlusDays	,
"" as 	UnloadPlusDays	,
(UKEDAG_VAKT =1) as 	IsMonday	,
(UKEDAG_VAKT =2) as 	IsTuesday	,
(UKEDAG_VAKT =3) as IsWednesDay	,
(UKEDAG_VAKT =4) as IsThursday	,
(UKEDAG_VAKT =5) as 	IsFriday	,
(UKEDAG_VAKT =6) as 	IsSaturday	,
(UKEDAG_VAKT =7)  as 	IsSunday	
*/

from AlystraShifts limit 10;

--equipment
.once "equipment.txt"
select distinct VEHICLE_ID, VEHICLE_LICENSE_NUMBER, 	VEHICLE_TYPE, 	VEHICLE_MAX_NUMBER_OF_STANDARD_CARRIERS from AlystraShifts;

--depot/terminal
.once "depots.txt"
select distinct start_DEPOT as depot, start_DEPOT_X as x , start_DEPOT_Y as y from AlystraShifts
union 
select distinct END_DEPOT as depot, END_DEPOT_X as x , END_DEPOT_Y  as y from AlystraShifts;

--shift
.once "shifts.txt"
select distinct VAKTNR, VAKT_FRAKL, VAKT_TILKL, ENHETVAKT from  AlystraShifts; 
.once "shiftsW.txt"
select distinct UKEDAG_VAKT,VAKTNR, VAKT_FRAKL, VAKT_TILKL, ENHETVAKT from  AlystraShifts; 

--route
.once "route.txt"
select distinct VAKTNR, RUTENR, RUTENAVN,RUTE_FRAKL, RUTE_TILKL  from  AlystraShifts; 
.once "aktoer.txt"
select distinct AKTOERNR, KUNDE, ERPOSTAL, ERBEDRIFT from AlystraShifts order by KUNDE;

/*select distinct AVTALENUMMER, ENHETAVTALE, ORDRENUMMER, ENHETORDRE, KUNDE from AlystraShifts order by KUNDE;

select distinct AVTALENUMMER, ENHETAVTALE, ORDRENUMMER, ENHETORDRE, KUNDE , LASTHUS_ID from AlystraShifts order by KUNDE;

select distinct AVTALENUMMER, ENHETAVTALE, ORDRENUMMER, ENHETORDRE, KUNDE,FASTPRISBRUTTO,	FASTPRISNETTO,	FAKTURATYPE,	ERFASTPRIS
from AlystraShifts order by KUNDE;*/

.once "avtaler.txt"
select distinct AVTALENUMMER, ENHETAVTALE, KUNDE
from AlystraShifts order by KUNDE;

.once "ordre.txt"
select distinct AVTALENUMMER, ENHETAVTALE, ORDRENUMMER, modulnr, trtjeneste, ukedagordre, ENHETORDRE, KUNDE,FASTPRISBRUTTO,	FASTPRISNETTO,	FAKTURATYPE,	ERFASTPRIS
from AlystraShifts order by KUNDE;

.once "steder.txt"
select distinct HENTENAVN as N, KUNDE_FRA as kunde,	TYPE_FRA as type,	POSTNR_FRA as postnr,	POSTSTED_FRA as poststed,	
GATEADRESSE_FRA as gateadresse,
PICKUP_X as x,	PICKUP_Y as y from AlystraShifts
union 
select distinct BRINGENAVN as N, KUNDE_TIL as kunde,	TYPE_TIL as type,	POSTNR_TIL as postnr,	POSTSTED_TIL as poststed,
	GATEADRESSE_TIL as gateadresse, 
delivery_X as x,	delivery_y as y from AlystraShifts;
.once "lastb.txt"
select distinct LASTB, KONTAINERFAKTOR from AlystraShifts;

.once "produkter.txt"
select distinct PRODUKTGRUPPE, PRODUKT, PRODUKTKODE from AlystraShifts order by PRODUKTGRUPPE,  PRODUKTKODE ;
.once "tjeneste.txt"
select distinct trtjeneste from alystrashifts;

--select distinct AVTALENUMMER, ENHETAVTALE, ORDRENUMMER, UKEDAGORDRE, ENHETORDRE, KUNDE from AlystraShifts order by KUNDE;

--select distinct AVTALENUMMER, ENHETAVTALE, ORDRENUMMER, ENHETORDRE, KUNDE , LASTHUS_ID, MODULNR from AlystraShifts order by KUNDE;


select distinct lasthus_id, start_depot, end_depot;

.once "aktoer.txt"
select distinct AKTOERNR, KUNDE, ERPOSTAL, ERBEDRIFT from AlystraShifts order by KUNDE;







.once pickupadr.txt
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
---legge til til-adresser, adresser fra amphora, adresser fra matvaretilsyn

.once testreport.txt
select distinct vaktnr, rutenr, aktoernr, kunde, avtalenummer, ukedagordre, hentenavn, bringenavn, avgangstid_til, avgangstid_fra, SEQ_LOAD_EVENT, SEQ_UNLOAD_EVENT, antall, lastb
from AlystraShifts
order by vaktnr, rutenr, aktoernr, kunde, avtalenummer, ukedagordre, hentenavn, bringenavn, avgangstid_til, avgangstid_fra, SEQ_LOAD_EVENT, SEQ_UNLOAD_EVENT, antall, lastb;




.mode csv
.separator ";"

.import "Fishery_establishments manip.csv" AdresserFisk


create table Postnr (code Varchar,name Varchar,district Varchar,districtname Varchar,kind Varchar);


select distinct a.NAVN, a.ADRESSE_1, a.POSTNR_ID, b.name from AmphoraTrips a, Postnr b where a.postnr_id = b.code;
select distinct a.NAVN, a.ADRESSE_1, a.POSTNR_ID, b.name from AmphoraTrips a left outer join Postnr b on a.postnr_id = b.code;

