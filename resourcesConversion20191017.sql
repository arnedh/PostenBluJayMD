
drop table if exists RESOURCES_OSL1;
.import Resourcesbasis\\RESOURCES_OSL1.csv RESOURCES_OSL1
.header on
.output Converted20191017\\OSL1\\mRESOURCES_OSL1.csv
.header on
select * from RESOURCES_OSL1;
.header off
select  RESOURCE_ID,
NAME,
'' as ADRES1,
'' as POSTAL_CODE1,
'' as CITY1,
'' as COUNTRYNR1,
'' as COUNTRYCODE1,
'' as XSTRING1,
'' as YSTRING1,
'' as ADRES2,
'' as POSTAL_CODE2,
'' as CITY2,
'' as COUNTRYNR2,
'' as COUNTRYCODE2,
'' as XSTRING2,
'' as YSTRING2,
'08:00' as START_NORMAL_WORKTIME,
'16:00' as END_NORMAL_WORKTIME,
'08:00' as MAX_NORMAL_WORK_HOURS,
'08:00' as START_OVERTIME_WORKTIME,
'16:00' as END_OVERTIME_WORKTIME,
'08:00' as MAX_OVERTIME_WORK_HOURS,
'1' as RESOURCE_TYPE,
'0' as PRELOADED_START_PLAN,
'1' as PRELOADED_END_PLAN,
'' as SKIP_START_LOCATION,
'' as SKIP_END_LOCATION,
'' as MAX_VOLUME,
'9999' as MAX_PIECES,
'9999' as MAX_SIZE3,
'1' as ALL_DEPOTS_ALLOWED,
'' as DEPOT1,
'' as DEPOT2,
'' as DEPOT3,
'' as DEPOT4,
'' as DEPOT5,
'' as FIXED_COSTS,
'' as COST_PER_KM,
'' as COST_PER_HOUR,
'' as COST_PER_HOUR_OVERTIME,
'1' as SPEED_CORRECTION_FACTOR,
'0' as PRIORITY,
'' as TERRITORY,
'180101' as STARTDATE,
DEPARTMENT_CODE,
'11' as RESOURCE_KIND_CODE,
'' as START_LOC_ID,
'' as END_LOC_ID,
'' as USE_FIXED_START,
'00:00' as FIXED_START_AMPL,
'00:00' as FIXED_START_TIME,
'0' as HELPER_REQ,
'' as MAX_TRIP_TIME,
'20' as COUPLE_TIME,
'20' as DECOUPLE_TIME,
'0' as UNIT_NUMBER,
'END' as END
 from deptresource where department_code='OSL1' and name not in (select name from RESOURCES_OSL1);
 
.header on
.output stdout


drop table if exists RESOURCES_OSL2;
.import Resourcesbasis\\RESOURCES_OSL2.csv RESOURCES_OSL2
.header on
.output Converted20191017\\OSL2\\mRESOURCES_OSL2.csv
.header on
select * from RESOURCES_OSL2;
.header off
select  RESOURCE_ID,
NAME,
'' as ADRES1,
'' as POSTAL_CODE1,
'' as CITY1,
'' as COUNTRYNR1,
'' as COUNTRYCODE1,
'' as XSTRING1,
'' as YSTRING1,
'' as ADRES2,
'' as POSTAL_CODE2,
'' as CITY2,
'' as COUNTRYNR2,
'' as COUNTRYCODE2,
'' as XSTRING2,
'' as YSTRING2,
'08:00' as START_NORMAL_WORKTIME,
'16:00' as END_NORMAL_WORKTIME,
'08:00' as MAX_NORMAL_WORK_HOURS,
'08:00' as START_OVERTIME_WORKTIME,
'16:00' as END_OVERTIME_WORKTIME,
'08:00' as MAX_OVERTIME_WORK_HOURS,
'1' as RESOURCE_TYPE,
'0' as PRELOADED_START_PLAN,
'1' as PRELOADED_END_PLAN,
'' as SKIP_START_LOCATION,
'' as SKIP_END_LOCATION,
'' as MAX_VOLUME,
'9999' as MAX_PIECES,
'9999' as MAX_SIZE3,
'1' as ALL_DEPOTS_ALLOWED,
'' as DEPOT1,
'' as DEPOT2,
'' as DEPOT3,
'' as DEPOT4,
'' as DEPOT5,
'' as FIXED_COSTS,
'' as COST_PER_KM,
'' as COST_PER_HOUR,
'' as COST_PER_HOUR_OVERTIME,
'1' as SPEED_CORRECTION_FACTOR,
'0' as PRIORITY,
'' as TERRITORY,
'180101' as STARTDATE,
DEPARTMENT_CODE,
'11' as RESOURCE_KIND_CODE,
'' as START_LOC_ID,
'' as END_LOC_ID,
'' as USE_FIXED_START,
'00:00' as FIXED_START_AMPL,
'00:00' as FIXED_START_TIME,
'0' as HELPER_REQ,
'' as MAX_TRIP_TIME,
'20' as COUPLE_TIME,
'20' as DECOUPLE_TIME,
'0' as UNIT_NUMBER,
'END' as END
 from deptresource where department_code='OSL2' and name not in (select name from RESOURCES_OSL2);
 
.header on
.output stdout


drop table if exists RESOURCES_OSL3;
.import Resourcesbasis\\RESOURCES_OSL3.csv RESOURCES_OSL3
.header on
.output Converted20191017\\OSL3\\mRESOURCES_OSL3.csv
.header on
select * from RESOURCES_OSL3;
.header off
select  RESOURCE_ID,
NAME,
'' as ADRES1,
'' as POSTAL_CODE1,
'' as CITY1,
'' as COUNTRYNR1,
'' as COUNTRYCODE1,
'' as XSTRING1,
'' as YSTRING1,
'' as ADRES2,
'' as POSTAL_CODE2,
'' as CITY2,
'' as COUNTRYNR2,
'' as COUNTRYCODE2,
'' as XSTRING2,
'' as YSTRING2,
'08:00' as START_NORMAL_WORKTIME,
'16:00' as END_NORMAL_WORKTIME,
'08:00' as MAX_NORMAL_WORK_HOURS,
'08:00' as START_OVERTIME_WORKTIME,
'16:00' as END_OVERTIME_WORKTIME,
'08:00' as MAX_OVERTIME_WORK_HOURS,
'1' as RESOURCE_TYPE,
'0' as PRELOADED_START_PLAN,
'1' as PRELOADED_END_PLAN,
'' as SKIP_START_LOCATION,
'' as SKIP_END_LOCATION,
'' as MAX_VOLUME,
'9999' as MAX_PIECES,
'9999' as MAX_SIZE3,
'1' as ALL_DEPOTS_ALLOWED,
'' as DEPOT1,
'' as DEPOT2,
'' as DEPOT3,
'' as DEPOT4,
'' as DEPOT5,
'' as FIXED_COSTS,
'' as COST_PER_KM,
'' as COST_PER_HOUR,
'' as COST_PER_HOUR_OVERTIME,
'1' as SPEED_CORRECTION_FACTOR,
'0' as PRIORITY,
'' as TERRITORY,
'180101' as STARTDATE,
DEPARTMENT_CODE,
'11' as RESOURCE_KIND_CODE,
'' as START_LOC_ID,
'' as END_LOC_ID,
'' as USE_FIXED_START,
'00:00' as FIXED_START_AMPL,
'00:00' as FIXED_START_TIME,
'0' as HELPER_REQ,
'' as MAX_TRIP_TIME,
'20' as COUPLE_TIME,
'20' as DECOUPLE_TIME,
'0' as UNIT_NUMBER,
'END' as END
 from deptresource where department_code='OSL3' and name not in (select name from RESOURCES_OSL3);
 
.header on
.output stdout


drop table if exists RESOURCES_OSL4;
.import Resourcesbasis\\RESOURCES_OSL4.csv RESOURCES_OSL4
.header on
.output Converted20191017\\OSL4\\mRESOURCES_OSL4.csv
.header on
select * from RESOURCES_OSL4;
.header off
select  RESOURCE_ID,
NAME,
'' as ADRES1,
'' as POSTAL_CODE1,
'' as CITY1,
'' as COUNTRYNR1,
'' as COUNTRYCODE1,
'' as XSTRING1,
'' as YSTRING1,
'' as ADRES2,
'' as POSTAL_CODE2,
'' as CITY2,
'' as COUNTRYNR2,
'' as COUNTRYCODE2,
'' as XSTRING2,
'' as YSTRING2,
'08:00' as START_NORMAL_WORKTIME,
'16:00' as END_NORMAL_WORKTIME,
'08:00' as MAX_NORMAL_WORK_HOURS,
'08:00' as START_OVERTIME_WORKTIME,
'16:00' as END_OVERTIME_WORKTIME,
'08:00' as MAX_OVERTIME_WORK_HOURS,
'1' as RESOURCE_TYPE,
'0' as PRELOADED_START_PLAN,
'1' as PRELOADED_END_PLAN,
'' as SKIP_START_LOCATION,
'' as SKIP_END_LOCATION,
'' as MAX_VOLUME,
'9999' as MAX_PIECES,
'9999' as MAX_SIZE3,
'1' as ALL_DEPOTS_ALLOWED,
'' as DEPOT1,
'' as DEPOT2,
'' as DEPOT3,
'' as DEPOT4,
'' as DEPOT5,
'' as FIXED_COSTS,
'' as COST_PER_KM,
'' as COST_PER_HOUR,
'' as COST_PER_HOUR_OVERTIME,
'1' as SPEED_CORRECTION_FACTOR,
'0' as PRIORITY,
'' as TERRITORY,
'180101' as STARTDATE,
DEPARTMENT_CODE,
'11' as RESOURCE_KIND_CODE,
'' as START_LOC_ID,
'' as END_LOC_ID,
'' as USE_FIXED_START,
'00:00' as FIXED_START_AMPL,
'00:00' as FIXED_START_TIME,
'0' as HELPER_REQ,
'' as MAX_TRIP_TIME,
'20' as COUPLE_TIME,
'20' as DECOUPLE_TIME,
'0' as UNIT_NUMBER,
'END' as END
 from deptresource where department_code='OSL4' and name not in (select name from RESOURCES_OSL4);
 
.header on
.output stdout


drop table if exists RESOURCES_OSL5;
.import Resourcesbasis\\RESOURCES_OSL5.csv RESOURCES_OSL5
.header on
.output Converted20191017\\OSL5\\mRESOURCES_OSL5.csv
.header on
select * from RESOURCES_OSL5;
.header off
select  RESOURCE_ID,
NAME,
'' as ADRES1,
'' as POSTAL_CODE1,
'' as CITY1,
'' as COUNTRYNR1,
'' as COUNTRYCODE1,
'' as XSTRING1,
'' as YSTRING1,
'' as ADRES2,
'' as POSTAL_CODE2,
'' as CITY2,
'' as COUNTRYNR2,
'' as COUNTRYCODE2,
'' as XSTRING2,
'' as YSTRING2,
'08:00' as START_NORMAL_WORKTIME,
'16:00' as END_NORMAL_WORKTIME,
'08:00' as MAX_NORMAL_WORK_HOURS,
'08:00' as START_OVERTIME_WORKTIME,
'16:00' as END_OVERTIME_WORKTIME,
'08:00' as MAX_OVERTIME_WORK_HOURS,
'1' as RESOURCE_TYPE,
'0' as PRELOADED_START_PLAN,
'1' as PRELOADED_END_PLAN,
'' as SKIP_START_LOCATION,
'' as SKIP_END_LOCATION,
'' as MAX_VOLUME,
'9999' as MAX_PIECES,
'9999' as MAX_SIZE3,
'1' as ALL_DEPOTS_ALLOWED,
'' as DEPOT1,
'' as DEPOT2,
'' as DEPOT3,
'' as DEPOT4,
'' as DEPOT5,
'' as FIXED_COSTS,
'' as COST_PER_KM,
'' as COST_PER_HOUR,
'' as COST_PER_HOUR_OVERTIME,
'1' as SPEED_CORRECTION_FACTOR,
'0' as PRIORITY,
'' as TERRITORY,
'180101' as STARTDATE,
DEPARTMENT_CODE,
'11' as RESOURCE_KIND_CODE,
'' as START_LOC_ID,
'' as END_LOC_ID,
'' as USE_FIXED_START,
'00:00' as FIXED_START_AMPL,
'00:00' as FIXED_START_TIME,
'0' as HELPER_REQ,
'' as MAX_TRIP_TIME,
'20' as COUPLE_TIME,
'20' as DECOUPLE_TIME,
'0' as UNIT_NUMBER,
'END' as END
 from deptresource where department_code='OSL5' and name not in (select name from RESOURCES_OSL5);
 
.header on
.output stdout

