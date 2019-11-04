select distinct
 PARTY_NAME as nameLine1,
  ADDRESS1 as addressLine1,
 POSTAL_CODE as postalCode,
 CITY as city, Country as country,
 "CDH Bill to" as source
from Customer where "SITE_USE_CODE" ="BILL_TO"
union


select distinct
 account_number,
 PARTY_NAME as nameLine1,
 ADDRESS1 as addressLine1,
 POSTAL_CODE as postalCode,
 CITY as city, Country as country, "CDH Ship to" as source
from Customer 
---------------shipto adresses distinct from billto
select b.*, a.* from 

(select distinct
 account_number,
 PARTY_NAME as nameLine1,
 ADDRESS1 as addressLine1,
 POSTAL_CODE as postalCode,
 CITY as city, Country as country
from Customer where "SITE_USE_CODE" ="BILL_TO") as a,
(select distinct
 account_number,
 PARTY_NAME as nameLine1,
 ADDRESS1 as addressLine1,
 POSTAL_CODE as postalCode,
 CITY as city, Country as country
from Customer where "SITE_USE_CODE" ="SHIP_TO") as b
where a.account_number = b.account_number and a.addressLine1!=b.addressLine1



select distinct *
from 
(select aktoernr, kunde, erpostal, erbedrift, hentenavn as navn, gateadresse_fra as adresse, postnr_fra as postnr, poststed_fra as poststed, kunde_fra as k, type_fra as type from AlystraShifts
union select aktoernr, kunde, erpostal, erbedrift, bringenavn as navn, gateadresse_til as adresse, postnr_til as postnr, poststed_til as poststed, kunde_til as k, type_til as type from AlystraShifts
)
group by aktoernr, kunde, erpostal, erbedrift, navn, k, type, adresse, postnr, poststed
order by aktoernr, kunde, erpostal, erbedrift, navn, k, type, adresse, postnr, poststed;

GATEADRESSE_TIL as addressLine1,		POSTNR_TIL as postalCode,	POSTSTED_TIL as CITY,