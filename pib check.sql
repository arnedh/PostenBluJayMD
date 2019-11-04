SELECT substr(nameLine1, 1, pos-1) AS first_name,
       substr(nameLine1, pos+1) AS last_name
FROM
  (SELECT *,
          instr(trim(nameLine1),' ') AS pos
   FROM scoredAddresses)
ORDER BY first_name,
         last_name;
		 
		 
		 
with words as select substr(nameLine1, 1, instr(nameLine1, ' ')), nameLine1, 1 from scoredAddresses;


select distinct  length(account_number) as s, substr(account_number,1,1) from customer order by s desc;
select length(account_number) as s, substr(account_number,1,1) as f, orig_system,  count(*)  from customer where orig_system_reference = account_number group by orig_system, s, f;

select substr(party_name, 1, instr(party_name, ' ')-1) as word, substr(party_name, instr(party_name, ' ')+1, length(party_name))  , party_name, 1 from customer;


select substr(party_name, 1, instr(party_name, ' ')-1) as word, substr(party_name, instr(party_name, ' ')+1, length(party_name))  , party_name, 1 from (select distinct party_name from customer);

with select substr(party_name, 1, instr(party_name, ' ')-1) as word, substr(party_name, instr(party_name, ' ')+1, length(party_name))  , party_name, 1 from (select distinct party_name from customer);

------------------------------------------

select "drm" as source, "Navn 4. ledd" as id, Beskrivelse from Enhet where "Operativ tom Dato">"31.12.2019" 
	and "Organisasjonstype kode" in ("035", "019", "010", "018")

	
select distinct  nameLine1, addressLine1,	postalCode,	CITY
from (
select  distinct HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, TYPE_FRA as adrtype,	POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY from AlystraShifts
union select  distinct BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,	TYPE_TIL as adrtype,	POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY from AlystraShifts)
where  (adrType = "POST I BUTIKK") ;

select  distinct AKTOERNR,KUNDE from AlystraShifts where ERPOSTAL;



create table keywords as with base as (
select "drm" as source, "Navn 4. ledd" as id, Beskrivelse as phrase from Enhet where "Operativ tom Dato">"31.12.2019" and "Organisasjonstype kode" in ("035", "019", "010", "018") 
union select distinct  "alystra" as source, nameLine1 as id, nameLine1 as phrase
from (
select  distinct HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, TYPE_FRA as adrtype,	POSTNR_FRA as postalCode,	POSTSTED_FRA as CITY from AlystraShifts
union select  distinct BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,	TYPE_TIL as adrtype,	POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY from AlystraShifts)
where  (adrType = "POST I BUTIKK") 
),
	stream as (select "" as word, phrase as rest, phrase,  0 as pos , source, id from base
	union 
	select 
		case when instr(rest, ' ')=0 then rest else substr(rest, 1, instr(rest, ' ')-1) end as word, 
		case when instr(rest, ' ')=0 then "" else substr(rest, instr(rest, ' ')+1, length(rest)) end as rest,
		phrase,
		pos+1 as pos,  source, id
	from stream where length(rest)>1)
select * from stream ;	



select "Navn 4. ledd" as id, Beskrivelse as phrase from Enhet where "Operativ tom Dato">"31.12.2019" and "Organisasjonstype kode" in ("035", "019", "010", "018") 

select distinct postnr_fra from AlystraShifts;
select distinct Adresse."Postnummer" from adresse;


create table drmexp as select Enhet."Navn 4. Ledd",
	 Enhet."Beskrivelse", Adresse."Gatenavn"||" "||Adresse."Gatenummer" as Adr, Adresse."Postnummer", 
	 Adresse."Poststed", Adresse.adrLandKode from Enhet, Adresse 
 where 
	Enhet."Leveringsadresse-Enhet kobling" = Adresse.Name 
	and "Operativ tom Dato">"31.12.2019" 
	and "Organisasjonstype kode" in ("035", "019", "010", "018");

create table alystraexp as select distinct * from (select  distinct HENTENAVN as nameLine1, GATEADRESSE_FRA as addressLine1, TYPE_FRA as adrtype,	printf("%04d",POSTNR_FRA) as postalCode,	POSTSTED_FRA as CITY from AlystraShifts
union select  distinct BRINGENAVN as nameLine1, GATEADRESSE_TIL as addressLine1,	TYPE_TIL as adrtype,	printf("%04d",POSTNR_TIL) as postalCode,	POSTSTED_TIL as CITY from AlystraShifts)
where  (adrType = "POST I BUTIKK") or (adrType = "POSTKONTOR")
.once pibmatch.csv
select distinct * from (select Postnummer as p, d.*, a.* from drmexp d left join alystraexp a on Postnummer = postalCode
union all 
select postalCode as p, d.*,  a.* from alystraexp a left join drmexp d on Postnummer = postalCode) order by Postnummer, postalCode, nameLine1, "Navn 4. Ledd";






