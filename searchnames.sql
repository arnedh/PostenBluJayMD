.mode csv
.separator ";"

drop table UsedSearchnames;
.import "UsedSearchnames.csv" UsedSearchnames    
select *, substr(searchName,1, length(searchName)-4), cast(substr(searchName,length(searchName)-3, 4)as integer) from UsedSearchNames

---highwater mark for searchnames, can join later and add number within subrange

all address sources 
select count(*) as points, <fields> from <table> group by <fields>


basis = select aid, busid, score, fields.... from addresses
was

washed = select aid, busid, score, fields, washid, newfields, quality

select max(score) within busid

washed+bus = busid, washid, newfields, searchname (from business)
washed+search = washid, newfields, new searchname


join washid back to aid or via adress fields




