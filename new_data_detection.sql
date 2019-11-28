select distinct AGENT_NR from AmphoraTrips where AGENT_NR not in (select agent_nr from AmphoraDepts);

select distinct PRGR_KODE from AmphoraTrips where PRGR_KODE not in (select PRGR_KODE from amphoraprgr);

select distinct produkt from AlystraShifts where produkt not in (select prod from alystraprkd);

select distinct lastb from AlystraShifts where lastb not in (select lastb from LastbPackage);

select distinct enhetvakt from AlystraShifts where enhetvakt not in (select enhetvakt from AmphoraDepts);

select distinct type_fra from AlystraShifts where type_fra not in (select type from typer);

select distinct type_til from AlystraShifts where type_til not in (select type from typer);

select distinct Standard_term from PreCustomer where Standard_term not in (select Standard_term from terms);

select distinct * from AlystraShifts where type_fra not in (select type from typer) or type_til not in (select type from typer);

select distinct at.PRGR_KODE, ap.*  from AmphoraTrips at, amphoraprgr ap where at.PRGR_KODE = ap.PRGR_KODE;