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


.import "Ordersbasis\\ORDERS_20191008124316615000.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008124846170001.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008124905827002.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008124913280003.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008124920296004.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008124928453005.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008124935922006.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008152947826010.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008153023042011.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008153030010012.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008153045822013.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008153101149014.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008153104399015.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008153111179016.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008155212369017.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008155223307018.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008155229650019.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008155236807020.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008155245072021.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008155250338022.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008155256572023.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008161610323038.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008161617948039.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008161632214040.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008161636792041.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008161642652042.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008161645464043.csv" ordorders

.import "Ordersbasis\\ORDERS_20191008161650777044.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009102451722047.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009102458987048.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009102504363049.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009102509910050.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009102516035051.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009102521161052.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009102527130053.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009103228699054.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009103235231055.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009103239560056.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009103244857057.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009103249295058.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009103253014059.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009103257702060.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009112755983061.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009112810310062.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009112816623063.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009112822997064.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009112828513065.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009112832216066.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009112836840067.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113254077068.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113258718069.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113304749070.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113310093071.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113316531072.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113318735073.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113324281074.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113704218075.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113708280076.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113713187077.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113718297078.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113724891079.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113727048080.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009113731188081.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114042580082.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114047283083.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114052393084.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114057675085.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114103441086.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114106347087.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114110676088.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114643205089.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114647079090.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114652048091.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114656751092.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114701736093.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114704361094.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009114709267095.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130106550096.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130112034097.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130117253098.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130126409099.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130131488100.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130135269101.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130140066102.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130441290103.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130446571104.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130451337105.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130456947106.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130502056107.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130507541108.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009130512400109.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131333280117.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131342358118.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131351499119.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131356718120.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131401171121.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131405187122.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131409359123.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131718738124.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131725317125.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131732551126.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131739223127.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131745817128.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131746395129.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009131746833130.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009151206253131.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009151425709132.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009151431428133.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009151437053134.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009151442679135.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009151443178136.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009151447382137.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153121244138.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153210057139.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153219495140.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153229026141.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153238557142.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153239510143.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153240167144.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153536498145.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153545498146.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153550404147.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153555201148.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153600248149.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153604967150.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009153610295151.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154311835159.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154317116160.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154321475161.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154325741162.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154331851163.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154336132164.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154341382165.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154415508166.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154421086167.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154425445168.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154429805169.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154434461170.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154435321171.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009154440211172.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009155523209190.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009155531303191.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009155535772192.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009155541132193.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009155546757194.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009155549085195.csv" ordorders

.import "Ordersbasis\\ORDERS_20191009155557616196.csv" ordorders

.import "Ordersbasis\\ORDERS_20191010162733531029.csv" ordorders

.import "Ordersbasis\\ORDERS_20191010162738249030.csv" ordorders

.import "Ordersbasis\\ORDERS_20191010162742936031.csv" ordorders

.import "Ordersbasis\\ORDERS_20191010162747545032.csv" ordorders

.import "Ordersbasis\\ORDERS_20191010162748982033.csv" ordorders

.import "Ordersbasis\\ORDERS_20191010162753935034.csv" ordorders

.import "Ordersbasis\\ORDERS_20191010162759106035.csv" ordorders


drop table if  exists deptresource;

create table deptresource as select distinct 
oo.DEPARTMENT_CODE,
mo.vaktnr as RESOURCE_ID,
oo.department_code||"_"||mo.vaktnr as name 
from ordorders oo left join mappingOTR mo on oo.comment1 = mo.Reference and oo.TASK_TYPE = mo.pOrD;
