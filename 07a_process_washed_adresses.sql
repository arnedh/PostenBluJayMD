--load and process addresses
--washedaddress is same as unwashed, but with washed columns.

drop table if exists WashedAddresses;
.import washedaddresses.csv washedaddresses

drop table if exists logisticsbasis;
create table logisticsbasis as 
select distinct in_name, out_addr1, out_zip, out_city, (case (country_code) when "" then "NO" else country_code end) as  country from washedAddresses ;

drop table if exists mainadrX;
create table mainadrX as 
select distinct adr.weight, wadr.in_name, wadr.out_addr1, wadr.out_zip, wadr.out_city,  (case (wadr.country_code) when "" then "NO" else country_code end) as  country, rel.relationNumber, rel.searchName
from scoredAddresses adr, relations rel, washedaddresses wadr
where adr.org_id = rel.relationNumber 
and wadr.org_id = adr.org_id
and adr.nameLine1 = wadr.in_name
and adr.addressLine1 = wadr.in_addr
and adr.postalCode = wadr.in_zip
and adr.city = wadr.in_city
order by rel.relationNumber, rel.searchName;

drop table if exists reladrX;
create table reladrX as select *, searchname as searchnameref, "" as searchnamedef from (select mainadrX.*, row_number() over (partition by relationNumber order by relationNumber, weight desc ) as place from mainadrX) where place = 1;

drop table if exists remaining;
create table remaining as select * from (
select logisticsbasis.*, reladrX.searchnameref from logisticsbasis left join reladrX on 
 logisticsbasis.in_name = reladrX.in_name
and logisticsbasis.out_addr1 = reladrX.out_addr1
and logisticsbasis.out_zip = reladrX.out_zip
and logisticsbasis.out_city = reladrX.out_city)
where searchnameref is null;

--for addresses that don't have searchnamedef, create searchname

drop table if exists adrSN;
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
trim(upper(in_name))," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"'",""),"?",""),"´",""),";",""),char(9),""),char(34),""),1,9) as nameBase,
substr(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
trim(upper(out_city))," ",""),"(","") ,")","") ,"-","") ,"/","") ,"#","") ,":","") ,".","") ,"&","") ,",","") ,"+","") ,"'",""),"?",""),"´",""),";",""),char(9),""),char(34),""),1,5) as cityBase,
*
from remaining));


drop table if exists nonRelAdr;
create table nonRelAdr as 
select snbasis||printf("%04d", coalesce(usn2.maxnum,0)+row_number() over (partition by snBasis order by snBasis, in_name, out_addr1)) as searchname,*
from adrSN left join usn2 on adrSN.snBasis = usn2.searchBase;


drop table if exists adrLookup;
create table adrLookup as 
select in_name ,
  out_addr1 ,
  out_zip ,
  out_city ,
  country,
  relationNumber ,
  searchnameref,
  searchnamedef from relAdrX
union 
select in_name ,
  out_addr1 ,
  out_zip ,
  out_city ,
  country,
  "" as relationNumber,
  searchname as searchnamedef ,
  searchname as searchnameref 
from nonRelAdr;

delete from adrLookup where in_name = "" and out_addr1="";
.once _adrLookup.csv
select * from adrLookup;


drop table if exists logisticsadresses; 
create table logisticsadresses as select in_name ,
  out_addr1 ,
  out_zip ,
  out_city ,
  country,
  relationNumber ,
  searchnamedef
  from adrLookup;
  
  
  
 insert into logisticsadresses select 
	 Enhet."Beskrivelse", Adresse."Gatenavn"||" "||Adresse."Gatenummer", Adresse."Postnummer", 
	 Adresse."Poststed", Adresse.adrLandKode,  "", Enhet."Navn 4. Ledd" from Enhet, Adresse  where 
	Enhet."Leveringsadresse-Enhet kobling" = Adresse.Name 
	and "Operativ tom Dato">"31.12.2019" 
	and "Organisasjonstype kode" in ("035", "019", "010", "018");
	
/*
.once _logisticsadresses.csv
select  * from logisticsadresses;*/

insert into UsedSearchNames select searchNamedef, relationNumber, in_name from logisticsadresses;

.once _usedsearchname2.csv
select * from usedsearchnames;


.once _logisticsadresses.csv
select
searchnamedef as searchName,
relationnumber as relationNumber, 
in_name as nameLine1,
 "" as nameLine2,
 "" as nameLine3,
 out_addr1 as addressLine1,
"" as addressLine2,
 "" as addressLine3,
 out_zip as postalCode,
out_city as city,
country as countryCode,
 "" as subentityCode,
 "" as contactPerson,
"" as telephoneNumber,
"" as telexNumber,
"" as telefaxNumber,
"" as languageCode,
"" as emailAddress,
"" as internetAddress,
"" as "Select for planning characteristics" ,
"" as   "Type of address" ,
"" as   "Destination code" ,
"" as   "City2" ,
"" as   "AGP licence number" ,
"" as   "EAN relation number" ,
"" as   "Indication fiscal representation" ,
"" as   "VAT ID number" ,
"" as   "Base stop time" ,
"" as   "Pickup scan required" ,
"" as   "Order delivery type" ,
"" as   "Order collect type" 
from logisticsadresses;
