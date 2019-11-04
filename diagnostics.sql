select relationNumber from relations;

select distinct aktoernr, kunde from alystrashifts;

 select distinct "KUNDE_NR" ,
  "NPB_OEBS_ACCOUNTNUMBER" ,
  "NAVN" 
 from amphoratrips where NPB_OEBS_ACCOUNTNUMBER not in (select relationNumber from relations);
 
 
select distinct "KUNDE_NR" ,
  "NPB_OEBS_ACCOUNTNUMBER" ,
  "NAVN" ,  ORIG_SYSTEM_REFERENCE, ORIG_SYSTEM, PARTY_NAME, ACCOUNT_NUMBER
 from amphoratrips, Customer where 
"KUNDE_NR"=ORIG_SYSTEM_REFERENCE ;

select distinct aktoernr, kunde from alystrashifts where aktoernr not in (select relationNumber from relations);


select distinct aktoernr, kunde, 
    ORIG_SYSTEM_REFERENCE, ORIG_SYSTEM, PARTY_NAME, ACCOUNT_NUMBER
 from alystrashifts, Customer where 
aktoernr=ORIG_SYSTEM_REFERENCE 
and aktoernr <> ACCOUNT_NUMBER;


.once _alystra_unknowns.csv
select distinct aktoernr, kunde, erpostal from alystrashifts where aktoernr not in (select relationNumber from relations);

.once amphora_unknowns.csv
select distinct "KUNDE_NR" ,
  "NPB_OEBS_ACCOUNTNUMBER" ,
  "NAVN" 
 from amphoratrips where NPB_OEBS_ACCOUNTNUMBER not in (select relationNumber from relations);
 
 .import UAT_export_Add.csv export_relation2
 .import 
 select * from export_relation2 where relnr not in (select relationNumber from relations)
 and relnr <> "" and relnr<>"ABC.""RELNR""||'";
 
 
.import usedSearchnames_BROO_BRA_LA.csv usedX


.once outX.csv
 select * from export_relation2 where relnr not in (select distinct relationNumber from relations)
 and relnr not in (select distinct relationNumber from usedX)
 and relnr <> "" and relnr<>"ABC.""RELNR""||'" and not (relnr like "-------%");