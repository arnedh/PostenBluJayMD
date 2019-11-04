select ukedag_vakt, vaktnr, ukedag_rute, 
rutenr, aktoernr, kunde, ukedagordre, 
seq_load_event, hentenavn,  ukedag_stopp_fra, ankomsttid_fra,avgangstid_fra, 
seq_unload_event, bringenavn,  ukedag_stopp_til, ankomsttid_til, avgangstid_til
from AlystraShifts;

.once shiftsNarrow.txt

select count(ukedag_vakt), count(ukedag_rute),count(ukedagordre),count(ukedag_stopp_fra), count(ukedag_stopp_til),
vaktnr,  
rutenr, aktoernr, kunde, 
seq_load_event, hentenavn,   ankomsttid_fra,avgangstid_fra, 
seq_unload_event, bringenavn,   ankomsttid_til, avgangstid_til
from AlystraShifts group by 
vaktnr,  
rutenr, aktoernr, kunde,  
seq_load_event, hentenavn,   ankomsttid_fra,avgangstid_fra, 
seq_unload_event, bringenavn,   ankomsttid_til, avgangstid_til;

.once uniqueStops.txt

select count(ukedag_vakt), count(ukedag_rute),count(ukedag_stopp_fra), count(ukedag_stopp_til),
vaktnr,  
rutenr, 
ukedagordre,
aktoernr, kunde, 
seq_load_event, hentenavn,   ankomsttid_fra,avgangstid_fra, 
seq_unload_event, bringenavn,   ankomsttid_til, avgangstid_til
from AlystraShifts group by 
vaktnr,  
rutenr, 
ukedagordre, 
aktoernr, kunde,  
seq_load_event, hentenavn,   ankomsttid_fra,avgangstid_fra, 
seq_unload_event, bringenavn,   ankomsttid_til, avgangstid_til;.once uniqueStops.txt


.once uniqueStopsNoVakt.txt
select count(ukedag_vakt), count(ukedag_rute),count(ukedag_stopp_fra), count(ukedag_stopp_til),
rutenr, 
ukedagordre,
aktoernr, kunde, 
seq_load_event, hentenavn,   ankomsttid_fra,avgangstid_fra, 
seq_unload_event, bringenavn,   ankomsttid_til, avgangstid_til
from AlystraShifts group by 
rutenr, 
ukedagordre, 
aktoernr, kunde,  
seq_load_event, hentenavn,   ankomsttid_fra,avgangstid_fra, 
seq_unload_event, bringenavn,   ankomsttid_til, avgangstid_til;