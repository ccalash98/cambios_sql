--/////////script estructurado cuotas faltantes

BEGIN;
    DELETE FROM ISP.contrato_pago_pack WHERE id_pago in 
    (SELECT id 
    FROM ISP.contrato_pago 
    WHERE id_contrato in 
        (SELECT id
        FROM isp.contrato_clpv 
        WHERE id IN 
            (SELECT id_contrato 
            FROM isp.contrato_pago 
            WHERE id_contrato NOT IN 
                (SELECT id_contrato 
                FROM isp.contrato_pago 
                WHERE fecha = '2024-04-30'
                )AND fecha > '2024-04-30'
            )and estado = 'AP'
        )and fecha > '2024-03-31'
		and valor_pago = 0
		and id_factura is null
	)and fecha > '2024-03-31'
	AND valor_pago = 0;


    DELETE FROM ISP.contrato_pago WHERE id_contrato in 
    (SELECT id 
    FROM isp.contrato_clpv 
    WHERE id IN 
        (SELECT id_contrato 
        FROM isp.contrato_pago 
        WHERE id_contrato NOT IN 
            (SELECT id_contrato 
            FROM isp.contrato_pago 
            WHERE fecha = '2024-04-30'
            )AND fecha > '2024-04-30'
        )and estado = 'AP'
    )and fecha > '2024-03-31'
	and valor_pago = 0
	and id_factura is null;
COMMIT;

--VERIFICACION DE CUOTAS
SELECT ruc_clpv, nom_clpv, codigo,id_clpv
FROM isp.contrato_clpv 
WHERE id IN (
    SELECT id_contrato 
    FROM isp.contrato_pago 
    WHERE id_contrato NOT IN (
        SELECT id_contrato 
        FROM isp.contrato_pago 
        WHERE fecha = '2024-02-29'
    ) 
    AND fecha > '2024-02-29'
) 
ORDER BY id;
