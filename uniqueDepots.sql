create table depots as select dep from (select distinct start_depot as dep from Alystrashifts
union 
select distinct end_depot as dep from Alystrashifts)
order by dep;

create table alystraadr as select distinct nameline1, addressline1, adrtype, postalcode from alystrabasis2;

select * from alystraadr left join depots on alystraadr.nameLine1 = depots.dep;
.once depotsAlystra.csv
select * from depots left join alystraadr on alystraadr.nameLine1 = depots.dep;

