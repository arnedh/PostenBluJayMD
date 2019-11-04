/*

----main script, ADAPTED
.read 1_loadsources.sql
--- extract usedsearchnames from BluJay
.read 2_load_used.sql
.read 3a_createrelations.sql
.read 4_create_bases.sql
.read 5a_create_scheduled_bases.sql 

OTR_setup_9.sql

*/


.import "ORDERS_BGO.csv" ordorders


drop table if  exists deptresource;

create table deptresource as select distinct 
oo.DEPARTMENT_CODE,
mo.vaktnr as RESOURCE_ID,
oo.department_code||"_"||mo.vaktnr as name 
from ordorders oo left join mappingOTR mo on oo.comment1 = mo.Reference and oo.TASK_TYPE = mo.pOrD;
