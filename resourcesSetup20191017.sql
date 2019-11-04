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
.import Orders20191016\\OSL1\\ORDERS_20191016152421974138.csv ordorders
.import Orders20191016\\OSL1\\ORDERS_20191016152438771139.csv ordorders
.import Orders20191016\\OSL1\\ORDERS_20191016152453037140.csv ordorders
.import Orders20191016\\OSL1\\ORDERS_20191016152507771141.csv ordorders
.import Orders20191016\\OSL1\\ORDERS_20191016152522099142.csv ordorders
.import Orders20191016\\OSL1\\ORDERS_20191016152524599143.csv ordorders
.import Orders20191016\\OSL1\\ORDERS_20191016152526490144.csv ordorders
.import Orders20191016\\OSL2\\ORDERS_20191016163530616160.csv ordorders
.import Orders20191016\\OSL2\\ORDERS_20191016163535007161.csv ordorders
.import Orders20191016\\OSL2\\ORDERS_20191016163539507162.csv ordorders
.import Orders20191016\\OSL2\\ORDERS_20191016163544382163.csv ordorders
.import Orders20191016\\OSL2\\ORDERS_20191016163553382164.csv ordorders
.import Orders20191016\\OSL2\\ORDERS_20191016163555679165.csv ordorders
.import Orders20191016\\OSL2\\ORDERS_20191016163603304166.csv ordorders
.import Orders20191016\\OSL3\\ORDERS_20191016163334460146.csv ordorders
.import Orders20191016\\OSL3\\ORDERS_20191016163341913147.csv ordorders
.import Orders20191016\\OSL3\\ORDERS_20191016163348366148.csv ordorders
.import Orders20191016\\OSL3\\ORDERS_20191016163354538149.csv ordorders
.import Orders20191016\\OSL3\\ORDERS_20191016163400163150.csv ordorders
.import Orders20191016\\OSL3\\ORDERS_20191016163403726151.csv ordorders
.import Orders20191016\\OSL3\\ORDERS_20191016163405554152.csv ordorders
.import Orders20191016\\OSL4\\ORDERS_20191016163432116153.csv ordorders
.import Orders20191016\\OSL4\\ORDERS_20191016163438319154.csv ordorders
.import Orders20191016\\OSL4\\ORDERS_20191016163444460155.csv ordorders
.import Orders20191016\\OSL4\\ORDERS_20191016163451491156.csv ordorders
.import Orders20191016\\OSL4\\ORDERS_20191016163457819157.csv ordorders
.import Orders20191016\\OSL4\\ORDERS_20191016163459976158.csv ordorders
.import Orders20191016\\OSL4\\ORDERS_20191016163504007159.csv ordorders
.import Orders20191016\\OSL5\\ORDERS_20191016152247771131.csv ordorders
.import Orders20191016\\OSL5\\ORDERS_20191016152321412132.csv ordorders
.import Orders20191016\\OSL5\\ORDERS_20191016152326021133.csv ordorders
.import Orders20191016\\OSL5\\ORDERS_20191016152332021134.csv ordorders
.import Orders20191016\\OSL5\\ORDERS_20191016152342927135.csv ordorders
.import Orders20191016\\OSL5\\ORDERS_20191016152352990136.csv ordorders
.import Orders20191016\\OSL5\\ORDERS_20191016152359459137.csv ordorders



drop table if  exists deptresource;

create table deptresource as select distinct 
oo.DEPARTMENT_CODE,
mo.vaktnr as RESOURCE_ID,
oo.department_code||"_"||mo.vaktnr as name 
from ordorders oo left join mappingOTR mo on oo.comment1 = mo.Reference and oo.TASK_TYPE = mo.pOrD;
