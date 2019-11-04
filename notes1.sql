select expRel.*,relations.searchname
  from expRel, relations where expRel.relnr = relations.relationNumber and zoek <> searchname
  
expRel relnr zoek
 expAddr  zoek, relnr
logisticsadresses relationNumber, searchnamedef
 relations - searchname, relationNumber

sqlite> select count(*) from expRel, relations where expRel.relnr = relations.relationNumber;
count(*)
380
sqlite> select count(*) from expRel, relations where expRel.relnr = relations.relationNumber and expRel.zoek <> relations.searchname;
count(*)
74
sqlite> select count(*) from relnr where searchname in (select zoek from expRel);
Error: no such table: relnr
sqlite> select count(*) from relations where searchname in (select zoek from expRel);
count(*)
320
sqlite> select count(*) from relations where searchname in (select zoek from expRel union all select zoek from expAddr);
count(*)
320
sqlite> select count(*) from (select searchname from relations union select searchnamedef from logisticsadresses) where searchname in (select zoek from expRel union all select zoek from expAddr);
count(*)
324
sqlite> select count(*) from (select searchname from relations union select searchnamedef from logisticsadresses) where searchname in (select zoek from expRel union select zoek from expAddr);
count(*)
324
sqlite>

sqlite>  select count(*) from (select searchnamedef from logisticsadresses) where searchnamedef in (select zoek from expRel);
count(*)
13

sqlite> select count(*) from (select searchname from relations) where searchname in (select zoek from expAddr);
count(*)
320





sqlite> select count(*) from expRel, relations where expRel.relnr <> relations.relationNumber and expRel.zoek = relations.searchname;

select * from expAddr, relations where expAddr.relnr <> relations.relationNumber and expAddr.zoek = relations.searchname;



select * from relations left join expRel on logisticsbasis.in_name = reladrX.in_name


select * from (select zoek from expAddr union select zoek from expRel), basis5 where deliverysearchname = zoek


select * from (select * from expRel, relations where expRel.relnr = relations.relationNumber and expRel.zoek <> relations.searchname), basis5 where pickupsearchname = zoek
