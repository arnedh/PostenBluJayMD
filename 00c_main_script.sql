

----main script, ADAPTED
.read 01_loadsources.sql
--- extract usedsearchnames from BluJay
.read 02_load_used.sql
.read 03a_createrelations.sql
.read 04_create_bases.sql
.read 05c_create_scheduled_bases.sql 

.read 06_write_unwashed_addresses.sql
--- run script over unwashed_adr.csv, creating washed_adr.csv
.read 07a_process_washed_adresses.sql
.read 08c_produce_scheduled_orders.sql 

---- load relations to BluJay
---- load relationRegistrations to BluJay
---- load addresses to BluJay
---- run script over scheduledOrders.csv to load scheduledOrders to BluJay

.read 09a_corrected_adr_and_rel.sql 
-----ADDED
.read 10a_truncated_adr.sql 
-----ADDED
.read 11a_pibpk_logadr.sql 
-----ADDED

.read 12_ORD_translation.sql 
-----ADDED