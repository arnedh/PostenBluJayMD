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

drop table AmphoraTrips;
.import "Fixed pickup orders from Amphora_2.csv" AmphoraTrips         

drop table AmphoraDepts;
.import "AmphoraDepts.csv" AmphoraDepts

drop table AlystraDepts;
.import "AlystraDepts.csv" AlystraDepts

drop table LastbPackage;
.import "LastbPackage.csv" LastbPackage




----create table addresssBase as

select searchBase||printf("%04d", row_number() over (partition by searchBase order by searchBase, addressLine1))
, nameLine1, addressLine1, postalCode, city, country
from (
select *, country||nameBase||cityBase as searchBase from (
select *, 
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(trim(upper(nameLine1)),"Æ","A") ,"Ø","O") ,"Å","A") ,"Ö","O") ,"Ü","U") ,"Ä","A") ,"æ","A") ,"ø","O") ,"å","A") ,"ö","O") ,"ü","U") ,"ä","A") ," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"\'",""),1,9) as nameBase, 
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(trim(upper(city)),"Æ","A") ,"Ø","O") ,"Å","A") ,"Ö","O") ,"Ü","U") ,"Ä","A") ,"æ","A") ,"ø","O") ,"å","A") ,"ö","O") ,"ü","U") ,"ä","A") ," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"\'",""),1,5) as cityBase
from (select distinct HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, 		POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY,	"NO" as country from AlystraShifts
union select distinct BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,		POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,	 "NO" as country from AlystraShifts
union select distinct a.NAVN as nameLine1, a.ADRESSE_1 as addressLine1 ,  printf("%04d", a.POSTNR) as postalCode, a.POSTSTED as city ,"EKSP_LAND_KODE" as Country from AmphoraTrips a)));
-- add to this:
suppliers
customers
customers unique billto
fisheries
drm??


select a.*, p.package, depts.Column1 from AlystraShifts a, LastbPackage p, AlystraDepts depts
where a.enhetvakt = depts.enhetvakt 
and a.lastb = p.lastb


select a.*, depts.BluJayDept from AmphoraTrips a, AmphoraDepts depts
where 
a.AGENT_NR = depts.AGENT_NR;


create table addresses as select searchBase||printf("%04d", row_number() over (partition by searchBase order by searchBase, addressLine1)) as searchname
, nameLine1, addressLine1, postalCode, city, country
from (
select *, country||nameBase||cityBase as searchBase from (
select *, 
substr(replace(replace(replace(replace(replace(replace(replace(replace(
replace(replace(replace(
replace(replace(replace(replace(replace(replace(replace(trim(upper(nameLine1)),
"Æ","A") ,"Ø","O") ,"Å","A") ,"Ö","O") ,"Ü","U") ,"Ä","A") ," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"\'",""),1,9) as nameBase, 
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(trim(upper(city))
,"Æ","A") ,"Ø","O") ,"Å","A") ,"Ö","O") ,"Ü","U") ,"Ä","A")  ," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"\'",""),1,5) as cityBase
from (select distinct HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, 		POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY,	"NO" as country from AlystraShifts
union select distinct BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,		POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,	 "NO" as country from AlystraShifts
union select distinct a.NAVN as nameLine1, a.ADRESSE_1 as addressLine1 ,  printf("%04d", a.POSTNR) as postalCode, a.POSTSTED as city ,"EKSP_LAND_KODE" as Country from AmphoraTrips a)));



select adr.searchname, p.package, depts.Column1,  a.* from AlystraShifts a, LastbPackage p, AlystraDepts depts, addresses adr
where a.enhetvakt = depts.enhetvakt 
and a.lastb = p.lastb
and a.hentenavn = adr.nameline1 
and a.GATEADRESSE_FRA = adr.addressLine1
and a.POSTNR_FRA = adr.postalCode
and a.POSTSTED_FRA = adr.CITY; --- og samme for "til"

select depts.BluJayDept, adr.searchname, a.* from AmphoraTrips a, AmphoraDepts depts , addresses adr
where 
a.AGENT_NR = depts.AGENT_NR
and a.NAVN = adr.nameLine1 
and a.ADRESSE_1 = adr.addressLine1 
and printf("%04d", a.POSTNR) = adr.postalCode 
and a.POSTSTED = adr.city



