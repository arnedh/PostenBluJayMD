

.header on
--.mode tabs
.mode csv
.separator ";"



drop table if exists BusRelMissing;



.header on
.mode csv
.separator ";"


.import "BusinessRelations_Missing.csv" BusRelMissing 


.separator ";"

.once registrationsWithBan.csv
select * from registrations where Relationnumber not in (select relationNumber from BusRelMissing);
