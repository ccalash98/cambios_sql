--SCRIPT PARA BORRADO DE TRANSACCIONES
BEGIN;
    delete from comercial.inv_proforma_det;
    delete from comercial.inv_proforma;
    delete from public.saedped;
    delete from public.saepedi;
    delete from public.saedreq;
    DELETE from public.saeguia;
    DELETE from public.saedgui;
    delete from public.saerequ;
    delete from public.saedfac;
    delete from public.saefact;
    delete from public.saedmov;
    delete from public.saedmov_an;
    DELETE from public.saemxfp;  --compras inventario
    DELETE FROM PUBLIC.saebafp;
    DELETE from public.saefxfp;  --compras ventas
    DELETE FROM public.saedpag;
    delete from public.saeminv;
    delete from public.saeminv_an;
    delete from public.saeppr where ppr_cod_bode not IN (1); --PRECIOS PRODUCTO (1) mat // (2) serv
    delete from public.saecost;
    delete from public.saeprbo where prbo_cod_bode not IN (1);   --producto x bodega (1) mat // (2) serv
    --producto unicos sin importar la bodega // comentar si no se quiere borrar los productos solo cantidades
    delete from public.saeprod where prod_cod_tpro not IN ('2');   --(2) mat // (1) serv
    delete from public.saedncr;
    delete from public.saencnd;
    delete from isp.instalacion_materiales;
    delete from isp.instalacion_ejecucion;
    delete from isp.instalacion_prod;
    delete from isp.instalacion_tecnico;
    delete from isp.instalacion_clpv;
    delete from isp.contrato_factura;
    delete from isp.contrato_pago_pack;
    delete from isp.contrato_pago;
    delete from isp.contrato_medio_pago;
    delete from isp.int_contrato_caja_pack;
    delete from isp.int_contrato_caja;
    delete from isp.contrato_clpv;
    delete from isp.int_calle;
    delete from isp.int_calle_tipo;
    --//// BORRAR SECTOR - BARRIO
    --DELETE from comercial.sector_direccion;
    --DELETE FROM isp.int_barrio;
    delete from public.saedire where dire_cod_clpv IN (SELECT clpv_cod_clpv FROM public.saeclpv WHERE clpv_clopv_clpv = 'CL');
    delete from public.saeemai where emai_cod_clpv IN (SELECT clpv_cod_clpv FROM public.saeclpv WHERE clpv_clopv_clpv = 'CL');
    delete from public.saetlcp where tlcp_cod_clpv IN (SELECT clpv_cod_clpv FROM public.saeclpv WHERE clpv_clopv_clpv = 'CL');
    DELETE from public.saecoa where clpv_cod_clpv IN (SELECT clpv_cod_clpv FROM public.saeclpv WHERE clpv_clopv_clpv = 'CL');
    delete from public.saeclpv WHERE clpv_clopv_clpv = 'CL';
    --comentar si no se desea borrar los planes creados
    --delete from isp.int_paquetes_sucursal;
    --delete from isp.int_paquetes;
COMMIT;