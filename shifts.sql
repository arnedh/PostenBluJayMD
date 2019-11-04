--run exports from drm
--convert files to ANSI: Notepad++, encode, save

.header on
.mode tabs
--.mode csv
--.separator "\t"

--section: load DRM"
--drop table NPBP7_Selskap;
--.import NPBP7_Selskap.csv NPBP7_Selskap 


drop table Ottar103;

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


create table Paths as with recursive pairs as
(select a."Name", a."Parent Node", a.Beskrivelse, 1 as d, (a.Name || char(9) ||a.Beskrivelse) as "path"
from NPBP7_Enhet as a 
where a."Parent Node"="None" 
union all
select a.Name, a."Parent Node", a.Beskrivelse, 1+p.d as d,  ("path"||char(9)||a.Name||char(9)||a.Beskrivelse) as "path"
from NPBP7_Enhet as a, pairs as p 
where a."Parent Node"=p.Name )
select * from pairs;


.header on
.mode tabs



select distinct vaktnr, enhetvakt, vehicle_license_number, enh.Beskrivelse, enh."Divisjon Navn" from AlystraShifts, NPBP7_Enhet enh where enhetvakt = enh."Navn 4. ledd";

.once shifts.txt
select distinct vaktnr, enhetvakt, vehicle_license_number, enh.Beskrivelse, enh."Divisjon Navn", Paths.path 
from AlystraShifts, NPBP7_Enhet enh, Paths
where enhetvakt = enh."Navn 4. ledd" and enh."Name" = Paths."Name"


.import "units-mapping.txt" UnitsMapping

select VAKTNR, min(VAKT_FRAKL), max(VAKT_TILKL), "Leggroup/Dept ORD", TemplateRUTENR, RUTENAVN, VEHICLE_LICENSE_NUMBER 
from AlystraShifts, UnitsMapping where AlystraShifts.ENHETVAKT = UnitsMapping.ENHETVAKT
group by "Leggroup/Dept ORD", VAKTNR, RUTENR, RUTENAVN, VEHICLE_LICENSE_NUMBER
order by "Leggroup/Dept ORD", VAKTNR, RUTENR, RUTENAVN, VEHICLE_LICENSE_NUMBER;

select distinct VAKTNR, 
UKEDAG_VAKT, 
min(VAKT_FRAKL),
max(VAKT_TILKL), "Leggroup/Dept ORD",  "Template", AlystraShifts.ENHETVAKT, 
"Leggroup/Dept ORD"||"-"||VAKTNR||"-"||UKEDAG_VAKT
from AlystraShifts, UnitsMapping where AlystraShifts.ENHETVAKT = UnitsMapping.ENHETVAKT
group by VAKTNR, UKEDAG_VAKT, "Leggroup/Dept ORD",AlystraShifts.ENHETVAKT
order by VAKTNR, UKEDAG_VAKT, "Leggroup/Dept ORD",AlystraShifts.ENHETVAKT;

.import "PCZone.txt" PCZone
select distinct VAKTNR, pcz1.Dept from AlystraShifts, PCZone pcz1
where POSTNR_FRA>=pcz1.PCFrom and POSTNR_TIL<=pcz1.PCTo


UKEDAG_VAKT, POSTNR_FRA, POSTNR_TIL, 

select distinct VAKTNR, UKEDAG_VAKT, POSTNR_FRA, POSTNR_TIL, pcz1.Dept from AlystraShifts, PCZone pcz1
where POSTNR_FRA>=pcz1.PCFrom and POSTNR_TIL<=pcz1.PCTo and Vaktnr =210110;
select distinct VAKTNR, UKEDAG_VAKT, POSTNR_FRA, POSTNR_TIL, pcz1.Dept from AlystraShifts, PCZone pcz1
where cast(POSTNR_FRA as integer)>=cast(pcz1.PCFrom as integer) and cast(POSTNR_TIL as integer)<=cast(pcz1.PCTo as integer) and Vaktnr =210110;
-----------------------------------------


select distinct 
 "Template"||"_"||VAKTNR, 
 "Template"||"_"||VAKTNR, 
 "Leggroup/Dept ORD"||"_"||VAKTNR,
 'True' as active,
 "Template", 
VAKTNR, 
"Leggroup/Dept ORD", 
min(VAKT_FRAKL),
0 as from_offset,
max(VAKT_TILKL), 
0 as till_offset,
 AlystraShifts.ENHETVAKT
from AlystraShifts, UnitsMapping where AlystraShifts.ENHETVAKT = UnitsMapping.ENHETVAKT
group by VAKTNR, "Leggroup/Dept ORD",AlystraShifts.ENHETVAKT
order by VAKTNR, "Leggroup/Dept ORD",AlystraShifts.ENHETVAKT;
