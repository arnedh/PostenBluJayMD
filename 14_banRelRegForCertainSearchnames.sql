

.header on
--.mode tabs
.mode csv
.separator ";"



drop table BusRelMissing;
drop table registrations1;
drop table registrations2;


.header on
.mode csv
.separator ";"


.import "BusinessRelations_Missing.csv" BusRelMissing 
.import "_registrations.csv" registrations1
.import "_registrations2.csv" registrations2

.separator ";"

.once registrationsWithBan2.csv
select * from registrations1 where Relationnumber not in (select relationNumber from BusRelMissing)
union 
select * from registrations2 where Relationnumber not in (select relationNumber from BusRelMissing);
