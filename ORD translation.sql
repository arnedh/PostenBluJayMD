select distinct dept, short, a.enhetvakt,  ordrenummer, vaktnr, rutenr, rutenavn
from AlystraShifts a, AlystraDepts adepts, depts where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept order by a.enhetvakt,  ordrenummer, vaktnr, rutenr, rutenavn;


.once mappingORD.csv
select distinct dept, short, a.enhetvakt,  ordrenummer, vaktnr
from AlystraShifts a, AlystraDepts adepts, depts where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept order by a.enhetvakt,  ordrenummer, vaktnr;


.once mappingORD2.csv
select distinct dept, short, a.enhetvakt,  ordrenummer, vaktnr, RUTENR,RUTENAVN, RUTE_FRAKL
from AlystraShifts a, AlystraDepts adepts, depts where a.enhetvakt = adepts.enhetvakt 
and adepts.Column1 = depts.Dept order by a.enhetvakt,  ordrenummer, vaktnr,  RUTENR,RUTENAVN, RUTE_FRAKL