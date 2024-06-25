--/////VALIDA SI EXISTE LOS MENUS O NO PARA INSERTAR LOS MENUS QUE FALTEN 
    
    INSERT INTO comercial.menu_rd (menu_id, menu_codigo, menu_nombre, menu_link, menu_target, menu_imagen, menu_ayuda_titulo, menu_ayuda_texto, menu_activo, menu_perfil, menu_orden, menu_tipo, menu_conti, menu_tip_rd, menu_cont_adm) 
    SELECT * FROM (
        VALUES 
        (9990, '010806', 'Ejecucion Incidencia', 'asignar_incidencia/registro.php', 'main', 'ico_nuevo.png', 'Registro Ticket', 'Registro Ticket', 'S', '111111000000000110010100000000', 1, 'M', 0, 'L', 'C'),
        (9991, '010807', 'Productividad Incidencias', 'int_rep_incidencia/registro.php', 'main', 'ico_nuevo.png', 'Productividad Incidencias', 'Productividad Incidencias', 'S', '111010000001000010000000000000', 1, 'M', 0, 'L', 'C'),
        (9992, '010808', 'Conceptos-Clasificaciones', 'int_ccpt_mtv/registro.php', 'main', 'ico_nuevo.png', 'Conceptos-Clasificaciones', 'Conceptos-Clasificaciones', 'S', '110000000001000010000000000000', 1, 'M', 0, 'L', 'C'),
        (501003, '-00106', 'Productividad', 'dashboard_produ/dashboard.php', 'main', 'fa fa-tachometer', 'Productividad', 'Productividad', 'S', '110011000010010000000000000000', 1, 'M', 0, 'L', 'C'),
        (1239, '0100', 'Gestion WS', 'app_menu.php', 'menu', 'ico_nuevo.png', 'Gestión WS', 'Gestión WS', 'S', '110000000000000010000100000000', 2, 'D', 0, 'O', 'C'),
        (1240, '010001', 'Olt', 'int_ws_olt/olt.php', 'main', 'ico_nuevo.png', 'OLT', 'OLT', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        (1241, '010002', 'Router', 'int_ws_router/router.php', 'main', 'ico_nuevo.png', 'Router', 'Router', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        (1242, '010003', 'Vinculo Olt - Router', 'int_ws_olt_router/olt_router.php', 'main', 'ico_nuevo.png', 'Vinculo Olt - Router', 'Vinculo Olt - Router', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        (1244, '010004', 'Tareas programadas', 'int_ws_tareas/tareas.php', 'main', 'ico_nuevo.png', 'Tareas programadas', 'Tareas programadas', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        (629, '010005', 'Importar Onus', 'int_ws_importa_onus/importar.php', 'main', 'ico_nuevo.png', 'Importar Onus', 'Importar Onus', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        (1243, '010006', 'Listado Onus', 'int_ws_listado_onus/listado.php', 'main', 'ico_nuevo.png', 'Listado Onus', 'Listado Onus', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        (630, '010007', 'Traslado Onus', 'int_ws_traslado_onus/traslado.php', 'main', 'ico_nuevo.png', 'Traslado Onus', 'Traslado Onus', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        (7899, '2420', 'Promociones', 'int_promociones/promociones.php', 'main', 'fa fa-table', 'Promociones', 'Promociones', 'S', '100000000000001000000000000000', 1, 'M', 0, 'L', 'A'),
        (1228, '010412', 'Modelos Onus', 'int_modelo_onu/modelo.php', 'main', 'ico_nuevo.png', 'Modelos Onus', 'Modelos Onus', 'S', '110000100000000000000000000000', 9, 'M', 0, 'L', 'C')
    ) AS data
    WHERE NOT EXISTS (
        SELECT 1 FROM comercial.menu_rd WHERE menu_id = data.column1
    );