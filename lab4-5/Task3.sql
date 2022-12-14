use torg_firm
select count(*) from tovar
select count(*) from sotrudnik
select count(*) from postachalnik


select zakaz_tovar.id_zakaz, tovar.Nazva, zakaz.date_naznach,
zakaz_tovar.Kilkist
from (tovar  join zakaz_tovar ON tovar.id_tovar =
	zakaz_tovar.id_tovar)join zakaz  ON zakaz.id_zakaz = zakaz_tovar.id_zakaz
where zakaz.date_naznach between ('2022-11-1') and ('2022-11-30')

select  tovar.Nazva,
SUM(tovar.Price * zakaz_tovar.Kilkist) as TotalPrice
from (tovar  join zakaz_tovar ON tovar.id_tovar =
	zakaz_tovar.id_tovar)join zakaz  ON zakaz.id_zakaz = zakaz_tovar.id_zakaz
where zakaz.date_naznach between ('2002-11-1') and ('2022-11-30')
group by tovar.Nazva

select  postachalnik.Nazva, sum(tovar.Price * zakaz_tovar.Kilkist) as TotalPrice
from (zakaz_tovar join tovar on zakaz_tovar.id_tovar = tovar.id_tovar) join postachalnik on tovar.id_postav = postachalnik.id_postach
group by postachalnik.Nazva

select postachalnik.Nazva, Count(zakaz.id_zakaz) as k_zamovlen
from zakaz_tovar, zakaz, tovar, postachalnik
where zakaz_tovar.id_zakaz = zakaz.id_zakaz and  zakaz_tovar.id_tovar = tovar.id_tovar and tovar.id_tovar = postachalnik.id_postach and tovar.Nazva like 'Молоко'
group by postachalnik.Nazva

select  zakaz.id_zakaz,
avg(tovar.Price * zakaz_tovar.Kilkist)
from  (tovar join zakaz_tovar on tovar.id_tovar = zakaz_tovar.id_tovar) join zakaz on zakaz.id_zakaz = zakaz_tovar.id_zakaz
group by zakaz.id_zakaz

select klient.Nazva,
sum(zakaz_tovar.Kilkist * tovar.id_tovar)
from (tovar  join zakaz_tovar ON tovar.id_tovar =
	zakaz_tovar.id_tovar)join (zakaz join klient on zakaz.id_klient = klient.id_klient)  ON zakaz.id_zakaz = zakaz_tovar.id_zakaz
where klient.City like ('Жит%')
group by klient.Nazva

select postachalnik.Nazva, avg(tovar.Price)
from postachalnik join tovar on tovar.id_postav = postachalnik.id_postach
group by postachalnik.Nazva