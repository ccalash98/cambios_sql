CREATE OR REPLACE FUNCTION "public"."sp_lotes_productos_web_dev"("an_cod_empr" int4, "an_cod_sucu" int4, "an_cod_bode" int4, "ada_feci" date, "ada_fecf" date, "as_cod_prod" varchar, "as_cod_pro2" varchar, "as_cos_prod" varchar, "in_user" int4, "busqueda" text=''::text)
  RETURNS "pg_catalog"."varchar" AS $BODY$


declare msn2 varchar(10);
ln_linp_i INTEGER;
ln_linp_f INTEGER;
ln_grpr_i INTEGER;
ln_grpr_f INTEGER;
ln_cate_i INTEGER;
ln_cate_f INTEGER;
ln_marc_i INTEGER;
ln_marc_f INTEGER;
cpro CHAR ( 35 );
fecha DATE;
lda_fecf DATE;
fela DATE;
fcad DATE;
fac_prov CHAR ( 20 );
tipo CHAR ( 1 );
dtra CHAR ( 3 );
lotes CHAR ( 35 );
cant DECIMAL ( 18, 6 );
A1 DECIMAL ( 18, 6 );
costo DECIMAL ( 18, 6 );
cost_prom DECIMAL ( 18, 6 );
msn VARCHAR ( 100 );
prod_cod VARCHAR ( 255 );
prod_nom VARCHAR ( 255 );
BEGIN
	
	
	
	cost_prom := 0;
	costo := 0;
	prod_nom := '';
	prod_cod := '';
	msn := '';
	fcad := now();
	fela := now();
	lda_fecf := now();
	fecha := now();
	
	
	
	DELETE 
	FROM
		tmp_prod_lote_web 
	WHERE
		user_cod_web = in_user;
		

for cant, lotes, fela, fcad, prod_cod, prod_nom, costo, cost_prom 
in SELECT
case 
	when dmov_bod_envi <> an_cod_bode then -dmov_can_dmov
	Else 
			case defi_tip_defi
	when '0' then dmov_can_dmov
	when '1' then - dmov_can_dmov
	when '5' then  dmov_can_dmov
	when '6' then dmov_can_dmov
end 
end as dmov_can_dmov,
		TRIM(dmov_cod_lote),
		dmov_ela_lote,
		dmov_cad_lote,
		prod_cod_prod,
		prod_nom_prod,
		prbo_uco_prod,
		prbo_uco_prod 
	FROM
		saeprbo,
		saeprod,
		saedmov,
		saeminv,
		saetran,
		saedefi 
	WHERE
		prbo_cod_prod = prod_cod_prod 
		AND prbo_cod_empr = prod_cod_empr 
		AND prbo_cod_sucu = prod_cod_sucu 
		AND prod_cod_prod = dmov_cod_prod 
		AND prod_cod_empr = dmov_cod_empr 
		AND dmov_num_comp = minv_num_comp 
		AND dmov_num_prdo = minv_num_prdo 
		AND dmov_cod_empr = minv_cod_empr 
		AND dmov_cod_ejer = minv_cod_ejer 
		AND minv_cod_tran = tran_cod_tran 
		AND minv_cod_empr = tran_cod_empr 
		AND minv_cod_modu = tran_cod_modu 
		AND tran_cod_tran = defi_cod_tran 
		AND tran_cod_empr = defi_cod_empr 
		AND tran_cod_modu = defi_cod_modu 
		AND prbo_cod_bode = an_cod_bode 
		AND prbo_cod_empr = an_cod_empr 
		AND prbo_cod_sucu = an_cod_sucu 
		AND prbo_cos_prod = as_cos_prod 
		AND dmov_cod_lote NOT LIKE'' 
		AND dmov_can_dmov > 0 
		and (prod_cod_prod between as_cod_prod and as_cod_pro2 OR prod_cod_alterno between as_cod_prod and as_cod_pro2)
		AND dmov_cod_bode = an_cod_bode
		AND minv_fmov BETWEEN ada_feci 
		AND ada_fecf 
		AND minv_cod_empr = an_cod_empr 
    and dmov_cod_lote like '%'||busqueda||'%'
		AND defi_tip_defi IN ( '0', '1', '5', '6' )
		union all

select 
case defi_tip_defi
	when '0' then dmov_can_dmov
	when '1' then  -dmov_can_dmov
	when '5' then  dmov_can_dmov
	when '6' then dmov_can_dmov
end dmov_can_dmov,  TRIM(dmov_cod_lote), dmov_ela_lote, dmov_cad_lote, prod_cod_prod, prod_nom_prod, prbo_uco_prod, prbo_cos_prom
from saeprbo, saeprod, saedmov, saeminv,saetran, saedefi
where prbo_cod_prod = prod_cod_prod
and prbo_cod_empr = prod_cod_empr
and prbo_cod_sucu = prod_cod_sucu
and prod_cod_prod = dmov_cod_prod
and prod_cod_empr = dmov_cod_empr
and dmov_num_comp = minv_num_comp
and dmov_num_prdo= minv_num_prdo
and dmov_cod_empr = minv_cod_empr
and dmov_cod_ejer = minv_cod_ejer
and minv_cod_tran = tran_cod_tran
and minv_cod_empr = tran_cod_empr
and minv_cod_modu = tran_cod_modu
and tran_cod_tran = defi_cod_tran
and tran_cod_empr = defi_cod_empr
and tran_cod_modu = defi_cod_modu
and prbo_cod_bode = an_cod_bode
and prbo_cod_empr = an_cod_empr
and prbo_cod_sucu = an_cod_sucu
and prbo_cos_prod = as_cos_prod
and dmov_can_dmov > 0 and dmov_cod_lote not like ''
and (prod_cod_prod between as_cod_prod and as_cod_pro2 OR prod_cod_alterno between as_cod_prod and as_cod_pro2)
and dmov_bod_envi = an_cod_bode
and minv_fmov BETWEEN ada_feci  AND ada_fecf
and minv_cod_empr = an_cod_empr
and dmov_cod_lote like '%'||busqueda||'%'
and defi_tip_defi in ('0','1','5','6')
		loop 
		
		
		insert into tmp_prod_lote_web ( empr_cod_empr , sucu_cod_sucu , prod_cod_prod , bode_cod_bode , fecha_ini,  fecha_fin,  
				             user_cod_web,  cant_lote , num_lote , fecha_ela_lote , fecha_cad_lote,
 				            prod_nom_prod, costo, costo_prom   )
				values( an_cod_empr,an_cod_sucu, prod_cod, an_cod_bode,  ada_feci , ada_fecf ,            
				in_user, cant , lotes , fela,  fcad, prod_nom, costo, cost_prom );
				
				
		end loop;
		
				
msn2 := 'OK';
return msn2;
	
END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

ALTER FUNCTION "public"."sp_lotes_productos_web_dev"("an_cod_empr" int4, "an_cod_sucu" int4, "an_cod_bode" int4, "ada_feci" date, "ada_fecf" date, "as_cod_prod" varchar, "as_cod_pro2" varchar, "as_cos_prod" varchar, "in_user" int4, "busqueda" text) OWNER TO "sisconti";