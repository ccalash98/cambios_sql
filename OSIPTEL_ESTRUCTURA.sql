BEGIN;
  DROP TABLE IF EXISTS isp.submaterias_recla;
  CREATE TABLE isp.submaterias_recla (
    id serial,
    submateria varchar(255) COLLATE pg_catalog.default,
    id_materia_recla int8
  )
  ;
  -- ----------------------------
  -- Records of submaterias_recla
  -- ----------------------------
  INSERT INTO isp.submaterias_recla VALUES (4, 'MONTO FACTURADO NO RECONOCIDO', 1);
  INSERT INTO isp.submaterias_recla VALUES (1, 'CÁLCULO DE LOS CONSUMOS FACTURADOS', 1);
  INSERT INTO isp.submaterias_recla VALUES (2, 'TARIFA APLICADA DE CONSUMOS ADICIONALES FACTURADOS', 1);
  INSERT INTO isp.submaterias_recla VALUES (3, 'CARGO POR RECONEXIÓN', 1);
  INSERT INTO isp.submaterias_recla VALUES (5, 'MONTO FACTURADO NO RECONOCIDO', 2);
  INSERT INTO isp.submaterias_recla VALUES (6, 'CÁLCULO DE LOS CONSUMOS FACTURADOS', 2);
  INSERT INTO isp.submaterias_recla VALUES (7, 'TARIFA APLICADA DE CONSUMOS ADICIONALES FACTURADOS', 2);
  INSERT INTO isp.submaterias_recla VALUES (8, 'CARGO POR RECONEXIÓN', 2);
  INSERT INTO isp.submaterias_recla VALUES (13, 'INCREMENTO TARIFARIO NO COMUNICADO', 3);
  INSERT INTO isp.submaterias_recla VALUES (9, 'PAGOS NO PROCESADOS O REGISTRADOS', 3);
  INSERT INTO isp.submaterias_recla VALUES (10, 'MONTOS NO FACTURADOS OPORTUNAMENTE', 3);
  INSERT INTO isp.submaterias_recla VALUES (11, 'COBRO POR EQUIPOS TERMINALES', 3);
  INSERT INTO isp.submaterias_recla VALUES (12, 'REINTEGRO POR EQUIPOS TERMINALES', 3);
  INSERT INTO isp.submaterias_recla VALUES (15, 'IDONEIDAD DEL SERVICIO', 4);
  INSERT INTO isp.submaterias_recla VALUES (14, 'CALIDAD DEL SERVICIO', 4);
  INSERT INTO isp.submaterias_recla VALUES (19, 'MIGRACIÓN NO SOLICITADA', 5);
  INSERT INTO isp.submaterias_recla VALUES (16, 'CONDICIONAMIENTO DE LA MIGRACIÓN', 5);
  INSERT INTO isp.submaterias_recla VALUES (17, 'INEJECUCIÓN DE MIGRACIÓN', 5);
  INSERT INTO isp.submaterias_recla VALUES (18, 'FACTURACIÓN DE TARIFA ANTERIOR', 5);
  INSERT INTO isp.submaterias_recla VALUES (24, 'INFORMACIÓN INEXACTA', 7);
  INSERT INTO isp.submaterias_recla VALUES (20, 'APLICACIÓN DE CONDICIONES DISTINTAS A LAS PACTADAS', 7);
  INSERT INTO isp.submaterias_recla VALUES (21, 'INCUMPLIMIENTO DE OFERTA O PROMOCIÓN', 7);
  INSERT INTO isp.submaterias_recla VALUES (22, 'DESCUENTO NO RECONOCIDO DE ATRIBUTOS DEL SERVICIO', 7);
  INSERT INTO isp.submaterias_recla VALUES (23, 'OMISIÓN DE INFORMACIÓN', 7);
  INSERT INTO isp.submaterias_recla VALUES (30, 'FALTA DE DEVOLUCIÓN DE PAGO POR TRABAJOS NO EJECUTADOS', 8);
  INSERT INTO isp.submaterias_recla VALUES (25, 'FALTA DE INSTALACIÓN', 8);
  INSERT INTO isp.submaterias_recla VALUES (26, 'FALTA DE ACTIVACIÓN', 8);
  INSERT INTO isp.submaterias_recla VALUES (27, 'FALTA DE TRASLADO', 8);
  INSERT INTO isp.submaterias_recla VALUES (28, 'FALTA DE RESPUESTA AL TRASLADO', 8);
  INSERT INTO isp.submaterias_recla VALUES (29, 'NEGATIVA AL TRASLADO', 8);
  INSERT INTO isp.submaterias_recla VALUES (31, 'SUSPENSIÓN NO SOLICITADA/RECONOCIDA', 9);
  INSERT INTO isp.submaterias_recla VALUES (32, 'BAJA NO SOLICITADA/RECONOCIDA', 9);
  INSERT INTO isp.submaterias_recla VALUES (36, 'CAMBIO DE TITULARIDAD SIN CONSENTIMIENTO', 14);
  INSERT INTO isp.submaterias_recla VALUES (33, 'INTERRUPCIÓN', 14);
  INSERT INTO isp.submaterias_recla VALUES (34, 'CORTE NO RECONOCIDO', 14);
  INSERT INTO isp.submaterias_recla VALUES (35, 'FALTA DE REACTIVACIÓN DEL SERVICIO', 14);

  -- ----------------------------
  -- Auto increment value for submaterias_recla
  -- ----------------------------
  SELECT setval('isp.submaterias_recla_id_seq', 1, false);

  -- ----------------------------
  -- Primary Key structure for table submaterias_recla
  -- ----------------------------
  ALTER TABLE isp.submaterias_recla ADD CONSTRAINT submaterias_recla_pkey PRIMARY KEY (id);
COMMIT;

BEGIN;
  DROP TABLE IF EXISTS isp.servicios_reclamables;
  CREATE TABLE isp.servicios_reclamables (
    id serial,
    servicio_des varchar(255) COLLATE pg_catalog.default
  )
  ;
  -- ----------------------------
  -- Records of servicios_reclamables
  -- ----------------------------
  INSERT INTO isp.servicios_reclamables VALUES (1, 'INTERNET');
  INSERT INTO isp.servicios_reclamables VALUES (2, 'ARRENDAMIENTO DE CIRCUITOS');
  INSERT INTO isp.servicios_reclamables VALUES (3, 'TV');
  -- ----------------------------
  -- Auto increment value for servicios_reclamables
  -- ----------------------------
  SELECT setval('isp.servicios_reclamables_id_seq', 1, false);
  -- ----------------------------
  -- Primary Key structure for table servicios_reclamables
  -- ----------------------------
  ALTER TABLE isp.servicios_reclamables ADD CONSTRAINT servicios_reclamables_pkey PRIMARY KEY (id);
COMMIT;

BEGIN;
  DROP TABLE IF EXISTS isp.plazo_atencion;
  CREATE TABLE isp.plazo_atencion (
    -- id int4 NOT NULL DEFAULT nextval('isp.plazo_atencion_id_seq'::regclass),
    id serial,
    descripcion varchar(340) COLLATE pg_catalog.default,
    dias int8
  )
  ;
  -- ----------------------------
  -- Records of plazo_atencion
  -- ----------------------------
  INSERT INTO isp.plazo_atencion VALUES (1, 'Facturación montos < S/22', 15);
  INSERT INTO isp.plazo_atencion VALUES (2, 'Facturación montos > S/22', 20);
  INSERT INTO isp.plazo_atencion VALUES (3, 'Cobros', 20);
  INSERT INTO isp.plazo_atencion VALUES (4, 'Calidad o idoneidad en el servicio ', 3);
  INSERT INTO isp.plazo_atencion VALUES (5, 'Migración', 20);
  INSERT INTO isp.plazo_atencion VALUES (6, 'Falta de entrega del recibo ', 3);
  INSERT INTO isp.plazo_atencion VALUES (7, 'Incumplimiento de condiciones contractuales, ofertas y promociones ', 20);
  INSERT INTO isp.plazo_atencion VALUES (8, 'Instalación, traslado o activación del servicio ', 15);
  INSERT INTO isp.plazo_atencion VALUES (9, 'Baja o suspensión no solicitada ', 3);
  INSERT INTO isp.plazo_atencion VALUES (10, 'Tarjeta de pago físicas o virtuales ', 15);
  INSERT INTO isp.plazo_atencion VALUES (11, 'Contratación no solicitada ', 20);
  INSERT INTO isp.plazo_atencion VALUES (12, 'Negativa a brindar facturación detallada', 0);
  INSERT INTO isp.plazo_atencion VALUES (13, 'Negativa injustificada a contratar el servicio', 0);
  INSERT INTO isp.plazo_atencion VALUES (14, 'Falta de servicio', 3);
COMMIT;

BEGIN;
    CREATE TABLE isp.form_recla (
    id serial,
    cond_recla varchar(100) COLLATE pg_catalog.default,
    id_clpv int4,
    nombre_recl varchar(100) COLLATE pg_catalog.default,
    apellido_recla varchar(100) COLLATE pg_catalog.default,
    razon_social char(300) COLLATE pg_catalog.default,
    tip_docu varchar(50) COLLATE pg_catalog.default,
    num_docu varchar(20) COLLATE pg_catalog.default,
    nom_repre varchar(100) COLLATE pg_catalog.default,
    apell_repre varchar(100) COLLATE pg_catalog.default,
    tip_doc_repre varchar(50) COLLATE pg_catalog.default,
    num_doc_repre varchar(20) COLLATE pg_catalog.default,
    adjunta_doc_sn varchar(1) COLLATE pg_catalog.default,
    correo_recl varchar(100) COLLATE pg_catalog.default,
    autoriza_corr_sn varchar(1) COLLATE pg_catalog.default,
    departamento_recl varchar(150) COLLATE pg_catalog.default,
    provincia_recl varchar(100) COLLATE pg_catalog.default,
    distrito_recl varchar(300) COLLATE pg_catalog.default,
    direccion_recl varchar(300) COLLATE pg_catalog.default,
    telefono_recl varchar(20) COLLATE pg_catalog.default,
    nom_empresa varchar(100) COLLATE pg_catalog.default,
    serv_contrato varchar(100) COLLATE pg_catalog.default,
    num_contrato varchar(100) COLLATE pg_catalog.default,
    serv_mat_recl varchar(100) COLLATE pg_catalog.default,
    otros_srv varchar(100) COLLATE pg_catalog.default,
    motiv_materia_recla int4,
    prob_espec char(1000) COLLATE pg_catalog.default,
    infor_necesaria1 varchar(1000) COLLATE pg_catalog.default,
    infor_necesaria2 varchar(1000) COLLATE pg_catalog.default,
    infor_necesaria3 varchar(1000) COLLATE pg_catalog.default,
    infor_necesaria4 varchar(1000) COLLATE pg_catalog.default,
    descirp_prob_solc char(1000) COLLATE pg_catalog.default,
    ortr_inf_sn varchar(100) COLLATE pg_catalog.default,
    inf_ad_sn varchar(100) COLLATE pg_catalog.default,
    fecha_adic date,
    hora varchar(100) COLLATE pg_catalog.default,
    id_contrato int4,
    informa_adiciona char(3000) COLLATE pg_catalog.default,
    id_empresa int4,
    secuencial int8,
    estado_reclamo varchar(1) COLLATE pg_catalog.default DEFAULT 'S'::character varying,
    ruta_inf_adic varchar(100) COLLATE pg_catalog.default,
    observacion_finalizacion text COLLATE pg_catalog.default,
    hora_fina varchar(100) COLLATE pg_catalog.default,
    hora_final date,
    fecha_final date,
    usuario_derivado int4
    )
    ;

    ALTER TABLE isp.form_recla 
    OWNER TO sisconti;
        CREATE TABLE isp.form_apela (
    id int2 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
    INCREMENT 1
    MINVALUE  1
    MAXVALUE 32767
    START 1
    CACHE 1
    ),
    cond_recla varchar(100) COLLATE pg_catalog.default,
    id_clpv int4,
    nombre_recl varchar(100) COLLATE pg_catalog.default,
    apellido_recla varchar(100) COLLATE pg_catalog.default,
    razon_social char(300) COLLATE pg_catalog.default,
    tip_docu varchar(50) COLLATE pg_catalog.default,
    num_docu varchar(20) COLLATE pg_catalog.default,
    nom_repre varchar(100) COLLATE pg_catalog.default,
    apell_repre varchar(100) COLLATE pg_catalog.default,
    tip_doc_repre varchar(50) COLLATE pg_catalog.default,
    num_doc_repre varchar(20) COLLATE pg_catalog.default,
    adjunta_doc_sn varchar(1) COLLATE pg_catalog.default,
    correo_recl varchar(100) COLLATE pg_catalog.default,
    autoriza_corr_sn varchar(1) COLLATE pg_catalog.default,
    departamento_recl varchar(150) COLLATE pg_catalog.default,
    provincia_recl varchar(100) COLLATE pg_catalog.default,
    distrito_recl varchar(300) COLLATE pg_catalog.default,
    direccion_recl varchar(300) COLLATE pg_catalog.default,
    telefono_recl varchar(20) COLLATE pg_catalog.default,
    nom_empresa varchar(100) COLLATE pg_catalog.default,
    serv_contrato varchar(100) COLLATE pg_catalog.default,
    num_contrato varchar(100) COLLATE pg_catalog.default,
    serv_mat_recl varchar(100) COLLATE pg_catalog.default,
    otros_srv varchar(100) COLLATE pg_catalog.default,
    motiv_materia_recla varchar(32) COLLATE pg_catalog.default,
    prob_espec char(1000) COLLATE pg_catalog.default,
    infor_necesaria1 varchar(1000) COLLATE pg_catalog.default,
    infor_necesaria2 varchar(1000) COLLATE pg_catalog.default,
    infor_necesaria3 varchar(1000) COLLATE pg_catalog.default,
    infor_necesaria4 varchar(1000) COLLATE pg_catalog.default,
    descirp_prob_solc char(1000) COLLATE pg_catalog.default,
    ortr_inf_sn varchar(100) COLLATE pg_catalog.default,
    inf_ad_sn varchar(100) COLLATE pg_catalog.default,
    fecha_adic date,
    hora varchar(100) COLLATE pg_catalog.default,
    id_contrato int4,
    informa_adiciona char(3000) COLLATE pg_catalog.default,
    id_empresa int4,
    secuencial int8,
    estado_reclamo varchar(1) COLLATE pg_catalog.default DEFAULT 'S'::character varying,
    ruta_inf_adic varchar(100) COLLATE pg_catalog.default,
    usuario_derivado int4,
    observacion_finalizacion text COLLATE pg_catalog.default,
    fecha_final date,
    hora_final varchar(100) COLLATE pg_catalog.default,
    codigo_reclamo int8,
    numcarta_res_recl int8,
    fecha_cart_res date,
    CONSTRAINT form_apela_pkey PRIMARY KEY (id)
    )
    ;

    ALTER TABLE isp.form_apela 
    OWNER TO postgres;
        CREATE TABLE isp.form_queja (
    id int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
    INCREMENT 1
    MINVALUE  1
    MAXVALUE 2147483647
    START 1
    CACHE 1
    ),
    cond_recla varchar(100) COLLATE pg_catalog.default,
    id_clpv int4,
    nombre_recl varchar(100) COLLATE pg_catalog.default,
    apellido_recla varchar(100) COLLATE pg_catalog.default,
    razon_social char(300) COLLATE pg_catalog.default,
    tip_docu varchar(50) COLLATE pg_catalog.default,
    num_docu varchar(20) COLLATE pg_catalog.default,
    nom_repre varchar(100) COLLATE pg_catalog.default,
    apell_repre varchar(100) COLLATE pg_catalog.default,
    tip_doc_repre varchar(50) COLLATE pg_catalog.default,
    num_doc_repre varchar(20) COLLATE pg_catalog.default,
    adjunta_doc_sn varchar(1) COLLATE pg_catalog.default,
    correo_recl varchar(100) COLLATE pg_catalog.default,
    autoriza_corr_sn varchar(1) COLLATE pg_catalog.default,
    departamento_recl varchar(150) COLLATE pg_catalog.default,
    provincia_recl varchar(100) COLLATE pg_catalog.default,
    distrito_recl varchar(300) COLLATE pg_catalog.default,
    direccion_recl varchar(300) COLLATE pg_catalog.default,
    telefono_recl varchar(20) COLLATE pg_catalog.default,
    nom_empresa varchar(100) COLLATE pg_catalog.default,
    serv_contrato varchar(100) COLLATE pg_catalog.default,
    num_contrato varchar(100) COLLATE pg_catalog.default,
    serv_mat_recl varchar(100) COLLATE pg_catalog.default,
    otros_srv varchar(100) COLLATE pg_catalog.default,
    motiv_materia_recla varchar(255) COLLATE pg_catalog.default,
    prob_espec char(1000) COLLATE pg_catalog.default,
    infor_necesaria1 varchar(1000) COLLATE pg_catalog.default,
    infor_necesaria2 varchar(1000) COLLATE pg_catalog.default,
    infor_necesaria3 varchar(1000) COLLATE pg_catalog.default,
    infor_necesaria4 varchar(1000) COLLATE pg_catalog.default,
    descirp_prob_solc char(1000) COLLATE pg_catalog.default,
    ortr_inf_sn varchar(100) COLLATE pg_catalog.default,
    inf_ad_sn varchar(100) COLLATE pg_catalog.default,
    fecha_adic date,
    hora varchar(100) COLLATE pg_catalog.default,
    id_contrato int4,
    informa_adiciona char(3000) COLLATE pg_catalog.default,
    id_empresa int4,
    secuencial int8,
    estado_reclamo varchar(1) COLLATE pg_catalog.default DEFAULT 'S'::character varying,
    ruta_inf_adic varchar(100) COLLATE pg_catalog.default,
    usuario_derivado int4,
    observacion_finalizacion text COLLATE pg_catalog.default,
    fecha_final date,
    hora_final varchar(100) COLLATE pg_catalog.default,
    codigo_reclamo int8,
    CONSTRAINT form_queja_pkey PRIMARY KEY (id)
    )
    ;

    ALTER TABLE isp.form_queja 
    OWNER TO postgres;
        CREATE TABLE isp.reclamaciones (
    id serial,
    fech_recl date,
    anio_sec int4,
    secuencial varchar(100) COLLATE pg_catalog.default,
    nom_empres varchar(100) COLLATE pg_catalog.default,
    ruc_empr varchar(20) COLLATE pg_catalog.default,
    dir_empr varchar(100) COLLATE pg_catalog.default,
    codigo_iden_empr int4,
    id_clpv int4,
    nom_clie varchar(100) COLLATE pg_catalog.default,
    dom_cli varchar(100) COLLATE pg_catalog.default,
    ruc_cli varchar(50) COLLATE pg_catalog.default,
    tipo_contrato varchar(1) COLLATE pg_catalog.default,
    monto_recla varchar(100) COLLATE pg_catalog.default,
    descripción char(300) COLLATE pg_catalog.default,
    tip_recla varchar(1) COLLATE pg_catalog.default,
    detalle char(300) COLLATE pg_catalog.default,
    pedido char(300) COLLATE pg_catalog.default,
    firma_clie char(20000) COLLATE pg_catalog.default,
    fecha_respuesta date,
    descripción_res char(300) COLLATE pg_catalog.default,
    telf_cli varchar(20) COLLATE pg_catalog.default,
    id_empr int4
    )
    ;
COMMIT;