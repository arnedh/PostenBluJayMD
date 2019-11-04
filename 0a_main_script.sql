

----main script, ADAPTED
.read 1_loadsources.sql
--- extract usedsearchnames from BluJay
.read 2_load_used.sql
.read 3a_createrelations.sql
.read 4_create_bases.sql
.read 5a_create_scheduled_bases.sql 

.read 6_write_unwashed_addresses.sql
--- run script over unwashed_adr.csv, creating washed_adr.csv
.read 7a_process_washed_adresses.sql
.read 8a_produce_scheduled_orders.sql 

---- load relations to BluJay
---- load relationRegistrations to BluJay
---- load addresses to BluJay
---- run script over scheduledOrders.csv to load scheduledOrders to BluJay

.read 9a_corrected_adr_and_rel.sql 
-----ADDED
.read 10a_truncated_adr.sql 
-----ADDED
.read 11a_pibpk_logadr.sql 
-----ADDED