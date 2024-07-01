--Esquema pais PERU
BEGIN;
    --registra la catidad de digitos para facturacion
    UPDATE PUBLIC.saepais 
	SET pais_codigo_inter = '51', pais_dig_sere = '4', pais_dig_face = '9' ,pais_dig_autoe = '0', pais_dig_serp = '4', pais_dig_facp = '9' ,pais_dig_autop = '0'
	where pais_cod_pais =28;
    --configuracion de moneda por pais
    UPDATE public.saemone SET mone_cod_empr = 1, mone_des_mone = 'SOLES', mone_sgl_mone = 'PEN', mone_smb_mene = 'S/', mone_est_mone = '1', mone_cod_pais = 28 WHERE mone_cod_mone = 1;
    UPDATE public.saemone SET mone_cod_empr = 1, mone_des_mone = 'DOLAR', mone_sgl_mone = 'USD', mone_smb_mene = '$', mone_est_mone = '1', mone_cod_pais = 7 WHERE mone_cod_mone = 2;
    --etiquetas por pais
    DELETE from comercial.pais_etiq_imp;
    INSERT INTO comercial.pais_etiq_imp (pais_cod_pais, pais_codigo_inter, impuesto, etiqueta, porcentaje, porcentaje2) VALUES (28, '51', 'IVA', 'IGV', 18, 0);
    INSERT INTO comercial.pais_etiq_imp (pais_cod_pais, pais_codigo_inter, impuesto, etiqueta, porcentaje, porcentaje2) VALUES (28, '51', 'ICE', 'ICE', 0, 0);
    INSERT INTO comercial.pais_etiq_imp (pais_cod_pais, pais_codigo_inter, impuesto, etiqueta, porcentaje, porcentaje2) VALUES (28, '51', 'IRBP', 'IRBP', 0, 0);
    INSERT INTO comercial.pais_etiq_imp (pais_cod_pais, pais_codigo_inter, impuesto, etiqueta, porcentaje, porcentaje2) VALUES (28, '51', 'RETENCION', 'DET/RET', 0, 0);
    INSERT INTO comercial.pais_etiq_imp (pais_cod_pais, pais_codigo_inter, impuesto, etiqueta, porcentaje, porcentaje2) VALUES (28, '51', 'TIPO_RETENCION', 'DETR', 0, 0);
    INSERT INTO comercial.pais_etiq_imp (pais_cod_pais, pais_codigo_inter, impuesto, etiqueta, porcentaje, porcentaje2) VALUES (28, '51', 'DECIMALES_RETENCION', '2', 0, 0);

    -- Eliminar registros existentes
    DELETE FROM comercial.tipo_iden_clpv_pais WHERE pais_cod_pais = 28;

    -- Insertar nuevos registros
    INSERT INTO comercial.tipo_iden_clpv_pais (id_iden_pais, id_iden_clpv, pais_cod_pais, pais_des_pais, identificacion, digitos, pais_codigo_inter, extranjero, checked, cf_sn, cf_numero, codigo_libro) VALUES (31, 1, 28, 'PERU', 'RUC', 11, '51', 0, NULL, 'N', NULL, NULL);
    INSERT INTO comercial.tipo_iden_clpv_pais (id_iden_pais, id_iden_clpv, pais_cod_pais, pais_des_pais, identificacion, digitos, pais_codigo_inter, extranjero, checked, cf_sn, cf_numero, codigo_libro) VALUES (32, 2, 28, 'PERU', 'DNI', 8, '51', 0, NULL, 'N', NULL, NULL);
    INSERT INTO comercial.tipo_iden_clpv_pais (id_iden_pais, id_iden_clpv, pais_cod_pais, pais_des_pais, identificacion, digitos, pais_codigo_inter, extranjero, checked, cf_sn, cf_numero, codigo_libro) VALUES (33, 3, 28, 'PERU', 'EXTRANJERA', 12, '51', 0, NULL, 'N', NULL, NULL);
    INSERT INTO comercial.tipo_iden_clpv_pais (id_iden_pais, id_iden_clpv, pais_cod_pais, pais_des_pais, identificacion, digitos, pais_codigo_inter, extranjero, checked, cf_sn, cf_numero, codigo_libro) VALUES (34, 3, 28, 'PERU', 'CPP', 9, '51', 0, NULL, 'N', NULL, NULL);

    -- Actualizar configuración de geografía para distribución de creación de contrato
    DELETE FROM comercial.pais_etiq_contr;
    INSERT INTO comercial.pais_etiq_contr (id, pais_cod_pais, pais_etiq_pais, pais_tbl_direc, pais_etiq_est) VALUES (1, 28, 'DEPARTAMENTO', 'saeprov', 'A');
    INSERT INTO comercial.pais_etiq_contr (id, pais_cod_pais, pais_etiq_pais, pais_tbl_direc, pais_etiq_est) VALUES (2, 28, 'PROVINCIA', 'saecant', 'A');
    INSERT INTO comercial.pais_etiq_contr (id, pais_cod_pais, pais_etiq_pais, pais_tbl_direc, pais_etiq_est) VALUES (3, 28, 'PROVINCIA', 'saeciud', 'I');
    INSERT INTO comercial.pais_etiq_contr (id, pais_cod_pais, pais_etiq_pais, pais_tbl_direc, pais_etiq_est) VALUES (4, 28, 'DISTRITO', 'saeparr', 'A');
COMMIT;

--motivos de las notas de credito para pais peru

BEGIN;
    DELETE from public.saeddev;
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (1, 1, 'Anulación de la Operación', '01');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (2, 1, 'Anulación por Error en el RUC', '02');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (3, 1, 'Descuento Global', '04');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (4, 1, 'Devolución Total', '06');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (5, 1, 'Corrección por error en la descripcion', '03');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (6, 1, 'Devolución por ítem', '07');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (13, 1, 'Descuento por ítem', '05');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (14, 1, 'Bonificación', '08');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (15, 1, 'Disminución en el valor', '09');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (19, 1, 'Otros conceptos', '10');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (21, 1, 'Ajustes afectos al IVAP', '12');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (23, 1, 'Ajustes de operaciones de exportación', '11');
    INSERT INTO public.saeddev (ddev_cod_ddev, ddev_cod_empr, ddev_des_ddev, ddev_tip_ddev) VALUES (25, 1, 'Correción del monto neto pendiente de pago y/o las fechas de vencimiento del pago único o de las cuotas y /o los montos correspondientes a cada cuota, de ser el caso', '13');
    --APLICAR SI EL PROYECTO TIENE TRASACCIONES
    UPDATE public.saeclpv SET clpv_cod_vend = NULL, clpv_cod_zona = NULL, clpv_cod_ciud = NULL WHERE clpv_cod_sucu != 0 AND clpv_cod_empr != 0;
    UPDATE public.saevend SET zona_cod_zona = NULL, vend_cod_ciu = NULL WHERE vend_cod_empr != 0;
    UPDATE public.saeempl SET empl_cod_ciud = NULL WHERE empl_cod_empr != 0;
    UPDATE public.saeestr SET estr_cod_ciud = NULL WHERE estr_cod_empr != 0;
COMMIT;

BEGIN;
    DELETE FROM public.saeparr;
    DELETE FROM public.saeciud;
    DELETE FROM public.saecant;
    DELETE FROM public.saeprov;
    DELETE FROM public.saezona;
    --CREATE SEQUENCE saezona_zona_cod_zona_seq; 
    --ALTER SEQUENCE public.saezona_zona_cod_zona_seq RESTART WITH 1;
    INSERT INTO public.saezona (zona_cod_empr, zona_cod_sucu, zona_nom_zona, zona_opc_zona, zona_cod_ciud) 
        VALUES (
                (1, 1, 'AMAZONAS', NULL, NULL ),
                (2, 1, 'ÁNCASH', NULL, NULL ),
                (3, 1, 'APURÍMAC', NULL, NULL ),
                (4, 1, 'AREQUIPA', NULL, NULL ),
                (5, 1, 'AYACUCHO', NULL, NULL ),
                (6, 1, 'CAJAMARCA', NULL, NULL ),
                (7, 1, 'PROV. CONST. DEL CALLAO', NULL, NULL ),
                (8, 1, 'CUSCO', NULL, NULL ),
                (9, 1, 'HUANCAVELICA', NULL, NULL ),
                (10, 1, 'HUÁNUCO', NULL, NULL ),
                (11, 1, 'ICA', NULL, NULL ),
                (12, 1, 'JUNÍN', NULL, NULL ),
                (13, 1, 'LA LIBERTAD', NULL, NULL ),
                (14, 1, 'LAMBAYEQUE', NULL, NULL ),
                (15, 1, 'LIMA ', NULL, NULL ),
                (16, 1, 'LORETO', NULL, NULL ),
                (17, 1, 'MADRE DE DIOS', NULL, NULL ),
                (18, 1, 'MOQUEGUA', NULL, NULL ),
                (19, 1, 'PASCO', NULL, NULL ),
                (20, 1, 'PIURA', NULL, NULL ),
                (21, 1, 'PUNO', NULL, NULL ),
                (22, 1, 'SAN MARTÍN', NULL, NULL ),
                (23, 1, 'TACNA', NULL, NULL ),
                (24, 1, 'TUMBES', NULL, NULL ),
                (25, 1, 'UCAYALI', NULL, NULL )
                );
    INSERT INTO public.saeprov (prov_cod_prov, prov_des_prov,prov_cod_char) 
        VALUES (
                (1, 'AMAZONAS', '01'),
                (2, 'ÁNCASH', '02'),
                (3, 'APURÍMAC', '03'),
                (4, 'AREQUIPA', '04'),
                (5, 'AYACUCHO', '05'),
                (6, 'CAJAMARCA', '06'),
                (7, 'PROV. CONST. DEL CALLAO', '07'),
                (8, 'CUSCO', '08'),
                (9, 'HUANCAVELICA', '09'),
                (10, 'HUÁNUCO', '10'),
                (11, 'ICA', '11'),
                (12, 'JUNÍN', '12'),
                (13, 'LA LIBERTAD', '13'),
                (14, 'LAMBAYEQUE', '14'),
                (15, 'LIMA', '15'),
                (16, 'LORETO', '16'),
                (17, 'MADRE DE DIOS', '17'),
                (18, 'MOQUEGUA', '18'),
                (19, 'PASCO', '19'),
                (20, 'PIURA', '20'),
                (21, 'PUNO', '21'),
                (22, 'SAN MARTÍN', '22'),
                (23, 'TACNA', '23'),
                (24, 'TUMBES', '24'),
                (25, 'UCAYALI', '25')
                );
    INSERT INTO public.saecant (cant_cod_cant, cant_cod_char, cant_des_cant, cant_sri_codi, cant_cod_provc, cant_cod_prov, cant_est_cant) 
        VALUES  (
                (1, '01', 'CHACHAPOYAS', '', '', 1, 'A'),
                (2, '02', 'BAGUA', '', '', 1, 'A'),
                (3, '03', 'BONGARÁ', '', '', 1, 'A'),
                (4, '04', 'CONDORCANQUI', '', '', 1, 'A'),
                (5, '05', 'LUYA', '', '', 1, 'A'),
                (6, '06', 'RODRÍGUEZ DE MENDOZA', '', '', 1, 'A'),
                (7, '07', 'UTCUBAMBA', '', '', 1, 'A'),
                (8, '01', 'HUARAZ', '', '', 2, 'A'),
                (9, '02', 'AIJA', '', '', 2, 'A'),
                (10, '03', 'ANTONIO RAYMONDI', '', '', 2, 'A'),
                (11, '04', 'ASUNCIÓN', '', '', 2, 'A'),
                (12, '05', 'BOLOGNESI', '', '', 2, 'A'),
                (13, '06', 'CARHUAZ', '', '', 2, 'A'),
                (14, '07', 'CARLOS F. FITZCARRALD', '', '', 2, 'A'),
                (15, '08', 'CASMA', '', '', 2, 'A'),
                (16, '09', 'CORONGO', '', '', 2, 'A'),
                (17, '10', 'HUARI', '', '', 2, 'A'),
                (18, '11', 'HUARMEY', '', '', 2, 'A'),
                (19, '12', 'HUAYLAS', '', '', 2, 'A'),
                (20, '13', 'MARISCAL LUZURIAGA', '', '', 2, 'A'),
                (21, '14', 'OCROS', '', '', 2, 'A'),
                (22, '15', 'PALLASCA', '', '', 2, 'A'),
                (23, '16', 'POMABAMBA', '', '', 2, 'A'),
                (24, '17', 'RECUAY', '', '', 2, 'A'),
                (25, '18', 'SANTA', '', '', 2, 'A'),
                (26, '19', 'SIHUAS', '', '', 2, 'A'),
                (27, '20', 'YUNGAY', '', '', 2, 'A'),
                (28, '01', 'ABANCAY', '', '', 3, 'A'),
                (29, '02', 'ANDAHUAYLAS', '', '', 3, 'A'),
                (30, '03', 'ANTABAMBA', '', '', 3, 'A'),
                (31, '04', 'AYMARAES', '', '', 3, 'A'),
                (32, '05', 'COTABAMBAS', '', '', 3, 'A'),
                (33, '06', 'CHINCHEROS', '', '', 3, 'A'),
                (34, '07', 'GRAU', '', '', 3, 'A'),
                (35, '01', 'AREQUIPA', '', '', 4, 'A'),
                (36, '02', 'CAMANÁ', '', '', 4, 'A'),
                (37, '03', 'CARAVELÍ', '', '', 4, 'A'),
                (38, '04', 'CASTILLA', '', '', 4, 'A'),
                (39, '05', 'CAYLLOMA', '', '', 4, 'A'),
                (40, '06', 'CONDESUYOS', '', '', 4, 'A'),
                (41, '07', 'ISLAY', '', '', 4, 'A'),
                (42, '08', 'LA UNIÓN', '', '', 4, 'A'),
                (43, '01', 'HUAMANGA', '', '', 5, 'A'),
                (44, '02', 'CANGALLO', '', '', 5, 'A'),
                (45, '03', 'HUANCA SANCOS', '', '', 5, 'A'),
                (46, '04', 'HUANTA', '', '', 5, 'A'),
                (47, '05', 'LA MAR', '', '', 5, 'A'),
                (48, '06', 'LUCANAS', '', '', 5, 'A'),
                (49, '07', 'PARINACOCHAS', '', '', 5, 'A'),
                (50, '08', 'PÁUCAR DEL SARA SARA', '', '', 5, 'A'),
                (51, '09', 'SUCRE', '', '', 5, 'A'),
                (52, '10', 'VÍCTOR FAJARDO', '', '', 5, 'A'),
                (53, '11', 'VILCAS HUAMÁN', '', '', 5, 'A'),
                (54, '01', 'CAJAMARCA', '', '', 6, 'A'),
                (55, '02', 'CAJABAMBA', '', '', 6, 'A'),
                (56, '03', 'CELENDÍN', '', '', 6, 'A'),
                (57, '04', 'CHOTA', '', '', 6, 'A'),
                (58, '05', 'CONTUMAZÁ', '', '', 6, 'A'),
                (59, '06', 'CUTERVO', '', '', 6, 'A'),
                (60, '07', 'HUALGAYOC', '', '', 6, 'A'),
                (61, '08', 'JAÉN', '', '', 6, 'A'),
                (62, '09', 'SAN IGNACIO', '', '', 6, 'A'),
                (63, '10', 'SAN MARCOS', '', '', 6, 'A'),
                (64, '11', 'SAN MIGUEL', '', '', 6, 'A'),
                (65, '12', 'SAN PABLO', '', '', 6, 'A'),
                (66, '13', 'SANTA CRUZ', '', '', 6, 'A'),
                (67, '01', 'CALLAO', '', '', 7, 'A'),
                (68, '01', 'CUSCO', '', '', 8, 'A'),
                (69, '02', 'ACOMAYO', '', '', 8, 'A'),
                (70, '03', 'ANTA', '', '', 8, 'A'),
                (71, '04', 'CALCA', '', '', 8, 'A'),
                (72, '05', 'CANAS', '', '', 8, 'A'),
                (73, '06', 'CANCHIS', '', '', 8, 'A'),
                (74, '07', 'CHUMBIVILCAS', '', '', 8, 'A'),
                (75, '08', 'ESPINAR', '', '', 8, 'A'),
                (76, '09', 'LA CONVENCIÓN', '', '', 8, 'A'),
                (77, '10', 'PARURO', '', '', 8, 'A'),
                (78, '11', 'PAUCARTAMBO', '', '', 8, 'A'),
                (79, '12', 'QUISPICANCHI', '', '', 8, 'A'),
                (80, '13', 'URUBAMBA', '', '', 8, 'A'),
                (81, '01', 'HUANCAVELICA', '', '', 9, 'A'),
                (82, '02', 'ACOBAMBA', '', '', 9, 'A'),
                (83, '03', 'ANGARAES', '', '', 9, 'A'),
                (84, '04', 'CASTROVIRREYNA', '', '', 9, 'A'),
                (85, '05', 'CHURCAMPA', '', '', 9, 'A'),
                (86, '06', 'HUAYTARÁ', '', '', 9, 'A'),
                (87, '07', 'TAYACAJA', '', '', 9, 'A'),
                (88, '01', 'HUÁNUCO', '', '', 10, 'A'),
                (89, '02', 'AMBO', '', '', 10, 'A'),
                (90, '03', 'DOS DE MAYO', '', '', 10, 'A'),
                (91, '04', 'HUACAYBAMBA', '', '', 10, 'A'),
                (92, '05', 'HUAMALÍES', '', '', 10, 'A'),
                (93, '06', 'LEONCIO PRADO', '', '', 10, 'A'),
                (94, '07', 'MARAÑÓN', '', '', 10, 'A'),
                (95, '08', 'PACHITEA', '', '', 10, 'A'),
                (96, '09', 'PUERTO INCA', '', '', 10, 'A'),
                (97, '10', 'LAURICOCHA', '', '', 10, 'A'),
                (98, '11', 'YAROWILCA', '', '', 10, 'A'),
                (99, '01', 'ICA', '', '', 11, 'A'),
                (100, '02', 'CHINCHA', '', '', 11, 'A'),
                (101, '03', 'NASCA', '', '', 11, 'A'),
                (102, '04', 'PALPA', '', '', 11, 'A'),
                (103, '05', 'PISCO', '', '', 11, 'A'),
                (104, '01', 'HUANCAYO', '', '', 12, 'A'),
                (105, '02', 'CONCEPCIÓN', '', '', 12, 'A'),
                (106, '03', 'CHANCHAMAYO', '', '', 12, 'A'),
                (107, '04', 'JAUJA', '', '', 12, 'A'),
                (108, '05', 'JUNÍN', '', '', 12, 'A'),
                (109, '06', 'SATIPO', '', '', 12, 'A'),
                (110, '07', 'TARMA', '', '', 12, 'A'),
                (111, '08', 'YAULI', '', '', 12, 'A'),
                (112, '09', 'CHUPACA', '', '', 12, 'A'),
                (113, '01', 'TRUJILLO', '', '', 13, 'A'),
                (114, '02', 'ASCOPE', '', '', 13, 'A'),
                (115, '03', 'BOLÍVAR', '', '', 13, 'A'),
                (116, '04', 'CHEPÉN', '', '', 13, 'A'),
                (117, '05', 'JULCÁN', '', '', 13, 'A'),
                (118, '06', 'OTUZCO', '', '', 13, 'A'),
                (119, '07', 'PACASMAYO', '', '', 13, 'A'),
                (120, '08', 'PATAZ', '', '', 13, 'A'),
                (121, '09', 'SÁNCHEZ CARRIÓN', '', '', 13, 'A'),
                (122, '10', 'SANTIAGO DE CHUCO', '', '', 13, 'A'),
                (123, '11', 'GRAN CHIMÚ', '', '', 13, 'A'),
                (124, '12', 'VIRÚ', '', '', 13, 'A'),
                (125, '01', 'CHICLAYO', '', '', 14, 'A'),
                (126, '02', 'FERREÑAFE', '', '', 14, 'A'),
                (127, '03', 'LAMBAYEQUE', '', '', 14, 'A'),
                (128, '01', 'LIMA METROPOLITANA', '', '', 15, 'A'),
                (129, '02', 'BARRANCA', '', '', 15, 'A'),
                (130, '03', 'CAJATAMBO', '', '', 15, 'A'),
                (131, '04', 'CANTA', '', '', 15, 'A'),
                (132, '05', 'CAÑETE', '', '', 15, 'A'),
                (133, '06', 'HUARAL', '', '', 15, 'A'),
                (134, '07', 'HUAROCHIRÍ', '', '', 15, 'A'),
                (135, '08', 'HUAURA', '', '', 15, 'A'),
                (136, '09', 'OYÓN', '', '', 15, 'A'),
                (137, '10', 'YAUYOS', '', '', 15, 'A'),
                (138, '01', 'MAYNAS', '', '', 16, 'A'),
                (139, '02', 'ALTO AMAZONAS', '', '', 16, 'A'),
                (140, '03', 'LORETO', '', '', 16, 'A'),
                (141, '04', 'MARISCAL RAMÓN CASTILLA', '', '', 16, 'A'),
                (142, '05', 'REQUENA', '', '', 16, 'A'),
                (143, '06', 'UCAYALI', '', '', 16, 'A'),
                (144, '07', 'DATEM DEL MARAÑÓN', '', '', 16, 'A'),
                (145, '08', 'PUTUMAYO', '', '', 16, 'A'),
                (146, '01', 'TAMBOPATA', '', '', 17, 'A'),
                (147, '02', 'MANU', '', '', 17, 'A'),
                (148, '03', 'TAHUAMANU', '', '', 17, 'A'),
                (149, '01', 'MARISCAL NIETO', '', '', 18, 'A'),
                (150, '02', 'GENERAL SÁNCHEZ CERRO', '', '', 18, 'A'),
                (151, '03', 'ILO', '', '', 18, 'A'),
                (152, '01', 'PASCO', '', '', 19, 'A'),
                (153, '02', 'DANIEL ALCIDES CARRIÓN', '', '', 19, 'A'),
                (154, '03', 'OXAPAMPA', '', '', 19, 'A'),
                (155, '01', 'PIURA', '', '', 20, 'A'),
                (156, '02', 'AYABACA', '', '', 20, 'A'),
                (157, '03', 'HUANCABAMBA', '', '', 20, 'A'),
                (158, '04', 'MORROPÓN', '', '', 20, 'A'),
                (159, '05', 'PAITA', '', '', 20, 'A'),
                (160, '06', 'SULLANA', '', '', 20, 'A'),
                (161, '07', 'TALARA', '', '', 20, 'A'),
                (162, '08', 'SECHURA', '', '', 20, 'A'),
                (163, '01', 'PUNO', '', '', 21, 'A'),
                (164, '02', 'AZÁNGARO', '', '', 21, 'A'),
                (165, '03', 'CARABAYA', '', '', 21, 'A'),
                (166, '04', 'CHUCUITO', '', '', 21, 'A'),
                (167, '05', 'EL COLLAO', '', '', 21, 'A'),
                (168, '06', 'HUANCANÉ', '', '', 21, 'A'),
                (169, '07', 'LAMPA', '', '', 21, 'A'),
                (170, '08', 'MELGAR', '', '', 21, 'A'),
                (171, '09', 'MOHO', '', '', 21, 'A'),
                (172, '10', 'SAN ANTONIO DE PUTINA', '', '', 21, 'A'),
                (173, '11', 'SAN ROMÁN', '', '', 21, 'A'),
                (174, '12', 'SANDIA', '', '', 21, 'A'),
                (175, '13', 'YUNGUYO', '', '', 21, 'A'),
                (176, '01', 'MOYOBAMBA', '', '', 22, 'A'),
                (177, '02', 'BELLAVISTA', '', '', 22, 'A'),
                (178, '03', 'EL DORADO', '', '', 22, 'A'),
                (179, '04', 'HUALLAGA', '', '', 22, 'A'),
                (180, '05', 'LAMAS', '', '', 22, 'A'),
                (181, '06', 'MARISCAL CÁCERES', '', '', 22, 'A'),
                (182, '07', 'PICOTA', '', '', 22, 'A'),
                (183, '08', 'RIOJA', '', '', 22, 'A'),
                (184, '09', 'SAN MARTÍN', '', '', 22, 'A'),
                (185, '10', 'TOCACHE', '', '', 22, 'A'),
                (186, '01', 'TACNA', '', '', 23, 'A'),
                (187, '02', 'CANDARAVE', '', '', 23, 'A'),
                (188, '03', 'JORGE BASADRE', '', '', 23, 'A'),
                (189, '04', 'TARATA', '', '', 23, 'A'),
                (190, '01', 'TUMBES', '', '', 24, 'A'),
                (191, '02', 'CONTRALMIRANTE VILLAR', '', '', 24, 'A'),
                (192, '03', 'ZARUMILLA', '', '', 24, 'A'),
                (193, '01', 'CORONEL PORTILLO', '', '', 25, 'A'),
                (194, '02', 'ATALAYA', '', '', 25, 'A'),
                (195, '03', 'PADRE ABAD', '', '', 25, 'A'),
                (196, '04', 'PURÚS', '', '', 25, 'A')
                );

    INSERT INTO public.saeciud (ciud_cod_ciud, ciud_cod_pais, ciud_nom_ciud, ciud_cod_prov, ciud_tip_ciud, ciud_cod_sri, ciud_cod_urbano, ciud_zip_code) 
                        VALUES  (
                                (1, 28, 'CHACHAPOYAS', 1, 0, '0', 0, '0'),
                                (2, 28, 'BAGUA', 1, 0, '0', 0, '0'),
                                (3, 28, 'BONGARÁ', 1, 0, '0', 0, '0'),
                                (4, 28, 'CONDORCANQUI', 1, 0, '0', 0, '0'),
                                (5, 28, 'LUYA', 1, 0, '0', 0, '0'),
                                (6, 28, 'RODRÍGUEZ DE MENDOZA', 1, 0, '0', 0, '0'),
                                (7, 28, 'UTCUBAMBA', 1, 0, '0', 0, '0'),
                                (8, 28, 'HUARAZ', 2, 0, '0', 0, '0'),
                                (9, 28, 'AIJA', 2, 0, '0', 0, '0'),
                                (10, 28, 'ANTONIO RAYMONDI', 2, 0, '0', 0, '0'),
                                (11, 28, 'ASUNCIÓN', 2, 0, '0', 0, '0'),
                                (12, 28, 'BOLOGNESI', 2, 0, '0', 0, '0'),
                                (13, 28, 'CARHUAZ', 2, 0, '0', 0, '0'),
                                (14, 28, 'CARLOS F. FITZCARRALD', 2, 0, '0', 0, '0'),
                                (15, 28, 'CASMA', 2, 0, '0', 0, '0'),
                                (16, 28, 'CORONGO', 2, 0, '0', 0, '0'),
                                (17, 28, 'HUARI', 2, 0, '0', 0, '0'),
                                (18, 28, 'HUARMEY', 2, 0, '0', 0, '0'),
                                (19, 28, 'HUAYLAS', 2, 0, '0', 0, '0'),
                                (20, 28, 'MARISCAL LUZURIAGA', 2, 0, '0', 0, '0'),
                                (21, 28, 'OCROS', 2, 0, '0', 0, '0'),
                                (22, 28, 'PALLASCA', 2, 0, '0', 0, '0'),
                                (23, 28, 'POMABAMBA', 2, 0, '0', 0, '0'),
                                (24, 28, 'RECUAY', 2, 0, '0', 0, '0'),
                                (25, 28, 'SANTA', 2, 0, '0', 0, '0'),
                                (26, 28, 'SIHUAS', 2, 0, '0', 0, '0'),
                                (27, 28, 'YUNGAY', 2, 0, '0', 0, '0'),
                                (28, 28, 'ABANCAY', 3, 0, '0', 0, '0'),
                                (29, 28, 'ANDAHUAYLAS', 3, 0, '0', 0, '0'),
                                (30, 28, 'ANTABAMBA', 3, 0, '0', 0, '0'),
                                (31, 28, 'AYMARAES', 3, 0, '0', 0, '0'),
                                (32, 28, 'COTABAMBAS', 3, 0, '0', 0, '0'),
                                (33, 28, 'CHINCHEROS', 3, 0, '0', 0, '0'),
                                (34, 28, 'GRAU', 3, 0, '0', 0, '0'),
                                (35, 28, 'AREQUIPA', 4, 0, '0', 0, '0'),
                                (36, 28, 'CAMANÁ', 4, 0, '0', 0, '0'),
                                (37, 28, 'CARAVELÍ', 4, 0, '0', 0, '0'),
                                (38, 28, 'CASTILLA', 4, 0, '0', 0, '0'),
                                (39, 28, 'CAYLLOMA', 4, 0, '0', 0, '0'),
                                (40, 28, 'CONDESUYOS', 4, 0, '0', 0, '0'),
                                (41, 28, 'ISLAY', 4, 0, '0', 0, '0'),
                                (42, 28, 'LA UNIÓN', 4, 0, '0', 0, '0'),
                                (43, 28, 'HUAMANGA', 5, 0, '0', 0, '0'),
                                (44, 28, 'CANGALLO', 5, 0, '0', 0, '0'),
                                (45, 28, 'HUANCA SANCOS', 5, 0, '0', 0, '0'),
                                (46, 28, 'HUANTA', 5, 0, '0', 0, '0'),
                                (47, 28, 'LA MAR', 5, 0, '0', 0, '0'),
                                (48, 28, 'LUCANAS', 5, 0, '0', 0, '0'),
                                (49, 28, 'PARINACOCHAS', 5, 0, '0', 0, '0'),
                                (50, 28, 'PÁUCAR DEL SARA SARA', 5, 0, '0', 0, '0'),
                                (51, 28, 'SUCRE', 5, 0, '0', 0, '0'),
                                (52, 28, 'VÍCTOR FAJARDO', 5, 0, '0', 0, '0'),
                                (53, 28, 'VILCAS HUAMÁN', 5, 0, '0', 0, '0'),
                                (54, 28, 'CAJAMARCA', 6, 0, '0', 0, '0'),
                                (55, 28, 'CAJABAMBA', 6, 0, '0', 0, '0'),
                                (56, 28, 'CELENDÍN', 6, 0, '0', 0, '0'),
                                (57, 28, 'CHOTA', 6, 0, '0', 0, '0'),
                                (58, 28, 'CONTUMAZÁ', 6, 0, '0', 0, '0'),
                                (59, 28, 'CUTERVO', 6, 0, '0', 0, '0'),
                                (60, 28, 'HUALGAYOC', 6, 0, '0', 0, '0'),
                                (61, 28, 'JAÉN', 6, 0, '0', 0, '0'),
                                (62, 28, 'SAN IGNACIO', 6, 0, '0', 0, '0'),
                                (63, 28, 'SAN MARCOS', 6, 0, '0', 0, '0'),
                                (64, 28, 'SAN MIGUEL', 6, 0, '0', 0, '0'),
                                (65, 28, 'SAN PABLO', 6, 0, '0', 0, '0'),
                                (66, 28, 'SANTA CRUZ', 6, 0, '0', 0, '0'),
                                (67, 28, 'CALLAO', 7, 0, '0', 0, '0'),
                                (68, 28, 'CUSCO', 8, 0, '0', 0, '0'),
                                (69, 28, 'ACOMAYO', 8, 0, '0', 0, '0'),
                                (70, 28, 'ANTA', 8, 0, '0', 0, '0'),
                                (71, 28, 'CALCA', 8, 0, '0', 0, '0'),
                                (72, 28, 'CANAS', 8, 0, '0', 0, '0'),
                                (73, 28, 'CANCHIS', 8, 0, '0', 0, '0'),
                                (74, 28, 'CHUMBIVILCAS', 8, 0, '0', 0, '0'),
                                (75, 28, 'ESPINAR', 8, 0, '0', 0, '0'),
                                (76, 28, 'LA CONVENCIÓN', 8, 0, '0', 0, '0'),
                                (77, 28, 'PARURO', 8, 0, '0', 0, '0'),
                                (78, 28, 'PAUCARTAMBO', 8, 0, '0', 0, '0'),
                                (79, 28, 'QUISPICANCHI', 8, 0, '0', 0, '0'),
                                (80, 28, 'URUBAMBA', 8, 0, '0', 0, '0'),
                                (81, 28, 'HUANCAVELICA', 9, 0, '0', 0, '0'),
                                (82, 28, 'ACOBAMBA', 9, 0, '0', 0, '0'),
                                (83, 28, 'ANGARAES', 9, 0, '0', 0, '0'),
                                (84, 28, 'CASTROVIRREYNA', 9, 0, '0', 0, '0'),
                                (85, 28, 'CHURCAMPA', 9, 0, '0', 0, '0'),
                                (86, 28, 'HUAYTARÁ', 9, 0, '0', 0, '0'),
                                (87, 28, 'TAYACAJA', 9, 0, '0', 0, '0'),
                                (88, 28, 'HUÁNUCO', 10, 0, '0', 0, '0'),
                                (89, 28, 'AMBO', 10, 0, '0', 0, '0'),
                                (90, 28, 'DOS DE MAYO', 10, 0, '0', 0, '0'),
                                (91, 28, 'HUACAYBAMBA', 10, 0, '0', 0, '0'),
                                (92, 28, 'HUAMALÍES', 10, 0, '0', 0, '0'),
                                (93, 28, 'LEONCIO PRADO', 10, 0, '0', 0, '0'),
                                (94, 28, 'MARAÑÓN', 10, 0, '0', 0, '0'),
                                (95, 28, 'PACHITEA', 10, 0, '0', 0, '0'),
                                (96, 28, 'PUERTO INCA', 10, 0, '0', 0, '0'),
                                (97, 28, 'LAURICOCHA', 10, 0, '0', 0, '0'),
                                (98, 28, 'YAROWILCA', 10, 0, '0', 0, '0'),
                                (99, 28, 'ICA', 11, 0, '0', 0, '0'),
                                (100, 28, 'CHINCHA', 11, 0, '0', 0, '0'),
                                (101, 28, 'NASCA', 11, 0, '0', 0, '0'),
                                (102, 28, 'PALPA', 11, 0, '0', 0, '0'),
                                (103, 28, 'PISCO', 11, 0, '0', 0, '0'),
                                (104, 28, 'HUANCAYO', 12, 0, '0', 0, '0'),
                                (105, 28, 'CONCEPCIÓN', 12, 0, '0', 0, '0'),
                                (106, 28, 'CHANCHAMAYO', 12, 0, '0', 0, '0'),
                                (107, 28, 'JAUJA', 12, 0, '0', 0, '0'),
                                (108, 28, 'JUNÍN', 12, 0, '0', 0, '0'),
                                (109, 28, 'SATIPO', 12, 0, '0', 0, '0'),
                                (110, 28, 'TARMA', 12, 0, '0', 0, '0'),
                                (111, 28, 'YAULI', 12, 0, '0', 0, '0'),
                                (112, 28, 'CHUPACA', 12, 0, '0', 0, '0'),
                                (113, 28, 'TRUJILLO', 13, 0, '0', 0, '0'),
                                (114, 28, 'ASCOPE', 13, 0, '0', 0, '0'),
                                (115, 28, 'BOLÍVAR', 13, 0, '0', 0, '0'),
                                (116, 28, 'CHEPÉN', 13, 0, '0', 0, '0'),
                                (117, 28, 'JULCÁN', 13, 0, '0', 0, '0'),
                                (118, 28, 'OTUZCO', 13, 0, '0', 0, '0'),
                                (119, 28, 'PACASMAYO', 13, 0, '0', 0, '0'),
                                (120, 28, 'PATAZ', 13, 0, '0', 0, '0'),
                                (121, 28, 'SÁNCHEZ CARRIÓN', 13, 0, '0', 0, '0'),
                                (122, 28, 'SANTIAGO DE CHUCO', 13, 0, '0', 0, '0'),
                                (123, 28, 'GRAN CHIMÚ', 13, 0, '0', 0, '0'),
                                (124, 28, 'VIRÚ', 13, 0, '0', 0, '0'),
                                (125, 28, 'CHICLAYO', 14, 0, '0', 0, '0'),
                                (126, 28, 'FERREÑAFE', 14, 0, '0', 0, '0'),
                                (127, 28, 'LAMBAYEQUE', 14, 0, '0', 0, '0'),
                                (128, 28, 'LIMA METROPOLITANA', 15, 0, '0', 0, '0'),
                                (129, 28, 'BARRANCA', 15, 0, '0', 0, '0'),
                                (130, 28, 'CAJATAMBO', 15, 0, '0', 0, '0'),
                                (131, 28, 'CANTA', 15, 0, '0', 0, '0'),
                                (132, 28, 'CAÑETE', 15, 0, '0', 0, '0'),
                                (133, 28, 'HUARAL', 15, 0, '0', 0, '0'),
                                (134, 28, 'HUAROCHIRÍ', 15, 0, '0', 0, '0'),
                                (135, 28, 'HUAURA', 15, 0, '0', 0, '0'),
                                (136, 28, 'OYÓN', 15, 0, '0', 0, '0'),
                                (137, 28, 'YAUYOS', 15, 0, '0', 0, '0'),
                                (138, 28, 'MAYNAS', 16, 0, '0', 0, '0'),
                                (139, 28, 'ALTO AMAZONAS', 16, 0, '0', 0, '0'),
                                (140, 28, 'LORETO', 16, 0, '0', 0, '0'),
                                (141, 28, 'MARISCAL RAMÓN CASTILLA', 16, 0, '0', 0, '0'),
                                (142, 28, 'REQUENA', 16, 0, '0', 0, '0'),
                                (143, 28, 'UCAYALI', 16, 0, '0', 0, '0'),
                                (144, 28, 'DATEM DEL MARAÑÓN', 16, 0, '0', 0, '0'),
                                (145, 28, 'PUTUMAYO', 16, 0, '0', 0, '0'),
                                (146, 28, 'TAMBOPATA', 17, 0, '0', 0, '0'),
                                (147, 28, 'MANU', 17, 0, '0', 0, '0'),
                                (148, 28, 'TAHUAMANU', 17, 0, '0', 0, '0'),
                                (149, 28, 'MARISCAL NIETO', 18, 0, '0', 0, '0'),
                                (150, 28, 'GENERAL SÁNCHEZ CERRO', 18, 0, '0', 0, '0'),
                                (151, 28, 'ILO', 18, 0, '0', 0, '0'),
                                (152, 28, 'PASCO', 19, 0, '0', 0, '0'),
                                (153, 28, 'DANIEL ALCIDES CARRIÓN', 19, 0, '0', 0, '0'),
                                (154, 28, 'OXAPAMPA', 19, 0, '0', 0, '0'),
                                (155, 28, 'PIURA', 20, 0, '0', 0, '0'),
                                (156, 28, 'AYABACA', 20, 0, '0', 0, '0'),
                                (157, 28, 'HUANCABAMBA', 20, 0, '0', 0, '0'),
                                (158, 28, 'MORROPÓN', 20, 0, '0', 0, '0'),
                                (159, 28, 'PAITA', 20, 0, '0', 0, '0'),
                                (160, 28, 'SULLANA', 20, 0, '0', 0, '0'),
                                (161, 28, 'TALARA', 20, 0, '0', 0, '0'),
                                (162, 28, 'SECHURA', 20, 0, '0', 0, '0'),
                                (163, 28, 'PUNO', 21, 0, '0', 0, '0'),
                                (164, 28, 'AZÁNGARO', 21, 0, '0', 0, '0'),
                                (165, 28, 'CARABAYA', 21, 0, '0', 0, '0'),
                                (166, 28, 'CHUCUITO', 21, 0, '0', 0, '0'),
                                (167, 28, 'EL COLLAO', 21, 0, '0', 0, '0'),
                                (168, 28, 'HUANCANÉ', 21, 0, '0', 0, '0'),
                                (169, 28, 'LAMPA', 21, 0, '0', 0, '0'),
                                (170, 28, 'MELGAR', 21, 0, '0', 0, '0'),
                                (171, 28, 'MOHO', 21, 0, '0', 0, '0'),
                                (172, 28, 'SAN ANTONIO DE PUTINA', 21, 0, '0', 0, '0'),
                                (173, 28, 'SAN ROMÁN', 21, 0, '0', 0, '0'),
                                (174, 28, 'SANDIA', 21, 0, '0', 0, '0'),
                                (175, 28, 'YUNGUYO', 21, 0, '0', 0, '0'),
                                (176, 28, 'MOYOBAMBA', 22, 0, '0', 0, '0'),
                                (177, 28, 'BELLAVISTA', 22, 0, '0', 0, '0'),
                                (178, 28, 'EL DORADO', 22, 0, '0', 0, '0'),
                                (179, 28, 'HUALLAGA', 22, 0, '0', 0, '0'),
                                (180, 28, 'LAMAS', 22, 0, '0', 0, '0'),
                                (181, 28, 'MARISCAL CÁCERES', 22, 0, '0', 0, '0'),
                                (182, 28, 'PICOTA', 22, 0, '0', 0, '0'),
                                (183, 28, 'RIOJA', 22, 0, '0', 0, '0'),
                                (184, 28, 'SAN MARTÍN', 22, 0, '0', 0, '0'),
                                (185, 28, 'TOCACHE', 22, 0, '0', 0, '0'),
                                (186, 28, 'TACNA', 23, 0, '0', 0, '0'),
                                (187, 28, 'CANDARAVE', 23, 0, '0', 0, '0'),
                                (188, 28, 'JORGE BASADRE', 23, 0, '0', 0, '0'),
                                (189, 28, 'TARATA', 23, 0, '0', 0, '0'),
                                (190, 28, 'TUMBES', 24, 0, '0', 0, '0'),
                                (191, 28, 'CONTRALMIRANTE VILLAR', 24, 0, '0', 0, '0'),
                                (192, 28, 'ZARUMILLA', 24, 0, '0', 0, '0'),
                                (193, 28, 'CORONEL PORTILLO', 25, 0, '0', 0, '0'),
                                (194, 28, 'ATALAYA', 25, 0, '0', 0, '0'),
                                (195, 28, 'PADRE ABAD', 25, 0, '0', 0, '0'),
                                (196, 28, 'PURÚS', 25, 0, '0', 0, '0')
                                );

    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1, '1', 1, 'CHACHAPOYAS', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (2, '2', 1, 'ASUNCIÓN', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (3, '3', 1, 'BALSAS', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (4, '4', 1, 'CHETO', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (5, '5', 1, 'CHILIQUIN', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (6, '6', 1, 'CHUQUIBAMBA', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (7, '7', 1, 'GRANADA', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (8, '8', 1, 'HUANCAS', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (9, '9', 1, 'LA JALCA', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (10, '10', 1, 'LEIMEBAMBA', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (11, '11', 1, 'LEVANTO', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (12, '12', 1, 'MAGDALENA', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (13, '13', 1, 'MARISCAL CASTILLA', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (14, '14', 1, 'MOLINOPAMPA', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (15, '15', 1, 'MONTEVIDEO', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (16, '16', 1, 'OLLEROS', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (17, '17', 1, 'QUINJALCA', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (18, '18', 1, 'SAN FRANCISCO DE DAGUAS', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (19, '19', 1, 'SAN ISIDRO DE MAINO', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (20, '20', 1, 'SOLOCO', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (21, '21', 1, 'SONCHE', '', '1');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (22, '22', 2, 'BAGUA', '', '2');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (23, '23', 2, 'ARAMANGO', '', '2');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (24, '24', 2, 'COPALLÍN', '', '2');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (25, '25', 2, 'EL PARCO', '', '2');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (26, '26', 2, 'IMAZA', '', '2');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (27, '27', 2, 'LA PECA', '', '2');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (28, '28', 3, 'JUMBILLA', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (29, '29', 3, 'CHISQUILLA', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (30, '30', 3, 'CHURUJA', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (31, '31', 3, 'COROSHA', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (32, '32', 3, 'CUISPES', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (33, '33', 3, 'FLORIDA', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (34, '34', 3, 'JAZÁN', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (35, '35', 3, 'RECTA', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (36, '36', 3, 'SAN CARLOS', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (37, '37', 3, 'SHIPASBAMBA', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (38, '38', 3, 'VALERA', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (39, '39', 3, 'YAMBRASBAMBA', '', '3');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (40, '40', 4, 'NIEVA', '', '4');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (41, '41', 4, 'EL CENEPA', '', '4');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (42, '42', 4, 'RÍO SANTIAGO', '', '4');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (43, '43', 5, 'LAMUD', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (44, '44', 5, 'CAMPORREDONDO', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (45, '45', 5, 'COCABAMBA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (46, '46', 5, 'COLCAMAR', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (47, '47', 5, 'CONILA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (48, '48', 5, 'INGUILPATA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (49, '49', 5, 'LONGUITA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (50, '50', 5, 'LONYA CHICO', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (51, '51', 5, 'LUYA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (52, '52', 5, 'LUYA VIEJO', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (53, '53', 5, 'MARÍA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (54, '54', 5, 'OCALLI', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (55, '55', 5, 'OCUMAL', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (56, '56', 5, 'PISUQUIA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (57, '57', 5, 'PROVIDENCIA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (58, '58', 5, 'SAN CRISTÓBAL', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (59, '59', 5, 'SAN FRANCISCO DEL YESO', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (60, '60', 5, 'SAN JERÓNIMO', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (61, '61', 5, 'SAN JUAN DE LOPECANCHA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (62, '62', 5, 'SANTA CATALINA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (63, '63', 5, 'SANTO TOMÁS', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (64, '64', 5, 'TINGO', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (65, '65', 5, 'TRITA', '', '5');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (66, '66', 6, 'SAN NICOLÁS', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (67, '67', 6, 'CHIRIMOTO', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (68, '68', 6, 'COCHAMAL', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (69, '69', 6, 'HUAMBO', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (70, '70', 6, 'LIMABAMBA', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (71, '71', 6, 'LONGAR', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (72, '72', 6, 'MARISCAL BENAVIDES', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (73, '73', 6, 'MILPUC', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (74, '74', 6, 'OMIA', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (75, '75', 6, 'SANTA ROSA', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (76, '76', 6, 'TOTORA', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (77, '77', 6, 'VISTA ALEGRE', '', '6');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (78, '78', 7, 'BAGUA GRANDE', '', '7');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (79, '79', 7, 'CAJARURO', '', '7');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (80, '80', 7, 'CUMBA', '', '7');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (81, '81', 7, 'EL MILAGRO', '', '7');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (82, '82', 7, 'JAMALCA', '', '7');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (83, '83', 7, 'LONYA GRANDE', '', '7');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (84, '84', 7, 'YAMÓN', '', '7');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (85, '85', 8, 'HUARAZ', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (86, '86', 8, 'COCHABAMBA', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (87, '87', 8, 'COLCABAMBA', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (88, '88', 8, 'HUANCHAY', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (89, '89', 8, 'INDEPENDENCIA', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (90, '90', 8, 'JANGAS', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (91, '91', 8, 'LA LIBERTAD', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (92, '92', 8, 'OLLEROS', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (93, '93', 8, 'PAMPAS', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (94, '94', 8, 'PARIACOTO', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (95, '95', 8, 'PIRA', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (96, '96', 8, 'TARICA', '', '8');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (97, '97', 9, 'AIJA', '', '9');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (98, '98', 9, 'CORIS', '', '9');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (99, '99', 9, 'HUACLLAN', '', '9');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (100, '100', 9, 'LA MERCED', '', '9');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (101, '101', 9, 'SUCCHA', '', '9');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (102, '102', 10, 'LLAMELLIN', '', '10');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (103, '103', 10, 'ACZO', '', '10');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (104, '104', 10, 'CHACCHO', '', '10');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (105, '105', 10, 'CHINGAS', '', '10');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (106, '106', 10, 'MIRGAS', '', '10');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (107, '107', 10, 'SAN JUAN DE RONTOY', '', '10');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (108, '108', 11, 'CHACAS', '', '11');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (109, '109', 11, 'ACOCHACA', '', '11');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (110, '110', 12, 'CHIQUIÁN', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (111, '111', 12, 'ABELARDO PARDO LEZAMETA', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (112, '112', 12, 'ANTONIO RAYMONDI', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (113, '113', 12, 'AQUIA', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (114, '114', 12, 'CAJACAY', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (115, '115', 12, 'CANIS', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (116, '116', 12, 'COLQUIOC', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (117, '117', 12, 'HUALLANCA', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (118, '118', 12, 'HUASTA', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (119, '119', 12, 'HUAYLLACAYAN', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (120, '120', 12, 'LA PRIMAVERA', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (121, '121', 12, 'MANGAS', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (122, '122', 12, 'PACLLÓN', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (123, '123', 12, 'SAN MIGUEL DE CORPANQUI', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (124, '124', 12, 'TICLLOS', '', '12');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (125, '125', 13, 'CARHUAZ', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (126, '126', 13, 'ACOPAMPA', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (127, '127', 13, 'AMASHCA', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (128, '128', 13, 'ANTA', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (129, '129', 13, 'ATAQUERO', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (130, '130', 13, 'MARCARA', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (131, '131', 13, 'PARIAHUANCA', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (132, '132', 13, 'SAN MIGUEL DE ACO', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (133, '133', 13, 'SHILLA', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (134, '134', 13, 'TINCO', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (135, '135', 13, 'YUNGAR', '', '13');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (136, '136', 14, 'SAN LUIS', '', '14');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (137, '137', 14, 'SAN NICOLÁS', '', '14');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (138, '138', 14, 'YAUYA', '', '14');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (139, '139', 15, 'CASMA', '', '15');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (140, '140', 15, 'BUENA VISTA ALTA', '', '15');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (141, '141', 15, 'COMANDANTE NOEL', '', '15');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (142, '142', 15, 'YAUTAN', '', '15');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (143, '143', 16, 'CORONGO', '', '16');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (144, '144', 16, 'ACO', '', '16');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (145, '145', 16, 'BAMBAS', '', '16');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (146, '146', 16, 'CUSCA', '', '16');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (147, '147', 16, 'LA PAMPA', '', '16');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (148, '148', 16, 'YANAC', '', '16');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (149, '149', 16, 'YUPÁN', '', '16');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (150, '150', 17, 'HUARI', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (151, '151', 17, 'ANRA', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (152, '152', 17, 'CAJAY', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (153, '153', 17, 'CHAVÍN DE HUÁNTAR', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (154, '154', 17, 'HUACACHI', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (155, '155', 17, 'HUACCHIS', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (156, '156', 17, 'HUACHIS', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (157, '157', 17, 'HUÁNTAR', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (158, '158', 17, 'MASIN', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (159, '159', 17, 'PAUCAS', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (160, '160', 17, 'PONTO', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (161, '161', 17, 'RAHUAPAMPA', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (162, '162', 17, 'RAPAYAN', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (163, '163', 17, 'SAN MARCOS', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (164, '164', 17, 'SAN PEDRO DE CHANA', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (165, '165', 17, 'UCO', '', '17');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (166, '166', 18, 'HUARMEY', '', '18');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (167, '167', 18, 'COCHAPETI', '', '18');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (168, '168', 18, 'CULEBRAS', '', '18');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (169, '169', 18, 'HUAYÁN', '', '18');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (170, '170', 18, 'MALVAS', '', '18');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (171, '171', 19, 'CARAZ', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (172, '172', 19, 'HUALLANCA', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (173, '173', 19, 'HUATA', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (174, '174', 19, 'HUAYLAS', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (175, '175', 19, 'MATO', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (176, '176', 19, 'PAMPAROMAS', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (177, '177', 19, 'PUEBLO LIBRE', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (178, '178', 19, 'SANTA CRUZ', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (179, '179', 19, 'SANTO TORIBIO', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (180, '180', 19, 'YURACMARCA', '', '19');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (181, '181', 20, 'PISCOBAMBA', '', '20');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (182, '182', 20, 'CASCA', '', '20');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (183, '183', 20, 'ELEAZAR GUZMÁN BARRÓN', '', '20');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (184, '184', 20, 'FIDEL OLIVAS ESCUDERO', '', '20');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (185, '185', 20, 'LLAMA', '', '20');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (186, '186', 20, 'LLUMPA', '', '20');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (187, '187', 20, 'LUCMA', '', '20');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (188, '188', 20, 'MUSGA', '', '20');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (189, '189', 21, 'OCROS', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (190, '190', 21, 'ACAS', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (191, '191', 21, 'CAJAMARQUILLA', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (192, '192', 21, 'CARHUAPAMPA', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (193, '193', 21, 'COCHAS', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (194, '194', 21, 'CONGAS', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (195, '195', 21, 'LLIPA', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (196, '196', 21, 'SAN CRISTÓBAL DE RAJÁN', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (197, '197', 21, 'SAN PEDRO', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (198, '198', 21, 'SANTIAGO DE CHILCAS', '', '21');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (199, '199', 22, 'CABANA', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (200, '200', 22, 'BOLOGNESI', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (201, '201', 22, 'CONCHUCOS', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (202, '202', 22, 'HUACASCHUQUE', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (203, '203', 22, 'HUANDOVAL', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (204, '204', 22, 'LACABAMBA', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (205, '205', 22, 'LLAPO', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (206, '206', 22, 'PALLASCA', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (207, '207', 22, 'PAMPAS', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (208, '208', 22, 'SANTA ROSA', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (209, '209', 22, 'TAUCA', '', '22');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (210, '210', 23, 'POMABAMBA', '', '23');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (211, '211', 23, 'HUAYLLÁN', '', '23');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (212, '212', 23, 'PAROBAMBA', '', '23');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (213, '213', 23, 'QUINUABAMBA', '', '23');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (214, '214', 24, 'RECUAY', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (215, '215', 24, 'CATAC', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (216, '216', 24, 'COTAPARACO', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (217, '217', 24, 'HUAYLLAPAMPA', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (218, '218', 24, 'LLACLLÍN', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (219, '219', 24, 'MARCA', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (220, '220', 24, 'PAMPAS CHICO', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (221, '221', 24, 'PARARÍN', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (222, '222', 24, 'TAPACOCHA', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (223, '223', 24, 'TICAPAMPA', '', '24');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (224, '224', 25, 'CHIMBOTE', '', '25');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (225, '225', 25, 'CÁCERES DEL PERÚ', '', '25');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (226, '226', 25, 'COISHCO', '', '25');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (227, '227', 25, 'MACATE', '', '25');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (228, '228', 25, 'MORO', '', '25');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (229, '229', 25, 'NEPEÑA', '', '25');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (230, '230', 25, 'SAMANCO', '', '25');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (231, '231', 25, 'SANTA', '', '25');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (232, '232', 25, 'NUEVO CHIMBOTE', '', '25');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (233, '233', 26, 'SIHUAS', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (234, '234', 26, 'ACOBAMBA', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (235, '235', 26, 'ALFONSO UGARTE', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (236, '236', 26, 'CASHAPAMPA', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (237, '237', 26, 'CHINGALPO', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (238, '238', 26, 'HUAYLLABAMBA', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (239, '239', 26, 'QUICHES', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (240, '240', 26, 'RAGASH', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (241, '241', 26, 'SAN JUAN', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (242, '242', 26, 'SICSIBAMBA', '', '26');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (243, '243', 27, 'YUNGAY', '', '27');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (244, '244', 27, 'CASCAPARA', '', '27');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (245, '245', 27, 'MANCOS', '', '27');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (246, '246', 27, 'MATACOTO', '', '27');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (247, '247', 27, 'QUILLO', '', '27');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (248, '248', 27, 'RANRAHIRCA', '', '27');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (249, '249', 27, 'SHUPLUY', '', '27');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (250, '250', 27, 'YANAMA', '', '27');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (251, '251', 28, 'ABANCAY', '', '28');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (252, '252', 28, 'CHACOCHE', '', '28');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (253, '253', 28, 'CIRCA', '', '28');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (254, '254', 28, 'CURAHUASI', '', '28');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (255, '255', 28, 'HUANIPACA', '', '28');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (256, '256', 28, 'LAMBRAMA', '', '28');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (257, '257', 28, 'PICHIRHUA', '', '28');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (258, '258', 28, 'SAN PEDRO DE CACHORA', '', '28');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (259, '259', 28, 'TAMBURCO', '', '28');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (260, '260', 29, 'ANDAHUAYLAS', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (261, '261', 29, 'ANDARAPA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (262, '262', 29, 'CHIARA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (263, '263', 29, 'HUANCARAMA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (264, '264', 29, 'HUANCARAY', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (265, '265', 29, 'HUAYANA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (266, '266', 29, 'KISHUARA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (267, '267', 29, 'PACOBAMBA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (268, '268', 29, 'PACUCHA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (269, '269', 29, 'PAMPACHIRI', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (270, '270', 29, 'POMACOCHA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (271, '271', 29, 'SAN ANTONIO DE CACHI', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (272, '272', 29, 'SAN JERÓNIMO', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (273, '273', 29, 'SAN MIGUEL DE CHACCRAMPA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (274, '274', 29, 'SANTA MARÍA DE CHICMO', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (275, '275', 29, 'TALAVERA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (276, '276', 29, 'TUMAY HUARACA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (277, '277', 29, 'TURPO', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (278, '278', 29, 'KAQUIABAMBA', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (279, '279', 29, 'JOSÉ MARÍA ARGUEDAS', '', '29');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (280, '280', 30, 'ANTABAMBA', '', '30');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (281, '281', 30, 'EL ORO', '', '30');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (282, '282', 30, 'HUAQUIRCA', '', '30');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (283, '283', 30, 'JUAN ESPINOZA MEDRANO', '', '30');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (284, '284', 30, 'OROPESA', '', '30');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (285, '285', 30, 'PACHACONAS', '', '30');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (286, '286', 30, 'SABAINO', '', '30');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (287, '287', 31, 'CHALHUANCA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (288, '288', 31, 'CAPAYA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (289, '289', 31, 'CARAYBAMBA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (290, '290', 31, 'CHAPIMARCA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (291, '291', 31, 'COLCABAMBA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (292, '292', 31, 'COTARUSE', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (293, '293', 31, 'HUAYLLO', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (294, '294', 31, 'JUSTO APU SAHUARAURA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (295, '295', 31, 'LUCRE', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (296, '296', 31, 'POCOHUANCA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (297, '297', 31, 'SAN JUAN DE CHACÑA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (298, '298', 31, 'SAÑAYCA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (299, '299', 31, 'SORAYA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (300, '300', 31, 'TAPAIRIHUA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (301, '301', 31, 'TINTAY', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (302, '302', 31, 'TORAYA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (303, '303', 31, 'YANACA', '', '31');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (304, '304', 32, 'TAMBOBAMBA', '', '32');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (305, '305', 32, 'COTABAMBAS', '', '32');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (306, '306', 32, 'COYLLURQUI', '', '32');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (307, '307', 32, 'HAQUIRA', '', '32');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (308, '308', 32, 'MARA', '', '32');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (309, '309', 32, 'CHALLHUAHUACHO', '', '32');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (310, '310', 33, 'CHINCHEROS', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (311, '311', 33, 'ANCO-HUALLO', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (312, '312', 33, 'COCHARCAS', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (313, '313', 33, 'HUACCANA', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (314, '314', 33, 'OCOBAMBA', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (315, '315', 33, 'ONGOY', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (316, '316', 33, 'URANMARCA', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (317, '317', 33, 'RANRACANCHA', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (318, '318', 33, 'ROCCHACC', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (319, '319', 33, 'EL PORVENIR', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (320, '320', 33, 'LOS CHANKAS', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (321, '321', 33, 'AHUAYRO', '', '33');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (322, '322', 34, 'CHUQUIBAMBILLA', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (323, '323', 34, 'CURPAHUASI', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (324, '324', 34, 'GAMARRA', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (325, '325', 34, 'HUAYLLATI', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (326, '326', 34, 'MAMARA', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (327, '327', 34, 'MICAELA BASTIDAS', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (328, '328', 34, 'PATAYPAMPA', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (329, '329', 34, 'PROGRESO', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (330, '330', 34, 'SAN ANTONIO', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (331, '331', 34, 'SANTA ROSA', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (332, '332', 34, 'TURPAY', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (333, '333', 34, 'VILCABAMBA', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (334, '334', 34, 'VIRUNDO', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (335, '335', 34, 'CURASCO', '', '34');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (336, '336', 35, 'AREQUIPA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (337, '337', 35, 'ALTO SELVA ALEGRE', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (338, '338', 35, 'CAYMA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (339, '339', 35, 'CERRO COLORADO', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (340, '340', 35, 'CHARACATO', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (341, '341', 35, 'CHIGUATA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (342, '342', 35, 'JACOBO HUNTER', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (343, '343', 35, 'LA JOYA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (344, '344', 35, 'MARIANO MELGAR', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (345, '345', 35, 'MIRAFLORES', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (346, '346', 35, 'MOLLEBAYA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (347, '347', 35, 'PAUCARPATA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (348, '348', 35, 'POCSI', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (349, '349', 35, 'POLOBAYA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (350, '350', 35, 'QUEQUEÑA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (351, '351', 35, 'SABANDÍA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (352, '352', 35, 'SACHACA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (353, '353', 35, 'SAN JUAN DE SIGUAS', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (354, '354', 35, 'SAN JUAN DE TARUCANI', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (355, '355', 35, 'SANTA ISABEL DE SIGUAS', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (356, '356', 35, 'SANTA RITA DE SIGUAS', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (357, '357', 35, 'SOCABAYA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (358, '358', 35, 'TIABAYA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (359, '359', 35, 'UCHUMAYO', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (360, '360', 35, 'VITOR', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (361, '361', 35, 'YANAHUARA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (362, '362', 35, 'YARABAMBA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (363, '363', 35, 'YURA', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (364, '364', 35, 'JOSÉ LUIS BUSTAMANTE Y RIVERO', '', '35');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (365, '365', 36, 'CAMANÁ', '', '36');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (366, '366', 36, 'JOSÉ MARÍA QUÍMPER', '', '36');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (367, '367', 36, 'MARIANO NICOLÁS VALCÁRCEL', '', '36');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (368, '368', 36, 'MARISCAL CÁCERES', '', '36');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (369, '369', 36, 'NICOLÁS DE PIÉROLA', '', '36');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (370, '370', 36, 'OCOÑA', '', '36');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (371, '371', 36, 'QUILCA', '', '36');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (372, '372', 36, 'SAMUEL PASTOR', '', '36');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (373, '373', 37, 'CARAVELÍ', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (374, '374', 37, 'ACARI', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (375, '375', 37, 'ATICO', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (376, '376', 37, 'ATIQUIPA', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (377, '377', 37, 'BELLA UNIÓN', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (378, '378', 37, 'CAHUACHO', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (379, '379', 37, 'CHALA', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (380, '380', 37, 'CHAPARRA', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (381, '381', 37, 'HUANUHUANU', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (382, '382', 37, 'JAQUI', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (383, '383', 37, 'LOMAS', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (384, '384', 37, 'QUICACHA', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (385, '385', 37, 'YAUCA', '', '37');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (386, '386', 38, 'APLAO', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (387, '387', 38, 'ANDAGUA', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (388, '388', 38, 'AYO', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (389, '389', 38, 'CHACHAS', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (390, '390', 38, 'CHILCAYMARCA', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (391, '391', 38, 'CHOCO', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (392, '392', 38, 'HUANCARQUI', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (393, '393', 38, 'MACHAGUAY', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (394, '394', 38, 'ORCOPAMPA', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (395, '395', 38, 'PAMPACOLCA', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (396, '396', 38, 'TIPAN', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (397, '397', 38, 'UÑÓN', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (398, '398', 38, 'URACA', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (399, '399', 38, 'VIRACO', '', '38');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (400, '400', 39, 'CHIVAY', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (401, '401', 39, 'ACHOMA', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (402, '402', 39, 'CABANACONDE', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (403, '403', 39, 'CALLALLI', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (404, '404', 39, 'CAYLLOMA', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (405, '405', 39, 'COPORAQUE', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (406, '406', 39, 'HUAMBO', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (407, '407', 39, 'HUANCA', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (408, '408', 39, 'ICHUPAMPA', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (409, '409', 39, 'LARI', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (410, '410', 39, 'LLUTA', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (411, '411', 39, 'MACA', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (412, '412', 39, 'MADRIGAL', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (413, '413', 39, 'SAN ANTONIO DE CHUCA', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (414, '414', 39, 'SIBAYO', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (415, '415', 39, 'TAPAY', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (416, '416', 39, 'TISCO', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (417, '417', 39, 'TUTI', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (418, '418', 39, 'YANQUE', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (419, '419', 39, 'MAJES', '', '39');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (420, '420', 40, 'CHUQUIBAMBA', '', '40');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (421, '421', 40, 'ANDARAY', '', '40');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (422, '422', 40, 'CAYARANI', '', '40');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (423, '423', 40, 'CHICHAS', '', '40');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (424, '424', 40, 'IRAY', '', '40');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (425, '425', 40, 'RÍO GRANDE', '', '40');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (426, '426', 40, 'SALAMANCA', '', '40');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (427, '427', 40, 'YANAQUIHUA', '', '40');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (428, '428', 41, 'MOLLENDO', '', '41');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (429, '429', 41, 'COCACHACRA', '', '41');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (430, '430', 41, 'DEAN VALDIVIA', '', '41');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (431, '431', 41, 'ISLAY', '', '41');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (432, '432', 41, 'MEJÍA', '', '41');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (433, '433', 41, 'PUNTA DE BOMBÓN', '', '41');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (434, '434', 42, 'COTAHUASI', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (435, '435', 42, 'ALCA', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (436, '436', 42, 'CHARCANA', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (437, '437', 42, 'HUAYNACOTAS', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (438, '438', 42, 'PAMPAMARCA', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (439, '439', 42, 'PUYCA', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (440, '440', 42, 'QUECHUALLA', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (441, '441', 42, 'SAYLA', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (442, '442', 42, 'TAURÍA', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (443, '443', 42, 'TOMEPAMPA', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (444, '444', 42, 'TORO', '', '42');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (445, '445', 43, 'AYACUCHO', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (446, '446', 43, 'ACOCRO', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (447, '447', 43, 'ACOS VINCHOS', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (448, '448', 43, 'CARMEN ALTO', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (449, '449', 43, 'CHIARA', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (450, '450', 43, 'OCROS', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (451, '451', 43, 'PACAYCASA', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (452, '452', 43, 'QUINUA', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (453, '453', 43, 'SAN JOSÉ DE TICLLAS', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (454, '454', 43, 'SAN JUAN BAUTISTA', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (455, '455', 43, 'SANTIAGO DE PISCHA', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (456, '456', 43, 'SOCOS', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (457, '457', 43, 'TAMBILLO', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (458, '458', 43, 'VINCHOS', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (459, '459', 43, 'JESÚS NAZARENO', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (460, '460', 43, 'ANDRÉS AVELINO CÁCERES DORREGARAY', '', '43');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (461, '461', 44, 'CANGALLO', '', '44');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (462, '462', 44, 'CHUSCHI', '', '44');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (463, '463', 44, 'LOS MOROCHUCOS', '', '44');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (464, '464', 44, 'MARÍA PARADO DE BELLIDO', '', '44');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (465, '465', 44, 'PARAS', '', '44');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (466, '466', 44, 'TOTOS', '', '44');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (467, '467', 45, 'SANCOS', '', '45');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (468, '468', 45, 'CARAPO', '', '45');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (469, '469', 45, 'SACSAMARCA', '', '45');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (470, '470', 45, 'SANTIAGO DE LUCANAMARCA', '', '45');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (471, '471', 46, 'HUANTA', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (472, '472', 46, 'AYAHUANCO', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (473, '473', 46, 'HUAMANGUILLA', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (474, '474', 46, 'IGUAIN', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (475, '475', 46, 'LURICOCHA', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (476, '476', 46, 'SANTILLANA', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (477, '477', 46, 'SIVIA', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (478, '478', 46, 'LLOCHEGUA', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (479, '479', 46, 'CANAYRE', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (480, '480', 46, 'UCHURACCAY', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (481, '481', 46, 'PUCACOLPA', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (482, '482', 46, 'CHACA', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (483, '483', 46, 'PUTIS', '', '46');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (484, '484', 47, 'SAN MIGUEL', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (485, '485', 47, 'ANCO', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (486, '486', 47, 'AYNA', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (487, '487', 47, 'CHILCAS', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (488, '488', 47, 'CHUNGUI', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (489, '489', 47, 'LUIS CARRANZA', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (490, '490', 47, 'SANTA ROSA', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (491, '491', 47, 'TAMBO', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (492, '492', 47, 'SAMUGARI', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (493, '493', 47, 'ANCHIHUAY', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (494, '494', 47, 'ORONCOY', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (495, '495', 47, 'UNIÓN PROGRESO', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (496, '496', 47, 'RIO MAGDALENA', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (497, '497', 47, 'NINABAMBA', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (498, '498', 47, 'PATIBAMBA', '', '47');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (499, '499', 48, 'PUQUIO', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (500, '500', 48, 'AUCARA', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (501, '501', 48, 'CABANA', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (502, '502', 48, 'CARMEN SALCEDO', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (503, '503', 48, 'CHAVIÑA', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (504, '504', 48, 'CHIPAO', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (505, '505', 48, 'HUAC-HUAS', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (506, '506', 48, 'LARAMATE', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (507, '507', 48, 'LEONCIO PRADO', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (508, '508', 48, 'LLAUTA', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (509, '509', 48, 'LUCANAS', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (510, '510', 48, 'OCAÑA', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (511, '511', 48, 'OTOCA', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (512, '512', 48, 'SAISA', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (513, '513', 48, 'SAN CRISTÓBAL', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (514, '514', 48, 'SAN JUAN', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (515, '515', 48, 'SAN PEDRO', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (516, '516', 48, 'SAN PEDRO DE PALCO', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (517, '517', 48, 'SANCOS', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (518, '518', 48, 'SANTA ANA DE HUAYCAHUACHO', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (519, '519', 48, 'SANTA LUCÍA', '', '48');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (520, '520', 49, 'CORACORA', '', '49');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (521, '521', 49, 'CHUMPI', '', '49');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (522, '522', 49, 'CORONEL CASTAÑEDA', '', '49');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (523, '523', 49, 'PACAPAUSA', '', '49');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (524, '524', 49, 'PULLO', '', '49');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (525, '525', 49, 'PUYUSCA', '', '49');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (526, '526', 49, 'SAN FRANCISCO DE RAVACAYCO', '', '49');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (527, '527', 49, 'UPAHUACHO', '', '49');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (528, '528', 50, 'PAUSA', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (529, '529', 50, 'COLTA', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (530, '530', 50, 'CORCULLA', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (531, '531', 50, 'LAMPA', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (532, '532', 50, 'MARCABAMBA', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (533, '533', 50, 'OYOLO', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (534, '534', 50, 'PARARCA', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (535, '535', 50, 'SAN JAVIER DE ALPABAMBA', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (536, '536', 50, 'SAN JOSÉ DE USHUA', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (537, '537', 50, 'SARA SARA', '', '50');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (538, '538', 51, 'QUEROBAMBA', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (539, '539', 51, 'BELÉN', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (540, '540', 51, 'CHALCOS', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (541, '541', 51, 'CHILCAYOC', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (542, '542', 51, 'HUACAÑA', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (543, '543', 51, 'MORCOLLA', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (544, '544', 51, 'PAICO', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (545, '545', 51, 'SAN PEDRO DE LARCAY', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (546, '546', 51, 'SAN SALVADOR DE QUIJE', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (547, '547', 51, 'SANTIAGO DE PÁUCARAY', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (548, '548', 51, 'SORAS', '', '51');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (549, '549', 52, 'HUANCAPI', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (550, '550', 52, 'ALCAMENCA', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (551, '551', 52, 'APONGO', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (552, '552', 52, 'ASQUIPATA', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (553, '553', 52, 'CANARIA', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (554, '554', 52, 'CAYARA', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (555, '555', 52, 'COLCA', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (556, '556', 52, 'HUAMÁNQUIQUIA', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (557, '557', 52, 'HUANCARAYLLA', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (558, '558', 52, 'HUAYA', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (559, '559', 52, 'SARHUA', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (560, '560', 52, 'VILCANCHOS', '', '52');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (561, '561', 53, 'VILCAS HUAMÁN', '', '53');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (562, '562', 53, 'ACCOMARCA', '', '53');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (563, '563', 53, 'CARHUANCA', '', '53');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (564, '564', 53, 'CONCEPCIÓN', '', '53');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (565, '565', 53, 'HUAMBALPA', '', '53');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (566, '566', 53, 'INDEPENDENCIA', '', '53');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (567, '567', 53, 'SAURAMA', '', '53');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (568, '568', 53, 'VISCHONGO', '', '53');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (569, '569', 54, 'CAJAMARCA', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (570, '570', 54, 'ASUNCIÓN', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (571, '571', 54, 'CHETILLA', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (572, '572', 54, 'COSPAN', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (573, '573', 54, 'ENCAÑADA', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (574, '574', 54, 'JESÚS', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (575, '575', 54, 'LLACANORA', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (576, '576', 54, 'LOS BAÑOS DEL INCA', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (577, '577', 54, 'MAGDALENA', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (578, '578', 54, 'MATARA', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (579, '579', 54, 'NAMORA', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (580, '580', 54, 'SAN JUAN', '', '54');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (581, '581', 55, 'CAJABAMBA', '', '55');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (582, '582', 55, 'CACHACHI', '', '55');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (583, '583', 55, 'CONDEBAMBA', '', '55');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (584, '584', 55, 'SITACOCHA', '', '55');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (585, '585', 56, 'CELENDÍN', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (586, '586', 56, 'CHUMUCH', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (587, '587', 56, 'CORTEGANA', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (588, '588', 56, 'HUASMIN', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (589, '589', 56, 'JORGE CHÁVEZ', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (590, '590', 56, 'JOSÉ GÁLVEZ', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (591, '591', 56, 'MIGUEL IGLESIAS', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (592, '592', 56, 'OXAMARCA', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (593, '593', 56, 'SOROCHUCO', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (594, '594', 56, 'SUCRE', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (595, '595', 56, 'UTCO', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (596, '596', 56, 'LA LIBERTAD DE PALLÁN', '', '56');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (597, '597', 57, 'CHOTA', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (598, '598', 57, 'ANGUÍA', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (599, '599', 57, 'CHADÍN', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (600, '600', 57, 'CHIGUIRIP', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (601, '601', 57, 'CHIMBAN', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (602, '602', 57, 'CHOROPAMPA', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (603, '603', 57, 'COCHABAMBA', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (604, '604', 57, 'CONCHÁN', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (605, '605', 57, 'HUAMBOS', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (606, '606', 57, 'LAJAS', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (607, '607', 57, 'LLAMA', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (608, '608', 57, 'MIRACOSTA', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (609, '609', 57, 'PACCHA', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (610, '610', 57, 'PIÓN', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (611, '611', 57, 'QUEROCOTO', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (612, '612', 57, 'SAN JUAN DE LICUPIS', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (613, '613', 57, 'TACABAMBA', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (614, '614', 57, 'TOCMOCHE', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (615, '615', 57, 'CHALAMARCA', '', '57');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (616, '616', 58, 'CONTUMAZÁ', '', '58');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (617, '617', 58, 'CHILETE', '', '58');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (618, '618', 58, 'CUPISNIQUE', '', '58');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (619, '619', 58, 'GUZMANGO', '', '58');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (620, '620', 58, 'SAN BENITO', '', '58');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (621, '621', 58, 'SANTA CRUZ DE TOLEDO', '', '58');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (622, '622', 58, 'TANTARICA', '', '58');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (623, '623', 58, 'YONAN', '', '58');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (624, '624', 59, 'CUTERVO', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (625, '625', 59, 'CALLAYUC', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (626, '626', 59, 'CHOROS', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (627, '627', 59, 'CUJILLO', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (628, '628', 59, 'LA RAMADA', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (629, '629', 59, 'PIMPINGOS', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (630, '630', 59, 'QUEROCOTILLO', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (631, '631', 59, 'SAN ANDRÉS DE CUTERVO', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (632, '632', 59, 'SAN JUAN DE CUTERVO', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (633, '633', 59, 'SAN LUIS DE LUCMA', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (634, '634', 59, 'SANTA CRUZ', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (635, '635', 59, 'SANTO DOMINGO DE LA CAPILLA', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (636, '636', 59, 'SANTO TOMÁS', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (637, '637', 59, 'SOCOTA', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (638, '638', 59, 'TORIBIO CASANOVA', '', '59');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (639, '639', 60, 'BAMBAMARCA', '', '60');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (640, '640', 60, 'CHUGUR', '', '60');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (641, '641', 60, 'HUALGAYOC', '', '60');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (642, '642', 61, 'JAÉN', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (643, '643', 61, 'BELLAVISTA', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (644, '644', 61, 'CHONTALI', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (645, '645', 61, 'COLASAY', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (646, '646', 61, 'HUABAL', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (647, '647', 61, 'LAS PIRIAS', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (648, '648', 61, 'POMAHUACA', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (649, '649', 61, 'PUCARA', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (650, '650', 61, 'SALLIQUE', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (651, '651', 61, 'SAN FELIPE', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (652, '652', 61, 'SAN JOSÉ DEL ALTO', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (653, '653', 61, 'SANTA ROSA', '', '61');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (654, '654', 62, 'SAN IGNACIO', '', '62');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (655, '655', 62, 'CHIRINOS', '', '62');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (656, '656', 62, 'HUARANGO', '', '62');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (657, '657', 62, 'LA COIPA', '', '62');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (658, '658', 62, 'NAMBALLE', '', '62');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (659, '659', 62, 'SAN JOSÉ DE LOURDES', '', '62');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (660, '660', 62, 'TABACONAS', '', '62');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (661, '661', 63, 'PEDRO GÁLVEZ', '', '63');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (662, '662', 63, 'CHANCAY', '', '63');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (663, '663', 63, 'EDUARDO VILLANUEVA', '', '63');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (664, '664', 63, 'GREGORIO PITA', '', '63');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (665, '665', 63, 'ICHOCAN', '', '63');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (666, '666', 63, 'JOSÉ MANUEL QUIROZ', '', '63');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (667, '667', 63, 'JOSÉ SABOGAL', '', '63');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (668, '668', 64, 'SAN MIGUEL', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (669, '669', 64, 'BOLÍVAR', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (670, '670', 64, 'CALQUIS', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (671, '671', 64, 'CATILLUC', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (672, '672', 64, 'EL PRADO', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (673, '673', 64, 'LA FLORIDA', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (674, '674', 64, 'LLAPA', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (675, '675', 64, 'NANCHOC', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (676, '676', 64, 'NIEPOS', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (677, '677', 64, 'SAN GREGORIO', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (678, '678', 64, 'SAN SILVESTRE DE COCHÁN', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (679, '679', 64, 'TONGOD', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (680, '680', 64, 'UNIÓN AGUA BLANCA', '', '64');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (681, '681', 65, 'SAN PABLO', '', '65');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (682, '682', 65, 'SAN BERNARDINO', '', '65');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (683, '683', 65, 'SAN LUIS', '', '65');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (684, '684', 65, 'TUMBADEN', '', '65');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (685, '685', 66, 'SANTA CRUZ', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (686, '686', 66, 'ANDABAMBA', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (687, '687', 66, 'CATACHE', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (688, '688', 66, 'CHANCAYBAÑOS', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (689, '689', 66, 'LA ESPERANZA', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (690, '690', 66, 'NINABAMBA', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (691, '691', 66, 'PULAN', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (692, '692', 66, 'SAUCEPAMPA', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (693, '693', 66, 'SEXI', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (694, '694', 66, 'UTICYACU', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (695, '695', 66, 'YAUYUCÁN', '', '66');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (696, '696', 67, 'CALLAO', '', '67');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (697, '697', 67, 'BELLAVISTA', '', '67');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (698, '698', 67, 'CARMEN DE LA LEGUA REYNOSO', '', '67');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (699, '699', 67, 'LA PERLA', '', '67');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (700, '700', 67, 'LA PUNTA', '', '67');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (701, '701', 67, 'VENTANILLA', '', '67');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (702, '702', 67, 'MI PERÚ', '', '67');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (703, '703', 68, 'CUSCO', '', '68');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (704, '704', 68, 'CCORCA', '', '68');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (705, '705', 68, 'POROY', '', '68');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (706, '706', 68, 'SAN JERÓNIMO', '', '68');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (707, '707', 68, 'SAN SEBASTIÁN', '', '68');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (708, '708', 68, 'SANTIAGO', '', '68');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (709, '709', 68, 'SAYLLA', '', '68');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (710, '710', 68, 'WANCHAQ', '', '68');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (711, '711', 69, 'ACOMAYO', '', '69');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (712, '712', 69, 'ACOPIA', '', '69');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (713, '713', 69, 'ACOS', '', '69');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (714, '714', 69, 'MOSOC LLACTA', '', '69');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (715, '715', 69, 'POMACANCHI', '', '69');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (716, '716', 69, 'RONDOCÁN', '', '69');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (717, '717', 69, 'SANGARARÁ', '', '69');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (718, '718', 70, 'ANTA', '', '70');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (719, '719', 70, 'ANCAHUASI', '', '70');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (720, '720', 70, 'CACHIMAYO', '', '70');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (721, '721', 70, 'CHINCHAYPUJIO', '', '70');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (722, '722', 70, 'HUAROCONDO', '', '70');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (723, '723', 70, 'LIMATAMBO', '', '70');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (724, '724', 70, 'MOLLEPATA', '', '70');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (725, '725', 70, 'PUCYURA', '', '70');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (726, '726', 70, 'ZURITE', '', '70');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (727, '727', 71, 'CALCA', '', '71');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (728, '728', 71, 'COYA', '', '71');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (729, '729', 71, 'LAMAY', '', '71');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (730, '730', 71, 'LARES', '', '71');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (731, '731', 71, 'PISAC', '', '71');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (732, '732', 71, 'SAN SALVADOR', '', '71');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (733, '733', 71, 'TARAY', '', '71');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (734, '734', 71, 'YANATILE', '', '71');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (735, '735', 72, 'YANAOCA', '', '72');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (736, '736', 72, 'CHECCA', '', '72');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (737, '737', 72, 'KUNTURKANKI', '', '72');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (738, '738', 72, 'LANGUI', '', '72');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (739, '739', 72, 'LAYO', '', '72');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (740, '740', 72, 'PAMPAMARCA', '', '72');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (741, '741', 72, 'QUEHUE', '', '72');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (742, '742', 72, 'TÚPAC AMARU', '', '72');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (743, '743', 73, 'SICUANI', '', '73');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (744, '744', 73, 'CHECACUPE', '', '73');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (745, '745', 73, 'COMBAPATA', '', '73');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (746, '746', 73, 'MARANGANI', '', '73');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (747, '747', 73, 'PITUMARCA', '', '73');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (748, '748', 73, 'SAN PABLO', '', '73');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (749, '749', 73, 'SAN PEDRO', '', '73');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (750, '750', 73, 'TINTA', '', '73');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (751, '751', 74, 'SANTO TOMÁS', '', '74');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (752, '752', 74, 'CAPACMARCA', '', '74');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (753, '753', 74, 'CHAMACA', '', '74');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (754, '754', 74, 'COLQUEMARCA', '', '74');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (755, '755', 74, 'LIVITACA', '', '74');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (756, '756', 74, 'LLUSCO', '', '74');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (757, '757', 74, 'QUIÑOTA', '', '74');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (758, '758', 74, 'VELILLE', '', '74');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (759, '759', 75, 'ESPINAR', '', '75');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (760, '760', 75, 'CONDOROMA', '', '75');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (761, '761', 75, 'COPORAQUE', '', '75');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (762, '762', 75, 'OCORURO', '', '75');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (763, '763', 75, 'PALLPATA', '', '75');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (764, '764', 75, 'PICHIGUA', '', '75');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (765, '765', 75, 'SUYCKUTAMBO', '', '75');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (766, '766', 75, 'ALTO PICHIGUA', '', '75');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (767, '767', 76, 'SANTA ANA', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (768, '768', 76, 'ECHARATE', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (769, '769', 76, 'HUAYOPATA', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (770, '770', 76, 'MARANURA', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (771, '771', 76, 'OCOBAMBA', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (772, '772', 76, 'QUELLOUNO', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (773, '773', 76, 'KIMBIRI', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (774, '774', 76, 'SANTA TERESA', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (775, '775', 76, 'VILCABAMBA', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (776, '776', 76, 'PICHARI', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (777, '777', 76, 'INKAWASI', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (778, '778', 76, 'VILLA VIRGEN', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (779, '779', 76, 'VILLA KINTIARINA', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (780, '780', 76, 'MEGANTONI', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (781, '781', 76, 'KUMPIRUSHIATO', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (782, '782', 76, 'CIELO PUNCO', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (783, '783', 76, 'MANITEA', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (784, '784', 76, 'UNIÓN ASHÁNINKA', '', '76');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (785, '785', 77, 'PARURO', '', '77');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (786, '786', 77, 'ACCHA', '', '77');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (787, '787', 77, 'CCAPI', '', '77');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (788, '788', 77, 'COLCHA', '', '77');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (789, '789', 77, 'HUANOQUITE', '', '77');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (790, '790', 77, 'OMACHA', '', '77');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (791, '791', 77, 'PACCARITAMBO', '', '77');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (792, '792', 77, 'PILLPINTO', '', '77');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (793, '793', 77, 'YAURISQUE', '', '77');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (794, '794', 78, 'PAUCARTAMBO', '', '78');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (795, '795', 78, 'CAICAY', '', '78');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (796, '796', 78, 'CHALLABAMBA', '', '78');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (797, '797', 78, 'COLQUEPATA', '', '78');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (798, '798', 78, 'HUANCARANI', '', '78');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (799, '799', 78, 'KOSÑIPATA', '', '78');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (800, '800', 79, 'URCOS', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (801, '801', 79, 'ANDAHUAYLILLAS', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (802, '802', 79, 'CAMANTI', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (803, '803', 79, 'CCARHUAYO', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (804, '804', 79, 'CCATCA', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (805, '805', 79, 'CUSIPATA', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (806, '806', 79, 'HUARO', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (807, '807', 79, 'LUCRE', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (808, '808', 79, 'MARCAPATA', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (809, '809', 79, 'OCONGATE', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (810, '810', 79, 'OROPESA', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (811, '811', 79, 'QUIQUIJANA', '', '79');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (812, '812', 80, 'URUBAMBA', '', '80');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (813, '813', 80, 'CHINCHERO', '', '80');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (814, '814', 80, 'HUAYLLABAMBA', '', '80');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (815, '815', 80, 'MACHUPICCHU', '', '80');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (816, '816', 80, 'MARAS', '', '80');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (817, '817', 80, 'OLLANTAYTAMBO', '', '80');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (818, '818', 80, 'YUCAY', '', '80');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (819, '819', 81, 'HUANCAVELICA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (820, '820', 81, 'ACOBAMBILLA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (821, '821', 81, 'ACORIA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (822, '822', 81, 'CONAYCA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (823, '823', 81, 'CUENCA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (824, '824', 81, 'HUACHOCOLPA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (825, '825', 81, 'HUAYLLAHUARA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (826, '826', 81, 'IZCUCHACA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (827, '827', 81, 'LARIA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (828, '828', 81, 'MANTA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (829, '829', 81, 'MARISCAL CÁCERES', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (830, '830', 81, 'MOYA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (831, '831', 81, 'NUEVO OCCORO', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (832, '832', 81, 'PALCA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (833, '833', 81, 'PILCHACA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (834, '834', 81, 'VILCA', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (835, '835', 81, 'YAULI', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (836, '836', 81, 'ASCENSIÓN', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (837, '837', 81, 'HUANDO', '', '81');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (838, '838', 82, 'ACOBAMBA', '', '82');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (839, '839', 82, 'ANDABAMBA', '', '82');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (840, '840', 82, 'ANTA', '', '82');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (841, '841', 82, 'CAJA', '', '82');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (842, '842', 82, 'MARCAS', '', '82');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (843, '843', 82, 'PAUCARÁ', '', '82');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (844, '844', 82, 'POMACOCHA', '', '82');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (845, '845', 82, 'ROSARIO', '', '82');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (846, '846', 83, 'LIRCAY', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (847, '847', 83, 'ANCHONGA', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (848, '848', 83, 'CALLANMARCA', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (849, '849', 83, 'CCOCHACCASA', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (850, '850', 83, 'CHINCHO', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (851, '851', 83, 'CONGALLA', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (852, '852', 83, 'HUANCA-HUANCA', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (853, '853', 83, 'HUAYLLAY GRANDE', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (854, '854', 83, 'JULCAMARCA', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (855, '855', 83, 'SAN ANTONIO DE ANTAPARCO', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (856, '856', 83, 'SANTO TOMÁS DE PATA', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (857, '857', 83, 'SECCLLA', '', '83');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (858, '858', 84, 'CASTROVIRREYNA', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (859, '859', 84, 'ARMA', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (860, '860', 84, 'AURAHUA', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (861, '861', 84, 'CAPILLAS', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (862, '862', 84, 'CHUPAMARCA', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (863, '863', 84, 'COCAS', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (864, '864', 84, 'HUACHOS', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (865, '865', 84, 'HUAMATAMBO', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (866, '866', 84, 'MOLLEPAMPA', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (867, '867', 84, 'SAN JUAN', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (868, '868', 84, 'SANTA ANA', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (869, '869', 84, 'TANTARÁ', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (870, '870', 84, 'TICRAPO', '', '84');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (871, '871', 85, 'CHURCAMPA', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (872, '872', 85, 'ANCO', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (873, '873', 85, 'CHINCHIHUASI', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (874, '874', 85, 'EL CARMEN', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (875, '875', 85, 'LA MERCED', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (876, '876', 85, 'LOCROJA', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (877, '877', 85, 'PAUCARBAMBA', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (878, '878', 85, 'SAN MIGUEL DE MAYOCC', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (879, '879', 85, 'SAN PEDRO DE CORIS', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (880, '880', 85, 'PACHAMARCA', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (881, '881', 85, 'COSME', '', '85');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (882, '882', 86, 'HUAYTARÁ', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (883, '883', 86, 'AYAVI', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (884, '884', 86, 'CORDOVA', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (885, '885', 86, 'HUAYACUNDO ARMA', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (886, '886', 86, 'LARAMARCA', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (887, '887', 86, 'OCOYO', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (888, '888', 86, 'PILPICHACA', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (889, '889', 86, 'QUERCO', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (890, '890', 86, 'QUITO-ARMA', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (891, '891', 86, 'SAN ANTONIO DE CUSICANCHA', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (892, '892', 86, 'SAN FRANCISCO DE SANGAYAICO', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (893, '893', 86, 'SAN ISIDRO', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (894, '894', 86, 'SANTIAGO DE CHOCORVOS', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (895, '895', 86, 'SANTIAGO DE QUIRAHUARA', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (896, '896', 86, 'SANTO DOMINGO DE CAPILLAS', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (897, '897', 86, 'TAMBO', '', '86');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (898, '898', 87, 'PAMPAS', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (899, '899', 87, 'ACOSTAMBO', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (900, '900', 87, 'ACRAQUIA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (901, '901', 87, 'AHUAYCHA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (902, '902', 87, 'COLCABAMBA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (903, '903', 87, 'DANIEL HERNANDEZ', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (904, '904', 87, 'HUACHOCOLPA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (905, '905', 87, 'HUARIBAMBA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (906, '906', 87, 'ÑAHUIMPUQUIO', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (907, '907', 87, 'PAZOS', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (908, '908', 87, 'QUISHUAR', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (909, '909', 87, 'SALCABAMBA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (910, '910', 87, 'SALCAHUASI', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (911, '911', 87, 'SAN MARCOS DE ROCCHAC', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (912, '912', 87, 'SURCUBAMBA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (913, '913', 87, 'TINTAY PUNCU', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (914, '914', 87, 'QUICHUAS', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (915, '915', 87, 'ANDAYMARCA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (916, '916', 87, 'ROBLE', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (917, '917', 87, 'PICHOS', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (918, '918', 87, 'SANTIAGO DE TUCUMA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (919, '919', 87, 'LAMBRAS', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (920, '920', 87, 'COCHABAMBA', '', '87');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (921, '921', 88, 'HUÁNUCO', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (922, '922', 88, 'AMARILIS', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (923, '923', 88, 'CHINCHAO', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (924, '924', 88, 'CHURUBAMBA', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (925, '925', 88, 'MARGOS', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (926, '926', 88, 'QUISQUI', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (927, '927', 88, 'SAN FRANCISCO DE CAYRÁN', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (928, '928', 88, 'SAN PEDRO DE CHAULÁN', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (929, '929', 88, 'SANTA MARÍA DEL VALLE', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (930, '930', 88, 'YARUMAYO', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (931, '931', 88, 'PILLCO MARCA', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (932, '932', 88, 'YACUS', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (933, '933', 88, 'SAN PABLO DE PILLAO', '', '88');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (934, '934', 89, 'AMBO', '', '89');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (935, '935', 89, 'CAYNA', '', '89');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (936, '936', 89, 'COLPAS', '', '89');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (937, '937', 89, 'CONCHAMARCA', '', '89');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (938, '938', 89, 'HUÁCAR', '', '89');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (939, '939', 89, 'SAN FRANCISCO', '', '89');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (940, '940', 89, 'SAN RAFAEL', '', '89');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (941, '941', 89, 'TOMAY KICHWA', '', '89');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (942, '942', 90, 'LA UNIÓN', '', '90');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (943, '943', 90, 'CHUQUIS', '', '90');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (944, '944', 90, 'MARÍAS', '', '90');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (945, '945', 90, 'PACHAS', '', '90');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (946, '946', 90, 'QUIVILLA', '', '90');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (947, '947', 90, 'RIPAN', '', '90');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (948, '948', 90, 'SHUNQUI', '', '90');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (949, '949', 90, 'SILLAPATA', '', '90');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (950, '950', 90, 'YANAS', '', '90');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (951, '951', 91, 'HUACAYBAMBA', '', '91');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (952, '952', 91, 'CANCHABAMBA', '', '91');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (953, '953', 91, 'COCHABAMBA', '', '91');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (954, '954', 91, 'PINRA', '', '91');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (955, '955', 92, 'LLATA', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (956, '956', 92, 'ARANCAY', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (957, '957', 92, 'CHAVÍN DE PARIARCA', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (958, '958', 92, 'JACAS GRANDE', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (959, '959', 92, 'JIRCÁN', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (960, '960', 92, 'MIRAFLORES', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (961, '961', 92, 'MONZÓN', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (962, '962', 92, 'PUNCHAO', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (963, '963', 92, 'PUÑOS', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (964, '964', 92, 'SINGA', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (965, '965', 92, 'TANTAMAYO', '', '92');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (966, '966', 93, 'RUPA-RUPA', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (967, '967', 93, 'DANIEL ALOMÍA ROBLES', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (968, '968', 93, 'HERMILIO VALDIZÁN', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (969, '969', 93, 'JOSÉ CRESPO Y CASTILLO', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (970, '970', 93, 'LUYANDO', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (971, '971', 93, 'MARIANO DAMASO BERAÚN', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (972, '972', 93, 'PUCAYACU', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (973, '973', 93, 'CASTILLO GRANDE', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (974, '974', 93, 'PUEBLO NUEVO', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (975, '975', 93, 'SANTO DOMINGO DE ANDA', '', '93');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (976, '976', 94, 'HUACRACHUCO', '', '94');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (977, '977', 94, 'CHOLÓN', '', '94');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (978, '978', 94, 'SAN BUENAVENTURA', '', '94');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (979, '979', 94, 'LA MORADA', '', '94');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (980, '980', 94, 'SANTA ROSA DE ALTO YANAJANCA', '', '94');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (981, '981', 95, 'PANAO', '', '95');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (982, '982', 95, 'CHAGLLA', '', '95');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (983, '983', 95, 'MOLINO', '', '95');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (984, '984', 95, 'UMARI', '', '95');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (985, '985', 96, 'PUERTO INCA', '', '96');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (986, '986', 96, 'CODO DEL POZUZO', '', '96');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (987, '987', 96, 'HONORIA', '', '96');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (988, '988', 96, 'TOURNAVISTA', '', '96');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (989, '989', 96, 'YUYAPICHIS', '', '96');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (990, '990', 97, 'JESÚS', '', '97');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (991, '991', 97, 'BAÑOS', '', '97');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (992, '992', 97, 'JIVIA', '', '97');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (993, '993', 97, 'QUEROPALCA', '', '97');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (994, '994', 97, 'RONDOS', '', '97');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (995, '995', 97, 'SAN FRANCISCO DE ASIS', '', '97');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (996, '996', 97, 'SAN MIGUEL DE CAURI', '', '97');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (997, '997', 98, 'CHAVINILLO', '', '98');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (998, '998', 98, 'CAHUAC', '', '98');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (999, '999', 98, 'CHACABAMBA', '', '98');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1000, '1000', 98, 'APARICIO POMARES', '', '98');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1001, '1001', 98, 'JACAS CHICO', '', '98');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1002, '1002', 98, 'OBAS', '', '98');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1003, '1003', 98, 'PAMPAMARCA', '', '98');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1004, '1004', 98, 'CHORAS', '', '98');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1005, '1005', 99, 'ICA', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1006, '1006', 99, 'LA TINGUIÑA', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1007, '1007', 99, 'LOS AQUIJES', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1008, '1008', 99, 'OCUCAJE', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1009, '1009', 99, 'PACHACUTEC', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1010, '1010', 99, 'PARCONA', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1011, '1011', 99, 'PUEBLO NUEVO', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1012, '1012', 99, 'SALAS', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1013, '1013', 99, 'SAN JOSÉ DE LOS MOLINOS', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1014, '1014', 99, 'SAN JUAN BAUTISTA', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1015, '1015', 99, 'SANTIAGO', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1016, '1016', 99, 'SUBTANJALLA', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1017, '1017', 99, 'TATE', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1018, '1018', 99, 'YAUCA DEL ROSARIO', '', '99');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1019, '1019', 100, 'CHINCHA ALTA', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1020, '1020', 100, 'ALTO LARAN', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1021, '1021', 100, 'CHAVÍN', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1022, '1022', 100, 'CHINCHA BAJA', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1023, '1023', 100, 'EL CARMEN', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1024, '1024', 100, 'GROCIO PRADO', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1025, '1025', 100, 'PUEBLO NUEVO', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1026, '1026', 100, 'SAN JUAN DE YANAC', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1027, '1027', 100, 'SAN PEDRO DE HUACARPANA', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1028, '1028', 100, 'SUNAMPE', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1029, '1029', 100, 'TAMBO DE MORA', '', '100');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1030, '1030', 101, 'NASCA', '', '101');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1031, '1031', 101, 'CHANGUILLO', '', '101');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1032, '1032', 101, 'EL INGENIO', '', '101');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1033, '1033', 101, 'MARCONA', '', '101');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1034, '1034', 101, 'VISTA ALEGRE', '', '101');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1035, '1035', 102, 'PALPA', '', '102');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1036, '1036', 102, 'LLIPATA', '', '102');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1037, '1037', 102, 'RÍO GRANDE', '', '102');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1038, '1038', 102, 'SANTA CRUZ', '', '102');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1039, '1039', 102, 'TIBILLO', '', '102');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1040, '1040', 103, 'PISCO', '', '103');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1041, '1041', 103, 'HUANCANO', '', '103');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1042, '1042', 103, 'HUMAY', '', '103');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1043, '1043', 103, 'INDEPENDENCIA', '', '103');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1044, '1044', 103, 'PARACAS', '', '103');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1045, '1045', 103, 'SAN ANDRÉS', '', '103');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1046, '1046', 103, 'SAN CLEMENTE', '', '103');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1047, '1047', 103, 'TÚPAC AMARU INCA', '', '103');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1048, '1048', 104, 'HUANCAYO', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1049, '1049', 104, 'CARHUACALLANGA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1050, '1050', 104, 'CHACAPAMPA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1051, '1051', 104, 'CHICCHE', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1052, '1052', 104, 'CHILCA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1053, '1053', 104, 'CHONGOS ALTO', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1054, '1054', 104, 'CHUPURO', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1055, '1055', 104, 'COLCA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1056, '1056', 104, 'CULLHUAS', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1057, '1057', 104, 'EL TAMBO', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1058, '1058', 104, 'HUACRAPUQUIO', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1059, '1059', 104, 'HUALHUAS', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1060, '1060', 104, 'HUANCAN', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1061, '1061', 104, 'HUASICANCHA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1062, '1062', 104, 'HUAYUCACHI', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1063, '1063', 104, 'INGENIO', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1064, '1064', 104, 'PARIAHUANCA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1065, '1065', 104, 'PILCOMAYO', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1066, '1066', 104, 'PUCARA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1067, '1067', 104, 'QUICHUAY', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1068, '1068', 104, 'QUILCAS', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1069, '1069', 104, 'SAN AGUSTÍN', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1070, '1070', 104, 'SAN JERÓNIMO DE TUNÁN', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1071, '1071', 104, 'SAÑO', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1072, '1072', 104, 'SAPALLANGA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1073, '1073', 104, 'SICAYA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1074, '1074', 104, 'SANTO DOMINGO DE ACOBAMBA', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1075, '1075', 104, 'VIQUES', '', '104');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1076, '1076', 105, 'CONCEPCIÓN', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1077, '1077', 105, 'ACO', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1078, '1078', 105, 'ANDAMARCA', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1079, '1079', 105, 'CHAMBARA', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1080, '1080', 105, 'COCHAS', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1081, '1081', 105, 'COMAS', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1082, '1082', 105, 'HEROÍNAS TOLEDO', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1083, '1083', 105, 'MANZANARES', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1084, '1084', 105, 'MARISCAL CASTILLA', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1085, '1085', 105, 'MATAHUASI', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1086, '1086', 105, 'MITO', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1087, '1087', 105, 'NUEVE DE JULIO', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1088, '1088', 105, 'ORCOTUNA', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1089, '1089', 105, 'SAN JOSÉ DE QUERO', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1090, '1090', 105, 'SANTA ROSA DE OCOPA', '', '105');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1091, '1091', 106, 'CHANCHAMAYO', '', '106');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1092, '1092', 106, 'PERENÉ', '', '106');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1093, '1093', 106, 'PICHANAQUI', '', '106');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1094, '1094', 106, 'SAN LUIS DE SHUARO', '', '106');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1095, '1095', 106, 'SAN RAMÓN', '', '106');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1096, '1096', 106, 'VITOC', '', '106');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1097, '1097', 107, 'JAUJA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1098, '1098', 107, 'ACOLLA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1099, '1099', 107, 'APATA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1100, '1100', 107, 'ATAURA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1101, '1101', 107, 'CANCHAYLLO', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1102, '1102', 107, 'CURICACA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1103, '1103', 107, 'EL MANTARO', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1104, '1104', 107, 'HUAMALI', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1105, '1105', 107, 'HUARIPAMPA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1106, '1106', 107, 'HUERTAS', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1107, '1107', 107, 'JANJAILLO', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1108, '1108', 107, 'JULCÁN', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1109, '1109', 107, 'LEONOR ORDÓÑEZ', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1110, '1110', 107, 'LLOCLLAPAMPA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1111, '1111', 107, 'MARCO', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1112, '1112', 107, 'MASMA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1113, '1113', 107, 'MASMA CHICCHE', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1114, '1114', 107, 'MOLINOS', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1115, '1115', 107, 'MONOBAMBA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1116, '1116', 107, 'MUQUI', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1117, '1117', 107, 'MUQUIYAUYO', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1118, '1118', 107, 'PACA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1119, '1119', 107, 'PACCHA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1120, '1120', 107, 'PANCAN', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1121, '1121', 107, 'PARCO', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1122, '1122', 107, 'POMACANCHA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1123, '1123', 107, 'RICRAN', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1124, '1124', 107, 'SAN LORENZO', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1125, '1125', 107, 'SAN PEDRO DE CHUNAN', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1126, '1126', 107, 'SAUSA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1127, '1127', 107, 'SINCOS', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1128, '1128', 107, 'TUNÁN MARCA', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1129, '1129', 107, 'YAULI', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1130, '1130', 107, 'YAUYOS', '', '107');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1131, '1131', 108, 'JUNÍN', '', '108');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1132, '1132', 108, 'CARHUAMAYO', '', '108');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1133, '1133', 108, 'ONDORES', '', '108');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1134, '1134', 108, 'ULCUMAYO', '', '108');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1135, '1135', 109, 'SATIPO', '', '109');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1136, '1136', 109, 'COVIRIALI', '', '109');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1137, '1137', 109, 'LLAYLLA', '', '109');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1138, '1138', 109, 'MAZAMARI', '', '109');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1139, '1139', 109, 'PAMPA HERMOSA', '', '109');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1140, '1140', 109, 'PANGOA', '', '109');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1141, '1141', 109, 'RÍO NEGRO', '', '109');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1142, '1142', 109, 'RÍO TAMBO', '', '109');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1143, '1143', 109, 'VIZCATÁN DEL ENE', '', '109');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1144, '1144', 110, 'TARMA', '', '110');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1145, '1145', 110, 'ACOBAMBA', '', '110');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1146, '1146', 110, 'HUARICOLCA', '', '110');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1147, '1147', 110, 'HUASAHUASI', '', '110');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1148, '1148', 110, 'LA UNIÓN', '', '110');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1149, '1149', 110, 'PALCA', '', '110');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1150, '1150', 110, 'PALCAMAYO', '', '110');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1151, '1151', 110, 'SAN PEDRO DE CAJAS', '', '110');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1152, '1152', 110, 'TAPO', '', '110');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1153, '1153', 111, 'LA OROYA', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1154, '1154', 111, 'CHACAPALPA', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1155, '1155', 111, 'HUAY-HUAY', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1156, '1156', 111, 'MARCAPOMACOCHA', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1157, '1157', 111, 'MOROCOCHA', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1158, '1158', 111, 'PACCHA', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1159, '1159', 111, 'SANTA BÁRBARA DE CARHUACAYAN', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1160, '1160', 111, 'SANTA ROSA DE SACCO', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1161, '1161', 111, 'SUITUCANCHA', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1162, '1162', 111, 'YAULI', '', '111');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1163, '1163', 112, 'CHUPACA', '', '112');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1164, '1164', 112, 'AHUAC', '', '112');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1165, '1165', 112, 'CHONGOS BAJO', '', '112');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1166, '1166', 112, 'HUACHAC', '', '112');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1167, '1167', 112, 'HUAMANCACA CHICO', '', '112');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1168, '1168', 112, 'SAN JUAN DE ISCOS', '', '112');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1169, '1169', 112, 'SAN JUAN DE JARPA', '', '112');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1170, '1170', 112, 'TRES DE DICIEMBRE', '', '112');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1171, '1171', 112, 'YANACANCHA', '', '112');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1172, '1172', 113, 'TRUJILLO', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1173, '1173', 113, 'EL PORVENIR', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1174, '1174', 113, 'FLORENCIA DE MORA', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1175, '1175', 113, 'HUANCHACO', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1176, '1176', 113, 'LA ESPERANZA', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1177, '1177', 113, 'LAREDO', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1178, '1178', 113, 'MOCHE', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1179, '1179', 113, 'POROTO', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1180, '1180', 113, 'SALAVERRY', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1181, '1181', 113, 'SIMBAL', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1182, '1182', 113, 'VÍCTOR LARCO HERRERA', '', '113');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1183, '1183', 114, 'ASCOPE', '', '114');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1184, '1184', 114, 'CHICAMA', '', '114');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1185, '1185', 114, 'CHOCOPE', '', '114');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1186, '1186', 114, 'MAGDALENA DE CAO', '', '114');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1187, '1187', 114, 'PAIJÁN', '', '114');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1188, '1188', 114, 'RÁZURI', '', '114');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1189, '1189', 114, 'SANTIAGO DE CAO', '', '114');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1190, '1190', 114, 'CASA GRANDE', '', '114');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1191, '1191', 115, 'BOLÍVAR', '', '115');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1192, '1192', 115, 'BAMBAMARCA', '', '115');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1193, '1193', 115, 'CONDORMARCA', '', '115');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1194, '1194', 115, 'LONGOTEA', '', '115');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1195, '1195', 115, 'UCHUMARCA', '', '115');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1196, '1196', 115, 'UCUNCHA', '', '115');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1197, '1197', 116, 'CHEPÉN', '', '116');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1198, '1198', 116, 'PACANGA', '', '116');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1199, '1199', 116, 'PUEBLO NUEVO', '', '116');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1200, '1200', 117, 'JULCÁN', '', '117');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1201, '1201', 117, 'CALAMARCA', '', '117');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1202, '1202', 117, 'CARABAMBA', '', '117');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1203, '1203', 117, 'HUASO', '', '117');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1204, '1204', 118, 'OTUZCO', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1205, '1205', 118, 'AGALLPAMPA', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1206, '1206', 118, 'CHARAT', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1207, '1207', 118, 'HUARANCHAL', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1208, '1208', 118, 'LA CUESTA', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1209, '1209', 118, 'MACHE', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1210, '1210', 118, 'PARANDAY', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1211, '1211', 118, 'SALPO', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1212, '1212', 118, 'SINSICAP', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1213, '1213', 118, 'USQUIL', '', '118');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1214, '1214', 119, 'SAN PEDRO DE LLOC', '', '119');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1215, '1215', 119, 'GUADALUPE', '', '119');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1216, '1216', 119, 'JEQUETEPEQUE', '', '119');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1217, '1217', 119, 'PACASMAYO', '', '119');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1218, '1218', 119, 'SAN JOSÉ', '', '119');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1219, '1219', 120, 'TAYABAMBA', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1220, '1220', 120, 'BULDIBUYO', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1221, '1221', 120, 'CHILLIA', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1222, '1222', 120, 'HUANCASPATA', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1223, '1223', 120, 'HUAYLILLAS', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1224, '1224', 120, 'HUAYO', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1225, '1225', 120, 'ONGON', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1226, '1226', 120, 'PARCOY', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1227, '1227', 120, 'PATAZ', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1228, '1228', 120, 'PIAS', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1229, '1229', 120, 'SANTIAGO DE CHALLAS', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1230, '1230', 120, 'TAURIJA', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1231, '1231', 120, 'URPAY', '', '120');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1232, '1232', 121, 'HUAMACHUCO', '', '121');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1233, '1233', 121, 'CHUGAY', '', '121');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1234, '1234', 121, 'COCHORCO', '', '121');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1235, '1235', 121, 'CURGOS', '', '121');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1236, '1236', 121, 'MARCABAL', '', '121');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1237, '1237', 121, 'SANAGORAN', '', '121');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1238, '1238', 121, 'SARÍN', '', '121');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1239, '1239', 121, 'SARTIMBAMBA', '', '121');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1240, '1240', 122, 'SANTIAGO DE CHUCO', '', '122');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1241, '1241', 122, 'ANGASMARCA', '', '122');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1242, '1242', 122, 'CACHICADÁN', '', '122');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1243, '1243', 122, 'MOLLEBAMBA', '', '122');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1244, '1244', 122, 'MOLLEPATA', '', '122');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1245, '1245', 122, 'QUIRUVILCA', '', '122');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1246, '1246', 122, 'SANTA CRUZ DE CHUCA', '', '122');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1247, '1247', 122, 'SITABAMBA', '', '122');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1248, '1248', 123, 'CASCAS', '', '123');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1249, '1249', 123, 'LUCMA', '', '123');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1250, '1250', 123, 'MARMOT', '', '123');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1251, '1251', 123, 'SAYAPULLO', '', '123');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1252, '1252', 124, 'VIRÚ', '', '124');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1253, '1253', 124, 'CHAO', '', '124');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1254, '1254', 124, 'GUADALUPITO', '', '124');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1255, '1255', 125, 'CHICLAYO', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1256, '1256', 125, 'CHONGOYAPE', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1257, '1257', 125, 'ETÉN', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1258, '1258', 125, 'ETÉN PUERTO', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1259, '1259', 125, 'JOSÉ LEONARDO ORTÍZ', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1260, '1260', 125, 'LA VICTORIA', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1261, '1261', 125, 'LAGUNAS', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1262, '1262', 125, 'MONSEFÚ', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1263, '1263', 125, 'NUEVA ARICA', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1264, '1264', 125, 'OYOTÚN', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1265, '1265', 125, 'PICSI', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1266, '1266', 125, 'PIMENTEL', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1267, '1267', 125, 'REQUE', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1268, '1268', 125, 'SANTA ROSA', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1269, '1269', 125, 'SAÑA', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1270, '1270', 125, 'CAYALTI', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1271, '1271', 125, 'PÁTAPO', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1272, '1272', 125, 'POMALCA', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1273, '1273', 125, 'PUCALÁ', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1274, '1274', 125, 'TUMÁN', '', '125');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1275, '1275', 126, 'FERREÑAFE', '', '126');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1276, '1276', 126, 'CAÑARIS', '', '126');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1277, '1277', 126, 'INCAHUASI', '', '126');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1278, '1278', 126, 'MANUEL ANTONIO MESONES MURO', '', '126');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1279, '1279', 126, 'PÍTIPO', '', '126');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1280, '1280', 126, 'PUEBLO NUEVO', '', '126');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1281, '1281', 127, 'LAMBAYEQUE', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1282, '1282', 127, 'CHOCHOPE', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1283, '1283', 127, 'ÍLLIMO', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1284, '1284', 127, 'JAYANCA', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1285, '1285', 127, 'MOCHUMI', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1286, '1286', 127, 'MÓRROPE', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1287, '1287', 127, 'MOTUPE', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1288, '1288', 127, 'OLMOS', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1289, '1289', 127, 'PACORA', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1290, '1290', 127, 'SALAS', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1291, '1291', 127, 'SAN JOSÉ', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1292, '1292', 127, 'TÚCUME', '', '127');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1293, '1293', 128, 'LIMA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1294, '1294', 128, 'ANCÓN', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1295, '1295', 128, 'ATE', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1296, '1296', 128, 'BARRANCO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1297, '1297', 128, 'BREÑA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1298, '1298', 128, 'CARABAYLLO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1299, '1299', 128, 'CHACLACAYO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1300, '1300', 128, 'CHORRILLOS', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1301, '1301', 128, 'CIENEGUILLA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1302, '1302', 128, 'COMAS', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1303, '1303', 128, 'EL AGUSTINO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1304, '1304', 128, 'INDEPENDENCIA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1305, '1305', 128, 'JESÚS MARÍA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1306, '1306', 128, 'LA MOLINA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1307, '1307', 128, 'LA VICTORIA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1308, '1308', 128, 'LINCE', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1309, '1309', 128, 'LOS OLIVOS', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1310, '1310', 128, 'LURIGANCHO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1311, '1311', 128, 'LURÍN', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1312, '1312', 128, 'MAGDALENA DEL MAR', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1313, '1313', 128, 'PUEBLO LIBRE', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1314, '1314', 128, 'MIRAFLORES', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1315, '1315', 128, 'PACHACAMAC', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1316, '1316', 128, 'PUCUSANA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1317, '1317', 128, 'PUENTE PIEDRA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1318, '1318', 128, 'PUNTA HERMOSA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1319, '1319', 128, 'PUNTA NEGRA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1320, '1320', 128, 'RÍMAC', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1321, '1321', 128, 'SAN BARTOLO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1322, '1322', 128, 'SAN BORJA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1323, '1323', 128, 'SAN ISIDRO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1324, '1324', 128, 'SAN JUAN DE LURIGANCHO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1325, '1325', 128, 'SAN JUAN DE MIRAFLORES', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1326, '1326', 128, 'SAN LUIS', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1327, '1327', 128, 'SAN MARTÍN DE PORRES', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1328, '1328', 128, 'SAN MIGUEL', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1329, '1329', 128, 'SANTA ANITA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1330, '1330', 128, 'SANTA MARÍA DEL MAR', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1331, '1331', 128, 'SANTA ROSA', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1332, '1332', 128, 'SANTIAGO DE SURCO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1333, '1333', 128, 'SURQUILLO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1334, '1334', 128, 'VILLA EL SALVADOR', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1335, '1335', 128, 'VILLA MARÍA DEL TRIUNFO', '', '128');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1336, '1336', 129, 'BARRANCA', '', '129');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1337, '1337', 129, 'PARAMONGA', '', '129');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1338, '1338', 129, 'PATIVILCA', '', '129');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1339, '1339', 129, 'SUPE', '', '129');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1340, '1340', 129, 'SUPE PUERTO', '', '129');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1341, '1341', 130, 'CAJATAMBO', '', '130');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1342, '1342', 130, 'COPA', '', '130');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1343, '1343', 130, 'GORGOR', '', '130');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1344, '1344', 130, 'HUANCAPÓN', '', '130');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1345, '1345', 130, 'MANAS', '', '130');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1346, '1346', 131, 'CANTA', '', '131');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1347, '1347', 131, 'ARAHUAY', '', '131');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1348, '1348', 131, 'HUAMANTANGA', '', '131');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1349, '1349', 131, 'HUAROS', '', '131');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1350, '1350', 131, 'LACHAQUI', '', '131');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1351, '1351', 131, 'SAN BUENAVENTURA', '', '131');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1352, '1352', 131, 'SANTA ROSA DE QUIVES', '', '131');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1353, '1353', 132, 'SAN VICENTE DE CAÑETE', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1354, '1354', 132, 'ASIA', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1355, '1355', 132, 'CALANGO', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1356, '1356', 132, 'CERRO AZUL', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1357, '1357', 132, 'CHILCA', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1358, '1358', 132, 'COAYLLO', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1359, '1359', 132, 'IMPERIAL', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1360, '1360', 132, 'LUNAHUANA', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1361, '1361', 132, 'MALA', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1362, '1362', 132, 'NUEVO IMPERIAL', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1363, '1363', 132, 'PACARÁN', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1364, '1364', 132, 'QUILMANÁ', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1365, '1365', 132, 'SAN ANTONIO', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1366, '1366', 132, 'SAN LUIS', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1367, '1367', 132, 'SANTA CRUZ DE FLORES', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1368, '1368', 132, 'ZÚÑIGA', '', '132');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1369, '1369', 133, 'HUARAL', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1370, '1370', 133, 'ATAVILLOS ALTO', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1371, '1371', 133, 'ATAVILLOS BAJO', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1372, '1372', 133, 'AUCALLAMA', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1373, '1373', 133, 'CHANCAY', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1374, '1374', 133, 'IHUARI', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1375, '1375', 133, 'LAMPIAN', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1376, '1376', 133, 'PACARAOS', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1377, '1377', 133, 'SAN MIGUEL DE ACOS', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1378, '1378', 133, 'SANTA CRUZ DE ANDAMARCA', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1379, '1379', 133, 'SUMBILCA', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1380, '1380', 133, 'VEINTISIETE DE NOVIEMBRE', '', '133');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1381, '1381', 134, 'MATUCANA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1382, '1382', 134, 'ANTIOQUIA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1383, '1383', 134, 'CALLAHUANCA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1384, '1384', 134, 'CARAMPOMA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1385, '1385', 134, 'CHICLA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1386, '1386', 134, 'CUENCA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1387, '1387', 134, 'HUACHUPAMPA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1388, '1388', 134, 'HUANZA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1389, '1389', 134, 'HUAROCHIRÍ', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1390, '1390', 134, 'LAHUAYTAMBO', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1391, '1391', 134, 'LANGA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1392, '1392', 134, 'LARAOS', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1393, '1393', 134, 'MARIATANA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1394, '1394', 134, 'RICARDO PALMA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1395, '1395', 134, 'SAN ANDRÉS DE TUPICOCHA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1396, '1396', 134, 'SAN ANTONIO', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1397, '1397', 134, 'SAN BARTOLOMÉ', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1398, '1398', 134, 'SAN DAMIÁN', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1399, '1399', 134, 'SAN JUAN DE IRIS', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1400, '1400', 134, 'SAN JUAN DE TANTARANCHE', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1401, '1401', 134, 'SAN LORENZO DE QUINTI', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1402, '1402', 134, 'SAN MATEO', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1403, '1403', 134, 'SAN MATEO DE OTAO', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1404, '1404', 134, 'SAN PEDRO DE CASTA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1405, '1405', 134, 'SAN PEDRO DE HUANCAYRE', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1406, '1406', 134, 'SANGALLAYA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1407, '1407', 134, 'SANTA CRUZ DE COCACHACRA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1408, '1408', 134, 'SANTA EULALIA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1409, '1409', 134, 'SANTIAGO DE ANCHUCAYA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1410, '1410', 134, 'SANTIAGO DE TUNA', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1411, '1411', 134, 'SANTO DOMINGO DE LOS OLLEROS', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1412, '1412', 134, 'SURCO', '', '134');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1413, '1413', 135, 'HUACHO', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1414, '1414', 135, 'AMBAR', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1415, '1415', 135, 'CALETA DE CARQUÍN', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1416, '1416', 135, 'CHECRAS', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1417, '1417', 135, 'HUALMAY', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1418, '1418', 135, 'HUAURA', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1419, '1419', 135, 'LEONCIO PRADO', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1420, '1420', 135, 'PACCHO', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1421, '1421', 135, 'SANTA LEONOR', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1422, '1422', 135, 'SANTA MARÍA', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1423, '1423', 135, 'SAYÁN', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1424, '1424', 135, 'VEGUETA', '', '135');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1425, '1425', 136, 'OYÓN', '', '136');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1426, '1426', 136, 'ANDAJES', '', '136');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1427, '1427', 136, 'CAUJUL', '', '136');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1428, '1428', 136, 'COCHAMARCA', '', '136');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1429, '1429', 136, 'NAVÁN', '', '136');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1430, '1430', 136, 'PACHANGARA', '', '136');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1431, '1431', 137, 'YAUYOS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1432, '1432', 137, 'ALIS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1433, '1433', 137, 'AYAUCA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1434, '1434', 137, 'AYAVIRI', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1435, '1435', 137, 'AZÁNGARO', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1436, '1436', 137, 'CACRA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1437, '1437', 137, 'CARANIA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1438, '1438', 137, 'CATAHUASI', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1439, '1439', 137, 'CHOCOS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1440, '1440', 137, 'COCHAS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1441, '1441', 137, 'COLONIA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1442, '1442', 137, 'HONGOS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1443, '1443', 137, 'HUAMPARA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1444, '1444', 137, 'HUANCAYA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1445, '1445', 137, 'HUANGASCAR', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1446, '1446', 137, 'HUANTAN', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1447, '1447', 137, 'HUAÑEC', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1448, '1448', 137, 'LARAOS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1449, '1449', 137, 'LINCHA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1450, '1450', 137, 'MADEAN', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1451, '1451', 137, 'MIRAFLORES', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1452, '1452', 137, 'OMAS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1453, '1453', 137, 'PUTINZA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1454, '1454', 137, 'QUINCHES', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1455, '1455', 137, 'QUINOCAY', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1456, '1456', 137, 'SAN JOAQUÍN', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1457, '1457', 137, 'SAN PEDRO DE PILAS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1458, '1458', 137, 'TANTA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1459, '1459', 137, 'TAURIPAMPA', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1460, '1460', 137, 'TOMÁS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1461, '1461', 137, 'TUPE', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1462, '1462', 137, 'VIÑAC', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1463, '1463', 137, 'VITIS', '', '137');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1464, '1464', 138, 'IQUITOS', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1465, '1465', 138, 'ALTO NANAY', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1466, '1466', 138, 'FERNANDO LORES', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1467, '1467', 138, 'INDIANA', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1468, '1468', 138, 'LAS AMAZONAS', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1469, '1469', 138, 'MAZÁN', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1470, '1470', 138, 'NAPO', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1471, '1471', 138, 'PUNCHANA', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1472, '1472', 138, 'TORRES CAUSANA', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1473, '1473', 138, 'BELÉN', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1474, '1474', 138, 'SAN JUAN BAUTISTA', '', '138');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1475, '1475', 139, 'YURIMAGUAS', '', '139');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1476, '1476', 139, 'BALSAPUERTO', '', '139');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1477, '1477', 139, 'JEBEROS', '', '139');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1478, '1478', 139, 'LAGUNAS', '', '139');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1479, '1479', 139, 'SANTA CRUZ', '', '139');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1480, '1480', 139, 'TENIENTE CÉSAR LÓPEZ ROJAS', '', '139');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1481, '1481', 140, 'NAUTA', '', '140');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1482, '1482', 140, 'PARINARI', '', '140');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1483, '1483', 140, 'TIGRE', '', '140');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1484, '1484', 140, 'TROMPETEROS', '', '140');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1485, '1485', 140, 'URARINAS', '', '140');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1486, '1486', 141, 'RAMÓN CASTILLA', '', '141');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1487, '1487', 141, 'PEBAS', '', '141');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1488, '1488', 141, 'YAVARI', '', '141');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1489, '1489', 141, 'SAN PABLO', '', '141');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1490, '1490', 142, 'REQUENA', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1491, '1491', 142, 'ALTO TAPICHE', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1492, '1492', 142, 'CAPELO', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1493, '1493', 142, 'EMILIO SAN MARTÍN', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1494, '1494', 142, 'MAQUIA', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1495, '1495', 142, 'PUINAHUA', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1496, '1496', 142, 'SAQUENA', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1497, '1497', 142, 'SOPLIN', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1498, '1498', 142, 'TAPICHE', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1499, '1499', 142, 'JENARO HERRERA', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1500, '1500', 142, 'YAQUERANA', '', '142');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1501, '1501', 143, 'CONTAMANA', '', '143');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1502, '1502', 143, 'INAHUAYA', '', '143');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1503, '1503', 143, 'PADRE MARQUEZ', '', '143');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1504, '1504', 143, 'PAMPA HERMOSA', '', '143');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1505, '1505', 143, 'SARAYACU', '', '143');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1506, '1506', 143, 'VARGAS GUERRA', '', '143');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1507, '1507', 144, 'BARRANCA', '', '144');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1508, '1508', 144, 'CAHUAPANAS', '', '144');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1509, '1509', 144, 'MANSERICHE', '', '144');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1510, '1510', 144, 'MORONA', '', '144');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1511, '1511', 144, 'PASTAZA', '', '144');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1512, '1512', 144, 'ANDOAS', '', '144');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1513, '1513', 145, 'PUTUMAYO', '', '145');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1514, '1514', 145, 'ROSA PANDURO', '', '145');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1515, '1515', 145, 'TENIENTE MANUEL CLAVERO', '', '145');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1516, '1516', 145, 'YAGUAS', '', '145');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1517, '1517', 146, 'TAMBOPATA', '', '146');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1518, '1518', 146, 'INAMBARI', '', '146');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1519, '1519', 146, 'LAS PIEDRAS', '', '146');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1520, '1520', 146, 'LABERINTO', '', '146');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1521, '1521', 147, 'MANU', '', '147');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1522, '1522', 147, 'FITZCARRALD', '', '147');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1523, '1523', 147, 'MADRE DE DIOS', '', '147');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1524, '1524', 147, 'HUEPETUHE', '', '147');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1525, '1525', 148, 'IÑAPARI', '', '148');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1526, '1526', 148, 'IBERIA', '', '148');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1527, '1527', 148, 'TAHUAMANU', '', '148');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1528, '1528', 149, 'MOQUEGUA', '', '149');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1529, '1529', 149, 'CARUMAS', '', '149');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1530, '1530', 149, 'CUCHUMBAYA', '', '149');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1531, '1531', 149, 'SAMEGUA', '', '149');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1532, '1532', 149, 'SAN CRISTÓBAL', '', '149');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1533, '1533', 149, 'TORATA', '', '149');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1534, '1534', 149, 'SAN ANTONIO', '', '149');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1535, '1535', 150, 'OMATE', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1536, '1536', 150, 'CHOJATA', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1537, '1537', 150, 'COALAQUE', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1538, '1538', 150, 'ICHUÑA', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1539, '1539', 150, 'LA CAPILLA', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1540, '1540', 150, 'LLOQUE', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1541, '1541', 150, 'MATALAQUE', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1542, '1542', 150, 'PUQUINA', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1543, '1543', 150, 'QUINISTAQUILLAS', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1544, '1544', 150, 'UBINAS', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1545, '1545', 150, 'YUNGA', '', '150');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1546, '1546', 151, 'ILO', '', '151');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1547, '1547', 151, 'EL ALGARROBAL', '', '151');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1548, '1548', 151, 'PACOCHA', '', '151');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1549, '1549', 152, 'CHAUPIMARCA', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1550, '1550', 152, 'HUACHÓN', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1551, '1551', 152, 'HUARIACA', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1552, '1552', 152, 'HUAYLLAY', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1553, '1553', 152, 'NINACACA', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1554, '1554', 152, 'PALLANCHACRA', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1555, '1555', 152, 'PAUCARTAMBO', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1556, '1556', 152, 'SAN FCO.DE ASIS DE YARUSYAC', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1557, '1557', 152, 'SIMON BOLÍVAR', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1558, '1558', 152, 'TICLACAYAN', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1559, '1559', 152, 'TINYAHUARCO', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1560, '1560', 152, 'VICCO', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1561, '1561', 152, 'YANACANCHA', '', '152');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1562, '1562', 153, 'YANAHUANCA', '', '153');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1563, '1563', 153, 'CHACAYAN', '', '153');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1564, '1564', 153, 'GOYLLARISQUIZGA', '', '153');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1565, '1565', 153, 'PÁUCAR', '', '153');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1566, '1566', 153, 'SAN PEDRO DE PILLAO', '', '153');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1567, '1567', 153, 'SANTA ANA DE TUSI', '', '153');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1568, '1568', 153, 'TÁPUC', '', '153');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1569, '1569', 153, 'VILCABAMBA', '', '153');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1570, '1570', 154, 'OXAPAMPA', '', '154');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1571, '1571', 154, 'CHONTABAMBA', '', '154');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1572, '1572', 154, 'HUANCABAMBA', '', '154');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1573, '1573', 154, 'PALCAZU', '', '154');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1574, '1574', 154, 'POZUZO', '', '154');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1575, '1575', 154, 'PUERTO BERMÚDEZ', '', '154');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1576, '1576', 154, 'VILLA RICA', '', '154');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1577, '1577', 154, 'CONSTITUCIÓN', '', '154');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1578, '1578', 155, 'PIURA', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1579, '1579', 155, 'CASTILLA', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1580, '1580', 155, 'CATACAOS', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1581, '1581', 155, 'CURA MORI', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1582, '1582', 155, 'EL TALLAN', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1583, '1583', 155, 'LA ARENA', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1584, '1584', 155, 'LA UNIÓN', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1585, '1585', 155, 'LAS LOMAS', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1586, '1586', 155, 'TAMBO GRANDE', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1587, '1587', 155, 'VEINTISÉIS DE OCTUBRE', '', '155');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1588, '1588', 156, 'AYABACA', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1589, '1589', 156, 'FRIAS', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1590, '1590', 156, 'JILILI', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1591, '1591', 156, 'LAGUNAS', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1592, '1592', 156, 'MONTERO', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1593, '1593', 156, 'PACAIPAMPA', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1594, '1594', 156, 'PAIMAS', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1595, '1595', 156, 'SAPILLICA', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1596, '1596', 156, 'SICCHEZ', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1597, '1597', 156, 'SUYO', '', '156');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1598, '1598', 157, 'HUANCABAMBA', '', '157');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1599, '1599', 157, 'CANCHAQUE', '', '157');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1600, '1600', 157, 'EL CARMEN DE LA FRONTERA', '', '157');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1601, '1601', 157, 'HUARMACA', '', '157');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1602, '1602', 157, 'LALAQUIZ', '', '157');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1603, '1603', 157, 'SAN MIGUEL DE EL FAIQUE', '', '157');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1604, '1604', 157, 'SONDOR', '', '157');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1605, '1605', 157, 'SONDORILLO', '', '157');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1606, '1606', 158, 'CHULUCANAS', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1607, '1607', 158, 'BUENOS AIRES', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1608, '1608', 158, 'CHALACO', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1609, '1609', 158, 'LA MATANZA', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1610, '1610', 158, 'MORROPÓN', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1611, '1611', 158, 'SALITRAL', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1612, '1612', 158, 'SAN JUAN DE BIGOTE', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1613, '1613', 158, 'SANTA CATALINA DE MOSSA', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1614, '1614', 158, 'SANTO DOMINGO', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1615, '1615', 158, 'YAMANGO', '', '158');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1616, '1616', 159, 'PAITA', '', '159');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1617, '1617', 159, 'AMOTAPE', '', '159');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1618, '1618', 159, 'ARENAL', '', '159');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1619, '1619', 159, 'COLÁN', '', '159');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1620, '1620', 159, 'LA HUACA', '', '159');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1621, '1621', 159, 'TAMARINDO', '', '159');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1622, '1622', 159, 'VICHAYAL', '', '159');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1623, '1623', 160, 'SULLANA', '', '160');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1624, '1624', 160, 'BELLAVISTA', '', '160');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1625, '1625', 160, 'IGNACIO ESCUDERO', '', '160');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1626, '1626', 160, 'LANCONES', '', '160');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1627, '1627', 160, 'MARCAVELICA', '', '160');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1628, '1628', 160, 'MIGUEL CHECA', '', '160');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1629, '1629', 160, 'QUERECOTILLO', '', '160');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1630, '1630', 160, 'SALITRAL', '', '160');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1631, '1631', 161, 'PARIÑAS', '', '161');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1632, '1632', 161, 'EL ALTO', '', '161');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1633, '1633', 161, 'LA BREA', '', '161');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1634, '1634', 161, 'LOBITOS', '', '161');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1635, '1635', 161, 'LOS ÓRGANOS', '', '161');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1636, '1636', 161, 'MÁNCORA', '', '161');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1637, '1637', 162, 'SECHURA', '', '162');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1638, '1638', 162, 'BELLAVISTA DE LA UNIÓN', '', '162');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1639, '1639', 162, 'BERNAL', '', '162');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1640, '1640', 162, 'CRISTO NOS VALGA', '', '162');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1641, '1641', 162, 'VICE', '', '162');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1642, '1642', 162, 'RINCONADA LLICUAR', '', '162');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1643, '1643', 163, 'PUNO', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1644, '1644', 163, 'ACORA', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1645, '1645', 163, 'AMANTANI', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1646, '1646', 163, 'ATUNCOLLA', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1647, '1647', 163, 'CAPACHICA', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1648, '1648', 163, 'CHUCUITO', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1649, '1649', 163, 'COATA', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1650, '1650', 163, 'HUATA', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1651, '1651', 163, 'MAÑAZO', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1652, '1652', 163, 'PAUCARCOLLA', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1653, '1653', 163, 'PICHACANI', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1654, '1654', 163, 'PLATERÍA', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1655, '1655', 163, 'SAN ANTONIO', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1656, '1656', 163, 'TIQUILLACA', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1657, '1657', 163, 'VILQUE', '', '163');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1658, '1658', 164, 'AZÁNGARO', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1659, '1659', 164, 'ACHAYA', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1660, '1660', 164, 'ARAPA', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1661, '1661', 164, 'ASILLO', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1662, '1662', 164, 'CAMINACA', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1663, '1663', 164, 'CHUPA', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1664, '1664', 164, 'JOSÉ DOMINGO CHOQUEHUANCA', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1665, '1665', 164, 'MUÑANI', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1666, '1666', 164, 'POTONI', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1667, '1667', 164, 'SAMAN', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1668, '1668', 164, 'SAN ANTON', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1669, '1669', 164, 'SAN JOSÉ', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1670, '1670', 164, 'SAN JUAN DE SALINAS', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1671, '1671', 164, 'SANTIAGO DE PUPUJA', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1672, '1672', 164, 'TIRAPATA', '', '164');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1673, '1673', 165, 'MACUSANI', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1674, '1674', 165, 'AJOYANI', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1675, '1675', 165, 'AYAPATA', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1676, '1676', 165, 'COASA', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1677, '1677', 165, 'CORANI', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1678, '1678', 165, 'CRUCERO', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1679, '1679', 165, 'ITUATA', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1680, '1680', 165, 'OLLACHEA', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1681, '1681', 165, 'SAN GABAN', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1682, '1682', 165, 'USICAYOS', '', '165');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1683, '1683', 166, 'JULI', '', '166');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1684, '1684', 166, 'DESAGUADERO', '', '166');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1685, '1685', 166, 'HUACULLANI', '', '166');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1686, '1686', 166, 'KELLUYO', '', '166');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1687, '1687', 166, 'PISACOMA', '', '166');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1688, '1688', 166, 'POMATA', '', '166');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1689, '1689', 166, 'ZEPITA', '', '166');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1690, '1690', 167, 'ILAVE', '', '167');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1691, '1691', 167, 'CAPAZO', '', '167');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1692, '1692', 167, 'PILCUYO', '', '167');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1693, '1693', 167, 'SANTA ROSA', '', '167');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1694, '1694', 167, 'CONDURIRI', '', '167');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1695, '1695', 168, 'HUANCANÉ', '', '168');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1696, '1696', 168, 'COJATA', '', '168');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1697, '1697', 168, 'HUATASANI', '', '168');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1698, '1698', 168, 'INCHUPALLA', '', '168');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1699, '1699', 168, 'PUSI', '', '168');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1700, '1700', 168, 'ROSASPATA', '', '168');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1701, '1701', 168, 'TARACO', '', '168');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1702, '1702', 168, 'VILQUE CHICO', '', '168');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1703, '1703', 169, 'LAMPA', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1704, '1704', 169, 'CABANILLA', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1705, '1705', 169, 'CALAPUJA', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1706, '1706', 169, 'NICASIO', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1707, '1707', 169, 'OCUVIRI', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1708, '1708', 169, 'PALCA', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1709, '1709', 169, 'PARATIA', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1710, '1710', 169, 'PUCARA', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1711, '1711', 169, 'SANTA LUCÍA', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1712, '1712', 169, 'VILAVILA', '', '169');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1713, '1713', 170, 'AYAVIRI', '', '170');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1714, '1714', 170, 'ANTAUTA', '', '170');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1715, '1715', 170, 'CUPI', '', '170');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1716, '1716', 170, 'LLALLI', '', '170');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1717, '1717', 170, 'MACARI', '', '170');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1718, '1718', 170, 'NUÑOA', '', '170');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1719, '1719', 170, 'ORURILLO', '', '170');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1720, '1720', 170, 'SANTA ROSA', '', '170');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1721, '1721', 170, 'UMACHIRI', '', '170');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1722, '1722', 171, 'MOHO', '', '171');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1723, '1723', 171, 'CONIMA', '', '171');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1724, '1724', 171, 'HUAYRAPATA', '', '171');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1725, '1725', 171, 'TILALI', '', '171');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1726, '1726', 172, 'PUTINA', '', '172');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1727, '1727', 172, 'ANANEA', '', '172');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1728, '1728', 172, 'PEDRO VILCA APAZA', '', '172');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1729, '1729', 172, 'QUILCAPUNCU', '', '172');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1730, '1730', 172, 'SINA', '', '172');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1731, '1731', 173, 'JULIACA', '', '173');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1732, '1732', 173, 'CABANA', '', '173');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1733, '1733', 173, 'CABANILLAS', '', '173');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1734, '1734', 173, 'CARACOTO', '', '173');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1735, '1735', 173, 'SAN MIGUEL', '', '173');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1736, '1736', 174, 'SANDIA', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1737, '1737', 174, 'CUYOCUYO', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1738, '1738', 174, 'LIMBANI', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1739, '1739', 174, 'PATAMBUCO', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1740, '1740', 174, 'PHARA', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1741, '1741', 174, 'QUIACA', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1742, '1742', 174, 'SAN JUAN DEL ORO', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1743, '1743', 174, 'YANAHUAYA', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1744, '1744', 174, 'ALTO INAMBARI', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1745, '1745', 174, 'SAN PEDRO DE PUTINA PUNCU', '', '174');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1746, '1746', 175, 'YUNGUYO', '', '175');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1747, '1747', 175, 'ANAPIA', '', '175');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1748, '1748', 175, 'COPANI', '', '175');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1749, '1749', 175, 'CUTURAPI', '', '175');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1750, '1750', 175, 'OLLARAYA', '', '175');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1751, '1751', 175, 'TINICACHI', '', '175');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1752, '1752', 175, 'UNICACHI', '', '175');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1753, '1753', 176, 'MOYOBAMBA', '', '176');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1754, '1754', 176, 'CALZADA', '', '176');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1755, '1755', 176, 'HABANA', '', '176');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1756, '1756', 176, 'JEPELACIO', '', '176');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1757, '1757', 176, 'SORITOR', '', '176');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1758, '1758', 176, 'YANTALO', '', '176');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1759, '1759', 177, 'BELLAVISTA', '', '177');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1760, '1760', 177, 'ALTO BIAVO', '', '177');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1761, '1761', 177, 'BAJO BIAVO', '', '177');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1762, '1762', 177, 'HUALLAGA', '', '177');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1763, '1763', 177, 'SAN PABLO', '', '177');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1764, '1764', 177, 'SAN RAFAEL', '', '177');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1765, '1765', 178, 'SAN JOSÉ DE SISA', '', '178');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1766, '1766', 178, 'AGUA BLANCA', '', '178');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1767, '1767', 178, 'SAN MARTÍN', '', '178');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1768, '1768', 178, 'SANTA ROSA', '', '178');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1769, '1769', 178, 'SHATOJA', '', '178');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1770, '1770', 179, 'SAPOSOA', '', '179');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1771, '1771', 179, 'ALTO SAPOSOA', '', '179');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1772, '1772', 179, 'EL ESLABON', '', '179');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1773, '1773', 179, 'PISCOYACU', '', '179');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1774, '1774', 179, 'SACANCHE', '', '179');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1775, '1775', 179, 'TINGO DE SAPOSOA', '', '179');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1776, '1776', 180, 'LAMAS', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1777, '1777', 180, 'ALONSO DE ALVARADO', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1778, '1778', 180, 'BARRANQUITA', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1779, '1779', 180, 'CAYNARACHI', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1780, '1780', 180, 'CUÑUMBUQUI', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1781, '1781', 180, 'PINTO RECODO', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1782, '1782', 180, 'RUMISAPA', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1783, '1783', 180, 'SAN ROQUE DE CUMBAZA', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1784, '1784', 180, 'SHANAO', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1785, '1785', 180, 'TABALOSOS', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1786, '1786', 180, 'ZAPATERO', '', '180');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1787, '1787', 181, 'JUANJUI', '', '181');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1788, '1788', 181, 'CAMPANILLA', '', '181');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1789, '1789', 181, 'HUICUNGO', '', '181');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1790, '1790', 181, 'PACHIZA', '', '181');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1791, '1791', 181, 'PAJARILLO', '', '181');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1792, '1792', 182, 'PICOTA', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1793, '1793', 182, 'BUENOS AIRES', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1794, '1794', 182, 'CASPISAPA', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1795, '1795', 182, 'PILLUANA', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1796, '1796', 182, 'PUCACACA', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1797, '1797', 182, 'SAN CRISTÓBAL', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1798, '1798', 182, 'SAN HILARION', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1799, '1799', 182, 'SHAMBOYACU', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1800, '1800', 182, 'TINGO DE PONASA', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1801, '1801', 182, 'TRES UNIDOS', '', '182');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1802, '1802', 183, 'RIOJA', '', '183');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1803, '1803', 183, 'AWAJUN', '', '183');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1804, '1804', 183, 'ELÍAS SOPLÍN VARGAS', '', '183');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1805, '1805', 183, 'NUEVA CAJAMARCA', '', '183');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1806, '1806', 183, 'PARDO MIGUEL', '', '183');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1807, '1807', 183, 'POSIC', '', '183');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1808, '1808', 183, 'SAN FERNANDO', '', '183');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1809, '1809', 183, 'YORONGOS', '', '183');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1810, '1810', 183, 'YURACYACU', '', '183');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1811, '1811', 184, 'TARAPOTO', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1812, '1812', 184, 'ALBERTO LEVEAU', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1813, '1813', 184, 'CACATACHI', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1814, '1814', 184, 'CHAZUTA', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1815, '1815', 184, 'CHIPURANA', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1816, '1816', 184, 'EL PORVENIR', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1817, '1817', 184, 'HUIMBAYOC', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1818, '1818', 184, 'JUAN GUERRA', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1819, '1819', 184, 'LA BANDA DE SHILCAYO', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1820, '1820', 184, 'MORALES', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1821, '1821', 184, 'PAPAPLAYA', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1822, '1822', 184, 'SAN ANTONIO', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1823, '1823', 184, 'SAUCE', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1824, '1824', 184, 'SHAPAJA', '', '184');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1825, '1825', 185, 'TOCACHE', '', '185');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1826, '1826', 185, 'NUEVO PROGRESO', '', '185');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1827, '1827', 185, 'PÓLVORA', '', '185');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1828, '1828', 185, 'SHUNTE', '', '185');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1829, '1829', 185, 'UCHIZA', '', '185');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1830, '1830', 185, 'SANTA LUCIA', '', '185');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1831, '1831', 186, 'TACNA', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1832, '1832', 186, 'ALTO DE LA ALIANZA', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1833, '1833', 186, 'CALANA', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1834, '1834', 186, 'CIUDAD NUEVA', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1835, '1835', 186, 'INCLAN', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1836, '1836', 186, 'PACHIA', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1837, '1837', 186, 'PALCA', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1838, '1838', 186, 'POCOLLAY', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1839, '1839', 186, 'SAMA', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1840, '1840', 186, 'CRNEL.GREGORIO ALBARRACIN LANCHIPA', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1841, '1841', 186, 'LA YARADA LOS PALOS', '', '186');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1842, '1842', 187, 'CANDARAVE', '', '187');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1843, '1843', 187, 'CAIRANI', '', '187');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1844, '1844', 187, 'CAMILACA', '', '187');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1845, '1845', 187, 'CURIBAYA', '', '187');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1846, '1846', 187, 'HUANUARA', '', '187');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1847, '1847', 187, 'QUILAHUANI', '', '187');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1848, '1848', 188, 'LOCUMBA', '', '188');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1849, '1849', 188, 'ILABAYA', '', '188');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1850, '1850', 188, 'ITE', '', '188');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1851, '1851', 189, 'TARATA', '', '189');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1852, '1852', 189, 'HÉROES ALBARRACÍN', '', '189');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1853, '1853', 189, 'ESTIQUE', '', '189');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1854, '1854', 189, 'ESTIQUE-PAMPA', '', '189');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1855, '1855', 189, 'SITAJARA', '', '189');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1856, '1856', 189, 'SUSAPAYA', '', '189');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1857, '1857', 189, 'TARUCACHI', '', '189');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1858, '1858', 189, 'TICACO', '', '189');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1859, '1859', 190, 'TUMBES', '', '190');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1860, '1860', 190, 'CORRALES', '', '190');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1861, '1861', 190, 'LA CRUZ', '', '190');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1862, '1862', 190, 'PAMPAS DE HOSPITAL', '', '190');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1863, '1863', 190, 'SAN JACINTO', '', '190');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1864, '1864', 190, 'SAN JUAN DE LA VIRGEN', '', '190');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1865, '1865', 191, 'ZORRITOS', '', '191');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1866, '1866', 191, 'CASITAS', '', '191');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1867, '1867', 191, 'CANOAS DE PUNTA SAL', '', '191');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1868, '1868', 192, 'ZARUMILLA', '', '192');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1869, '1869', 192, 'AGUAS VERDES', '', '192');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1870, '1870', 192, 'MATAPALO', '', '192');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1871, '1871', 192, 'PAPAYAL', '', '192');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1872, '1872', 193, 'CALLERIA', '', '193');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1873, '1873', 193, 'CAMPOVERDE', '', '193');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1874, '1874', 193, 'IPARIA', '', '193');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1875, '1875', 193, 'MASISEA', '', '193');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1876, '1876', 193, 'YARINACOCHA', '', '193');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1877, '1877', 193, 'NUEVA REQUENA', '', '193');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1878, '1878', 193, 'MANANTAY', '', '193');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1879, '1879', 194, 'RAYMONDI', '', '194');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1880, '1880', 194, 'SEPAHUA', '', '194');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1881, '1881', 194, 'TAHUANIA', '', '194');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1882, '1882', 194, 'YURUA', '', '194');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1883, '1883', 195, 'PADRE ABAD', '', '195');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1884, '1884', 195, 'IRAZOLA', '', '195');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1885, '1885', 195, 'CURIMANA', '', '195');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1886, '1886', 195, 'NESHUYA', '', '195');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1887, '1887', 195, 'ALEXANDER VON HUMBOLDT', '', '195');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1888, '1888', 195, 'HUIPOCA', '', '195');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1889, '1889', 195, 'BOQUERON', '', '195');
    INSERT INTO public.saeparr (parr_cod_parr, parr_cod_char, parr_cod_cant, parr_des_parr, parr_zip_code, parr_cod_ciud) VALUES (1890, '1890', 196, 'PURÚS', '', '196');
COMMIT;