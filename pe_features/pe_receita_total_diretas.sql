create table analise_corrupcao_cluster.licit_rec_anual_diretas as
( 
	select cnpj,			
			        round(sum(case when ano = 2009 then total else 0 end)) as receita_09,
			        round(sum(case when ano = 2010 then total else 0 end)) as receita_10,
			        round(sum(case when ano = 2011 then total else 0 end)) as receita_11,
			        round(sum(case when ano = 2012 then total else 0 end)) as receita_12,
			        round(sum(case when ano = 2013 then total else 0 end)) as receita_13,
			        round(sum(case when ano = 2014 then total else 0 end)) as receita_14,
			        round(sum(case when ano = 2015 then total else 0 end)) as receita_15,
			        round(sum(case when ano = 2016 then total else 0 end)) as receita_16,
			        round(sum(case when ano = 2017 then total else 0 end)) as receita_17
			        --round(sum(total)) as total
			from(
					select distinct(numerodocumentoajustado) as cnpj, 
						   anoprocesso as ano,
					       --sum(totaladjudicadolicitante) over (partition by anoprocesso) as total
					       totaladjudicadolicitante as total
					from analise_corrupcao_cluster.sca_licitacoesdetalhes
					where adjudicada = 'Vencedor' 
						and qtdelicitantes = 1 
						and nomemodalidade != 'Inexigibilidade' 
						and nomemodalidade != 'Dispensa'
						--and numerodocumentoajustado='08201104000176'
					group by 1,2,3
			    ) s
			group by cnpj
			--order by total desc
		)

