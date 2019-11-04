
drop table if exists ordorders;
--.separator ","
.import Orders20191023\\FRK\\ORDERS_20191009113254077068.csv ordorders
.import Orders20191023\\FRK\\ORDERS_20191009113258718069.csv ordorders
.import Orders20191023\\FRK\\ORDERS_20191009113304749070.csv ordorders
.import Orders20191023\\FRK\\ORDERS_20191009113310093071.csv ordorders
.import Orders20191023\\FRK\\ORDERS_20191009113316531072.csv ordorders
.import Orders20191023\\FRK\\ORDERS_20191009113318735073.csv ordorders
.import Orders20191023\\FRK\\ORDERS_20191009113324281074.csv ordorders

--.separator ";"







drop table if  exists deptresource;

create table deptresource as select distinct 
oo.DEPARTMENT_CODE,
mo.vaktnr as RESOURCE_ID,
oo.department_code||"_"||mo.vaktnr as name 
from ordorders oo left join mappingOTR mo on oo.comment1 = mo.Reference and oo.TASK_TYPE = mo.pOrD;
