-- crescimento anual

create table analise_corrupcao_cluster.licit_rec_variacao_diretas as 
(
	select cnpj,
		   (receita_10-receita_09)/NULLIF(receita_09,0) as t1009,
		   (receita_11-receita_10)/NULLIF(receita_10,0) as t1110,
		   (receita_12-receita_11)/NULLIF(receita_11,0) as t1211,
		   (receita_13-receita_12)/NULLIF(receita_12,0) as t1312,
		   (receita_14-receita_13)/NULLIF(receita_13,0) as t1413,
		   (receita_15-receita_14)/NULLIF(receita_14,0) as t1514,
		   (receita_16-receita_15)/NULLIF(receita_15,0) as t1615,
		   (receita_17-receita_16)/NULLIF(receita_16,0) as t1716
	from analise_corrupcao_cluster.licit_rec_anual_diretas
	--where cnpj = '35401447000157'
	group by cnpj, 1,2,3,4,5,6,7,8,9
)

-- crescimento acumulado

select cnpj, avg((1+t1009)*(1+t1110)*(1+t1211)*(1+t1312)*(1+t1413)*(1+t1514)*(1+t1615)*(1+t1716)) as acumul
from analise_corrupcao_cluster.licit_rec_variacao_diretas
group by cnpj
order by acumul desc;

-- correcao de zeros

--UPDATE analise_corrupcao_cluster.licit_rec_variacao_diretas
--set        t1009=0
----		   t1110=0
----		   t1211=0
----		   t1312=0
----		   t1413=0
----		   t1514=0
----		   t1615=0
----		   t1716=0
--where      t1009 IS NULL
----		   t1110 IS NULL
----		   t1211=NULL
----		   t1312=NULL
----		   t1413=NULL
----		   t1514=NULL
----		   t1615=NULL
----		   t1716=NULL
