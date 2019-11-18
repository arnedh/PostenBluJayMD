 ---adapted from 5c-create-scheduled-bases
drop table if exists typer; 
.import typer.csv typer

drop table if exists basisalystra1;
create table basisalystra1 as
  with dist as (select distinct 
 "ENHETVAKT", "ORDRENUMMER","ENHETAVTALE", "AVTALENUMMER",  "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB", ap.prodkat as _prodcat
 from AlystraShifts sh left join alystraprkd ap on sh.produkt = ap.prod
 )
 select
 (case when (tf.sentralisering - tt.sentralisering)>=0  then 'f' else 'g' end) as "HandlingCode",
 "ENHETVAKT", "ORDRENUMMER","ENHETAVTALE", "AVTALENUMMER",  "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB", _prodcat
 from dist, 
 typer as tf, 
 typer as tt
where dist.type_fra = tf.type and dist.type_til = tt.type
 order by "ENHETVAKT", "ORDRENUMMER","ENHETAVTALE", "AVTALENUMMER", "AKTOERNR", "KUNDE", "ERPOSTAL", "UKEDAGORDRE", "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA", "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB";


drop table if exists basisalystra2;
create table basisalystra2 as select 
a.*,
a."ENHETVAKT"||"/"||"ORDRENUMMER" as RefBase,
adepts.Column1 as "Department",
depts.TermRel as "TerminalSearchName",
p.package as "PackageType",
p."KONTAINERFAKTOR" as kontainerfaktor
from basisalystra1 a, LastbPackage p, AlystraDepts adepts, depts
where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept
and a.lastb = p.lastb;
 
 
drop table if exists basisalystra3;
create table basisalystra3 as select distinct "RefBase", "HandlingCode", "Department", "TerminalSearchName","AKTOERNR", "UKEDAGORDRE",
"ENHETVAKT", "ORDRENUMMER",
 "HENTENAVN", "TYPE_FRA", "POSTNR_FRA", "POSTSTED_FRA", "GATEADRESSE_FRA", "RAMMETIDFRAKL_FRA", "RAMMETIDTILKL_FRA",
 "BRINGENAVN", "TYPE_TIL", "POSTNR_TIL", "POSTSTED_TIL", "GATEADRESSE_TIL", "RAMMETIDFRAKL_TIL", "RAMMETIDTILKL_TIL", "ANTALL", "LASTB", kontainerfaktor, PackageType, _prodcat, 
 case when erpostal = 1  then 999999001000 else coalesce(r.relationNumber,999999000000) end as "Principal" 
from basisalystra2 left join relations r
on AKTOERNR = r.relationNumber;
