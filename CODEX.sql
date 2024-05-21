*CONTRASEÑA

SIS-WIFI
Bucky-32@.ec

select * from contrato_clpv WHERE ruc_clpv like '%90000001%'

*revisar secuenciales

select * from contrato_clpv where id_sucursal = '2'

*aceceder al proyecto

select * from int_tipo_cobro where id_sucursal = '2'

*TIPO DE COBRO

select * from int_rutas where id_sucursal = '2'

*busqueda rutas

UPDATE isp.contrato_clpv SET tipo_contrato_de_cobro = 'POSTPAGO' WHERE id = 36659

*realizar update

UPDATE contrato_clpv SET tipo_contrato_de_cobro = 'POSTPAGO' WHERE ID_EMPRESA = '1'

*REALIZAR UPDATE POR FILAS

SELECT * FROM SAEEMPR

*BUSQUEDA DE EMPRESA

select * from saesucu

*busqe. sucursales

SELECT * FROM saefact

*busqueda de facturas

SELECT * FROM saefpag

*busqueda formas de pago

delete from saedfac

*borrar filas 

select * from int_paquetes

*lista de planes

SELECT * FROM SAEDMOV

*DET MOV INVT

delete from saeminv

*borrar mov inv

select * from saeppr

*ver precio producto

select * from saebode

*buscar bode ( revisar nro de bodega)

select * from saeppr where ppr_cod_bode = '3'

*buscar dentro de la bodega

delete from saeppr where ppr_cod_bode = '3'

*borrar los precios de la bodega selecionada

select * from saedncr

*preguntar que es

select * from saeprbo where prbo_cod_bode = '3'

* buscar productos de la bodega

delete from saeprbo where prbo_cod_bode = '3'

* borrar los productos de la bodega selecionada

select * from instalacion_clpv

*ver las ordenes de trabajo

select * from instalacion_ejecucion

*ver las ordenes de ejecucion

SELECT * FROM saesubo

*cambiar sucursales almacen

select * from int_tipo_proceso

*tabla de ordenes de trabajo


select * from int_tipo_proceso ORDER BY id

*ordenar por id

ORDER BY id

*ordenar por = (id)

SELECT * FROM int_contrato_caja WHERE estado = 'P' AND ID_CONTRATO = 21692

ELIMINAR CONTRATOS EN ESTADO PENDIENTE CON FILTRO = P // Y FILTRO PARA BUSCAR ID ESPECIFICO DE CONTRATO

contrato_clpv
SELECT * FROM int_contrato_caja WHERE estado = 'P'
SELECT * FROM int_tipo_proceso WHERE id_actividad = '2'
SELECT * FROM int_motivos_canc ORDER BY motivo
SELECT * FROM int_tipo_proceso ORDER BY DESCRIPCION



SELECT * FROM contrato_clpv
SELECT * FROM saeempr
select * from int_tipo_proceso WHERE DEFECTO = 'S' ORDER BY ID
select * from int_tipo_proceso WHERE visible_sn = 'S' ORDER BY ID
UPDATE int_tipo_proceso SET visible_sn = 'N'
SELECT * from int_tipo_proceso ORDER BY 
SELECT * FROM saebode
select * from saeppr where ppr_cod_bode = '5'
select * from int_paquetes where
select * from config_email
SELECT * from saefact
SELECT * from saeemifa
SELECT * from saefpag




SELECT * from saefact
delete from saedfac
delete from saefact
select * from int_paquetes
delete from int_paquetes
SELECT * FROM saeminv
delete from saeminv
select * from saeppr where ppr_cod_bode = '3'
select * from saeprbo where prbo_cod_bode = '3'
delete from saeprbo where prbo_cod_bode ='3'
select * from saedncr
delete from saedncr
select * from instalacion_clpv
delete from instalacion_clpv
select * from instalacion_ejecucion
delete from instalacion_ejecucion
SELECT * from instalacion_prod
delete from instalacion_prod
DELETE from contrato_clpv where id_sucursal = '1'
delete from contrato_factura
select * from contrato_clpv where id_sucursal = '1'
delete from contrato_clpv where id_sucursal = '1'
delete from contrato_pago
delete from contrato_medio_pago
DELETE FROM contrato_pago_pack
delete from contrato_clpv where id_sucursal = '1'
delete from int_contrato_caja

DELETE FROM saeCLPV
DELETE FROM saeDIRE
DELETE FROM saeEMAI

*comandos para borrar y limpiar los proyectos


saebafp

buscar la tabla click derecho y design tabla y reemplazar

bag_nom_banc

--para insertar plan de cuentas se debe borrar

DELETE from saecuen;
delete from saesald;


--BORRAR TRANSACCIONES 

DELETE FROM saepgs
SELECT * from comercial.plantilla_clpv ORDER BY id ASC



(1239, '0100', 'Gestion WS', 'app_menu.php', 'menu', 'ico_nuevo.png', 'Gestión WS', 'Gestión WS', 'S', '110000000000000010000100000000', 2, 'D', 0, 'O', 'C'),
(1240, '010001', 'Olt', 'int_ws_olt/olt.php', 'main', 'ico_nuevo.png', 'OLT', 'OLT', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
(1242, '010003', 'Vinculo Olt - Router', 'int_ws_olt_router/olt_router.php', 'main', 'ico_nuevo.png', 'Vinculo Olt - Router', 'Vinculo Olt - Router', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
(1241, '010002', 'Router', 'int_ws_router/router.php', 'main', 'ico_nuevo.png', 'Router', 'Router', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
(1243, '010004', 'Onus', 'int_activar_equipo/activacion.php', 'main', 'ico_nuevo.png', 'Onus', 'Onus', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
(1244, '010004', 'Tareas programadas', 'int_ws_tareas/tareas.php', 'main', 'ico_nuevo.png', 'Tareas programadas', 'Tareas programadas', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C')

--////// 2 likes o mas

SELECT * 
FROM comercial.menu_rd 
WHERE menu_nombre LIKE '%Ejecucion Inci%' OR menu_nombre LIKE '%Productividad Inci%';

--///// tipo de documento para el envio masivo ///--

INSERT INTO comercial.doc_time (id_time, documento, time, estado, centro_costos, tipo) VALUES (20, 'CORREOS MASIVOS', 4, 'S', 'N', 'E');



--///// validacion de inserts if exists


INSERT INTO comercial.menu_rd (menu_id, menu_codigo, menu_nombre, menu_link, menu_target, menu_imagen, menu_ayuda_titulo, menu_ayuda_texto, menu_activo, menu_perfil, menu_orden, menu_tipo, menu_conti, menu_tip_rd, menu_cont_adm) 
SELECT * FROM (
    VALUES 
    (9990, '010806', 'Ejecucion Incidencia', 'asignar_incidencia/registro.php', 'main', 'ico_nuevo.png', 'Registro Ticket', 'Registro Ticket', 'S', '111111000000000110010100000000', 1, 'M', 0, 'L', 'C'),
    (9991, '010807', 'Productividad Incidencias', 'int_rep_incidencia/registro.php', 'main', 'ico_nuevo.png', 'Productividad Incidencias', 'Productividad Incidencias', 'S', '111010000001000010000000000000', 1, 'M', 0, 'L', 'C'),
    (9992, '010808', 'Conceptos-Clasificaciones', 'int_ccpt_mtv/registro.php', 'main', 'ico_nuevo.png', 'Conceptos-Clasificaciones', 'Conceptos-Clasificaciones', 'S', '110000000001000010000000000000', 1, 'M', 0, 'L', 'C'),
    (501003, '-00106', 'Productividad', 'dashboard_produ/dashboard.php', 'main', 'fa fa-tachometer', 'Productividad', 'Productividad', 'S', '110011000010010000000000000000', 1, 'M', 0, 'L', 'C'),
    (1239, '0100', 'Gestion WS', 'app_menu.php', 'menu', 'ico_nuevo.png', 'Gestión WS', 'Gestión WS', 'S', '110000000000000010000100000000', 2, 'D', 0, 'O', 'C'),
    (1240, '010001', 'Olt', 'int_ws_olt/olt.php', 'main', 'ico_nuevo.png', 'OLT', 'OLT', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
    (1242, '010003', 'Vinculo Olt - Router', 'int_ws_olt_router/olt_router.php', 'main', 'ico_nuevo.png', 'Vinculo Olt - Router', 'Vinculo Olt - Router', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
    (1241, '010002', 'Router', 'int_ws_router/router.php', 'main', 'ico_nuevo.png', 'Router', 'Router', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
    (1243, '010004', 'Onus', 'int_activar_equipo/activacion.php', 'main', 'ico_nuevo.png', 'Onus', 'Onus', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
    (1244, '010004', 'Tareas programadas', 'int_ws_tareas/tareas.php', 'main', 'ico_nuevo.png', 'Tareas programadas', 'Tareas programadas', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C')
) AS data
WHERE NOT EXISTS (
    SELECT 1 FROM comercial.menu_rd WHERE menu_id = data.column1
);


--////// cambiar las nc y fac cuando estan mal los valores

SELECT * from public.saencre WHERE ncre_num_preimp like '%000000029%';
SELECT * from public.saedncr where dncr_cod_ncre = 15;
SELECT * from public.saedmcc WHERE dmcc_cod_tran like '%NDC%'AND dmcc_num_fac like '%001FEGC-000001469-000%';