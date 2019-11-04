select distinct select distinct "OrgNr Bedrift" from Enhet
union select distinct "OrgNr Juridisk" from Enhet;


select distinct JGZZ_FISCAL_CODE, PARTY_NAME, ACCOUNT_NUMBER, ACCOUNT_NAME, ADDRESS1, ADDRESS2, ADDRESS3, ADDRESS4,CITY,POSTAL_CODE,COUNTRY,SITE_USE_CODE from Customer where site_use_code = "BILL_TO"
and JGZZ_FISCAL_CODE in (select distinct "OrgNr Bedrift" from Enhet
union select distinct "OrgNr Juridisk" from Enhet) and JGZZ_FISCAL_CODE<>"";


select distinct JGZZ_FISCAL_CODE, PARTY_NAME, ACCOUNT_NUMBER, ACCOUNT_NAME, ADDRESS1, ADDRESS2, ADDRESS3, ADDRESS4,CITY,POSTAL_CODE,COUNTRY,SITE_USE_CODE from Customer where site_use_code = "BILL_TO"

select distinct "Vendor Name","Vendor Number","Vendor Type","Oraganization Number","ADDRESS_LINE1","ADDRESS_LINE2","CITY","ZIP","COUNTRY" from Supplier where 
 "Oraganization Number" in (select distinct "OrgNr Bedrift" from Enhet
union select distinct "OrgNr Juridisk" from Enhet) and "Oraganization Number"<>"";
