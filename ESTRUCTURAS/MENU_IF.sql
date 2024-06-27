
--/////VALIDA SI EXISTE LOS MENUS O NO PARA INSERTAR LOS MENUS QUE FALTEN
BEGIN;
    DO $$
    DECLARE
        new_start_value INT;
    BEGIN
        -- Ejecutar la subconsulta para obtener el nuevo valor de inicio
        SELECT count(*) + 1 INTO new_start_value FROM comercial.menu_rd;
        
        -- Usar ese valor en el comando RESTART WITH
        EXECUTE 'ALTER TABLE comercial.menu_rd ALTER COLUMN menu_id RESTART WITH ' || new_start_value;
    END $$;

    BEGIN;
        -- Paso 1: Eliminar la clave primaria temporalmente
        ALTER TABLE comercial.menu_rd DROP CONSTRAINT pk_menu_rd;

        -- Paso 2: Crear una columna temporal con nuevos IDs consecutivos
        ALTER TABLE comercial.menu_rd ADD COLUMN new_id SERIAL;

        -- Paso 3: Actualizar la columna original de IDs con los valores de la columna temporal
        UPDATE comercial.menu_rd SET menu_id = new_id;

        -- Paso 4: Eliminar la columna temporal
        ALTER TABLE comercial.menu_rd DROP COLUMN new_id;

        -- Paso 5: Restaurar la clave primaria
        ALTER TABLE comercial.menu_rd ADD CONSTRAINT pk_menu_rd PRIMARY KEY (menu_id);

    COMMIT;

    INSERT INTO comercial.menu_rd (menu_codigo, menu_nombre, menu_link, menu_target, menu_imagen, menu_ayuda_titulo, menu_ayuda_texto, menu_activo, menu_perfil, menu_orden, menu_tipo, menu_conti, menu_tip_rd, menu_cont_adm) 
    SELECT column1, column2, column3, column4, column5, column6, column7, column8, column9, column10, column11, column12, column13, column14
    FROM 
    (VALUES 
        ('010806', 'Ejecucion Incidencia', 'asignar_incidencia/registro.php', 'main', 'ico_nuevo.png', 'Registro Ticket', 'Registro Ticket', 'S', '111111000000000110010100000000', 1, 'M', 0, 'L', 'C'),
        ('010807', 'Productividad Incidencias', 'int_rep_incidencia/registro.php', 'main', 'ico_nuevo.png', 'Productividad Incidencias', 'Productividad Incidencias', 'S', '111010000001000010000000000000', 1, 'M', 0, 'L', 'C'),
        ('010808', 'Conceptos-Clasificaciones', 'int_ccpt_mtv/registro.php', 'main', 'ico_nuevo.png', 'Conceptos-Clasificaciones', 'Conceptos-Clasificaciones', 'S', '110000000001000010000000000000', 1, 'M', 0, 'L', 'C'),
        ('-00106', 'Productividad', 'dashboard_produ/dashboard.php', 'main', 'fa fa-tachometer', 'Productividad', 'Productividad', 'S', '110011000010010000000000000000', 1, 'M', 0, 'L', 'C'),
        ('0100', 'Gestion WS', 'app_menu.php', 'menu', 'ico_nuevo.png', 'Gestión WS', 'Gestión WS', 'S', '110000000000000010000100000000', 2, 'D', 0, 'O', 'C'),
        ('010001', 'Olt', 'int_ws_olt/olt.php', 'main', 'ico_nuevo.png', 'OLT', 'OLT', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        ('010002', 'Router', 'int_ws_router/router.php', 'main', 'ico_nuevo.png', 'Router', 'Router', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        ('010003', 'Vinculo Olt - Router', 'int_ws_olt_router/olt_router.php', 'main', 'ico_nuevo.png', 'Vinculo Olt - Router', 'Vinculo Olt - Router', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        ('010004', 'Tareas programadas', 'int_ws_tareas/tareas.php', 'main', 'ico_nuevo.png', 'Tareas programadas', 'Tareas programadas', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        ('010005', 'Importar Onus', 'int_ws_importa_onus/importar.php', 'main', 'ico_nuevo.png', 'Importar Onus', 'Importar Onus', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        ('010006', 'Listado Onus', 'int_ws_listado_onus/listado.php', 'main', 'ico_nuevo.png', 'Listado Onus', 'Listado Onus', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        ('010007', 'Traslado Onus', 'int_ws_traslado_onus/traslado.php', 'main', 'ico_nuevo.png', 'Traslado Onus', 'Traslado Onus', 'S', '111011000100010010000100000000', 1, 'M', 0, 'L', 'C'),
        ('2420', 'Promociones', 'int_promociones/promociones.php', 'main', 'fa fa-table', 'Promociones', 'Promociones', 'S', '100000000000001000000000000000', 1, 'M', 0, 'L', 'A'),
        ('010412', 'Modelos Onus', 'int_modelo_onu/modelo.php', 'main', 'ico_nuevo.png', 'Modelos Onus', 'Modelos Onus', 'S', '110000100000000000000000000000', 9, 'M', 0, 'L', 'C'),
        ('010802', 'Promesas de Pago', 'int_promesas_pago/promesas.php', 'main', 'ico_nuevo.png', 'Promesas de Pago', 'Promesas de Pago', 'S', '110011100111100000000000000000', 1, 'M', 0, 'L', 'C')
    ) AS data (column1, column2, column3, column4, column5, column6, column7, column8, column9, column10, column11, column12, column13, column14)
    WHERE NOT EXISTS (
        SELECT 1 
        FROM comercial.menu_rd 
        WHERE CONCAT(menu_nombre, menu_link) = CONCAT(data.column2, data.column3)
    );
COMMIT;