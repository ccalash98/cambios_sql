delete from saesubo where subo_cod_bode = '13';
delete from saeppr where ppr_cod_bode = '13';
delete from saecost where cost_cod_bode = '13';
delete from saecost where cost_cod_bode = '13';
delete from saedmov where dmov_cod_bode = '13';
delete from saeprbo where prbo_cod_bode = '13';
DELETE FROM public.saebode WHERE bode_cod_bode = 13 AND bode_cod_empr = 1;
::borrar un almacen completo en 13 va el codigo de bodega y en 1 el nro de empresa::

delete from saeppr where ppr_cod_bode = '3';
delete from saecost where cost_cod_bode = '3';
delete from saecost where cost_cod_bode = '3';
delete from saedmov where dmov_cod_bode = '3';
delete from saeprbo where prbo_cod_bode = '3';
SELECT * FROM saebode;

:: borrar productos de una bodega 3 hace referencia  a la bodega 


SELECT * FROM saebode where bode_cod_bode = '2'
SELECT * from saeprbo where prbo_cod_bode = '2'
SELECT * from saeppr where ppr_cod_bode = '2'
SELECT * FROM saesubo where subo_cod_bode = '2'
SELECT * FROM saebode ORDER BY bode_cod_bode

:: revisar bodegas


SELECT CONCAT(a.id,',') FROM isp.contrato_pago a INNER JOIN isp.contrato_clpv b ON a.id_contrato = b.id where a.estado = 'CO' AND b.estado = 'AP'


update isp.contrato_pago set estado = 'PE' where id in (201820,
201819)


SELECT * FROM contrato_pago where id_contrato = 29331


select * from contrato_pago where valor_no_uso is null

SELECT * from saefact WHERE fact_num_preimp = '000000005'

SELECT * FROM saebode
SELECT * from saeprbo where prbo_cod_bode in (
1,
2, 
3,
4,
5,
6,
7)

::BUSCAR , ACTYUALIZAR Y DISCRIMINAR::


SELECT * FROM int_audi_impo_contr_det
SELECT * FROM int_audi_impo_contr

::buscar historial de contratos::

delete from int_audi_impo_contr_det;
delete from int_audi_impo_contr;
SELECT * FROM int_audi_impo_contr;
::borrar historial de contratos::

tablas relacionadas a int_tipo_proceso

NOTICE:  truncate cascades to table instalacion_clpv
NOTICE:  truncate cascades to table instalacion_tecnico
NOTICE:  truncate cascades to table int_tipo_proceso_clave --claves
NOTICE:  truncate cascades to table int_tipo_proceso_serv  --vacio
NOTICE:  truncate cascades to table instalacion_ejecucion
NOTICE:  truncate cascades to table instalacion_ejecucion_audi
NOTICE:  truncate cascades to table instalacion_materiales
NOTICE:  truncate cascades to table instalacion_prod

--realiza un reinicio a la generacion del id //tomar en cuenta el numero ultimo de generacion

ALTER TABLE isp.instalacion_ejecucion_audi 
ALTER COLUMN id_ejec_audi RESTART WITH 13;

--SELECT * FROM pais_etiq_contr
--SELECT * FROM saecant
--SELECT * FROM saeprov
--SELECT * FROM saeciud
--SELECT * FROM saeparr
--truncate isp.int_motivos_canc RESTART IDENTITY CASCADE;

--borrar tablas para configurar rubros peru

DELETE from saecten;
DELETE from saevari;
DELETE from saeeps;
DELETE from saeafpt;
DELETE from saeafp;
DELETE from saepdie;
DELETE from saepemp;
DELETE from saepnom;
DELETE FROM saetpre;
DELETE from saerubr;

SELECT * from comercial.usuario where usuario_id = 213

SELECT * from public.tmp_prod_lote_web where user_cod_web = 213

BEGIN;
DELETE from public.tmp_prod_lote_web where user_cod_web = 213;
COMMIT;

--realizar doble set de serie y secuencial en las notas de credito
UPDATE public.saencre SET ncre_nse_ncre = () and  ncre_num_preimp = () WHERE ncre_cod_ncre = ()

--realiza la validacion para el despliegue de los proyectos para que permita la anulacion
DROP TABLE IF EXISTS saeminv_an;
CREATE TABLE saeminv_an AS TABLE saeminv;

DROP TABLE IF EXISTS saedmov_an;
CREATE TABLE saedmov_an AS TABLE saedmov;

--///// TIPO DOC ////
select * from comercial.tipo_iden_clpv


INSERT INTO isp.int_archivos_cash_config (id_archivo, id_empresa, clave, valor, fecha_server) VALUES (11, 1, 'codigo_solicitud', '01', '2023-11-08 13:50:15.751783');
INSERT INTO isp.int_archivos_cash_config (id_archivo, id_empresa, clave, valor, fecha_server) VALUES (11, 1, 'tipo_operacion', 'M', '2023-11-08 14:33:58.282612');
INSERT INTO isp.int_archivos_cash_config (id_archivo, id_empresa, clave, valor, fecha_server) VALUES (11, 1, 'interbank_recaudo', '4502332', '2023-11-08 19:44:28.169459');
INSERT INTO isp.int_archivos_cash_config (id_archivo, id_empresa, clave, valor, fecha_server) VALUES (11, 1, 'tipo_formato', '02', '2023-11-08 20:11:31.983642');
INSERT INTO isp.int_archivos_cash_config (id_archivo, id_empresa, clave, valor, fecha_server) VALUES (11, 1, 'DETALLE_LOTES', 'INTERBANK RECAUDO', '2023-11-14 19:01:48.400266');
INSERT INTO isp.int_archivos_cash_config (id_archivo, id_empresa, clave, valor, fecha_server) VALUES (11, 1, 'codigo_rubro', '03', '2023-11-08 13:49:03.065888');
INSERT INTO isp.int_archivos_cash_config (id_archivo, id_empresa, clave, valor, fecha_server) VALUES (11, 1, 'codigo_empresa', '160', '2023-11-08 13:49:28.290522');
INSERT INTO isp.int_archivos_cash_config (id_archivo, id_empresa, clave, valor, fecha_server) VALUES (11, 1, 'codigo_servicio', '01', '2023-11-08 13:50:01.150119');


--agregar columna a bdd

ALTER TABLE comercial.tipo_iden_clpv_pais ADD COLUMN codigo_libro varchar;


--ubicar series
SELECT dmov_can_dmov,dmov_cod_tran,dmov_cod_lote,* from public.saedmov where dmov_cod_bode = 2 and dmov_cod_prod = 'ROU007' and dmov_cod_lote like '%ZTEGD36707F6%';
SELECT * from public.saetran where tran_cod_tran in('007', '009');


SELECT id,ruc_clpv from isp.contrato_clpv ORDER BY id asc;
SELECT clpv_cod_clpv,clpv_ruc_clpv from public.saeclpv where clpv_clopv_clpv = 'CL' ORDER BY clpv_cod_clpv asc;

-- buscar la suscripccion del cliente
SELECT * from isp.int_suscribir where id_contrato =1033;
SELECT suscripcion,*from isp.contrato_clpv where id =1033;

busqueda lote
SELECT dmov_can_dmov,dmov_cod_tran,dmov_cod_lote,dmov_cod_serie,* from public.saedmov where dmov_cod_bode != 0 and dmov_cod_prod = '33' and dmov_cod_lote = '0';

SELECT * from public.saebode where bode_cod_bode = 31


---borrar asiento contable ---

SELECT * FROM PUBLIC.saeasto where asto_cod_asto = '0060100000001';
SELECT * from public.saedasi where asto_cod_asto = '0060100000001';
SELECT * from public.saedmcp WHERE dmcp_cod_asto = '0060100000001';
SELECT * from public.saedir where dire_cod_asto = '0060100000001';
SELECT * from public.saeret where rete_cod_asto = '0060100000001';
SELECT * from public.saetloc where tloc_cod_asto = '0060100000001';


--BORRAR PRODUCTO--

select * from public.saeprod WHERE prod_cod_prod like '%MAT097%';
SELECT * from public.saeprbo where prbo_cod_prod like '%MAT097%';
SELECT * from public.saecost where cost_cod_prod like '%MAT097%';
SELECT * from public.saeppr WHERE ppr_cod_prod like '%MAT097%';
SELECT * from public.saedmov WHERE dmov_cod_prod like '%MAT097%';

--linea //grupo//categoria//marca

SELECT * FROM PUBLIC.saelinp;
SELECT * from public.saegrpr;
SELECT * from public.saecate;
SELECT * from public.saemarc;

---/// verificar prestamos ////---

SELECT * from saepret where pret_cod_empl = '1716339468'

SELECT *from saecuot where cuot_cod_pret = '010100038'

SELECT * from saepago where pago_cod_empl = '1716339468' AND pago_per_pago = '202405' 


--/////

SELECT ruc_clpv, nom_clpv, codigo,id_clpv
FROM isp.contrato_clpv 
WHERE id IN (
    SELECT id_contrato 
    FROM isp.contrato_pago 
    WHERE id_contrato NOT IN (
        SELECT id_contrato 
        FROM isp.contrato_pago 
        WHERE fecha = '2024-04-30'
    ) 
    AND fecha > '2024-04-30'
)
and estado IN ('AP')
and fecha_instalacion <= '2024-03-31'
ORDER BY id;

--//////// formato cancelacion de facturas ///////

INSERT INTO public.saeftrn(ftrn_cod_ftrn, ftrn_cod_empr, ftrn_des_ftrn, ftrn_ubi_ftrn, ftrn_cod_modu, ftrn_tip_movi, ftrn_ubi_web) VALUES (51, 1, 'RECIBO CANCELACION', '', 7, NULL, 'Include/Formatos/comercial/GlobalFiber/recibo_cancelacion.php');

--/////// prov //////
SELECT
    CONCAT('{
		"prov_cod_prov":', prov_cod_prov,
			',"prov_des_prov": "', prov_des_prov,
			'","pais_codigo_inter": "51",
        "country_id": 173,
        "prov_cod_pais": "28",
        "country_name": "Peru",
        "state_code": "PE",
    },') AS prov_jason
FROM
    public.saeprov;

--/////// cant ////////////
SELECT
    CONCAT('{
		"prov_cod_prov":', cant_cod_prov,
		',"cant_cod_cant":', cant_cod_cant,
			',"cant_des_prov": "', cant_des_cant,
			'","pais_codigo_inter": "51",
        "country_id": 173,
        "prov_cod_pais": "28",
        "country_name": "Peru",
        "state_code": "PE",
    },') AS prov_jason
FROM
    public.saecant;

--/////// busqueda columnas ////

SELECT 
    parr_des_parr,
    (
        SELECT cant_cod_char 
        FROM saecant 
        WHERE cant_cod_cant = saeparr.parr_cod_parr
    ) AS cant_cod_char,
		    (
        SELECT cant_cod_char 
        FROM saeprov 
        WHERE cant_cod_cant = saeparr.parr_cod_parr
    ) AS prov_cod_char
FROM 
    saeparr;


--/////// ciud ////
BEGIN;
	INSERT 
    INTO 
    public.olts (id_red, id_marca, id_modelo, id_software, nombre, descripcion, habilitado, fecha_creado, fecha_modificado )
    VALUES(
	(1, 2, 4, 1, 'CHIMA61', 'CHIMA61', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'CHIMA78', 'CHIMA78', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'CHIMA62', 'CHIMA62', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'GEPONVESALIUS40', 'GEPONVESALIUS40', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'GEPONPERIFERICA2', 'GEPONPERIFERICA2', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'GEPONPERIFERICA1', 'GEPONPERIFERICA1', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'GEPONARM15', 'GEPONARM15', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'CHIMA46', 'CHIMA46', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'CHIMA45', 'CHIMA45', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'HUAWEI42', 'HUAWEI42', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'PLANETLAJA', 'PLANETLAJA', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'PLANETTAMBILLO', 'PLANETTAMBILLO', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' ),
    (1, 2, 4, 1, 'PLANETTIAHUANACO', 'PLANETTIAHUANACO', 't', '2024-05-30 15:42:59+00', '2024-05-30 15:42:59+00' )
    );
COMMIT;

---EXTRAER CIUDAD
SELECT concat('(',ciud_cod_ciud,', ',ciud_cod_pais,', ','''',ciud_nom_ciud,''', ',ciud_cod_prov,', ',ciud_tip_ciud, ', ''0'', ',ciud_cod_urbano,', ''0''),') from saeciud ORDER BY ciud_cod_ciud asc
SELECT concat('(',parr_cod_parr,', ''',parr_cod_char,''', ',parr_cod_cant,', ','''',parr_des_parr,''', '''', ',parr_zip_code, ',''',parr_cod_ciud,'''),') from saeparr ORDER BY parr_cod_parr asc
