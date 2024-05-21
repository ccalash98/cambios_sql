--insertar incidencias // ordenes estructura isp
--primero procesara la estructura de incidencias
BEGIN;
    --inserta motivo cancelacion / promesa
    DELETE FROM isp.int_motivos_acuerdo;
    INSERT INTO isp.int_motivos_acuerdo (id, acuerdo, estado) VALUES (1, 'SITUACION ECONOMICA', 'A ');
    INSERT INTO isp.int_motivos_acuerdo (id, acuerdo, estado) VALUES (2, 'ACUERDO', 'A ');
    INSERT INTO isp.int_motivos_acuerdo (id, acuerdo, estado) VALUES (3, 'PROMOCION', 'A ');
    INSERT INTO isp.int_motivos_acuerdo (id, acuerdo, estado) VALUES (4, 'OTROS', 'A ');
    --valida que exista los menus
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
    --////VALIDA EL PAIS PARA INSERTAR LOS MENUS CORRESPONDIENTES
    DO $$
    BEGIN
        IF (SELECT pais_des_pais FROM public.saepais WHERE pais_cod_pais IN (SELECT empr_cod_pais FROM public.saeempr) LIMIT 1) = 'ECUADOR' THEN
            INSERT INTO comercial.menu_rd (menu_id, menu_codigo, menu_nombre, menu_link, menu_target, menu_imagen, menu_ayuda_titulo, menu_ayuda_texto, menu_activo, menu_perfil, menu_orden, menu_tipo, menu_conti, menu_tip_rd, menu_cont_adm)
            VALUES (9993, '010809', 'Soluciones Arcotel', 'int_sol_arc/registro.php', 'main', 'ico_nuevo.png', 'Soluciones Arcotel', 'Soluciones Arcotel', 'S', '110000000001000100000000000000', 1, 'M', 0, 'L', 'C');
        END IF;
    END $$;

    --borra las tablas de incidencias
    delete from isp.motivo;
    delete from isp.concepto;
    delete from isp.medio;
    delete from isp.clasificacion;
    --inserta esquema incidencias
    INSERT INTO isp.motivo (id, id_concepto, nombre) VALUES (1, 1, 'RECLAMO');
    INSERT INTO isp.motivo (id, id_concepto, nombre) VALUES (2, 1, 'CONSULTA');
    INSERT INTO isp.motivo (id, id_concepto, nombre) VALUES (3, 1, 'SOPORTE');
    INSERT INTO isp.motivo (id, id_concepto, nombre) VALUES (4, 1, 'OTROS');
    INSERT INTO isp.concepto (id, nombre) VALUES (1, 'INTERNET');
    INSERT INTO isp.concepto (id, nombre) VALUES (2, 'TV');
    INSERT INTO isp.concepto (id, nombre) VALUES (3, 'DUO');
    INSERT INTO isp.concepto (id, nombre) VALUES (4, 'OTROS');
    INSERT INTO isp.medio (id, nombre) VALUES (1, 'OFICINA');
    INSERT INTO isp.medio (id, nombre) VALUES (2, 'CALL CENTER');
    INSERT INTO isp.medio (id, nombre) VALUES (3, 'SOPORTE');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (1, 1, '1', 'INFORMACION INDEBIDA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (2, 1, '1', 'PROMOCIONES', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (3, 1, '1', 'SIN DSCTO PRONTO PAGO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (4, 1, '1', 'SOLICITUD RECONEXION / REACTIVACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (5, 1, '1', 'INCUMPLIMIENTO DE PROMOCION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (6, 1, '2', 'ESTADO DE SERVICIO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (7, 1, '2', 'FACTURACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (8, 1, '2', 'INFORMACION DE OFICINAS', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (9, 1, '2', 'INFORMACION DEL SERVICIO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (10, 1, '2', 'TRAMITES EN OFICINA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (11, 1, '2', 'TRANSFERENCIA CENTRAL TELEFONICA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (12, 1, '3', 'AVERIA MASIVA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (13, 1, '3', 'REINICIO DE ROUTER ', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (14, 1, '3', 'LENTITUD CONSTANTE', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (15, 1, '3', 'LENTITUD EN HORARIO ESPEC.', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (16, 1, '3', 'LENTITUD EN PAG. WEB ESPEC.', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (17, 1, '3', 'PROBLEMAS EN JUEGOS ONLINE', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (18, 1, '3', 'SEÑAL INESTABLE DE WIFI', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (19, 1, '3', 'SIN ACCESO A PAG. WEB ESPEC.', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (20, 1, '3', 'SIN SEÑAL DE INTERNET', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (21, 1, '3', 'SIN SEÑAL WIFI EN ONU', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (22, 1, '3', 'SIN SEÑAL WIFI EN REPETIDOR', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (23, 1, '4', 'OTROS', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (24, 2, '1', 'INFORMACION INDEBIDA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (25, 2, '1', 'PROMOCIONES', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (26, 2, '1', 'SIN DSCTO PRONTO PAGO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (27, 2, '1', 'SOLICITUD RECONEXION / REACTIVACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (28, 2, '1', 'INCUMPLIMIENTO DE PROMOCION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (29, 2, '2', 'ESTADO DE SERVICIO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (30, 2, '2', 'FACTURACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (31, 2, '2', 'INFORMACION DE OFICINAS', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (32, 2, '2', 'INFORMACION DEL SERVICIO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (33, 2, '2', 'TRAMITES EN OFICINA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (34, 2, '2', 'TRANSFERENCIA CENTRAL TELEFONICA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (35, 2, '3', 'AUTOPROGRAMACION DE CANALES', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (36, 2, '3', 'AVERIA MASIVA DE CABLE', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (37, 2, '3', 'ESCALADO A RDC', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (38, 2, '3', 'SEÑAL INESTABLE DE CABLE', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (39, 2, '3', 'SEÑAL PIXELADA DE CABLE', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (40, 2, '3', 'SIN AUDIO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (41, 2, '3', 'SIN CANALES HD', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (42, 2, '3', 'SIN SEÑAL DE CABLE', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (43, 2, '3', 'AVERIA MASIVA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (44, 2, '4', 'OTROS', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (45, 3, '1', 'INFORMACION INDEBIDA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (46, 3, '1', 'PROMOCIONES', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (47, 3, '1', 'SIN DSCTO PRONTO PAGO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (48, 3, '1', 'SOLICITUD RECONEXION / REACTIVACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (49, 3, '1', 'INCUMPLIMIENTO DE PROMOCION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (50, 3, '2', 'ESTADO DE SERVICIO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (51, 3, '2', 'FACTURACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (52, 3, '2', 'INFORMACION DE OFICINAS', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (53, 3, '2', 'INFORMACION DEL SERVICIO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (54, 3, '2', 'TRAMITES EN OFICINA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (55, 3, '2', 'TRANSFERENCIA CENTRAL TELEFONICA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (56, 3, '3', 'AVERIA MASIVA', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (57, 3, '4', 'OTROS', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (58, 4, '1', 'CALIDAD DEL SERVICIO ', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (59, 4, '1', 'VERACIDAD INFORMACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (60, 4, '1', 'ACTUALIZACION DE CORREO ELECTR.', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (61, 4, '1', 'ACTUALIZACION DE TELEFONO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (62, 4, '1', 'CONFIGURACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (63, 4, '2', 'CALIDAD DEL SERVICIO ', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (64, 4, '2', 'VERACIDAD INFORMACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (65, 4, '2', 'ACTUALIZACION DE CORREO ELECTR.', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (66, 4, '2', 'ACTUALIZACION DE TELEFONO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (67, 4, '2', 'CONFIGURACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (68, 4, '3', 'CALIDAD DEL SERVICIO ', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (69, 4, '3', 'VERACIDAD INFORMACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (70, 4, '3', 'ACTUALIZACION DE CORREO ELECTR.', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (71, 4, '3', 'ACTUALIZACION DE TELEFONO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (72, 4, '3', 'CONFIGURACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (73, 4, '4', 'CALIDAD DEL SERVICIO ', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (74, 4, '4', 'VERACIDAD INFORMACION', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (75, 4, '4', 'ACTUALIZACION DE CORREO ELECTR.', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (76, 4, '4', 'ACTUALIZACION DE TELEFONO', 'GENERAL');
    INSERT INTO isp.clasificacion (id, id_concepto, id_motivo, nombre, tipo_movimiento) VALUES (77, 4, '4', 'CONFIGURACION', 'GENERAL');
COMMIT;
--INSERT ESTRUCTURA DE ORDEN DE TRABAJO
BEGIN TRANSACTION;
    DELETE FROM isp.int_motivos_canc;
    TRUNCATE isp.int_tipo_proceso RESTART IDENTITY CASCADE;
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (1, 3, 'INSTALACION', 'N', 'I', 'glyphicon glyphicon-scissors', 'S', 'pdf_cortes', 5, NULL, NULL, 'S', 'N', 'AP', NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'S', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', NULL);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (2, 1, 'CORTE CONTRATO', 'S', 'C', 'glyphicon glyphicon-scissors', 'N', 'pdf_cortes', 1, 'PC', 'PP', 'S', 'N', 'CO', 'C', 'C', 'S', 'C', 'S', 'N', 'N', 'S', 'N', 'S', 'N', 'fecha_c_corte', NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (4, NULL, 'RECONEXION CONTRATO / N', 'S', 'R', 'glyphicon glyphicon-link', 'N', 'pdf_cortes', 9, 'PR', 'PP', 'S', 'N', 'AP', 'A', 'A', 'S', 'C', 'S', 'S', 'N', 'S', 'N', 'N', 'S', 'fecha_c_reconexion', NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (39, NULL, 'TRASLADOS', 'N', 'T', '<i class=fa-sharp fa-solid fa-truck-fast></i>', 'N', 'pdf_cortes', 0, NULL, NULL, 'S', 'N', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (11, 2, 'RECONEXION PAQUETES', 'N', 'R', 'glyphicon glyphicon-link', 'N', 'pdf_cortes', 9, NULL, 'PP', 'N', 'N', NULL, NULL, 'A', 'S', 'E', 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (12, 1, 'CORTE PAQUETES / N', 'N', 'C', 'glyphicon glyphicon-scissors', 'N', 'pdf_cortes', 1, NULL, 'PP', 'N', 'N', NULL, NULL, 'C', 'S', 'E', 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (13, 1, 'CORTE EQUIPO / N', 'N', 'C', 'glyphicon glyphicon-scissors', 'N', 'pdf_cortes', 1, NULL, 'PP', 'S', 'N', NULL, 'C', 'C', 'S', 'E', 'S', 'S', 'N', 'S', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (14, 2, 'RECONEXION EQUIPO / N', 'N', 'R', 'glyphicon glyphicon-link', 'N', 'pdf_cortes', 9, NULL, 'PP', 'S', 'N', NULL, 'A', 'A', 'S', 'E', 'S', 'S', 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (15, 4, 'RETIRO DE EQUIPO', 'N', 'D', 'glyphicon glyphicon-scissors', 'N', 'pdf_cortes', 13, NULL, 'PP', 'S', 'N', NULL, 'D', 'D', 'S', 'E', 'S', 'S', 'S', 'N', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, tiempo_estimado, op_cambio_equipo) VALUES (42, NULL, 'SOPORTE TV', 'N', '', '<i class=fa-sharp fa-solid fa-tv></i>', 'N', '', 0, NULL, NULL, 'S', 'N', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 0, 'S');
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (21, NULL, 'CAMBIO DE TITULAR', 'N', 'T', 'glyphicon glyphicon-scissors', 'N', 'pdf_cortes', 0, NULL, NULL, 'N', 'N', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'N', 'S', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (27, 2, 'RECONEXION\r\n', 'S', 'R', 'glyphicon glyphicon-link', 'N', 'pdf_cortes', 9, 'PR', 'PP', 'S', 'N', 'AP', 'A', 'A', 'S', 'C', 'S', 'S', 'N', 'S', 'N', 'S', 'S', 'fecha_c_reconexion', NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (53, 1, 'CAMBIO DE TECNOLOGIA', 'S', 'C', 'glyphicon glyphicon-scissors', 'N', 'pdf_cortes', 1, 'PC', 'PP', 'S', 'N', 'CO', 'C', 'C', 'S', 'C', 'S', 'N', 'N', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (40, NULL, 'SUSPENSION CONTRATO', 'S', '', '', 'N', '', 0, NULL, NULL, 'S', 'N', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'S', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (54, NULL, 'SOPORTE INTERNET', 'N', NULL, '<i class=fa-sharp fa-solid fa-globe></i>', 'N', 'pdf_cortes', NULL, NULL, NULL, 'S', 'S', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'S', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (55, NULL, 'RETIRO', 'N', NULL, '', 'N', 'pdf_cortes', NULL, NULL, NULL, 'S', 'S', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'S', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'N', 'S', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (56, NULL, 'REINSTALACION', 'N', NULL, '', 'N', 'pdf_cortes', NULL, NULL, NULL, 'S', 'S', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'S', 'N', 'N', 'N', NULL, NULL, 'S', 'N', 'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (57, NULL, 'MIGRACION', 'N', NULL, '', 'N', 'pdf_cortes', NULL, NULL, NULL, 'S', 'S', NULL, NULL, NULL, 'N', 'C', 'S', 'S', 'N', 'S', 'N', 'N', 'N', NULL, NULL, 'S', 'N', 'N', 'N', 'S', 'N', 'S', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (58, NULL, 'PLANTA EXTERNA', 'N', NULL, '', 'N', 'pdf_cortes', NULL, NULL, NULL, 'S', 'S', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (17, 3, 'INSTALACION EQUIPOS', 'N', 'I', 'glyphicon glyphicon-scissors', 'N', 'pdf_cortes', 5, NULL, 'PP', 'N', 'N', 'AP', 'A', 'A', 'S', 'E', 'S', 'S', 'N', 'S', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, op_cambio_equipo, tiempo_estimado) VALUES (10, 5, 'PAQUETE ADD', 'S', 'R', 'glyphicon glyphicon-phone-alt', 'N', 'pdf_cortes', 2, NULL, 'PP', 'N', 'N', NULL, 'A', 'A', 'S', 'E', 'N', 'N', 'N', 'S', 'N', 'S', 'N', NULL, NULL, 'S', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 'N', 0);
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, aplica_estado_contrato_sn, op_reconexion, op_retiro, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, tiempo_estimado, op_cambio_equipo) VALUES (43, NULL, 'sis', 'N', '', '', 'N', '', 0, NULL, NULL, 'N', 'S', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 0, 'N');
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, aplica_estado_contrato_sn, op_reconexion, op_retiro, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, op_averia, op_anulacion, peso, precio, tiempo_estimado, op_cambio_equipo) VALUES (51, NULL, 'SIS', 'N', '', '', 'N', '', 0, NULL, NULL, 'N', 'S', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 0, '0.00', 0, 'N');
    INSERT INTO isp.int_tipo_proceso (id, id_actividad, descripcion, op_corte, etiqueta, img, defecto, formato, color, estado_contrato, estado_equipo, op_motivo, estado_ejecucion, op_ejecucion, op_equipo, op_plan, op_pago, tipo, dias_consumidos, op_tarifa, op_elimina, tecnico, op_titular, call_center, op_recalculo, campo_fecha_c, op_sucursal, visible_sn, op_reconexion, op_retiro, aplica_estado_contrato_sn, op_instalacion_sn, op_reinstalacion_sn, op_cambio_precio_sn, op_cambio_ip, tiempo_estimado, op_averia, op_anulacion, peso, precio, op_cambio_equipo) VALUES (3, NULL, 'ANULACION', 'N', NULL, '', 'N', 'pdf_cortes', NULL, 'AN', NULL, 'S', 'S', NULL, NULL, NULL, 'N', 'C', 'S', 'N', 'N', 'N', 'N', 'S', 'N', NULL, NULL, 'S', 'N', 'N', 'S', 'N', 'N', 'N', 'N', 0, 'N', 'S', 0, '0.00', 'N');
    INSERT INTO isp.int_tipo_proceso_clave (id, id_proceso, clave) VALUES (5, 42, 'SISCONTI023');
    INSERT INTO isp.int_tipo_proceso_clave (id, id_proceso, clave) VALUES (6, 14, 'SISCONTI023');
    INSERT INTO isp.int_tipo_proceso_clave (id, id_proceso, clave) VALUES (1, 4, 'SISCONTI023');
    INSERT INTO isp.int_tipo_proceso_clave (id, id_proceso, clave) VALUES (2, 10, 'SISCONTI023');
    INSERT INTO isp.int_tipo_proceso_clave (id, id_proceso, clave) VALUES (8, 51, 'SISCONTI023');
    INSERT INTO isp.int_tipo_proceso_clave (id, id_proceso, clave) VALUES (10, 43, 'SISCONTI023');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (25, 27, 'RECONEXION DE CABLE', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (26, 27, 'REINSTALACION', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (27, 27, 'RECONEXION DE INTERNET CON FIBRA', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (28, 27, 'REINSTALACION DE INTERNET CON FIBRA', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (29, 27, 'RECONEXION DE INTERNET', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (30, 27, 'REINSTALACION DE INTERNET', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (38, 2, 'COBRO EN CARRO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (42, 2, 'CORTE DE INTERNET', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (19, 1, 'INSTALACION INTERNET ', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (24, 39, 'TRASLADO EXTERNO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (350, 4, 'RECONEXION CONTRATO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (351, 10, 'CAMBIO DE PAQUETE', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (353, 14, 'RECONEXION SERVICIO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (355, 40, 'SUSPENCION DE CONTRATO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (132, 54, 'SIN SEÑAL', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (133, 54, 'INTERNET LENTO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (388, 54, 'INTERMITENCIA', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (389, 54, 'CAMBIO DE CONTRASEÑA', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (398, 54, 'INTERNET INESTABLE', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (399, 54, 'INTERNET CON PROBLEMA WIFI', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (400, 54, 'CAMBIO DE ROUTER', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (405, 54, 'TRASLADO INTERNO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (403, 42, 'TRASLADO INTERNO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (3, 42, 'SIN SEÑAL', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (4, 42, 'CANALES PIXELEADOS', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (390, 42, 'CANALES INCOMPLETOS', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (391, 42, 'SEÑAL LLUVIOSA', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (392, 42, 'SEÑAL INESTABLE', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (393, 42, 'SEÑAL SIN HD', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (394, 42, 'HD CANALES DISTORSIONADOS', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (395, 42, 'HD SE PIXELEA', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (396, 42, 'HD SE CONGELA', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (397, 42, 'HD CANALES INCOMPLETOS Y SIN SEÑAL', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (2, 55, 'POR DEUDA', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (6, 55, 'POR CORTE DEFINITIVO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (1, 56, 'POR PROMOCION', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (5, 56, 'POR SOLICITUD', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (7, 57, 'INTERNET', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (8, 57, 'TV', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (9, 57, 'DUO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (33, 2, 'CORTE POR DEUDA', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (32, 2, 'CORTE TV', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (10, 58, 'CONSTRUCCION', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (11, 58, 'MANTENIMIENTO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (12, 58, 'AVERIAS CTO', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (13, 58, 'AMPLIACION', 'A');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (23, 1, 'INSTALACION DUO', 'I');
    INSERT INTO isp.int_motivos_canc (id, id_proceso, motivo, estado) VALUES (17, 1, 'INSTALACION CABLE', 'I');
    -- Confirmar la transacción si todo está bien
COMMIT;
