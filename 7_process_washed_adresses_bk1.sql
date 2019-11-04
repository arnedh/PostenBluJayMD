--load and process addresses
--washedaddress is same as unwashed, but with washed columns.

drop table WashedAddresses;
.import washedaddresses.csv washedaddresses

--create table uniqueWashed

--highscores -> uniqueWashed as relationnumber, blank searchnamedef, relation searchname as searchnameref
--lowscores -> uniqueWashed as "9999998", new searchname as searchnameref, searchnamedef
--unattached -> uniqueWashed as "9999998", new searchname as searchnameref, searchnamedef

--(update usedSearchnames)


/*

select sum(weight),count(*), scoredAddresses.org_id,  out_zip, out_city ,out_name, out_addr1 from scoredAddresses, washedAddresses 
where scoredAddresses.nameLine1 = washedAddresses.in_name
and scoredAddresses.addressLine1 = washedAddresses.in_addr
and scoredAddresses.postalCode = washedAddresses.in_zip
and scoredAddresses.city = washedAddresses.in_city
group by scoredAddresses.org_id, out_zip, out_city ,out_name, out_addr1
order by scoredAddresses.org_id, out_zip, out_city ,out_name, out_addr1;

select count(*) from (select distinct out_name,out_addr1,out_addr2,out_zip,out_city from washedAddresses);
*/
drop table logisticsbasis;
create table logisticsbasis as 
select distinct out_name, out_addr1, out_zip, out_city, (case (country_code) when "" then "NO" else country_code end) as  country, "" as relationNumber, "" as searchnamedef, "" as searchnameref from washedAddresses ;


drop table mainadr;
create table mainadr as 
select distinct adr.weight, wadr.in_name, wadr.in_addr, wadr.in_zip, wadr.in_city,  rel.relationNumber, rel.searchName, lb.*
from logisticsbasis lb, scoredAddresses adr, relations rel, washedaddresses wadr
where adr.org_id = rel.relationNumber 
and adr.nameLine1 = wadr.in_name
and adr.addressLine1 = wadr.in_addr
and adr.postalCode = wadr.in_zip
and adr.city = wadr.in_city
and lb.out_name = wadr.in_name
and lb.out_addr1 = wadr.in_addr
and lb.out_zip = wadr.in_zip
and lb.out_city = wadr.in_city
order by rel.relationNumber, rel.searchName, lb.out_addr1;

select * from (select mainadr.*, row_number() over (partition by relationNumber order by relationNumber, weight desc ) as place from mainadr) where place = 1;

--for main address per company: set searchnameref, def etc

--for addresses that don't have searchnamedef, create searchname


drop table adrSN;
create table adrSN as select *,replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(
sn1
,"ú","U") ,"í","I") ,"È","E") ,"í","I") ,"ó","O") ,"ã","A") 
,"î","I") ,"â","A") ,"ô","O") ,"è","E") ,"ò","O") ,"â","A")
,"ê","E") ,"á","A") ,"Á","A") ,"ý","Y") ,"û","U") ,"Â","A") as snbasis
from (select *, 
replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(
countryBase||nameBase||cityBase
,"Æ","A") ,"Ø","O") ,"Å","A") ,"Ö","O") ,"Ü","U") ,"Ä","A") 
,"æ","A") ,"ø","O") ,"å","A") ,"ö","O") ,"ü","U") ,"ä","A") 
,"ß","S") ,"é","E") ,"É","E") ,"Ú","U") ,"Ř","R") ,"Í","I") 
 as sn1
from
(select 
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
trim(upper(country))," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"'",""),"?",""),"´",""),";",""),char(9),""),char(34),""),1,2) as countryBase,
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
trim(upper(out_name))," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"'",""),"?",""),"´",""),";",""),char(9),""),char(34),""),1,9) as nameBase,
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
trim(upper(out_city))," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"'",""),"?",""),"´",""),";",""),char(9),""),char(34),""),1,5) as cityBase,
*
from logisticsbasis));

drop table logisticsadresses;

create table logisticsadresses as 
select snbasis||printf("%04d", coalesce(usn.maxnum,0)+row_number() over (partition by snBasis order by snBasis, relationNumber)) as searchname,*
from adrSN left join usn on adrSN.snBasis = usn.searchBase;

.once _logisticsadresses.csv
select  * from logisticsadresses;

insert into UsedSearchNames select searchName, relationNumber, nameLine1 from logisticsadresses;

.once _usedsearchname2.csv
select * from usedsearchnames;

