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


select distinct HENTENAVN as N, KUNDE_FRA as kunde,	TYPE_FRA as type,	POSTNR_FRA as postnr,	POSTSTED_FRA as poststed,	
GATEADRESSE_FRA as gateadresse,
PICKUP_X as x,	PICKUP_Y as y from AlystraShifts
union 
select distinct BRINGENAVN as N, KUNDE_TIL as kunde,	TYPE_TIL as type,	POSTNR_TIL as postnr,	POSTSTED_TIL as poststed,
	GATEADRESSE_TIL as gateadresse, 
delivery_X as x,	delivery_y as y from AlystraShifts;


select distinct NAVN,ADRESSE_1,ADRESSE_2,POSTNR,POSTSTED from AmphoraTrips a

select distinct "Approval number" ,
  "Factory name" ,
  a,
  
  "Address" ,
  "Postal Code" ,
  "City" 
 from AdresserFisk;

















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

