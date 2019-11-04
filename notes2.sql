--relations with same id, same sn: ok

--relations with same id, new sn: add as entry in translation table
select relations.searchname, expRel.zoek from expRel, relations where expRel.relnr = relations.relationNumber and expRel.zoek <> relations.searchname;


relations with sn already in use in expRel () or in expAddr;
--relations with sn expAddr: create new entry in translation table

addresses with sn in expRel: create new searchname, new entry in translation table 
other addresses, whether expaddr or not: fill the sn with the content, not translation



select relations.searchname from relations, expAddr where expAddr.zoek = relations.searchname;
select count(*) from relations, expAddr where expAddr.zoek = relations.searchname;

--addr with sn in expRel: create new entry in translation table

select distinct PickupSearchname from basis5 union select distinct DeliverySearchname from basis5 union select distinct TerminalSearchname from basis5;



select count(*) from expRel, relations where expRel.relnr = relations.relationNumber and expRel.zoek <> relations.searchname; 74
--update searchname in BluJay
select count(*) from expRel, relations where expRel.relnr <> relations.relationNumber and expRel.zoek = relations.searchname; 14
--update searchname in BluJay
select count(*) from expAddr, relations where expAddr.relnr = "99999998" and expAddr.zoek = relations.searchname; 0
select count(*) from expAddr, logisticsadresses where expAddr.relnr = "99999998" and expAddr.zoek = logisticsadresses.searchnamedef; 2
--update searchname in BluJay
select count(*) from expRel, logisticsadresses where expRel.zoek = logisticsadresses.searchnamedef; 13


select * from (select zoek from expRel union select zoek from expAddr where expAddr.relnr = "99999998" ), basis5 where zoek = PickupSearchname;