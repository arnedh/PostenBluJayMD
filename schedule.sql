alystra

principal,address,amount, day,time,

amphora
principal,address,amount, mondaytime,tuesdaytime...

blujay
principal, address, amount, time, ismonday, istuesday...





create table basis as 
select p, a, a, 1 as day, mondaytime as time from amphora
union select p, a, a, 2 as day, tuesdaytime as time from amphora
union ...
union select principal,address,amount, day,time from alystra

create table basis2 as select groupconcat(day) as grp 
from basis 
group by principal,address,amount,time

.once bigresult
select *, includes(grp,1) as ismonday,includes(grp,2) as istuesday,



