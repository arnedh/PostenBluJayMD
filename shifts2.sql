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

.import "Strategisk-OttarView-101-2018-04-20-1400.txt" AlystraShifts                          
.import "Strategisk-OttarView-102-2018-04-20-1400.txt" AlystraShifts                                       
.import "Strategisk-OttarView-103-2018-04-20-1401.txt" AlystraShifts                                       
.import "Strategisk-OttarView-104-2018-04-20-1404.txt" AlystraShifts                                       
.import "Strategisk-OttarView-105-2018-04-20-1405.txt" AlystraShifts                                       
.import "Strategisk-OttarView-106-2018-04-20-1405.txt" AlystraShifts                                       
.import "Strategisk-OttarView-107-2018-04-20-1406.txt" AlystraShifts                                       
.import "Strategisk-OttarView-108-2018-04-20-1408.txt" AlystraShifts                                       
.import "Strategisk-OttarView-109-2018-04-20-1408.txt" AlystraShifts                                       
.import "Strategisk-OttarView-110-2018-04-20-1409.txt" AlystraShifts                                       
.import "Strategisk-OttarView-112-2018-04-20-1410.txt" AlystraShifts                  



.header on
.mode tabs

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




