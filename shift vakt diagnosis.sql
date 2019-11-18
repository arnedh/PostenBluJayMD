select enhetvakt, ordrenummer, vaktnr, ukedagvakt, prodkat from AlystraShifts sh, alystraprkd pr where sh.prod = pr.prod;

select enhetvakt, ordrenummer, vaktnr, ukedag_vakt, prodkat from AlystraShifts sh, alystraprkd pr where sh.produkt = pr.prod;

select enhetvakt, ordrenummer, ukedag_vakt, prodkat, vaktnr  from AlystraShifts sh, alystraprkd pr where sh.produkt = pr.prod order by enhetvakt, ordrenummer, ukedag_vakt, prodkat;

select * from (select enhetvakt, ordrenummer, ukedag_vakt, prodkat, count(distinct vaktnr) as ct  from AlystraShifts sh, alystraprkd pr where sh.produkt = pr.prod group by enhetvakt, ordrenummer, ukedag_vakt, prodkat order by enhetvakt, ordrenummer, ukedag_vakt, prodkat) where ct>1 order by ct; 

select * from AlystraShifts where enhetordre =973140 and ordrenummer = 552300 and ukedag_vakt = 5;


select * from (select enhetvakt, ordrenummer, ukedag_vakt, count(distinct vaktnr) as ct  from AlystraShifts sh group by enhetvakt, ordrenummer, ukedag_vakt order by enhetvakt, ordrenummer, ukedag_vakt) where ct>1  and ordrenummer is not null order by ct; 

select * from AlystraShifts where enhetvakt =973227 and ordrenummer is null and ukedag_vakt = 4;

select count(*) from (select distinct enhetvakt, ordrenummer from (select enhetvakt, ordrenummer, ukedag_vakt, count(distinct vaktnr) as ct  from AlystraShifts sh group by enhetvakt, ordrenummer, ukedag_vakt order by enhetvakt, ordrenummer, ukedag_vakt) where ct>1  and ordrenummer is not null order by ct);

select * from (select enhetvakt, ordrenummer, ukedag_vakt, count(distinct vaktnr) as ct  from AlystraShifts sh group by enhetvakt, ordrenummer, ukedag_vakt order by enhetvakt, ordrenummer, ukedag_vakt) where ct>10  order by ct; 
