.header on
--.mode tabs
.mode csv
.separator ";"


drop table if  exists AlystraPRKD;

.import "AlystraPRKD.csv" AlystraPRKD  

drop table if  exists AmphoraPRGR;
.import "AmphoraPRGR.csv" AmphoraPRGR