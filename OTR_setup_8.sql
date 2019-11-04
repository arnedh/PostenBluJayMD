




drop table if exists tripnumbers;
create table tripnumbers as 
select vaktnr,  min(rute_frakl), max(rute_tilkl) , 1 as trip_nb from AlystraShifts group by vaktnr;


.once tripnumbers.csv
select * from tripnumbers;

/* produce file with trip_nb, vaktnr, (new seq nr), last realized (ankomsttid fra/til), ordnr */

drop table if exists alystraOTR;
create table alystraOTR as 
select distinct
"ENHETVAKT", "ORDRENUMMER","ENHETAVTALE", "AVTALENUMMER",  "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB", vaktnr,  rute_frakl, rute_tilkl, cast(seq_load_event as integer) as seq, ankomsttid_fra as last_realized_time, "P" as pOrD
from AlystraShifts
union all
select distinct
"ENHETVAKT", "ORDRENUMMER","ENHETAVTALE", "AVTALENUMMER",  "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB", vaktnr,  rute_frakl, rute_tilkl, cast(seq_unload_event as integer) as seq, ankomsttid_til as last_realized_time, "D" as pOrD
from AlystraShifts;


drop table if exists alystraOTR2;
create table alystraOTR2 as select ao.*, 1 as trip_nb from alystraOTR ao;

drop table if exists alystraOTR3;
create table alystraOTR3 as select ao2.*, ba2.r6, ba2.Reference from alystraOTR2 ao2, basisalystra2 ba2 where
ao2."ENHETVAKT"=ba2."ENHETVAKT"
and ao2."ORDRENUMMER"=ba2."ORDRENUMMER"
and ao2."AKTOERNR"=ba2."AKTOERNR"
and ao2."KUNDE"=ba2."KUNDE"
and ao2."UKEDAGORDRE"=ba2."UKEDAGORDRE"
and ao2."HENTENAVN"=ba2."HENTENAVN"
and ao2."POSTNR_FRA"=ba2."POSTNR_FRA"
and ao2."POSTSTED_FRA"=ba2. "POSTSTED_FRA"
and ao2."GATEADRESSE_FRA"=ba2."GATEADRESSE_FRA"
and ao2."RAMMETIDFRAKL_FRA"=ba2."RAMMETIDFRAKL_FRA"
and ao2."RAMMETIDTILKL_FRA"=ba2."RAMMETIDTILKL_FRA"
and ao2."BRINGENAVN"=ba2."BRINGENAVN"
and ao2."POSTNR_TIL"=ba2."POSTNR_TIL"
and ao2."POSTSTED_TIL"=ba2."POSTSTED_TIL"
and ao2."GATEADRESSE_TIL"=ba2."GATEADRESSE_TIL"
and ao2."RAMMETIDFRAKL_TIL"=ba2."RAMMETIDFRAKL_TIL"
and ao2."RAMMETIDTILKL_TIL"=ba2."RAMMETIDTILKL_TIL"
and ao2."ANTALL"=ba2."ANTALL"
and ao2."LASTB"=ba2."LASTB";


drop table if exists preMappingOTR; 
create table preMappingOTR as select distinct Reference, last_realized_time, pOrD, vaktnr, trip_nb, rank() over win as newseq, dense_rank() over win2 as vakt_rank
from alystraOTR3
window win as (partition by vaktnr, trip_nb order by last_realized_time, Reference, pOrD),
 win2 as (partition by Reference order by vaktnr)
order by vaktnr, trip_nb, Reference,  pOrD, last_realized_time;

drop table if exists mappingOTR; 
create table mappingOTR as select Reference, last_realized_time, pOrD, vaktnr, trip_nb, newseq
from preMappingOTR where vakt_rank =  1
order by vaktnr, trip_nb, Reference,  pOrD, last_realized_time;



.once mappingOTR.csv
select * from mappingOTR;


.header on
--.mode tabs
.mode csv
.separator ";"
