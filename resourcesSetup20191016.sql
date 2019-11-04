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

.import Orders20191016\\AES\\ORDERS_20191016125315869039.csv ordorders
.import Orders20191016\\AES\\ORDERS_20191016125320322040.csv ordorders
.import Orders20191016\\AES\\ORDERS_20191016125324775041.csv ordorders
.import Orders20191016\\AES\\ORDERS_20191016125329869042.csv ordorders
.import Orders20191016\\AES\\ORDERS_20191016125334228043.csv ordorders
.import Orders20191016\\AES\\ORDERS_20191016125337275044.csv ordorders
.import Orders20191016\\AES\\ORDERS_20191016125341837045.csv ordorders
.import Orders20191016\\ALF\\ORDERS_20191016125408603046.csv ordorders
.import Orders20191016\\ALF\\ORDERS_20191016125414244047.csv ordorders
.import Orders20191016\\ALF\\ORDERS_20191016125420166048.csv ordorders
.import Orders20191016\\ALF\\ORDERS_20191016125425338049.csv ordorders
.import Orders20191016\\ALF\\ORDERS_20191016125429791050.csv ordorders
.import Orders20191016\\ALF\\ORDERS_20191016125433822051.csv ordorders
.import Orders20191016\\ALF\\ORDERS_20191016125439150052.csv ordorders
.import Orders20191016\\BGO\\ORDERS_20191016125214994032.csv ordorders
.import Orders20191016\\BGO\\ORDERS_20191016125223322033.csv ordorders
.import Orders20191016\\BGO\\ORDERS_20191016125231900034.csv ordorders
.import Orders20191016\\BGO\\ORDERS_20191016125240634035.csv ordorders
.import Orders20191016\\BGO\\ORDERS_20191016125249697036.csv ordorders
.import Orders20191016\\BGO\\ORDERS_20191016125251306037.csv ordorders
.import Orders20191016\\BGO\\ORDERS_20191016125252900038.csv ordorders
.import Orders20191016\\FAU\\ORDERS_20191016125503322053.csv ordorders
.import Orders20191016\\FAU\\ORDERS_20191016125507338054.csv ordorders
.import Orders20191016\\FAU\\ORDERS_20191016125512009055.csv ordorders
.import Orders20191016\\FAU\\ORDERS_20191016125517181056.csv ordorders
.import Orders20191016\\FAU\\ORDERS_20191016125522119057.csv ordorders
.import Orders20191016\\FAU\\ORDERS_20191016125526181058.csv ordorders
.import Orders20191016\\FAU\\ORDERS_20191016125530822059.csv ordorders
.import Orders20191016\\FDE\\ORDERS_20191016125613994060.csv ordorders
.import Orders20191016\\FDE\\ORDERS_20191016125618306061.csv ordorders
.import Orders20191016\\FDE\\ORDERS_20191016125623572062.csv ordorders
.import Orders20191016\\FDE\\ORDERS_20191016125628666063.csv ordorders
.import Orders20191016\\FDE\\ORDERS_20191016125632572064.csv ordorders
.import Orders20191016\\FDE\\ORDERS_20191016125636540065.csv ordorders
.import Orders20191016\\FDE\\ORDERS_20191016125641900066.csv ordorders
.import Orders20191016\\HMR\\ORDERS_20191016125811290074.csv ordorders
.import Orders20191016\\HMR\\ORDERS_20191016125817618075.csv ordorders
.import Orders20191016\\HMR\\ORDERS_20191016125823821076.csv ordorders
.import Orders20191016\\HMR\\ORDERS_20191016125830368077.csv ordorders
.import Orders20191016\\HMR\\ORDERS_20191016125836384078.csv ordorders
.import Orders20191016\\HMR\\ORDERS_20191016125837931079.csv ordorders
.import Orders20191016\\HMR\\ORDERS_20191016125840400080.csv ordorders
.import Orders20191016\\KRS\\ORDERS_20191016125901493081.csv ordorders
.import Orders20191016\\KRS\\ORDERS_20191016125907962082.csv ordorders
.import Orders20191016\\KRS\\ORDERS_20191016125913540083.csv ordorders
.import Orders20191016\\KRS\\ORDERS_20191016125918806084.csv ordorders
.import Orders20191016\\KRS\\ORDERS_20191016125923946085.csv ordorders
.import Orders20191016\\KRS\\ORDERS_20191016125927150086.csv ordorders
.import Orders20191016\\KRS\\ORDERS_20191016125932087087.csv ordorders
.import Orders20191016\\MOL\\ORDERS_20191016125952415088.csv ordorders
.import Orders20191016\\MOL\\ORDERS_20191016125956306089.csv ordorders
.import Orders20191016\\MOL\\ORDERS_20191016130000071090.csv ordorders
.import Orders20191016\\MOL\\ORDERS_20191016130005321091.csv ordorders
.import Orders20191016\\MOL\\ORDERS_20191016130009431092.csv ordorders
.import Orders20191016\\MOL\\ORDERS_20191016130012165093.csv ordorders
.import Orders20191016\\MOL\\ORDERS_20191016130022696094.csv ordorders
.import Orders20191016\\MQN\\ORDERS_20191016130042915095.csv ordorders
.import Orders20191016\\MQN\\ORDERS_20191016130047712096.csv ordorders
.import Orders20191016\\MQN\\ORDERS_20191016130053181097.csv ordorders
.import Orders20191016\\MQN\\ORDERS_20191016130058353098.csv ordorders
.import Orders20191016\\MQN\\ORDERS_20191016130103368099.csv ordorders
.import Orders20191016\\MQN\\ORDERS_20191016130109790100.csv ordorders
.import Orders20191016\\MQN\\ORDERS_20191016130116009101.csv ordorders
.import Orders20191016\\NVK\\ORDERS_20191016130134228102.csv ordorders
.import Orders20191016\\NVK\\ORDERS_20191016130138868103.csv ordorders
.import Orders20191016\\NVK\\ORDERS_20191016130142993104.csv ordorders
.import Orders20191016\\NVK\\ORDERS_20191016130147665105.csv ordorders
.import Orders20191016\\NVK\\ORDERS_20191016130153103106.csv ordorders
.import Orders20191016\\NVK\\ORDERS_20191016130157931107.csv ordorders
.import Orders20191016\\NVK\\ORDERS_20191016130202587108.csv ordorders
.import Orders20191016\\STK\\ORDERS_20191016130226478109.csv ordorders
.import Orders20191016\\STK\\ORDERS_20191016130231665110.csv ordorders
.import Orders20191016\\STK\\ORDERS_20191016130236915111.csv ordorders
.import Orders20191016\\STK\\ORDERS_20191016130241806112.csv ordorders
.import Orders20191016\\STK\\ORDERS_20191016130242572113.csv ordorders
.import Orders20191016\\STK\\ORDERS_20191016130244118114.csv ordorders
.import Orders20191016\\STK\\ORDERS_20191016130249009115.csv ordorders
.import Orders20191016\\TOS\\ORDERS_20191016130339056116.csv ordorders
.import Orders20191016\\TOS\\ORDERS_20191016130343619117.csv ordorders
.import Orders20191016\\TOS\\ORDERS_20191016130349181118.csv ordorders
.import Orders20191016\\TOS\\ORDERS_20191016130355525119.csv ordorders
.import Orders20191016\\TOS\\ORDERS_20191016130400915120.csv ordorders
.import Orders20191016\\TOS\\ORDERS_20191016130405353121.csv ordorders
.import Orders20191016\\TOS\\ORDERS_20191016130411806122.csv ordorders
.import Orders20191016\\TRD\\ORDERS_20191016130439728123.csv ordorders
.import Orders20191016\\TRD\\ORDERS_20191016130448462124.csv ordorders
.import Orders20191016\\TRD\\ORDERS_20191016130457290125.csv ordorders
.import Orders20191016\\TRD\\ORDERS_20191016130506447126.csv ordorders
.import Orders20191016\\TRD\\ORDERS_20191016130516369127.csv ordorders
.import Orders20191016\\TRD\\ORDERS_20191016130517228128.csv ordorders
.import Orders20191016\\TRD\\ORDERS_20191016130518041129.csv ordorders



drop table if  exists deptresource;

create table deptresource as select distinct 
oo.DEPARTMENT_CODE,
mo.vaktnr as RESOURCE_ID,
oo.department_code||"_"||mo.vaktnr as name 
from ordorders oo left join mappingOTR mo on oo.comment1 = mo.Reference and oo.TASK_TYPE = mo.pOrD;
