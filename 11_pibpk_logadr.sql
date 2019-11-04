create table pibpk as select distinct 1 as weight, "drm" as source, 'pib-pk' as kind, Enhet."Navn 4. Ledd",
	 Enhet."Beskrivelse", Adresse."Gatenavn"||" "||Adresse."Gatenummer" as Adr, Adresse."Postnummer", 
	 Adresse."Poststed", Adresse.adrLandKode from Enhet, Adresse 
 where 
	Enhet."Leveringsadresse-Enhet kobling" = Adresse.Name 
	and "Operativ tom Dato">"31.12.2019" 
	and "Organisasjonstype kode" in ("035", "019", "010", "018");
	
	
.once _pibpk_logadr.csv
select
"Navn 4. Ledd" as "Searchname",
"99999998" as "Relation number", 
substr((case when length("Beskrivelse")=0 then '-' else "Beskrivelse" end),1,35) as "Name line 1",
"" as "Name line 2",
"" as "Name line 3",
substr((case when length("Adr")=0 then '-' else "Adr" end),1,35) as "Address line 1",
"" as "Address line 2",
"" as "Address line 3",
printf("%04d",Postnummer) as "Postal code",
"Poststed" as "City",
"NO" as "Country",
"" as "District code",
"" as "Contact person",
"" as "Telephone number",
"" as "Telex number",
"" as "Fax number",
"" as "Language code",
"" as "E-mail address",
"" as "Internet Address",
"" as "Select for planning characteristics",
3 as "Type of address",
"" as "Destination code",
"" as "City2",
"" as "AGP licence number",
"" as "EAN relation number",
"" as "Indication fiscal representation",
"" as "VAT ID number","" as "Base stop time",
"" as "Pickup scan required",
"" as "Order delivery type",
"" as "Order collect type"

from pibpk;
