---export from BluJay
drop table if exists UsedSearchNames;
.import "UsedSearchNames.csv" UsedSearchNames

drop table if exists bannedIds;
.import "bannedIds.csv" bannedIds
