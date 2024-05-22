--///tablas faltante en proyectos///---
    -- ----------------------------
    -- Table structure for saetgtra
    -- ----------------------------
    DROP TABLE IF EXISTS public.saetgtra;
    CREATE TABLE public.saetgtra (
    tgtra_cod_tgtra serial,
    tgtra_cod_empr int4,
    tgtra_cod_sucu int4,
    tgtra_nom_tgtra varchar(100) COLLATE pg_catalog.default,
    tgtra_des_tgtra varchar(500) COLLATE pg_catalog.default,
    tgtra_ord_movi int4,
    tgtra_usua_act int4,
    tgtra_fec_tgtra timestamp(6)
    )
    ;

    -- ----------------------------
    -- Records of saetgtra
    -- ----------------------------
    INSERT INTO public.saetgtra VALUES (1, 1, 1, 'INGRESOS', 'IN', 1, 1, '2024-02-20 11:28:54');
    INSERT INTO public.saetgtra VALUES (2, 1, 1, 'COSTOS', 'CO', 2, 1, '2024-02-20 11:29:28');
    INSERT INTO public.saetgtra VALUES (3, 1, 1, 'GASTOS', 'GA', 3, 1, '2024-02-20 11:29:54');
    INSERT INTO public.saetgtra VALUES (4, 1, 1, 'AMORTIZACION', 'AM', 4, 1, '2024-02-20 11:30:14');

    -- ----------------------------
    -- Primary Key structure for table saetgtra
    -- ----------------------------
    ALTER TABLE public.saetgtra ADD CONSTRAINT saetgtra_pkey PRIMARY KEY (tgtra_cod_tgtra);




    -- ----------------------------
    -- Table structure for saedasi_an
    -- ----------------------------
    DROP TABLE IF EXISTS public.saedasi_an;
    CREATE TABLE public.saedasi_an (
    dasi_cod_dasi int4 NOT NULL,
    asto_cod_asto varchar(13) COLLATE pg_catalog.default NOT NULL,
    asto_cod_empr int4 NOT NULL,
    asto_cod_sucu int4 NOT NULL,
    dasi_num_prdo int4 NOT NULL,
    asto_cod_ejer int4,
    dasi_cod_cuen varchar(35) COLLATE pg_catalog.default NOT NULL,
    dasi_cod_cact varchar(7) COLLATE pg_catalog.default,
    ccos_cod_ccos varchar(18) COLLATE pg_catalog.default,
    dasi_dml_dasi numeric(18,2) DEFAULT 0,
    dasi_cml_dasi numeric(18,2) DEFAULT 0,
    dasi_dme_dasi numeric(18,2) DEFAULT 0,
    dasi_cme_dasi numeric(18,2) DEFAULT 0,
    dasi_tip_camb numeric(12,6),
    dasi_det_asi varchar(1500) COLLATE pg_catalog.default,
    dasi_nom_ctac varchar(255) COLLATE pg_catalog.default,
    dasi_cod_ret int4,
    dasi_cod_dir int4,
    dasi_cta_ret varchar(5) COLLATE pg_catalog.default,
    dasi_cod_clie int4,
    dasi_tip_dasi varchar(5) COLLATE pg_catalog.default,
    dasi_dist_dasi varchar(1) COLLATE pg_catalog.default,
    dasi_ban_dasi varchar(1) COLLATE pg_catalog.default,
    dasi_bca_dasi varchar(1) COLLATE pg_catalog.default,
    dasi_cru_dasi varchar(2) COLLATE pg_catalog.default,
    dasi_cod_tran varchar(5) COLLATE pg_catalog.default,
    dasi_num_depo varchar(20) COLLATE pg_catalog.default,
    dasi_con_flch int4,
    dasi_fec_coni date,
    dasi_fec_conf date,
    dasi_cod_cuenpresu varchar(35) COLLATE pg_catalog.default,
    dasi_cta_extr varchar(35) COLLATE pg_catalog.default,
    dasi_efe_necniff varchar(35) COLLATE pg_catalog.default,
    dasi_user_web int4,
    dasi_num_comp int4
    )
    ;
