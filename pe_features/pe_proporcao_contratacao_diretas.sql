select foo4.ug, round(foo2.t1/(foo2.t1+foo4.t1)::numeric, 2) as ratio, foo2.t1 as licit, foo4.t1 as nlicit
	from(	
	select ug, codigoug, count(codigopl) as t1
		from(
			SELECT ug, codigoug, codigopl, qtdelicitantes
			FROM analise_corrupcao_cluster.sca_licitacoesdetalhes
				where adjudicada = 'Vencedor' 
					and qtdelicitantes = 1 
					and nomemodalidade != 'Inexigibilidade' 
					and nomemodalidade != 'Dispensa'
--					and (ug like '%Câmara%' or ug like '%Prefeitura%')
			group by ug, codigopl, codigoug, qtdelicitantes
			) foo1
		group by ug, codigoug
		) foo2				
  	inner join (select ug, codigoug, count(codigopl) as t1
				from(
					SELECT ug, codigoug, codigopl, qtdelicitantes
					FROM analise_corrupcao_cluster.sca_licitacoesdetalhes
					where qtdelicitantes > 1
					group by ug, codigopl, codigoug, qtdelicitantes
					) foo3
		group by ug, codigoug
		) foo4
		on (foo2.codigoug=foo4.codigoug)
group by foo4.ug, ratio, foo2.t1, foo4.t1
order by ratio desc
