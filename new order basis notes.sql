/*pseudocode

select uniqueorders from alystrashifts
select orderlines from alystrashifts


avtalenummer + ordrenummer er id

under denne: hvis forskjellig adresser, rammer, ukedagordre, legg på nummerering

under denne: forskjellige ordrelinjer*/


select count(*), DeliverySearchName, PickupSearchName, PossPrincipal, Department, Reference, TerminalSearchName, PickupFromTime, PickupTillTime, DeliveryFromTime, DeliveryTillTime, ukedagordre 
from basis5 group by  DeliverySearchName, PickupSearchName, PossPrincipal, Department, Reference, TerminalSearchName, PickupFromTime, PickupTillTime, DeliveryFromTime, DeliveryTillTime, ukedagordre 
order by Department, PossPrincipal, Reference;
select distinct
"ukedagordre",
"UKEDAG_VAKT" ,
  "UKEDAG_RUTE",
  "UKEDAG_STOPP_FRA" ,
    "UKEDAG_STOPP_TIL" 
  

  from AlystraShifts
  order by
  "ukedagordre",
"UKEDAG_VAKT" ,
  "UKEDAG_RUTE" ,
  "UKEDAG_STOPP_FRA" ,
    "UKEDAG_STOPP_TIL" 
  ;

  


create table AlystraOrders as select distinct
  
/*  "VAKTNR" ,
  "VAKT_FRAKL" ,
  "VAKT_TILKL" ,
  "ENHETVAKT" ,*/
  "ENHETAVTALE" ,
/*  "ENHETORDRE" ,

  "RUTENR" ,
  "RUTENAVN" ,
  "LASTHUS_ID" ,
  "RUTE_FRAKL" ,
  "RUTE_TILKL" ,*/
 -- "START_DEPOT" ,
 -- "START_DEPOT_X" ,
 -- "START_DEPOT_Y" ,
 -- "END_DEPOT" ,
 -- "END_DEPOT_X" ,
 -- "END_DEPOT_Y" ,
 -- "VEHICLE_ID" ,
 -- "VEHICLE_LICENSE_NUMBER" ,
 -- "VEHICLE_TYPE" ,
--  "VEHICLE_MAX_NUMBER_OF_STANDARD_CARRIERS" ,
--  "KILOMETER" ,
 -- "SLAKK" ,
 -- "SEQ_LOAD_EVENT" ,
 -- "SEQ_UNLOAD_EVENT" ,
  "AKTOERNR" ,
  "KUNDE" ,
  "ERPOSTAL" ,
  "ERBEDRIFT" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER" ,
-- "MODULNR" ,
--  "TRTJENESTE" ,
  "UKEDAGORDRE" ,
  "HENTENAVN" ,
--  "KUNDE_FRA" ,
  "TYPE_FRA" ,
  "POSTNR_FRA" ,
  "POSTSTED_FRA" ,
  "GATEADRESSE_FRA" ,
  "RAMMETIDFRAKL_FRA" ,
  "RAMMETIDTILKL_FRA" ,
 -- "ANKOMSTTID_FRA" ,
--  "AVGANGSTID_FRA" ,

--  "PICKUP_X" ,
--  "PICKUP_Y" ,
 -- "PICKUP_INITIAL_SERVICE_TIME" ,
 -- "PICKUP_ADDINITIONAL_SERVICE_TIME" ,
  "BRINGENAVN" ,
--  "KUNDE_TIL" ,
  "TYPE_TIL" ,
  "POSTNR_TIL" ,
  "POSTSTED_TIL" ,
  "GATEADRESSE_TIL" ,
  "RAMMETIDFRAKL_TIL" ,
  "RAMMETIDTILKL_TIL" 
--  "ANKOMSTTID_TIL" ,
--  "AVGANGSTID_TIL" ,
-- "DELIVERY_X" ,
--  "DELIVERY_Y" ,
--  "DELIVERY_INITIAL_SERVICE_TIME" ,
--  "DELIVERY_ADDINITIAL_SERVICE_TIME" ,
/*  "KOMMENTAR" ,
  "MERKNADLAST" ,
  "MERKNADLOSS" ,
  "ANTALL" ,
  "LASTB" ,
  "PRODUKT" ,
  "PRODUKTKODE" ,
  "KONTAINERFAKTOR" ,
  "PRODUKTGRUPPE" ,
  "EKSTERNFAKTURERES" ,
  "INTERNFAKTURERES" ,
  "FASTPRISBRUTTO" ,
  "FASTPRISNETTO" ,
  "FAKTURATYPE" ,
  "ERFASTPRIS" */
  from AlystraShifts;
  
  create table AlystraOrderlines as select distinct
  
  "VAKTNR" ,
  "VAKT_FRAKL" ,
  "VAKT_TILKL" ,
  "ENHETVAKT" ,
  "ENHETAVTALE" ,
  "ENHETORDRE" ,

  "RUTENR" ,
  "RUTENAVN" ,
  "LASTHUS_ID" ,
  "RUTE_FRAKL" ,
  "RUTE_TILKL" ,
  "START_DEPOT" ,
  "START_DEPOT_X" ,
  "START_DEPOT_Y" ,
  "END_DEPOT" ,
  "END_DEPOT_X" ,
  "END_DEPOT_Y" ,
  "VEHICLE_ID" ,
  "VEHICLE_LICENSE_NUMBER" ,
  "VEHICLE_TYPE" ,
  "VEHICLE_MAX_NUMBER_OF_STANDARD_CARRIERS" ,
  "KILOMETER" ,
  "SLAKK" ,
  "SEQ_LOAD_EVENT" ,
  "SEQ_UNLOAD_EVENT" ,
  "AKTOERNR" ,
  "KUNDE" ,
  "ERPOSTAL" ,
  "ERBEDRIFT" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER" ,
  "MODULNR" ,
  "TRTJENESTE" ,
  "UKEDAGORDRE" ,
  "HENTENAVN" ,
  "KUNDE_FRA" ,
  "TYPE_FRA" ,
  "POSTNR_FRA" ,
  "POSTSTED_FRA" ,
  "GATEADRESSE_FRA" ,
  "RAMMETIDFRAKL_FRA" ,
  "RAMMETIDTILKL_FRA" ,
  "ANKOMSTTID_FRA" ,
  "AVGANGSTID_FRA" ,

  "PICKUP_X" ,
  "PICKUP_Y" ,
  "PICKUP_INITIAL_SERVICE_TIME" ,
  "PICKUP_ADDINITIONAL_SERVICE_TIME" ,
  "BRINGENAVN" ,
  "KUNDE_TIL" ,
  "TYPE_TIL" ,
  "POSTNR_TIL" ,
  "POSTSTED_TIL" ,
  "GATEADRESSE_TIL" ,
  "RAMMETIDFRAKL_TIL" ,
  "RAMMETIDTILKL_TIL" ,
  "ANKOMSTTID_TIL" ,
  "AVGANGSTID_TIL" ,
  "DELIVERY_X" ,
  "DELIVERY_Y" ,
  "DELIVERY_INITIAL_SERVICE_TIME" ,
  "DELIVERY_ADDINITIAL_SERVICE_TIME" ,
  "KOMMENTAR" ,
  "MERKNADLAST" ,
  "MERKNADLOSS" ,
  "ANTALL" ,
  "LASTB" ,
  "PRODUKT" ,
  "PRODUKTKODE" ,
  "KONTAINERFAKTOR" ,
  "PRODUKTGRUPPE" ,
  "EKSTERNFAKTURERES" ,
  "INTERNFAKTURERES" ,
  "FASTPRISBRUTTO" ,
  "FASTPRISNETTO" ,
  "FAKTURATYPE" ,
  "ERFASTPRIS" 
  from AlystraShifts;
  
  select count(*), type_til, type_fra, kunde_til, kunde_fra from AlystraShifts group by type_til, type_fra, kunde_til, kunde_fra order by type_til, type_fra, kunde_til, kunde_fra ;
    select count(*), type_til, type_fra,  from AlystraShifts group by type_til, type_fra,  order by type_til, type_fra ;
  
  
  -----------------------------
  
  create table orderBasis as select distinct row_number() over (partition by "ENHETAVTALE" order by   "ENHETAVTALE" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER"  ) r
  "ENHETAVTALE" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER" ,
  "AKTOERNR" ,
  "KUNDE" ,
  "ERPOSTAL" ,
  "UKEDAGORDRE" ,
  "HENTENAVN" ,
  "TYPE_FRA" ,
  "POSTNR_FRA" ,
  "POSTSTED_FRA" ,
  "GATEADRESSE_FRA" ,
  "RAMMETIDFRAKL_FRA" ,
  "RAMMETIDTILKL_FRA" ,
  "BRINGENAVN" ,
  "TYPE_TIL" ,
  "POSTNR_TIL" ,
  "POSTSTED_TIL" ,
  "GATEADRESSE_TIL" ,
  "RAMMETIDFRAKL_TIL" ,
  "RAMMETIDTILKL_TIL" 
  from AlystraShifts;
  
  AlystraOrderlines
  antall
  lastb
  
  
  
create table ordreBasis as select  
  row_number() over (partition by "ENHETAVTALE", "AVTALENUMMER" ,
  "ORDRENUMMER"   order by   "ENHETAVTALE" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER" ) r,
  "ENHETAVTALE" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER" ,
  "AKTOERNR" ,
  "KUNDE" ,
  "ERPOSTAL" ,
  "UKEDAGORDRE" ,
  "HENTENAVN" ,
  "TYPE_FRA" ,
  "POSTNR_FRA" ,
  "POSTSTED_FRA" ,
  "GATEADRESSE_FRA" ,
  "RAMMETIDFRAKL_FRA" ,
  "RAMMETIDTILKL_FRA" ,
  "BRINGENAVN" ,
  "TYPE_TIL" ,
  "POSTNR_TIL" ,
  "POSTSTED_TIL" ,
  "GATEADRESSE_TIL" ,
  "RAMMETIDFRAKL_TIL" ,
  "RAMMETIDTILKL_TIL" 
  from (select distinct  "ENHETAVTALE" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER" ,
  "AKTOERNR" ,
  "KUNDE" ,
  "ERPOSTAL" ,
  "UKEDAGORDRE" ,
  "HENTENAVN" ,
  "TYPE_FRA" ,
  "POSTNR_FRA" ,
  "POSTSTED_FRA" ,
  "GATEADRESSE_FRA" ,
  "RAMMETIDFRAKL_FRA" ,
  "RAMMETIDTILKL_FRA" ,
  "BRINGENAVN" ,
  "TYPE_TIL" ,
  "POSTNR_TIL" ,
  "POSTSTED_TIL" ,
  "GATEADRESSE_TIL" ,
  "RAMMETIDFRAKL_TIL" ,
  "RAMMETIDTILKL_TIL" from AlystraShifts)
  order by "ENHETAVTALE" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER", r;
  
  
  select distinct "TYPE_FRA" as type, "EKSTERN" as kategori from AlystraShifts
  union  
  select distinct "TYPE_TIL" as type, "EKSTERN" as kategori from AlystraShifts;
  
.import type_hc.csv type_hc
.import typer.csv typer
.once AlystraOrders.csv
select * from ordreBasis ob, typer as tf, typer as tt, type_hc 
where ob.type_fra = tf.type and ob.type_til = tt.type and tf.kategori = type_hc.fra and tt.kategori = type_hc.til;
--orderlines basis: samme felter, deretter join til orders for å finne reference - konkatenert fra avtale, r +++



.once AlystraOrders.csv
select (tf.sentralisering - tt.sentralisering) as diff, 
(case when (tf.sentralisering - tt.sentralisering)>=0  then 'f' else 'g' end) as hc,
 ob.*, tf.*, tt.* from ordreBasis ob, typer as tf, typer as tt
where ob.type_fra = tf.type and ob.type_til = tt.type;
--orderlines basis: samme felter, deretter join til orders for å finne reference - konkatenert fra avtale, r +++

/*
pseudocode

select uniqueorders from alystrashifts
select orderlines from alystrashifts


avtalenummer + ordrenummer er id

under denne: hvis forskjellig adresser, rammer, ukedagordre, legg på nummerering

under denne: forskjellige ordrelinjer
*/

  create table orderLineBasis as 
  select row_number() over win r1,
   rank() over win r2,
   dense_rank() over win r3,
  "ENHETAVTALE" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER" ,
  "AKTOERNR" ,
  "KUNDE" ,
  "ERPOSTAL" ,
  "UKEDAGORDRE" ,
  "HENTENAVN" ,
  "TYPE_FRA" ,
  "POSTNR_FRA" ,
  "POSTSTED_FRA" ,
  "GATEADRESSE_FRA" ,
  "RAMMETIDFRAKL_FRA" ,
  "RAMMETIDTILKL_FRA" ,
  "BRINGENAVN" ,
  "TYPE_TIL" ,
  "POSTNR_TIL" ,
  "POSTSTED_TIL" ,
  "GATEADRESSE_TIL" ,
  "RAMMETIDFRAKL_TIL" ,
  "RAMMETIDTILKL_TIL", 
  "ANTALL", 
  "LASTB"
  from 
  (select distinct 
  "ENHETAVTALE" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER" ,
  "AKTOERNR" ,
  "KUNDE" ,
  "ERPOSTAL" ,
  "UKEDAGORDRE" ,
  "HENTENAVN" ,
  "TYPE_FRA" ,
  "POSTNR_FRA" ,
  "POSTSTED_FRA" ,
  "GATEADRESSE_FRA" ,
  "RAMMETIDFRAKL_FRA" ,
  "RAMMETIDTILKL_FRA" ,
  "BRINGENAVN" ,
  "TYPE_TIL" ,
  "POSTNR_TIL" ,
  "POSTSTED_TIL" ,
  "GATEADRESSE_TIL" ,
  "RAMMETIDFRAKL_TIL" ,
  "RAMMETIDTILKL_TIL", 
  "ANTALL", 
  "LASTB"
  from AlystraShifts)
  window win as (partition by "ENHETAVTALE" order by "ENHETAVTALE" , "AVTALENUMMER" ,  "ORDRENUMMER"  )
  order by "ENHETAVTALE" ,
  "AVTALENUMMER" ,
  "ORDRENUMMER";
  
/* create table orderLineBasis as 
 with dist as (select distinct 
 "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from AlystraShifts)
 select row_number() over win r1,
 rank() over win r2,
 dense_rank() over win r3,
 row_number() over win2 r4,
 rank() over win2 r5,
 dense_rank() over win2 r6,
 row_number() over win3 r7,
 rank() over win3 r8,
 dense_rank() over win3 r9,
 "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from dist
 window win as (order by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"),
 win2 as (partition by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR" order by "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"),
 win3 as (partition by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL" order by "ANTALL", "LASTB")
 order by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB";
 
 with dist as (select distinct 
 "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from AlystraShifts)
 select row_number() over win r1,
 rank() over win r2,
 dense_rank() over win r3,
 row_number() over win2 r4,
 rank() over win2 r5,
 dense_rank() over win2 r6,
 row_number() over win3 r7,
 rank() over win3 r8,
 dense_rank() over win3 r9,
 "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from dist
 window win as (order by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR"),
 win2 as (partition by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR" order by "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL"),
 win3 as (partition by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL" order by "ANTALL", "LASTB")
 order by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB";
 
 
 r3 is unique id per contract/order++
 r6 adds suffix per order/visit
 r9 is unique below this (at orderline level)
 
 
 with dist as (select distinct 
 "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from AlystraShifts)
 select
 dense_rank() over win r3,
 dense_rank() over win2 r6,
 dense_rank() over win3 r9,
 "ENHETAVTALE"||"/"||"ORDRENUMMER" as orderref,
 "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from dist
 window win as (order by "ENHETAVTALE", "AVTALENUMMER"),
 win2 as (partition by "ENHETAVTALE", "AVTALENUMMER" order by  "ORDRENUMMER", "AKTOERNR","KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL"),
 win3 as (partition by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL" order by "ANTALL", "LASTB")
 order by "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB";
 */
 
 
 -------------------------------------------
 
  with dist as (select distinct 
 "ENHETAVTALE", "AVTALENUMMER", "ORDRENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from AlystraShifts)
 select
 dense_rank() over win r3,
 dense_rank() over win2 r6,
 dense_rank() over win3 r9,
 "ENHETAVTALE"||"/"||"ORDRENUMMER" as orderref,
 (case when (tf.sentralisering - tt.sentralisering)>=0  then 'f' else 'g' end) as hc,
 (tf.sentralisering - tt.sentralisering) as diff, 
 "ENHETAVTALE", "ORDRENUMMER", "AVTALENUMMER",  "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB"
 from dist, 
 typer as tf, 
 typer as tt
where dist.type_fra = tf.type and dist.type_til = tt.type
 window win as (order by "ENHETAVTALE", "ORDRENUMMER"),
 win2 as (partition by "ENHETAVTALE", "ORDRENUMMER" order by  "AVTALENUMMER", "AKTOERNR","KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL"),
 win3 as (partition by "ENHETAVTALE","ORDRENUMMER",  "AVTALENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL" order by "ANTALL", "LASTB")
 order by "ENHETAVTALE", "ORDRENUMMER", "AVTALENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB";
 
 
 
 
 
 
 
 
 
 
 
