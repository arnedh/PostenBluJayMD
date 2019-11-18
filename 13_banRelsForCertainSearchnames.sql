

.header on
--.mode tabs
.mode csv
.separator ";"



drop table BusRelMissing;
drop table logadrNonrel;


.header on
.mode csv
.separator ";"

.import "BusinessRelations_Missing.csv" BusRelMissing 
.separator ","
.import "logAdrNonRelWSearchname.csv" logadrNonrel

.separator ";"

.once logadrNonrelAvoiddupes.csv
select * from logadrNonrel where "Relation number" not in (select relationNumber from BusRelMissing);
