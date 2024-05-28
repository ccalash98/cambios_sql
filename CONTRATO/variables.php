<?php
require("_Ajax.comun.php"); // No modificar esta linea

function genera_grid($aData = null, $aLabel = null, $sTitulo = 'Reporte', $iAncho = '400', $aAccion = null, $Totales = null, $aOrden = null)
{
    if (is_array($aData) && is_array($aLabel)) {
        $iLabel = count($aLabel);
        $iData = count($aData);
        $sClass = 'on';
        $sHtml = '';
        $sHtml .= '<form id="DataGrid">';
        $sHtml .= '<table class="table table-striped table-condensed" style="width: 98%; margin-bottom: 0px;">';
        $sHtml .= '<tr class="info" ><td colspan="' . $iLabel . '">Su consulta genero ' . $iData . ' registros de resultado</td></tr>';
        $sHtml .= '<tr>';
        // Genera Columnas de Grid
        for ($i = 0; $i < $iLabel; $i++) {
            $sLabel = explode('|', $aLabel[$i]);
            if ($sLabel[1] == '')
                //				$sHtml .= '<th class="diagrama" align="center">'.$sLabel[0].'</th>';
                if ($i == 13) {
                    $sHtml .= '<td class="diagrama" align="center" style="display:none">' . $sLabel[0] . '</th>';
                } else {
                    $sHtml .= '<td class="diagrama" align="center">' . $sLabel[0] . '</th>';
                }
            else {
                if ($sLabel[1] == $aOrden[0]) {
                    if ($aOrden[1] == 'ASC') {
                        $sLabel[1] .= '|DESC';
                        $sImg = '<img src="' . path(DIR_IMAGENES) . 'iconos/ico_down.png" align="absmiddle" />';
                    } else {
                        $sLabel[1] .= '|ASC';
                        $sImg = '<img src="' . path(DIR_IMAGENES) . 'iconos/ico_up.png" align="absmiddle" />';
                    }
                } else {
                    $sImg = '';
                    $sLabel[1] .= '|ASC';
                }

                $sHtml .= '<th onClick="xajax_' . $sLabel[2] . '(xajax.getFormValues(\'form1\'),\'' . $sLabel[1] . '\')" 
								style="cursor: hand !important; cursor: pointer !important;" >' . $sLabel[0] . ' ';
                $sHtml .= $sImg;
                $sHtml .= '</th>';
            }
        }
        $sHtml .= '</tr>';
        // Genera Filas de Grid

        for ($i = 0; $i < $iData; $i++) {
            if ($sClass == 'off')
                $sClass = 'on';
            else
                $sClass = 'off';

            $sHtml .= '<tr class="warning">';
            for ($j = 0; $j < $iLabel; $j++)
                if (is_float($aData[$i][$aLabel[$j]]))
                    $sHtml .= '<td align="right">' . number_format($aData[$i][$aLabel[$j]], 2, ',', '.') . '</td>';
                else
                    //				$sHtml .= '<td align="left">'.$aData[$i][$aLabel[$j]].'</td>';
                    if ($j == 13) {
                        $sHtml .= '<td align="left" style="display:none">' . $aData[$i][$aLabel[$j]] . '</td>';
                    } else {
                        $sHtml .= '<td align="left">' . $aData[$i][$aLabel[$j]] . '</td>';
                    }
            $sHtml .= '</tr>';
        }

        //Totales 
        $sHtml .= '<tr>';
        if (is_array($Totales)) {
            for ($i = 0; $i < $iLabel; $i++) {
                if ($i == 0)
                    $sHtml .= '<th class="total_reporte">Totales</th>';
                else {
                    if ($Totales[$i] == '')
                        if ($Totales[$i] == '0.00')
                            $sHtml .= '<th align="right" class="total_reporte">' . number_format($Totales[$i], 2, ',', '.') . '</th>';
                        else
                            $sHtml .= '<th align="right"></th>';
                    else
                        $sHtml .= '<th align="right" class="total_reporte">' . number_format($Totales[$i], 2, ',', '.') . '</th>';
                }
            }
        }

        $sHtml .= '</tr></table>';
        $sHtml .= '</form>';
    }
    return $sHtml;
}


function carga($aForm = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();
    $bodega = $aForm['bodega'];

    $sql = "SELECT p.prod_cod_prod, p.prod_nom_prod from saeprod p, saeprbo b where prbo_cod_bode='$bodega'
    and p.prod_cod_prod = b.prbo_cod_prod";
    //echo $sql;exit;

    $i = 1;
    if ($oIfx->Query($sql)) {
        $oReturn->script('eliminarListaSector();');
        // $oReturn->script('eliminarListaProd1();');
        if ($oIfx->NumFilas() > 0) {
            do {


                $oReturn->script(('anadirListaSector(' . $i++ . ',\'' . $oIfx->f('prod_cod_prod') . '\', \'' . $oIfx->f('prod_nom_prod') . '\' )'));
                //   $oReturn->script(('anadirListaProd1(' . $i++ . ',\'' . $oIfx->f('prod_cod_prod') . '\', \'' . $oIfx->f('prod_nom_prod') . '\' )'));

            } while ($oIfx->SiguienteRegistro());
        }
    }
    $oIfx->Free();
    return $oReturn;
}


function genera_formulario_cliente($aForm = '', $id_clpv = 0, $id_contrato = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $oReturn = new xajaxResponse();


    try {

        unset($_SESSION['A_CI_PAQ']);
        $idempresa      = $_SESSION['U_EMPRESA'];
        $idsucursal     = $_SESSION['U_SUCURSAL'];
        $idbodega       = $_SESSION['U_BODE_COD_BODE_'];
        $pais_cod       = $_SESSION['U_PAIS_COD'];
        $validador_pais = $_SESSION['S_PAIS_API_SRI'];

        $classParametros = new int_parametros($oCon, $idempresa, $idsucursal);
        $arrayParametros = $classParametros->consultarParametros();
        $objectParametros = (object)$arrayParametros;

        $codigo_automatico = $objectParametros->codigo_automatico;
        $num_digitos = $objectParametros->num_digitos;
        $num_letras = $objectParametros->num_letras;
        $codigo_actual = $objectParametros->codigo_actual;
        $abonado_actual = $objectParametros->abonado_actual;
        $dia_corte = $objectParametros->dia_corte;
        $dia_cobro = $objectParametros->dia_cobro;




        if (empty($dia_corte)) {
            $dia_corte = 0;
        }

        if (empty($dia_cobro)) {
            $dia_cobro = 0;
        }

        //vendedor
        $optionVendedor = '';
        $sql = "SELECT vend_cod_vend, vend_nom_vend
				from saevend
                where vend_cod_empr = $idempresa
				order by vend_nom_vend ";
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                do {
                    $optionVendedor .= '<option value="' . $oIfx->f('vend_cod_vend') . '">' . $oIfx->f('vend_nom_vend') . '</option>';
                } while ($oIfx->SiguienteRegistro());
            }
        }
        $oIfx->Free();

        //cobrador
        $optionCobrador = '';
        $sql = "select cobr_cod_cobr, (cobr_nom_cobr || ' ' || cobr_ape_cobr) as cobrador 
				from saecobr
				where cobr_cod_empr = $idempresa
				order by cobr_nom_cobr ";
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                do {
                    $optionCobrador .= '<option value="' . $oIfx->f('cobr_cod_cobr') . '">' . $oIfx->f('cobrador') . '</option>';
                } while ($oIfx->SiguienteRegistro());
            }
        }
        $oIfx->Free();

        //tipo
        $optionTipo = '';
        $sql = "select id, tipo
				from isp.int_tipo_contrato WHERE estado = 'A'
				order by id  ";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionTipo .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('tipo') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //tipo cobro
        $optionTipoCobro = '';
        $sql = "select id, tipo from isp.int_tipo_cobro";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionTipoCobro .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('tipo') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //tipo servicio
        $optionTipoServicio = '';
        $sql = "SELECT id, nombre
				from isp.int_tipo_prod
				WHERE estado = 'A' ";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionTipoServicio .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('nombre') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //pasi
        $optionPais = '';
        $sql = "select paisp_cod_paisp, paisp_des_paisp from saepaisp order by 2";
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                do {
                    $optionPais .= '<option value="' . $oIfx->f('paisp_cod_paisp') . '">' . $oIfx->f('paisp_des_paisp') . '</option>';
                } while ($oIfx->SiguienteRegistro());
            }
        }
        $oIfx->Free();


        //tipo adjunto
        $optionTipoAdj = '';
        $sql = "SELECT id, tipo
				from isp.int_adjuntos_tipo
				WHERE estado = 'A' and id_empresa=$idempresa order by id ";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionTipoAdj .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('tipo') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $disabledContrato = '';
        $classReq = 'required_valid';
        if ($codigo_automatico == 'S') {
            $disabledContrato = 'readOnly';
            $classReq = '';
        }

        $sql = "SELECT c.id_tipo_factura, c.factura from isp.int_tipo_factura c WHERE c.empr_cod_empr = $idempresa and id_tipo_factura > 0 ";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionFactura .= '<option value="' . $oCon->f('id_tipo_factura') . '">' . $oCon->f('factura') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $optionRuletera = '';
        $sql = "SELECT id, nombre from isp.int_rutas_ruletera WHERE id_empresa = $idempresa AND estado = 'A'";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionRuletera .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('nombre') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $input_ti = "";
        $input_ti_fa = "";

        //-----------------QUERY PARA TIPOS DE INFORMACION--------------------
        $sql = "SELECT i.tipo, i.tipo2, p.identificacion, p.extranjero, p.checked,
				p.cf_sn, p.cf_numero
                FROM comercial.tipo_iden_clpv i, comercial.tipo_iden_clpv_pais p
                WHERE i.id_iden_clpv = p.id_iden_clpv AND
                p.pais_cod_pais = $pais_cod";

        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $tipo = $oCon->f('tipo');
                    $tipo2 = $oCon->f('tipo2');
                    $identificacion = $oCon->f('identificacion');
                    $extranjero = $oCon->f('extranjero');
                    $checked = $oCon->f('checked');
                    $cf_sn = $oCon->f('cf_sn');
                    $cf_numero = $oCon->f('cf_numero');

                    $input_ti .= '<label class="control-label">' . $identificacion . '
                                        <input type="radio" name="identificacion" id="' . $tipo . '" value="' . $tipo . '" ' . $checked . ' onclick="listaPais(' . $extranjero . ', \'' . $cf_sn . '\', \'' . $cf_numero . '\');">
                                    </label>
                                    &nbsp;';

                    $input_ti_fa .= '<label class="control-label">' . $identificacion . '
                                        <input type="radio" name="fac_identificacion" id="' . $tipo . '" value="' . $tipo . '" ' . $checked . '>
                                    </label>
                                    &nbsp;';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //-----------------QUERYS PARA CONTACTOS---------------------------
        $optionTipoTelefono = '';
        $sql = "select codigo, tipo from comercial.tipo_telefono";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionTipoTelefono .= '<option value="' . $oCon->f('codigo') . '">' . $oCon->f('tipo') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //------------------------QUERYS PARA DIRECCION------------------------------
        //tipo direccion
        $optionTipoDireccion = '';
        $sql = "select id, tipo from comercial.tipo_direccion";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionTipoDireccion .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('tipo') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //tipo casa
        $optionTipoCasa = '';
        $sql = "select id, tipo from comercial.tipo_casa";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionTipoCasa .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('tipo') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //sector
        $optionSector = '';
        $sql = "SELECT id, sector FROM comercial.sector_direccion WHERE id_sucursal = $idsucursal";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionSector .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('sector') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //rutas
        $optionRuta = '';
        $sql = "select id, codigo, nombre from isp.int_rutas where id_empresa = $idempresa AND id_sucursal = $idsucursal";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionRuta .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('codigo') . ' - ' . $oCon->f('nombre') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //Departamentos / Provincias
        $sql = "select sucu_cod_ciud from saesucu where sucu_cod_empr = $idempresa and sucu_cod_sucu = $idsucursal ";
        $ciud_cod = consulta_string_func($sql, 'sucu_cod_ciud', $oIfx, 0);
        $sql = "select ciud_cod_prov from saeciud where ciud_cod_ciud = $ciud_cod ";
        $ciud_cod_provc = consulta_string_func($sql, 'ciud_cod_prov', $oIfx, 0);
        $sql_provc = '';
        if ($ciud_cod_provc > 0) {
            $sql_provc = " and provc_cod_provc = $ciud_cod_provc ";
        }

        $sql = "SELECT prov_cod_prov, prov_des_prov from saeprov";
        $optionProv = '';
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                do {
                    $optionProv .= '<option value="' . $oIfx->f('prov_cod_prov') . '">' . $oIfx->f('prov_des_prov') . '</option>';
                } while ($oIfx->SiguienteRegistro());
            }
        }
        $oIfx->Free();

        // Calles
        $sql = "select id, tipo from isp.int_calle_tipo where id_empresa = $idempresa order by 2 ";
        $optionIntCalle = '';
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionIntCalle .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('tipo') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //direcciones
        $optionTipVivienda = '';
        $sql = "SELECT a.id, a.nombre, a.sigla, a.grupo from comercial.dire_siglas a WHERE grupo = 3";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionTipVivienda .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('nombre') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $optionTipConjunto = '';
        $sql = "SELECT a.id, a.nombre, a.sigla, a.grupo from comercial.dire_siglas a WHERE grupo = 4";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionTipConjunto .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('nombre') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtmlDire = '';

        //ETIQUETAS DE DIRECCIONES
        //SAEPROV
        $sql = "SELECT pais_etiq_pais as etiqueta_prov from comercial.pais_etiq_contr where pais_cod_pais = $pais_cod and pais_tbl_direc = 'saeprov' and pais_etiq_est = 'A' LIMIT 1";
        $oCon->Query($sql);
        $etiqueta_prov = $oCon->f('etiqueta_prov');
        $oCon->Free();
        //SAECANT
        $sql = "SELECT pais_etiq_pais as etiqueta_cant from comercial.pais_etiq_contr where pais_cod_pais = $pais_cod and pais_tbl_direc = 'saecant' and pais_etiq_est = 'A' LIMIT 1";
        $oCon->Query($sql);
        $etiqueta_cant = $oCon->f('etiqueta_cant');
        $oCon->Free();
        //SAECIUD
        $sql = "SELECT pais_etiq_pais as etiqueta_ciud from comercial.pais_etiq_contr where pais_cod_pais = $pais_cod and pais_tbl_direc = 'saeciud' and pais_etiq_est = 'A' LIMIT 1";
        $oCon->Query($sql);
        $etiqueta_ciud = $oCon->f('etiqueta_ciud');
        $oCon->Free();
        //SAEPARR
        $sql = "SELECT pais_etiq_pais as etiqueta_parr from comercial.pais_etiq_contr where pais_cod_pais = $pais_cod and pais_tbl_direc = 'saeparr' and pais_etiq_est = 'A' LIMIT 1";
        $oCon->Query($sql);
        $etiqueta_parr = $oCon->f('etiqueta_parr');
        $oCon->Free();


        //SAEPAIS
        $sql = "SELECT pais_des_pais from saepais where pais_cod_pais = $pais_cod";
        $oCon->Query($sql);
        $nom_pais = $oCon->f('pais_des_pais');
        $oCon->Free();

        $sql = "SELECT codigo_servicio_sn from isp.int_parametros_general where id_empresa = $idempresa";
        $oCon->Query($sql);
        $codigo_servicio_sn = $oCon->f('codigo_servicio_sn');
        $oCon->Free();

        $sql = "SELECT plan_moneda_ext from isp.int_parametros where id_empresa = $idempresa and id_sucursal = $idsucursal";
        $oCon->Query($sql);
        $plan_moneda_ext = $oCon->f('plan_moneda_ext');
        $oCon->Free();

        if ($plan_moneda_ext == 'S') {
            $sql = "SELECT mone_cod_mone, mone_des_mone FROM saemone WHERE mone_cod_empr = $idempresa and mone_est_mone = '1' ORDER BY mone_cod_mone";
            $optionMone = lista_boostrap_func($oCon, $sql, 1, 'mone_cod_mone',  'mone_des_mone');
        }

        $optionTipoServContr = '';
        if ($codigo_servicio_sn == 'S') {
            $sql = "SELECT id, nombre FROM isp.int_tipo_servicio WHERE estado = 'A' AND tipo = 'C'";
            $optionTipoServContr = lista_boostrap_func($oCon, $sql, 0, 'id',  'nombre');
        }

        //-----------QUERYS PARA LOS TIPOS DE PAGO -----------------
        $optionMedioPago = '';
        $sql = "select f.fpag_cod_fpag, f.fpag_des_fpag
                from saefpag f
                where
                f.fpag_cod_empr = $idempresa and
                f.fpag_cod_sucu = $idsucursal 
                order by f.fpag_des_fpag";
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                do {
                    $optionMedioPago .= '<option value="' . $oIfx->f('fpag_cod_fpag') . '">' . $oIfx->f('fpag_des_fpag') . '</option>';
                } while ($oIfx->SiguienteRegistro());
            }
        }
        $oIfx->Free();

        //QUERYS PARA REFERENCIAS
        $optionParent = '';
        $sql = "select id_parentezco, nombre_parent from comercial.parentezco";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionParent .= '<option value="' . $oCon->f('id_parentezco') . '">' . $oCon->f('nombre_parent') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //VALIDACION PARA MOSTRAR // OCULTAR CAMPOS
        $campos_generacion = '';
        $sql = "SELECT campos_generacion FROM isp.int_parametros_general WHERE id_empresa = $idempresa";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $campos_generacion = json_decode($oCon->f('campos_generacion', false));
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $campos = [
            'calles_check', 'num_calle_check', 'tip_conjun_check', 'tip_vivienda_check',
            'ruta_check', 'calle_prin_check', 'n_calle_check', 'calle_secu_check',
            'dire_compl_check', 'ref_check'
        ];
        
        foreach ($campos as $campo) {
            if ($campo == 'dire_compl_check') {
                ${'visible_' . $campo} = ($campos_generacion->$campo == 'S') ? 'disabled' : '';
            } else {
                ${'visible_' . $campo} = ($campos_generacion->$campo == 'N') ? ' style="display:none" ' : '';
            }
        }

        // ------------------- CAMPOS DE INFORMACION GENERAL -------------------
        $tableContrato .=   '<div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                                <div id="divInfoContrato" class="row col-md-10"></div>
                                                <div id="divFotoContrato" class="row col-md-2" align="right"></div>
                                        </div>
                                        ' . $num . '
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label"></label>
                                            ' . $input_ti . '
                                            <div class="input-group">
                                            <input type="text" id="ruc_cli" name="ruc_cli" class="form-control required_valid" value="" placeholder="IDENTIFICACION" onchange="consultaExistenciaIden();" onblur="validarDocumento()" required autocomplete="off" />';
        if ($validador_pais == '51') {
            $tableContrato .= '<span class="input-group-addon primary" onclick="verificaDocumentoSunat();" style="cursor:pointer;"><i class="fa-brands fa-searchengin"></i></span>';
        }
        $tableContrato .= '</div></div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label" for="nombres">* Nombres:</label>
                                            <input type="text" id="nombres" name="nombres" class="form-control" value="" placeholder="NOMBRES DEL CLIENTE" onkeyUp="copiar_nombre();" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label" for="apellidos">* Apellidos:</label>
                                            <input type="text" id="apellidos" name="apellidos" class="form-control" value="" placeholder="APELLIDOS DEL CLIENTE" onkeyUp="copiar_nombre();" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label" for="email">* Email:</label>
                                            <div class="input-group">
                                                <input type="text" id="email" name="email" class="form-control required_valid email_valid" value="" placeholder="EMAIL DEL CLIENTE"  autocomplete="off">
                                                <span class="input-group-addon" id="basic-addon2"><i class="fa-solid fa-envelope"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label" for="telefono">* Telefono:</label>
                                            <div class="input-group">
                                                <input type="text" id="telefono" name="telefono" class="form-control required_valid" value="" placeholder="TELEFONO DEL CLIENTE"  autocomplete="off">
                                                <span class="input-group-addon" id="basic-addon2"><i class="fa-solid fa-phone"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <div id="divIdContrato"></div>
                                            <div id="codigoCID"></div>
                                            <input type="text" id="codigoContrato" name="codigoContrato" class="form-control '.$classReq.'" value="" size="' . $num_digitos . '" placeholder="CODIGO" ' . $disabledContrato . '/>
                                        </div>
                                    </div>';

        if ($plan_moneda_ext == 'S') {
            $tableContrato .= ' <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label" for="nom_clpv">* Nombres Completos:</label>
                                                <input type="text" id="nom_clpv" name="nom_clpv" class="form-control required_valid" value="" placeholder="NOMBRES COMPLETOS DEL CLIENTE" required autocomplete="off" style="font-size: 15px; color: blue; font-weight: bold;">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="control-label" for="selec_moneda_id">Moneda:</label><br>
                                                <select id="selec_moneda_id" name="selec_moneda_id" class="form-control" required style="width: 100%;">
                                                    <option value="0">Seleccione una opcion..</option>
                                                    ' . $optionMone . '
                                                </select> 
                                            </div>
                                        </div>';
        } else {
            $tableContrato .= ' <div class="col-md-8">
                                            <div class="form-group">
                                                <label class="control-label" for="nom_clpv">* Nombres Completos:</label>
                                                <input type="text" id="nom_clpv" name="nom_clpv" class="form-control required_valid" value="" placeholder="NOMBRES COMPLETOS DEL CLIENTE" required autocomplete="off" style="font-size: 15px; color: blue; font-weight: bold;">
                                            </div>
                                        </div>';
        }

        $tableContrato .= '</div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" for="apodo">Sobrenombre:</label>
                                            <input type="text" id="apodo" name="apodo" class="form-control" value="" placeholder="APODO DEL CLIENTE" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                        <label class="control-label" for="tipo">* Tipo contrato:</label>
                                            <div class="input-group">
                                                <select id="tipo" name="tipo" class="form-control select2 required_valid" required style="width: 100%;">
                                                    <option value="0">Seleccione una opcion..</option>
                                                    ' . $optionTipo . '
                                                </select> 
                                                <span class="input-group-addon primary" onClick="mostrarServicios();" style="cursor:pointer;"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" for="vendedor">Ruletera:</label>
                                            <select id="id_ruletera" name="id_ruletera" class="form-control select2" style="width: 100%;">
                                                <option value="">Seleccione una opcion..</option>
                                                ' . $optionRuletera . '
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" for="vendedor">* Vendedor:</label>
                                            <select id="vendedor" name="vendedor" class="form-control select2 required_valid" required style="width: 100%;">
                                                <option value="">Seleccione una opcion..</option>
                                                ' . $optionVendedor . '
                                            </select>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="row">
                                    <div class="col-md-1">
                                        <div class="form-group">
                                            <label class="control-label" for="duracionContrato">* Duración</label>
                                            <input type="text" class="form-control required_valid" id="duracionContrato" name="duracionContrato" value="0" style="text-align: right" onkeyUp="calculaFechaVence()" required/>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <label class="control-label" for="fechaVencimiento">*Fecha Vencimiento:</label>
                                            <input type="date" class="form-control required_valid" id="fechaVencimiento" name="fechaVencimiento" value="' . date("Y-m-d") . '" readOnly />
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" for="fecha_naci">*Fecha Nacimiento:</label>
                                            <input type="date" id="fecha_naci" name="fecha_naci" class="form-control required_valid" value="' . date("Y-m-d") . '" required>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" for="fechaContrato">*Fecha Contrato:</label>
                                            <input type="date" id="fechaContrato" name="fechaContrato" class="form-control required_valid" value="' . date("Y-m-d") . '" required>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" for="fechaFirma">*Fecha Firma:</label>
                                            <input type="date" id="fechaFirma" name="fechaFirma" class="form-control required_valid" value="' . date("Y-m-d") . '" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-9">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label" for="penalidadContrato">$ Penalidad:</label>
                                                    <input type="number" class="form-control" id="penalidadContrato" name="penalidadContrato" value="0" required/>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label" for="fechaCobro">* Dia Cobro:</label>
                                                    <input type="number" class="form-control required_valid" id="fechaCobro" name="fechaCobro" value="0" required/>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label" for="fechaCorte">* Dia Corte:</label>
                                                    <input type="number" class="form-control required_valid" id="fechaCorte" name="fechaCorte" value="0" required/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label" for="tipo_factura">* Comprobante:</label>
                                                    <select id="tipo_factura" name="tipo_factura" class="form-control select2 required_valid" style="width: 100%;" >
                                                        <option value="0">Seleccione una opcion..</option>
                                                        ' . $optionFactura . '
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label" for="tipo">* Tipo de cobro:</label>
                                                    <select id="tipo_contrato" name="tipo_contrato" class="form-control required_valid" required style="width: 100%;">
                                                        <option value="1">Prepago</option>
                                                        <option value="2">Postpago</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label" for="fechaVencimiento">* Condición del cliente:</label>
                                                    <select id="condicion_cliente" name="condicion_cliente" class="form-control select2 required_valid" required style="width: 100%;">
                                                        <option value="1">Normal</option>
                                                        <option value="2">Discapacitado</option>
                                                        <option value="3">Tercera Edad</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="row">
                                            <div class="col-md-12">
                                            <img id="img_user_1" src="images/abonado_ejemplo.png" style="width:95%; height:150px;"> 
                                            </div>
                                        </div>
                                        <div class="row">
                                            
                                        </div>
                                                                            
                                    </div>
                                </div>

                                <div class="row">';

        if ($codigo_servicio_sn == 'S') {
            $tableContrato .= '<div class="col-md-3">
                                                            <div class="form-group">
                                                                <label control-label" for="detalleContrato">* Tipo de Cliente:</label>
                                                                <select id="tipo_servicio_contrato" name="tipo_servicio_contrato" class="form-control select2 required_valid" style="width: 100%;" >
                                                                    <option value="0">Seleccione una opcion..</option>
                                                                    ' . $optionTipoServContr . '
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label control-label" for="detalleContrato">Observaciones:</label>
                                                                <textarea rows="1" cols="100" id="detalleContrato" name="detalleContrato" class="form-control"></textarea> 
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label">Facturable Lotes:</label>
                                                                <div class="input-group input-group-sm">
                                                                    <label for="fact_lotes_1" class="text-danger text-center input-group-addon">
                                                                        No
                                                                        <input type="radio" id="fact_lotes_1" name="fact_lotes" value="N" checked/>
                                                                    </label>
                                                                    <label for="fact_lotes_2" class="text-danger text-center input-group-addon">
                                                                        Si
                                                                        <input type="radio" id="fact_lotes_2" name="fact_lotes" value="S"/>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>';
        } else {
            $tableContrato .= '<div class="col-md-9">
                                    <div class="form-group">
                                        <label control-label" for="detalleContrato">Observaciones:</label>
                                        <textarea rows="1" cols="100" id="detalleContrato" name="detalleContrato" class="form-control"></textarea> 
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="control-label">Facturable Lotes:</label>
                                        <div class="input-group input-group-sm">
                                            <label for="fact_lotes_1" class="text-danger text-center input-group-addon">
                                                No
                                                <input type="radio" id="fact_lotes_1" name="fact_lotes" value="1" checked/>
                                            </label>
                                            <label for="fact_lotes_2" class="text-danger text-center input-group-addon">
                                                Si
                                                <input type="radio" id="fact_lotes_2" name="fact_lotes" value="2"/>
                                            </label>
                                        </div>
                                    </div>
                                </div>';
        }

        $tableContrato .= '</div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="hidden" id="num_digitos" name="num_digitos" value="' . $num_digitos . '">
                                        <input type="hidden" id="num_letras" name="num_letras" value="' . $num_letras . '">
                                        <input type="hidden" id="codigoCliente" name="codigoCliente" value="">
                                        <input type="hidden" id="idContrato" name="idContrato" value="">
                                        <input type="hidden" id="codigo_automatico" name="codigo_automatico" value="' . $codigo_automatico . '">
                                        <input type="hidden" id="clpv_cod_sucu" name="clpv_cod_sucu" value="' . $idsucursal . '">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <button type="button" onclick="generarContrato()" class="btn btn-primary btn-lg" style="width: 100%;">
                                                <span class="glyphicon glyphicon-floppy-saved"></span>
                                                Genera / Modifica Contrato
                                            </button>  
                                        </div>
                                    </div>
                                </div>

                            </div>';

        //---------------- CAMPOS PARA CONTACTOS --------------------

        $sHtmlContacs .= '<div class="container-fluid">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="control-label" for="tipo_telefono">* Tipo:</label>
                                        <select id="tipo_telefono" name="tipo_telefono" class="form-control select2" style="width: 100%;">
                                            <option value="">Seleccione una opcion..</option>
                                            ' . $optionTipoTelefono . '
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="control-label" for="telefono_cli">* Telefono:</label>
                                        <input type="text" id="telefono_cli" name="telefono_cli" class="form-control" value="" autocomplete="off" onkeyup="this.value=NumText(this.value)">
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <label class="control-label">&nbsp;</label>
                                        <div class="btn btn-success btn-block" onclick="agregarEntidad(2);">
                                            <span class="glyphicon glyphicon-plus-sign"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="control-label" for="emai_ema_emai">* Email:</label>
                                        <input type="text" id="emai_ema_emai" name="emai_ema_emai" class="form-control min" value="" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <div class="form-group">
                                        <label class="control-label">&nbsp;</label>
                                        <div class="btn btn-success btn-block" onclick="agregarEntidad(3);">
                                            <span class="glyphicon glyphicon-plus-sign"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-7">
                                    <div id="divReporteTelefono" style="width: 98%; margin-top: 10px;" class="table-responsive"></div>
                                </div>
                                <div class="col-md-5">
                                    <div id="divReporteEmail" style="width: 98%; margin-top: 10px;" align="center" class="table-responsive"></div>
                                </div>
                            </div>
                        </div>';

        //------------------CAMPOS PARA LA DIRECCION --------------- CAMBIADO CARGA DE CAMPOS 22-12-2022

        $sHtmlDire .= ' <div class="container-fluid">
                            <div class="row">';

        if (!empty($etiqueta_prov)) {
            $sHtmlDire .= '<div class="col-md-4">
                                                    <label class="control-label" for="dprovc">* ' . ucfirst(strtolower($etiqueta_prov)) . ':</label>
                                                    <select id="dprovc" name="dprovc" class="form-control select2" onchange="cargarCantonCiudad()" style="width: 100%;">
                                                        <option value="0">Seleccione una opcion..</option>
                                                        ' . $optionProv . '
                                                    </select>
                                                </div>';
        }

        if (!empty($etiqueta_cant)) {
            $sHtmlDire .= ' <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="control-label" for="muniDire">* ' . ucfirst(strtolower($etiqueta_cant)) . ':</label>
                                                        <select id="muniDire" name="muniDire" class="form-control select2" style="width: 100%;" onchange="cargarParroquia()">
                                                            <option value="0">Seleccione una opcion..</option>
                                                        </select>
                                                    </div>
                                                </div>';
        }

        if (!empty($etiqueta_ciud)) {
            $sHtmlDire .= '<div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="control-label" for="ciudDire">* ' . ucfirst(strtolower($etiqueta_ciud)) . ':</label>
                                                        <select id="ciudDire" name="ciudDire" class="form-control select2" style="width: 100%;" onchange="crearDireccion()">
                                                            <option value="0">Seleccione una opcion..</option>
                                                        </select>
                                                    </div>
                                                    <input type="hidden" id="siglaDirec">
                                                </div>';
        }

        if (!empty($etiqueta_parr)) {
            $sHtmlDire .= '<div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="control-label" for="parrDire">' . ucfirst(strtolower($etiqueta_parr)) . ':</label>
                                                        <select id="parrDire" name="parrDire" class="form-control select2" style="width: 100%;" onchange="crearDireccion(); valida_cargar_sector()">
                                                        <option value="0">Seleccione una opcion..</option>
                                                        </select>
                                                    </div>
                                                    <input type="hidden" id="siglaDirec">
                                                </div>';
        }

        $sHtmlDire .= '<div class="col-md-4">
                                    <div class="form-group">
                                        <label class="control-label" for="sectorDire">* Sector:</label>
                                        <select id="sectorDire" name="sectorDire" class="form-control select2" style="width: 100%;" onchange="cargarBarrio()">
                                            <option value="0">Seleccione una opcion..</option>
                                            ' . $optionSector . '
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="control-label" for="barrioDire">* Barrio:</label>
                                        <select id="barrioDire" name="barrioDire" class="form-control select2" style="width: 100%;" onchange="crearDireccion()">
                                            <option value="0">Seleccione una opcion..</option>
                                        </select>
                                    </div>
                                </div>
                                
                            </div>
                            <div class="row">
                                <div class="col-md-4" '.$visible_calles_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="tipo_direccion">Tipo Dirección:</label>
                                        <select id="tipo_direccion" name="tipo_direccion" class="form-control select2" onchange="cargarCalle()" style="width: 100%;">
                                            <option value="0">Seleccione una opcion..</option>
                                            ' . $optionIntCalle . '
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4" '.$visible_calles_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="tipo_direccion">Calle Dirección:</label>
                                        <select id="calle_direccion" name="calle_direccion" class="form-control select2" style="width: 100%;" onchange="llenarCalle()">
                                            <option value="0">Seleccione una opcion..</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4" '.$visible_calles_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="tipo_direccion">Calle:</label>
                                        <input type="text" id="calle_direccion_txt" name="calle_direccion_txt" class="form-control" value="" placeholder="" autocomplete="off" readonly>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-4" '.$visible_num_calle_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="tipo_direccion">N° Calle:</label>
                                        <select id="n_calle_select" name="n_calle_select" class="form-control select2" style="width: 100%;" onchange="llenarCalle()">
                                            <option value="0">Seleccione una opcion..</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4" '.$visible_tip_conjun_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="conjDire">* Tipo de Conjunto:</label>
                                        <select id="conjDire" name="conjDire" class="form-control select2" style="width: 100%;" onchange="obtenerSiglaDire(this)">
                                            <option value="0">Seleccione una opcion..</option>
                                            ' . $optionTipConjunto . '
                                        </select>
                                    </div>
                                    <input type="hidden" id="siglaConj">
                                </div>
                                <div class="col-md-4" '.$visible_tip_vivienda_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="tipo_casa">* Tipo Vivienda:</label>
                                        <select id="tipo_casa" name="tipo_casa" class="form-control select2" style="width: 100%;">
                                            <option value="0">Seleccione una opcion..</option>
                                            ' . $optionTipVivienda . '
                                        </select>
                                        <input type="hidden" id="siglaCasa">
                                    </div>
                                    
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4" '.$visible_ruta_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="rutaDire">Ruta</label>
                                        <select id="rutaDire" name="rutaDire" class="form-control select2" style="width: 100%;">
                                            <option value="">Seleccione una opcion..</option>
                                            ' . $optionRuta . '
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2" '.$visible_ruta_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="">&nbsp;</label>
                                        <button type="button" class="btn btn-warning" onclick="detalleRutasCliente();" style="width: 100%;">Rutas</button>
                                    </div>
                                </div>
                                <div class="col-md-3" '.$visible_ruta_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="ordenRutaDire">Orden Ruta:</label>
                                        <input type="text" id="ordenRutaDire" name="ordenRutaDire" class="form-control" value="" placeholder="" autocomplete="off" onkeyUp="cargarCodigoRuta(2);">
                                    </div>
                                </div>
                                <div class="col-md-3" '.$visible_ruta_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="codigoRutaDire">Codigo Ruta:</label>
                                        <input type="text" id="codigoRutaDire" name="codigoRutaDire" class="form-control" value="" placeholder="" autocomplete="off" readOnly>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6" '.$visible_calle_prin_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="callePrincipal">Calle Principal:</label>
                                        <input type="text" id="callePrincipal" name="callePrincipal" class="form-control" value="" placeholder="CALLE PRINCIPAL" autocomplete="off" onkeyUp="crearDireccion();">
                                    </div>
                                </div>
                                <div class="col-md-2" '.$visible_n_calle_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="numeroDire">Número:</label>
                                        <input type="text" id="numeroDire" name="numeroDire" class="form-control" value="" placeholder="" autocomplete="off" onkeyUp="crearDireccion();">
                                    </div>
                                </div>
                                <div class="col-md-4" '.$visible_calle_secu_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="calleSecundaria">Calle Secundaria:</label>
                                        <input type="text" id="calleSecundaria" name="calleSecundaria" class="form-control" value="" placeholder="CALLE SECUNDARIA" autocomplete="off" onkeyUp="crearDireccion();">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group" >
                                        <label class="control-label" for="direccion">* Direcci&oacute;n Completa:</label>
                                        <input type="text" id="direccion" name="direccion" class="form-control" '.$visible_dire_compl_check.' placeholder="DIRECCION COMPLETA" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12" '.$visible_ref_check.'>
                                    <div class="form-group">
                                        <label class="control-label" for="referenciaDire">Referencia:</label>
                                        <input type="text" id="referenciaDire" name="referenciaDire" class="form-control" value="" placeholder="REFERENCIA" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                            
                        </div>';

        //--------------CAMPOS PARA SOLICITUD DE SERVICIOS -------------------

        $tableEquipos = '<div class="container-fluid">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <button type="button" class="btn btn-success btn-lg" onclick="mirarPlanes();" style="width: 100%;">
                                            <i class="fa fa-plus-circle"></i>
                                            Seleccionar Planes
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>';

        //-------------CAMPOS PARA EL MEDIO DE PAGO ---------------------------
        $tableMedioPagos = '<div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label" for="pago">Forma de Pago:</label>
                                            <select id="pago" name="pago" class="form-control select2" style="width: 100%;">
                                                    <option value="">Seleccione una opcion..</option>
                                                    ' . $optionMedioPago . '
                                            </select>
                                            <input type="hidden" id="idMedioPago" name="idMedioPago" value="0">
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <label class="col-md-12">&nbsp;</label>
                                        <div id="divDetalleFormaPago" class="col-md-12"></div>
                                    </div>
                                </div>
                            </div>';

        //-------------CAMPOS PARA REFERENCIAS ------------------------------

        $sHtmlReferencia .= '<div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label control-label" for="referenciaNombre">* Nombres:</label>
                                            <input type="text" id="referenciaNombre" name="referenciaNombre" class="form-control" value="" placeholder="NOMBRES DE LA REFERENCIA" autocomplete="off">
                                            <input type="hidden" id="idReferencia" name="idReferencia" value="0">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label control-label" for="referenciaIden">* Identificaci&oacute;n:</label>
                                            <input type="text" id="referenciaIden" name="referenciaIden" class="form-control" value="" placeholder="IDENTIFICACION DE LA REFERENCIA" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label control-label" for="referenciaParent">Parentezco:</label>
                                            <select id="referenciaParent" name="referenciaParent" class="form-control" style="width: 100%;">
                                                <option value="">Seleccione una opcion..</option>
                                                ' . $optionParent . '
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label control-label" for="referenciaTelefono">* Telefono:</label>
                                            <input type="text" id="referenciaTelefono" name="referenciaTelefono" class="form-control" value="" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <div class="btn btn-success btn-md" onclick="guardarReferencia();" style="width: 100%;">
                                                <i class="fa fa-plus-circle"></i>
                                                Agregar Referencia
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                            </div>';

        //adjuntos
        $ifu->AgregarCampoArchivo('archivo', 'Archivo|left', false, '', 100, 100, '');

        $tableAdjuntos =    '<div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label" for="titulo">* Documento:</label>
                                            <select id="titulo" name="titulo" class="form-control select2" style="width: 100%;">
                                                <option value="0">Seleccione una opcion..</option> 
                                                ' . $optionTipoAdj . '
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label control-label" for="archivo">Adjunto:</label><br>
                                            <div class="btn-group" style="width:100%" role="group" aria-label="...">
                                                <button type="button" class="btn btn-primary" onclick="setup_adj()"><i class="fa-solid fa-camera"></i> Foto</button>
                                                <button type="button" class="btn btn-info" onclick="muestra_adj()"><i class="fa-solid fa-file-pdf"></i> <i class="fa-solid fa-file-image"></i> Archivo</button>
                                                <button type="button" id="btn_adj_1" class="btn btn-success" onclick="guardarAdjuntosImg()" style="display:none"><i class="fa-solid fa-floppy-disk"></i> Guardar</button>
                                                <button type="button" id="btn_adj_2" class="btn btn-success" onclick="guardarAdjuntos()" style="display:none"><i class="fa-solid fa-floppy-disk"></i> Guardar</button>
                                            </div>
                                            <div id="results_adj"></div>
                                            <div id="my_camera_adj"></div>
                                            
                                            <div id="my_camera_adj_btn" style="display:none">
                                            <br>
                                                <button type="button" onclick="take_snapshot_adj()" class="btn btn-success btn-block">
                                                    Tomar foto
                                                </button>
                                            </div>
                                            <br>
                                            <div id="archivo_up" style="display:none">
                                                <input type="file" name="archivo" id="archivo">
                                                <div class="upload-msg-archivo"></div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>';
        $tableFotos = ' <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <img id="img_user" src="images/abonado_ejemplo.png" style="width:320px; height:240px;"> 
                                    <div id="results"></div>
                                    <div id="my_camera"></div>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-3">     
                                </div>
                                <div class="col-md-3">
                                    <button id="foto_abrir_camara" class="btn btn-block btn-primary" type="button" onClick="setup();"> <i class="fa fa-sign-in" aria-hidden="true"></i> Acceder a la camara</button>
                                    <button id="foto_tomar_foto" class="btn btn-block btn-success" type="button" onClick="take_snapshot()" style="display:none"><i class="fa fa-camera" aria-hidden="true"></i> Tomar foto</button>
                                    <button id="foto_volver_foto" class="btn btn-block btn-success" type="button" onClick="setup2()" style="display:none"><i class="fa fa-camera" aria-hidden="true"></i> Tomar otra foto </button>
                                </div>
                                <div class="col-md-3">
                                    <button id="foto_selec_foto" class="btn btn-block btn-primary" type="button" onClick="setup3()" ><i class="fa fa-hand-o-right" aria-hidden="true"></i> Seleccionar foto </button>
                                    <input type="file" name="imagen_abonado" id="imagen_abonado" onchange="upload_image(id);" style="display:none">
                                    <div class="upload-msg"></div>
                                </div>
                                <div class="col-md-3">     
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-3">     
                                </div>
                                <div class="col-md-6">
                                    <button id="foto_guardar" class="btn btn-block btn-primary" type="button" onClick="saveSnap();" style="display:none"> <i class="fa fa-save" aria-hidden="true"></i> Guardar imagen</button>
                                    <button id="foto_guardar_archivo" class="btn btn-block btn-primary" type="button" onClick="saveArchivo();" style="display:none"> <i class="fa fa-save" aria-hidden="true"></i> Guardar imagenn</button>
                                </div>
                                <div class="col-md-3">     
                                </div>
                            </div>
                        </div>';
        //garantias
        $tableGarantias = '<div class="row">
                                <h4 align="center">Ingreso Garantias <small></small></h4>
                            </div>
                            <div class="row">
                                <label for="garantiaTipo" class="control-label">Tipo Garantia</label>
                            </div>';

        $sHtmlFinalizar = '<div class="alert alert-warning" style="text-align:center"role="alert">
                            <i class="fa-solid fa-bell fa-10x"></i>
                                <br><br>
                                <h4>NO HA SELECCIONADO NINGÚN CONTRATO PARA VISUALIZAR ESTA SECCIÓN</h4> 
                            </div>';
        $oReturn->assign("divFormularioProdServClpv", "innerHTML", $tableEquipos);
        $oReturn->assign("divFormularioContactoTelf", "innerHTML", $sHtmlContacs);
        $oReturn->assign("divFormularioContactoDire", "innerHTML", $sHtmlDire);
        $oReturn->assign("divFormularioReferencias", "innerHTML", $sHtmlReferencia);
        $oReturn->assign("divFormularioMediosPago", "innerHTML", $tableMedioPagos);
        $oReturn->assign("divFormularioAdjuntos", "innerHTML", $tableAdjuntos);
        $oReturn->assign("divFormularioContrato", "innerHTML", $tableContrato);
        $oReturn->assign("divFormularioGarantias", "innerHTML", $tableGarantias);
        $oReturn->assign("divFormularioFoto", "innerHTML", $tableFotos);
        $oReturn->assign('divBodyTableEquipos', 'innerHTML', '');
        $oReturn->assign('informacionCliente', 'innerHTML', '');
        $oReturn->assign('divReporteReferencias', 'innerHTML', '');
        $oReturn->assign('divReporteAdjuntos', 'innerHTML', '');
        $oReturn->assign('divReporteMedioPago', 'innerHTML', '');
        $oReturn->assign('buscaContrato', 'focus()', '');
        $oReturn->assign('divReporteDireccion', 'innerHTML', '');
        $oReturn->assign('divFinalizar', 'innerHTML', $sHtmlFinalizar);
        $oReturn->assign('btn_reactivar', 'innerHTML', '');

        $oReturn->script("$('.select2').select2();

						$('#rutaDire').change(function () {
							cargarCodigoRuta(1);
                        });
                        
                        $('#pago').change(function(){
                            validarFormaPago(this);
                        });");


        $oReturn->script('initOmitirSaltoLinea();');
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function buscarContratos($aForm = '', $op = 0)
{

    // echo "aaaa";exit;
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idUser = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $sucursal = $_SESSION['U_SUCURSAL'];

    try {

        //datos del formulario
        $buscaContrato = strtoupper(trim($aForm['buscaContrato']));
        $num_digitos = $aForm['num_digitos'];

        if ($buscaContrato == '0') {
            $sql = "select max(id) as id from isp.int_tmp_buscar where id_user = $idUser";
            $idmaximo = consulta_string_func($sql, 'id', $oCon, 0);

            if ($idmaximo > 0) {
                $sql = "select id_contrato, id_clpv from isp.int_tmp_buscar where id = $idmaximo";
                if ($oCon->Query($sql)) {
                    if ($oCon->NumFilas() > 0) {
                        $id = $oCon->f('id_contrato');
                        $id_clpv = $oCon->f('id_clpv');
                        //------------------------------------
                        $sql_1 = "SELECT clv_con_clpv from saeclpv where clpv_cod_clpv=$id_clpv";
                        $tip_doc = consulta_string_func($sql_1, 'clv_con_clpv', $oCon, 0);

                        $oReturn->script('seleccionarContrato(' . $id_clpv . ',' . $id . ');');
                    }
                }
                $oCon->Free();
            }
        } else {

            $sqlTmp = '';
            if ($op == 1) { //abonado

                $buscaContratoOk = $buscaContrato;
                // $buscaContratoOk = secuencial(2, '', $buscaContrato - 1, $num_digitos);
                // $oReturn->assign('buscaContrato', 'value', $buscaContratoOk);
                $sqlTmp = " and codigo like ('%$buscaContratoOk%')";
            }

            $sql = "select count(*) as control from isp.contrato_clpv  where id_empresa = $idempresa and id_sucursal = $sucursal $sqlTmp";
            $control = consulta_string_func($sql, 'control', $oCon, 0);

            if ($control == 0) {
                $oReturn->alert("No existen Coincidencias de Busqueda, vuelva a intentarlo...!");
            } elseif ($control == 1) {
                $sql = "select id, id_clpv from isp.contrato_clpv  where id_empresa = $idempresa and id_sucursal = $sucursal $sqlTmp";
                if ($oCon->Query($sql)) {
                    if ($oCon->NumFilas() > 0) {
                        $id = $oCon->f('id');
                        $id_clpv = $oCon->f('id_clpv');
                        $oReturn->script('seleccionarContrato(' . $id_clpv . ',' . $id . ');');
                    }
                }
                $oCon->Free();
            } else {
                $oReturn->script('buscarContratosModal(' . $op . ')');
            }

            //  $oReturn->assign('titulo', 'checked', true);

        }
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    // echo $tip_doc;exit;



    return $oReturn;
}

function cargar_tip_docu($aForm = '')
{

    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();
    $tipo = $aForm['identificacion'];

    $id_empresa = $_SESSION["U_EMPRESA"];

    $sql = "SELECT  id, tipo from isp.int_adjuntos_tipo where  estado = 'A' and tip_docu='$tipo' AND id_empresa = $id_empresa";
    $i = 1;
    if ($oIfx->Query($sql)) {
        $oReturn->script('eliminarListadoc();');
        if ($oIfx->NumFilas() > 0) {
            do {
                $oReturn->script(('anadirListadoc(' . $i++ . ',\'' . $oIfx->f('id') . '\', \'' . $oIfx->f('tipo') . '\' )'));
            } while ($oIfx->SiguienteRegistro());
        }
    }
    $oIfx->Free();
    return $oReturn;
}

function buscarContratosFiltros($aForm = '', $op = 0, $idHtml = 0)
{

    global $DSN;
    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $arraySector = $_SESSION['ARRAY_SECTOR_BARRIO'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $filtro = trim(strtoupper($aForm['filtro_' . $op]));

    try {

        $sql = "SELECT id_contrato, string_agg(ip, ' - ') as ip from isp.int_contrato_caja where id_empresa = $idempresa GROUP BY 1";
        $array_ip = array_dato($oCon, $sql, 'id_contrato', 'ip');

        //array estado
        $sql = "select id, estado, color from isp.estado_contrato";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayEstado);
                unset($arrayEstadoColor);
                do {
                    $arrayEstado[$oCon->f('id')] = $oCon->f('estado');
                    $arrayEstadoColor[$oCon->f('id')] = $oCon->f('color');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml = '';
        $sHtml .= '<table class="table table-condensed table-bordered table-hover table-striped" style="width: 100%; margin: 0px;" align="center">';
        $sHtml .= '<tr>';
        $sHtml .= '<td class="warning fecha_letra">Abonado</th>';
        $sHtml .= '<td class="warning fecha_letra">Nombres</td>';
        $sHtml .= '<td class="warning fecha_letra">Apodo</td>';
        $sHtml .= '<td class="warning fecha_letra">Estado</td>';
        $sHtml .= '<td class="warning fecha_letra">Sector</td>';
        $sHtml .= '<td class="warning fecha_letra">Direccion</td>';
        $sHtml .= '<td class="warning fecha_letra">Ip</td>';
        $sHtml .= '<td class="warning fecha_letra">Telefono</td>';
        $sHtml .= '</tr>';

        if ($op == 1) {
            $controlCampo = strpos($filtro, ",");
            if ($controlCampo !== false) {
                $arrayCampo = split(',', $filtro);
                $apellido = trim($arrayCampo[1]);
                $nombre = trim($arrayCampo[0]);
                $sqlTmp = " and (nombre like('$nombre%') AND apellido like('$apellido%'))";
            } else {
                $sqlTmp = " and nom_clpv like('%$filtro%')";
            }
        } elseif ($op == 2) {
            $sqlTmp = " and sobrenombre like('%$filtro%')";
        } elseif ($op == 3) {
            $sqlTmp = " and ruc_clpv like('%$filtro%')";
        } elseif ($op == 4) {
            $sqlTmp = " and telefono like('%$filtro%')";
        } elseif ($op == 5) {
            $sqlTmp = " and direccion like('%$filtro%')";
        } elseif ($op == 6) {
            $sqlTmp = " and referencia like('%$filtro%')";
        }

        $sql = "select id, id_clpv, abonado, codigo, nom_clpv,
				sobrenombre, direccion, id_sector, id_barrio,
				referencia, telefono, estado
				from isp.contrato_clpv
				where id_empresa = $idempresa 
				$sqlTmp
				limit 50";

        //$oReturn->alert($sql);
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id = $oCon->f('id');
                    $id_clpv = $oCon->f('id_clpv');
                    $abonado = $oCon->f('abonado');
                    $codigo = $oCon->f('codigo');
                    $nom_clpv = $oCon->f('nom_clpv');
                    $sobrenombre = $oCon->f('sobrenombre');
                    $id_sector = $oCon->f('id_sector');
                    $id_barrio = $oCon->f('id_barrio');
                    $referencia = $oCon->f('referencia');
                    $telefono = $oCon->f('telefono');
                    $direccion = $oCon->f('direccion');
                    $estado = $oCon->f('estado');

                    $sHtml .= '<tr style="cursor: pointer;" onclick="seleccionaItemBuscar(' . $id_clpv . ', ' . $id . ', ' . $idHtml . ')">';
                    $sHtml .= '<td class="danger" style="width: 8%;"><h6>' . $codigo . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 25%;"><h6>' . $nom_clpv . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 15%;"><h6>' . $sobrenombre . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 8%; color: ' . $arrayEstadoColor[$estado] . '"><h6>' . $arrayEstado[$estado] . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 15%;"><h6>' . $arraySector[$id_sector] . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 20%;"><h6>' . $direccion . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 20%;"><h6>' . $array_ip[$id] . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 9%;"><h6>' . $telefono . '</h6></td>';
                    $sHtml .= '</tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml .= '</table>';

        $oReturn->assign('divResultados_' . $idHtml, 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function consultaExistenciaIden($aForm = '')
{

    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $ruc_cli = $aForm['ruc_cli'];
    $tipo = $aForm['identificacion'];

    $clpv_cod_clpv = 0;
    $clpv_ruc_clpv = '';
    $clpv_nom_clpv = '';
    $nombre = '';
    $apellido = '';

    try {

        $sql = "select clpv_cod_clpv, clpv_ruc_clpv, clpv_nom_clpv
                from saeclpv where
                clpv_cod_empr = $idempresa and
                clpv_ruc_clpv = '$ruc_cli' and
                clv_con_clpv = '$tipo' and
                clpv_clopv_clpv = 'CL' ";
        //$oReturn->alert($sql);
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                $clpv_cod_clpv = $oIfx->f('clpv_cod_clpv');
                $clpv_ruc_clpv = $oIfx->f('clpv_ruc_clpv');
                $clpv_nom_clpv = $oIfx->f('clpv_nom_clpv');

                if ($clpv_cod_clpv > 0) {
                    $sql = "select nombre, apellido from isp.contrato_clpv where id_clpv = $clpv_cod_clpv";
                    if ($oCon->Query($sql)) {
                        $nombre = $oCon->f('nombre');
                        $apellido = $oCon->f('apellido');
                    }
                    $oCon->Free();
                }

                $oReturn->assign('ruc_cli', 'value', $clpv_ruc_clpv);
                $oReturn->assign('nombres', 'value', $nombre);
                $oReturn->assign('apellidos', 'value', $apellido);
                $oReturn->assign('nom_clpv', 'value', $clpv_nom_clpv);
            }
        }
        $oIfx->Free();

        if ($clpv_cod_clpv > 0) {
            $sql = "select count(*) as numero from isp.contrato_clpv where id_clpv = $clpv_cod_clpv";
            $numeroContratos = consulta_string_func($sql, 'numero', $oCon, 0);

            $oReturn->assign('numContratos', 'innerHTML', $numeroContratos);
            $oReturn->script("listadoContratos($clpv_cod_clpv);");
            $oReturn->assign('ruc_cli', 'value', '');
            $oReturn->assign('nombres', 'value', '');
            $oReturn->assign('apellidos', 'value', '');
            $oReturn->assign('nom_clpv', 'value', '');
        }

        $oReturn->assign('codigoCliente', 'value', $clpv_cod_clpv);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}


function seleccionarContrato($aForm = '', $id_clpv = 0, $id = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon1 = new Dbo;
    $oCon1->DSN = $DSN;
    $oCon1->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $userWeb = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    try {

        $sql = "SELECT table_name FROM information_schema.columns 
                WHERE table_name='contrato_firmas' 
                AND table_schema = 'public'";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $table_name    = $oCon->f('table_name');
            }
        }
        $oCon->Free();

        if (empty($table_name)) {

            $oCon1->QueryT('BEGIN;');

            $sqlCreateTable = 'CREATE TABLE "public"."contrato_firmas" (
                                "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
                                INCREMENT 1
                                MINVALUE  1
                                MAXVALUE 2147483647
                                START 1
                                CACHE 1
                                ),
                                "id_contrato" int4 NOT NULL,
                                "imagen" text COLLATE "pg_catalog"."default" NOT NULL,
                                "created_at" timestamp(0),
                                "updated_at" timestamp(0)
                                );';
            $oCon1->QueryT($sqlCreateTable);

            $sqlClavePrimaria = 'ALTER TABLE "public"."contrato_firmas" ADD CONSTRAINT "contrato_firmas_pkey" PRIMARY KEY ("id");';
            $oCon1->QueryT($sqlClavePrimaria);
        }

        $oCon1->QueryT('COMMIT;');

        $sql = "SELECT num_digitos, aprobar_automatico from isp.int_parametros WHERE id_empresa = $idempresa AND id_sucursal = $idsucursal";
        $aprobar_automatico = consulta_string_func($sql, 'aprobar_automatico', $oCon, 0);

        $classContratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $id_clpv, $id);
        $arrayContrato = $classContratos->consultarContrato();
        $valorDeuda = $classContratos->consultaMontoMesAdeuda();
        $valorCuotas = $classContratos->consultaMesesAdeuda();

        if (count($arrayContrato) > 0) {
            foreach ($arrayContrato as $val) {

                $codigo = $val[5];
                $nom_clpv = $val[6];
                $ruc_clpv = $val[7];
                $fecha_contrato = $val[8];
                $fecha_firma = $val[9];
                $fecha_corte = $val[10];
                $fecha_cobro = $val[11];
                $duracion = $val[12];
                $penalidad = $val[13];
                $estado = $val[14];
                $vendedor = $val[15];
                $tarifa = $val[18];
                $fecha_instalacion = $val[21];
                $sobrenombre = $val[23];
                $limite = $val[24];
                $cobrador = $val[25];
                $tipo_contrato = $val[26];
                $cheque_sn = $val[27];
                $cobro_directo = $val[28];
                $abonado = $val[37];
                $nombre = $val[39];
                $apellido = $val[40];
                $foto = $val[41];
                $observaciones = $val[42];
                $tipo_duracion = $val[43];
                $fecha_c_vence = $val[44];
                $email_factura = $val[57];
                $ruletera = $val[63];
                $id_tipo_cobro = $val[64];
                $id_ruletera = $val[68];
                $factura_ncf = $val[69];
                $email = $val[34];
                $telefono = $val[33];
                $cantidad_tv = $val[71];
                $celular = $val[72];
                $moneda_id = $val[73];
                $tipoContrato = $val[75];
            }

            //estado
            $sql = "SELECT estado, color, class from isp.estado_contrato where id = '$estado'";
            $estadoNombre = consulta_string_func($sql, 'estado', $oCon, '');
            $estadoColor = consulta_string_func($sql, 'color', $oCon, '');
            $estadoClass = consulta_string_func($sql, 'class', $oCon, '');


            $sql = "SELECT pcon_seg_mone from saepcon where pcon_cod_empr = $idempresa";
            $pcon_seg_mone = consulta_string_func($sql, 'pcon_seg_mone', $oCon, '');

            $msn_non_ext = '';
            if ($moneda_id == $pcon_seg_mone) {
                $msn_non_ext = '<span class="label label-warning" style="font-size:11px">Contrato en moneda extranjera</span>';
            }

            $btn_reactivar = '';
            if ($estado == 'CA') {
                $btn_reactivar = '<button type="button" class="btn btn-info" onclick="reinstalar_contrato(' . $id . ')">Reinstalar Contrato</button>';
            }

            $sql = "SELECT identificador, id_tipo_cont_serv, ruc_clpv from isp.contrato_clpv where id = $id";
            $identificador      = consulta_string($sql, 'identificador', $oCon, '');
            $id_tipo_cont_serv  = consulta_string($sql, 'id_tipo_cont_serv', $oCon, '');
            $ruc_clpv_iden      = consulta_string($sql, 'ruc_clpv', $oCon, '');

            $sql = "SELECT imagen from contrato_firmas where id_contrato = $id";
            $imagen_firma       = consulta_string($sql, 'imagen', $oCon, '');

            $sql = "SELECT codigo_servicio_sn from isp.int_parametros_general where id_empresa = $idempresa";
            $oCon->Query($sql);
            $codigo_servicio_sn = $oCon->f('codigo_servicio_sn');
            $oCon->Free();

            if ($codigo_servicio_sn == 'S' && !empty($id_tipo_cont_serv)) {
                //REMPLAZADO EL 12/10/2023 A PEDIDO DE GLOBAL
                /*  $sql = "SELECT codigo from isp.int_tipo_servicio where id = $id_tipo_cont_serv";
                $codigo_cid_1       = consulta_string($sql, 'codigo', $oCon, '');

                $codigo_cid_fn      = $codigo_cid_1 . $codigo;

                $lbl_cid = '<label class="control-label" for="codigoContrato">Código de pago:  <span> ' . $codigo_cid_fn . ' </span></label>';
                */

                $sql = "SELECT a.id_contrato, string_agg(a.codigo_cid , '<br>') as datos_2
                        FROM isp.int_contrato_caja_pack a 
                        WHERE a.estado IN ('A', 'P', 'C', 'I') AND a.activo IN ('S') GROUP BY 1";
                unset($array_cid);
                $array_cid = array_dato($oCon, $sql, 'id_contrato', 'datos_2');
                $codigo_cid_fn = $array_cid[$id];

                $lbl_cid = '<label class="control-label" for="codigoContrato">Código de pago:  <br> <span> ' . $codigo_cid_fn . ' </span></label>';
                $oReturn->assign('codigoCID', 'innerHTML', $lbl_cid);
            }

            if (!empty($imagen_firma)) {
                $identificador     = '<img width="200px;" height="100px;" src="data:image/png;base64,' . $imagen_firma . '">';
            } else {
                if (!empty($identificador)) {
                    $identificador = DIR_FACTELEC . 'modulos/int_clientes/' . $identificador;
                    $identificador = '<img width="200px;" height="100px;" src="' . $identificador . '">';
                }
            }

            //control contratos
            $sql = "select count(*) as control from isp.contrato_clpv where id_clpv = $id_clpv and ruc_clpv = '$ruc_clpv_iden'";
            $numContratos = consulta_string_func($sql, 'control', $oCon, 0);

            $sql = "select c.clpv_cod_vend, c.clpv_pre_ven, c.clv_con_clpv,c.clpv_fec_naci
                    from saeclpv c where
                    c.clpv_cod_empr = $idempresa and
                    c.clpv_cod_clpv = $id_clpv";
            if ($oIfx->Query($sql)) {
                if ($oIfx->NumFilas() > 0) {
                    $clpv_cod_vend = $oIfx->f('clpv_cod_vend');
                    $clpv_pre_ven = round($oIfx->f('clpv_pre_ven'));
                    $clv_con_clpv = $oIfx->f('clv_con_clpv');
                    $clpv_fec_naci = $oIfx->f('clpv_fec_naci');
                }
            }
            $oIfx->Free();

            $fecha_nacimineto = $clpv_fec_naci;

            $sHtml = '<div class="col-xs-12 col-sm-12 col-md-4">
                            <div class="form-group has-error">
                                    <label>Estado</label>
                                    <h5 class="' . $estadoClass . '" style="color:' . $estadoColor . '; font-size: 20px; font-weight: bold; margin: 0px;">' . $estadoNombre . '</h5>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-2">
                            <div class="form-group has-error">
                                <label for="tarifaContrato">Tarifa</label>
                                <input type="text" class="form-control" id="tarifaContrato" value="' . number_format($tarifa, 2, '.', '') . '" style="text-align: right" readonly/>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-2">
                            <div class="form-group has-error">
                                <label for="cuotasContrato">Cuotas Vencidas</label>
                                <input type="text" class="form-control" id="cuotasContrato" value="' . number_format($valorCuotas, 2, '.', '') . '"  style="text-align: right" readonly/>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-2">
                            <div class="form-group has-error">
                                <label for="adeudaContrato">Valor Vencido</label>
                                <input type="text" class="form-control" id="adeudaContrato" value="' . number_format($valorDeuda, 2, '.', '') . '"  style="text-align: right" readonly/>
                            </div>
                        </div>
                       <div class="col-xs-12 col-sm-12 col-md-2">
                            <div class="form-group">
                                <label>&nbsp;</label>
                                <button type="button" class="btn btn-success " onclick="actualizaInfo()" title="Actualizar Informaci&oacute;n "><i class="glyphicon glyphicon-refresh"></i></button>
                                <button type="button" class="btn btn-info " onclick="listadoContratos(' . $id_clpv . ')" title="Contratos Registrados"> ' . $numContratos . '</button>
                            </div>
                        </div>';

            //numero notas
            $sql = "select count(*) as notas
                    from isp.int_notas
                    where id_clpv = $id_clpv and
                    id_contrato = $id";
            $notas = consulta_string_func($sql, 'notas', $oCon, 0);

            $oReturn->assign('numNotas', 'innerHTML', '<span>' . $notas . '</span>');
            //echo $id_clpv.'hola';

            $sql_1 = "SELECT clv_con_clpv from saeclpv where clpv_cod_clpv=$id_clpv";
            $tip_doc = consulta_string_func($sql_1, 'clv_con_clpv', $oCon, 0);

            //RUC
            if ($tip_doc == 01) {
                $oReturn->assign('01', 'checked', true);
            }
            //CEDULA/DNI

            if ($tip_doc == 02) {
                $oReturn->assign('02', 'checked', true);
            }
            //PASAPORTE
            if ($tip_doc == 03) {
                $oReturn->assign('03', 'checked', true);
            }

            //C.FINAL/OTROS

            if ($tip_doc == 07) {
                $oReturn->assign('07', 'checked', true);
            }

            //EXTRANJERIA

            if ($tip_doc == 04) {
                $oReturn->assign('04', 'checked', true);
            }

            $oReturn->assign('divInfoContrato', 'innerHTML', $sHtml);

            $oReturn->assign('idContrato', 'value', $id);
            $oReturn->assign('codigoCliente', 'value', $id_clpv);
            $oReturn->assign('ruc_cli', 'value', $ruc_clpv);
            $oReturn->assign('nombres', 'value', $nombre);
            $oReturn->assign('email', 'value', $email);
            $oReturn->assign('telefono', 'value', $telefono);
            $oReturn->assign('apellidos', 'value', $apellido);
            $oReturn->assign('nom_clpv', 'value', $nom_clpv);
            $oReturn->assign('codigoContrato', 'value', $codigo);
            $oReturn->assign('fechaContrato', 'value', $fecha_contrato);
            $oReturn->assign('fechaFirma', 'value', $fecha_firma);
            $oReturn->assign('fechaCorte', 'value', $fecha_corte);
            $oReturn->assign('fechaCobro', 'value', $fecha_cobro);
            $oReturn->assign('fechaInstalacion', 'value', $fecha_instalacion);
            $oReturn->assign('duracionContrato', 'value', $duracion);
            $oReturn->assign('penalidadContrato', 'value', $penalidad);
            $oReturn->assign('detalleContrato', 'value', $observaciones);
            $oReturn->assign('apodo', 'value', $sobrenombre);
            $oReturn->assign('creditoContrato', 'value', $limite);
            $oReturn->assign('tipoDuracion_' . $tipo_duracion, 'checked', true);
            $oReturn->assign('fechaVencimiento', 'value', $fecha_c_vence);
            $oReturn->assign('foto', 'value', $foto);
            $oReturn->assign('tipo_servicio_contrato', 'value', $id_tipo_cont_serv);
            $oReturn->assign('btn_reactivar', 'innerHTML', $btn_reactivar);
            $oReturn->assign('fecha_naci', 'value', $fecha_nacimineto);

            $oReturn->script("listaPais()");

            $oReturn->script("$('#tipo').val($tipo_contrato).trigger('change.select2');");
            $oReturn->script("$('#vendedor').val('$vendedor').trigger('change.select2');");
            $oReturn->script("$('#cobrador').val('$cobrador').trigger('change.select2');");
            $oReturn->script("$('#tipo_factura').val($factura_ncf).trigger('change.select2');");
            $oReturn->script("$('#id_tipo_cobro').val($id_tipo_cobro).trigger('change.select2');");
            $oReturn->script("$('#id_ruletera').val($id_ruletera).trigger('change.select2');");
            $oReturn->assign('selec_moneda_id', 'value', $moneda_id);
            $oReturn->assign('div_mon_ext', 'innerHTML', $msn_non_ext);

            //fotos
            if (!empty($foto)) {
                $oReturn->assign('img_user_1', 'src', $foto);
                $oReturn->assign('img_user', 'src', $foto);
            }

            if (!empty($identificador)) {

                $sHtmlFirma = '<br><div class="box-header with-border">
                                    <h3 class="box-title text-primary">Firma actual abonado</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                                        <button type="button" class="btn btn-box-tool"
                                                onclick="ubicarMain();"><i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="centrador">
                                        <div class="row">
                                            <div class="col-md-12">
                                                ' . $identificador . '
                                            </div>
                                        </div>
                                    </div>
                                </div>';
                $oReturn->assign('firma_cliente', 'innerHTML', $sHtmlFirma);
            }

            if ($tipoContrato == "POSTPAGO") {
                $op_tip_contrato_cobro = 2;
            } else {
                $op_tip_contrato_cobro = 1;
            }

            if ($cobro_directo == 'S') {
                $oReturn->assign('tipoCobroContrato', 'checked', true);
            } else {
                $oReturn->assign('tipoCobroContrato', 'checked', false);
            }

            if ($cheque_sn == 'S') {
                $oReturn->assign('aceptaCheque', 'checked', true);
            } else {
                $oReturn->assign('aceptaCheque', 'checked', false);
            }

            if ($email_factura == 'S') {
                $oReturn->assign('email_factura', 'checked', true);
            } else {
                $oReturn->assign('email_factura', 'checked', false);
            }

            $div_id_contrato = '<label class="control-label" for="codigoContrato">ID: <span> ' . $id . '</span></label>';

            $oReturn->assign('divIdContrato', 'innerHTML', $div_id_contrato);
            $oReturn->assign('divFotoContrato', 'innerHTML', $sHtmlFoto);
            if ($id_clpv) {
                $oReturn->script('reporteTelefonoCliente();');
                $oReturn->script('reporteEmailCliente();');
                $oReturn->script('reporteDireCliente();');
                $oReturn->script('reporteEquipos();');
                $oReturn->script('reporteMedioPago();');
                $oReturn->script('reporteReferencias();');
                $oReturn->script('consultarAdjuntos();');
            } else {
                $oReturn->script("Swal.fire({
                                    type: 'error',
                                    title: 'Oops...',
                                    text: 'Contrato no cuenta con id_clpv'
                                })");
            }
            $oReturn->script('location.hash="#divFormularioContrato"');
            $oReturn->script("$('#opFiltro').val(1)");
            $oReturn->script('abrirFiltrosBuscar();');
            $oReturn->script('editarDireccion(' . $id . ')');


            //rutas
            $sql = "SELECT id_ruta, ruta, latitud, longitud from isp.contrato_clpv WHERE id = $id";
            if ($oCon->Query($sql)) {
                if ($oCon->NumFilas() > 0) {
                    $id_ruta = $oCon->f('id_ruta');
                    $ruta = $oCon->f('ruta');
                    $latitud1 = $oCon->f('latitud');
                    $longitud1 = $oCon->f('longitud');
                }
            }
            $oCon->Free();

            if (empty($latitud1)) {
                $sql = "SELECT latitud, longitud from isp.int_contrato_caja WHERE id_contrato = $id AND latitud not in ('')";
                if ($oCon->Query($sql)) {
                    if ($oCon->NumFilas() > 0) {
                        $latitud1 = $oCon->f('latitud');
                        $longitud1 = $oCon->f('longitud');
                    }
                }
                $oCon->Free();
            }

            //datos factura
            $sql = "SELECT id, tipo_iden, ruc_clpv, nombre, telefono, direccion, email
                    FROM isp.contrato_datos_factura 
                    WHERE id_contrato = $id";
            if ($oCon->Query($sql)) {
                if ($oCon->NumFilas() > 0) {
                    $f_id = $oCon->f('id');
                    $f_tipo_iden = $oCon->f('tipo_iden');
                    $f_ruc_clpv = $oCon->f('ruc_clpv');
                    $f_nombre = $oCon->f('nombre');
                    $f_telefono = $oCon->f('telefono');
                    $f_direccion = $oCon->f('direccion');
                    $f_email = $oCon->f('email');
                }
            }
            $oCon->Free();

            $oReturn->assign('fac_id', 'value', $f_id);
            $oReturn->assign('fac_ruc_cli', 'value', $f_ruc_clpv);
            $oReturn->assign('fac_nombres', 'value', $f_nombre);
            $oReturn->assign('fac_dire', 'value', $f_direccion);
            $oReturn->assign('fac_telefono', 'value', $f_telefono);
            $oReturn->assign('fac_email', 'value', $f_email);

            $classContratos->registraHistorialBusqueda(1, $codigo, $abonado, $nom_clpv, $sobrenombre, $userWeb);

            $oReturn->script('finalizar(\'' . $aprobar_automatico . '\')');

            $oReturn->script('initMap(\'' . $latitud1 . '\',\'' . $longitud1 . '\')');

            $oReturn->script("$('#tipo_contrato').val($op_tip_contrato_cobro)");

            $oReturn->script('validar_campos(1)');
        }
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cabeceraContrato($aForm = '', $id = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $id_clpv = $aForm['codigoCliente'];
    $fechaHoy = date("Y-m-d");

    try {

        $classContratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $id_clpv, $id);
        $arrayContrato = $classContratos->consultarContrato();
        $valorDeuda = $classContratos->consultaMontoMesAdeuda();

        if (count($arrayContrato) > 0) {
            foreach ($arrayContrato as $val) {
                $codigo = $val[5];
                $fecha_contrato = $val[8];
                $fecha_firma = $val[9];
                $fecha_corte = $val[10];
                $fecha_cobro = $val[11];
                $duracion = $val[12];
                $penalidad = $val[13];
                $estado = $val[14];
                $tarifa = $val[18];
            }

            //estado
            $sql = "select estado, class from isp.estado_contrato where id = '$estado'";
            $estadoNombre = consulta_string_func($sql, 'estado', $oCon, '');
            $estadoClass = consulta_string_func($sql, 'class', $oCon, '');

            $sHtml .= '<table align="right" class="table table-condensed table-striped" style="margin:0px; width: 100%;">';
            $sHtml .= '<tr>';
            $sHtml .= '<td class="fecha_letra">Estado:</td>';
            $sHtml .= '<td><a href="#" style="color:' . $estadoClass . '">' . $estadoNombre . '</a></td>';
            $sHtml .= '<td class="fecha_letra">Tarifa:</td>';
            $sHtml .= '<td align="right">
						<div class="input-group">
							<div class="input-group-addon">$</div>
							<input type="text" class="form-control" value="' . number_format($tarifa, 2, '.', '') . '" style="width: 100px;" readonly/>
						</div>
					</td>';
            $sHtml .= '<td class="fecha_letra">Adeuda:</td>';
            $sHtml .= '<td align="right">
						<div class="input-group">
							<div class="input-group-addon">$</div>
							<input type="text" class="form-control" value="' . number_format($valorDeuda, 2, '.', '') . '" style="width: 100px;" readonly/>
						</div>
					</td>';
            $sHtml .= '</tr>';
            $sHtml .= '</table>';

            $oReturn->assign('divInfoContrato', 'innerHTML', $sHtml);
        }
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function generarContrato($aForm = '')
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $empresa = $_SESSION['U_EMPRESA'];
    $usuario_web = $_SESSION['U_ID'];

    $id_api = $_SESSION['id_api'];
    $estado_api = $_SESSION['estado_api'];

    //variables del formulario
    $idContrato                 = $aForm['idContrato'];
    $clpv                       = $aForm['codigoCliente'];
    $nombre                     = trim(strtoupper(($aForm['nom_clpv'])));
    $nombres                    = trim(strtoupper(($aForm['nombres'])));
    $email                      = trim(strtoupper(($aForm['email'])));
    $apellidos                  = trim(strtoupper(($aForm['apellidos'])));
    $sobrenombre                = trim(strtoupper(($aForm['apodo'])));
    $tipo                       = $aForm['identificacion'];
    $limite                     = trim($aForm['creditoContrato']);
    $sucursal                   = $aForm['clpv_cod_sucu'];
    $fechaContrato              = $aForm['fechaContrato'];
    $fechaFirma                 = $aForm['fechaFirma'];
    $fechaCorte                 = $aForm['fechaCorte'];
    $fechaCobro                 = $aForm['fechaCobro'];
    $fecha_naci                 = fecha_informix_func($aForm['fecha_naci']);
    $tipoDuracion               = 1;
    $duracionContrato           = $aForm['duracionContrato'];
    $fechaVencimiento           = $aForm['fechaVencimiento'];
    $penalidadContrato          = $aForm['penalidadContrato'];
    $ruc_cli                    = strtoupper($aForm['ruc_cli']);
    $tipoCobroContrato          = $aForm['tipoCobroContrato'];
    $vendedor                   = $aForm['vendedor'];
    $cobrador                   = $aForm['cobrador'];
    $aceptaCheque               = $aForm['aceptaCheque'];
    $detalleContrato            = trim(strtoupper(($aForm['detalleContrato'])));
    $tipo_contrato              = $aForm['tipo'];
    $codigo_automatico          = $aForm['codigo_automatico'];
    $num_digitos                = $aForm['num_digitos'];
    $num_letras                 = $aForm['num_letras'];
    $email_factura              = $aForm['email_factura'];
    $id_tipo_cobro              = 1;
    $id_ruletera                = $aForm['id_ruletera'];
    $telefono                   = $aForm['telefono'];
    $dia                        = 0;
    $estado                     = 'A';
    $pago                       = '';
    $dsctDetalle                = 0;
    $dsctGeneral                = 0;
    $fecha                      = date("m-d-Y");
    $fecha_s                      = date("Y-m-d");
    $tipo_contrato_de_cobro     = $aForm['tipo_contrato'];
    $tipo_cliente               = $aForm['condicion_cliente'];
    $codigoContrato             = $aForm['codigoContrato'];
    $selec_moneda_id            = $aForm['selec_moneda_id'];
    $tipo_servicio_contrato     = $aForm['tipo_servicio_contrato'];
    $fact_lotes                 = $aForm['fact_lotes'];

    if (!isset($tipo_servicio_contrato)) {
        $tipo_servicio_contrato = 0;
    }

    if (!isset($selec_moneda_id)) {
        $selec_moneda_id = 1;
    }

    if ($tipo_contrato_de_cobro == 1) {
        $tipo_contrato_de_cobro = "PREPAGO";
    } else {
        $tipo_contrato_de_cobro = "POSTPAGO";
    }

    $fechaServer = date("Y-m-d H:i:s");
    $tipo_factura = $aForm['tipo_factura'];
    if (empty($tipo_factura)) {
        $tipo_factura = 0;
    }

    $ruletera = 'N';
    if (!empty($id_ruletera)) {
        $ruletera = 'S';
    }

    try {

        if (empty($tipoCobroContrato)) {
            $tipoCobroContrato = 'N';
        }

        if (empty($aceptaCheque)) {
            $aceptaCheque = 'N';
        }

        if (empty($pais)) {
            $pais = 'null';
        }

        if (empty($email_factura)) {
            $email_factura = 'N';
        }

        if (empty($id_ruletera)) {
            $id_ruletera = 'null';
        }

        // commit
        $oIfx->QueryT('BEGIN;');
        $oCon->QueryT('BEGIN;');

        $sql = "select empr_cod_pais from saeempr where empr_cod_empr = $empresa";
        $pais = consulta_string_func($sql, 'empr_cod_pais', $oIfx, 0);

        if (empty($idContrato)) {

            if (empty($clpv)) {

                $sql = "select clpv_cod_clpv from saeclpv where clpv_clopv_clpv = 'CL' and clpv_ruc_clpv = '$ruc_cli' and clpv_cod_empr = $empresa";
                $clpv_cod_clpv = consulta_string_func($sql, 'clpv_cod_clpv', $oIfx, 0);

                if ($clpv_cod_clpv > 0) {
                    $clpv = $clpv_cod_clpv;
                } else {

                    //consulta campos
                    $sql = "select clpv_cod_zona, clpv_pro_pago,
                            clpv_pre_ven, vend_cod_vend, grpv_cod_grpv
                            from isp.conf_cliente_nuevo 
                            where empr_cod_empr = $empresa and
                            clpv_cod_sucu = $sucursal";
                    if ($oCon->Query($sql)) {
                        if ($oCon->NumFilas() > 0) {
                            $zona = $oCon->f('clpv_cod_zona');
                            $precio = $oCon->f('clpv_pre_ven');
                            $vend_cod_vend = $oCon->f('vend_cod_vend');
                            $grupo = $oCon->f('grpv_cod_grpv');
                            $dia = $oCon->f('clpv_pro_pago');
                        }
                    }
                    $oCon->Free();

                    if (empty($vendedor)) {
                        $vendedor = $vend_cod_vend;
                    }

                    //selecciona nombre del vendedor
                    $sql_vend = "select vend_nom_vend from saevend where vend_cod_vend = '$vendedor'";
                    $vend_nom_vend = consulta_string($sql_vend, 'vend_nom_vend', $oIfx, '');

                    // cuenta cliente
                    $sql = "SELECT GRPV_CTA_GRPV from saeGRPV WHERE
                            GRPV_COD_EMPR = $empresa AND
                            GRPV_COD_MODU = 3 AND
                            GRPV_COD_GRPV = '$grupo' ";
                    $cuenta = consulta_string($sql, 'grpv_cta_grpv', $oIfx, '');
                    //echo $sql;exit;
                    $secuencialClpv = cargarSecuencial($grupo);
                    //$precio = 1;
                    // cliente nuevo


                    //control  de caracteres
                    $nombres = htmlentities($nombres);
                    $nombres = preg_replace('/\&(.)[^;]*;/', '\\1', $nombres);

                    $nombre = htmlentities($nombre);
                    $nombre = preg_replace('/\&(.)[^;]*;/', '\\1', $nombre);

                    $apellidos = htmlentities($apellidos);
                    $apellidos = preg_replace('/\&(.)[^;]*;/', '\\1', $apellidos);

                    //VALIDACION POR POSTGRESS
                    if (strlen($limite) == 0) {
                        $limite = 0;
                    }

                    if (strlen($pago) == 0) {
                        $pago = 0;
                    }
                    $sql = "INSERT into saeclpv (clpv_cod_sucu, clpv_cod_empr, clpv_cod_cuen,
                            clpv_cod_zona, clpv_cod_vend, clv_con_clpv,  
                            clpv_cod_char, clpv_clopv_clpv, clpv_nom_clpv, 
                            clpv_ruc_clpv, clpv_ved_clpv, clpv_est_clpv, 
                            clpv_fec_des,  clpv_fec_has,  clpv_fec_reno,
                            clpv_nom_come, clpv_cal_clpv, clpv_est_mon,  
                            clpv_lim_cred, clpv_pro_pago, clpv_pre_ven,  
                            grpv_cod_grpv, clpv_dsc_clpv, clpv_dsc_prpg,
                            clpv_cod_fpag, clpv_cod_cobr,  clpv_ret_clpv,
                            clpv_cobr_dire, clpv_fec_naci,  clpv_cod_sexo,
                            clpv_est_civi)
                            VALUES  ($sucursal,     $empresa,     '$cuenta',
                            $zona,        '$vendedor',    '$tipo',       
                            '$secuencialClpv',         'CL',           '$nombre', 
                            '$ruc_cli',         '$vend_nom_vend', '$estado',
                            NOW(),       NOW(),       NOW(),
                            '$nombre', 'A',            'N',           
                            '$limite',      $dia,           $precio ,       
                            '$grupo',       '$dsctGeneral', '$dsctDetalle',
                            '$pago',        '$cobrador',    '$aplicaRet',
                            '$cobroDirecto', '$fecha_naci', '$sexo',
                            '$estado_civil')";
                    //$oReturn->alert($sql);
                    $oIfx->QueryT($sql);

                    // serial de cliente
                    $sql_1 = "select clpv_cod_clpv from saeclpv where
                                        clpv_cod_empr = $empresa and
                                        clpv_ruc_clpv = '$ruc_cli' and
                                        clpv_clopv_clpv = 'CL' and
                                        clv_con_clpv = '$tipo'";
                    $clpv = consulta_string($sql_1, 'clpv_cod_clpv', $oIfx, 0);
                }
            }


            //echo $clpv ;
            //exit;
            $ctrlCodigo = true;

            /**
             * CONSULTAR PARAMETROS
             */
            $classParametros = new int_parametros($oCon, $empresa, $sucursal);
            $arrayParametros = $classParametros->consultarParametros();
            $objectParametros = (object)$arrayParametros;

            $codigo_automatico = $objectParametros->codigo_automatico;
            $num_digitos = $objectParametros->num_digitos;
            $num_letras = $objectParametros->num_letras;
            $codigo_actual = $objectParametros->codigo_actual;
            $abonado_actual = $objectParametros->abonado_actual;
            $dia_corte = $objectParametros->dia_corte;
            $dia_cobro = $objectParametros->dia_cobro;
            $estado = $objectParametros->estado_aprueba;

            $sql = "SELECT num_digitos, aprobar_automatico from isp.int_parametros WHERE id_empresa = $empresa AND id_sucursal = $sucursal";
            $aprobar_automatico = consulta_string_func($sql, 'aprobar_automatico', $oCon, 0);

            $sql = "SELECT codigo_abonado_sn, codigo_num_dig, codigo_actual as codigo_actual_general from isp.int_parametros_general WHERE id_empresa = $empresa";
            $codigo_abonado_sn      = consulta_string_func($sql, 'codigo_abonado_sn', $oCon, 0);
            $codigo_num_dig         = consulta_string_func($sql, 'codigo_num_dig', $oCon, 0);
            $codigo_actual_general  = consulta_string_func($sql, 'codigo_actual_general', $oCon, 0);

            if ($codigo_abonado_sn == 'S') {

                $codigo_actual = $codigo_actual_general + 1;
                $abonado_actual = $codigo_actual_general + 1;
                $codigoContrato = str_pad($codigo_actual, $codigo_num_dig, '0', STR_PAD_LEFT);
                $abonadoContrato = str_pad($codigo_actual, $codigo_num_dig, '0', STR_PAD_LEFT);

                $sql = "UPDATE isp.int_parametros_general set codigo_actual = $codigo_actual
                        where id_empresa = $empresa";
                $oCon->QueryT($sql);

                $ctrlCodigo = true;
            } else {
                if ($codigo_automatico == 'S') {
                    $codigo_actual = $codigo_actual + 1;
                    $abonado_actual = $abonado_actual + 1;
                    $codigoContrato = secuencial_pedido(2, '0', $codigo_actual, $num_digitos);
                    $abonadoContrato = secuencial_pedido(2, '0', $abonado_actual, $num_digitos);

                    $sql = "UPDATE isp.int_parametros set codigo_actual = $codigoContrato,
                            abonado_actual = $abonadoContrato
                            where id_empresa = $empresa and
                            id_sucursal = $sucursal";
                    $oCon->QueryT($sql);

                    $ctrlCodigo = true;
                } else {
                    $codigoContrato = trim($aForm['codigoContrato']);
                    $abonadoContrato = trim($aForm['codigoContrato']);

                    if (empty($codigoContrato)) {
                        $ctrlCodigo = false;
                    }
                }
            }


            if ($ctrlCodigo == true) {

                //$codigoContratoOk = trim($num_letras . '' . $codigoContrato);
                if ($codigo_abonado_sn == 'S') {
                    $codigoContratoOk = $codigoContrato;
                } else {
                    $codigoContratoOk = algoritmoCodigo($codigoContrato, $num_digitos, $num_letras);
                }


                //VALIDACION PARA POSTGRESS
                if (strlen($creditoContrato) == 0) {
                    $creditoContrato = 0;
                }
                $sql = "INSERT into isp.contrato_clpv(id_empresa, id_sucursal, id_clpv, fecha_contrato, fecha_firma,
                                                        fecha_corte, fecha_cobro, observaciones, sobrenombre, tipo_contrato,
                                                        duracion, penalidad, estado, user_web, fecha_server,
                                                        nom_clpv, ruc_clpv, codigo, cobro_directo, 
                                                        cheque_sn, vendedor, cobrador, limite,
                                                        nombre,email,telefono,apellido, abonado, tipo_duracion, fecha_c_vence, id_pais,
                                                        email_factura, tipo_factura, ruletera, id_tipo_cobro, id_ruletera, tipo_contrato_de_cobro, 
                                                        tipo_cliente, id_tipo_cont_serv, moneda_id, facturable_lotes_sn)
                                        values($empresa, $sucursal,$clpv, '$fechaContrato', '$fechaFirma',
                                                        '$fechaCorte', '$fechaCobro', '$detalleContrato', '$sobrenombre', '$tipo_contrato',
                                                        $duracionContrato, $penalidadContrato,  '$estado', $usuario_web, '$fechaServer',
                                                        '$nombre', '$ruc_cli', '$codigoContratoOk', '$tipoCobroContrato',
                                                        '$aceptaCheque', '$vendedor', '$cobrador', '$creditoContrato',
                                                        '$nombres','$email','$telefono', '$apellidos', '$abonadoContrato', $tipoDuracion, '$fechaVencimiento', $pais,
                                                        '$email_factura' , '$tipo_factura', '$ruletera', $id_tipo_cobro, $id_ruletera, '$tipo_contrato_de_cobro', 
                                                        $tipo_cliente, $tipo_servicio_contrato, $selec_moneda_id, '$fact_lotes')";
                $oCon->QueryT($sql);

                //id contrato
                $sql = "SELECT max(id) as id
                        from isp.contrato_clpv 
                        where id_empresa = $empresa and
                        id_sucursal = $sucursal and
                        id_clpv = $clpv and
                        fecha_contrato = '$fechaContrato'";
                $idContrato = consulta_string_func($sql, 'id', $oCon, 0);

                if ($id_api == 5 && $estado_api == 'A') {
                    $sql = "SELECT webservice_token FROM isp.int_datos_webservice";
                    $webservice_token = consulta_string_func($sql, 'webservice_token', $oCon, 0);

                    $Webservice = new Webservice($oCon);
                    $parametros = $Webservice->parametrosWS();

                    $datosEnvio = array(
                        "token" => $webservice_token,
                        "nombre" => $nombre,
                        "cedula" => $ruc_cli,
                        "correo" => $email,
                        "telefono" => $telefono,
                        "movil" => $telefono
                    );

                    $tipo_comando   = "CREAR_CLIENTE";
                    $tipo_sistema   = 1;
                    $envio_get      = "";
                    $envio_post     = $datosEnvio;
                    array_push($parametros, $id_api, $tipo_comando, $tipo_sistema);

                    $respuesta_creacion  = $Webservice->enviaComando($parametros, $envio_get, $envio_post);

                    if ($respuesta_creacion["estado"] == 'exito') {
                        $id_cliente_mk = $respuesta_creacion["idcliente"];

                        $sql = "UPDATE isp.contrato_clpv SET id_cliente_mk = $id_cliente_mk WHERE id = $idContrato";
                        $oCon->QueryT($sql);
                    }
                }

                $Contratos = new Contratos($oCon, $oIfx, $empresa, $sucursal, $clpv, $idContrato);
                $Contratos->registraAuditoriaContratos(1, $usuario_web, '');

                $oReturn->assign('codigoContrato', 'value', $codigoContratoOk);
                $oReturn->assign('codigoCliente', 'value', $clpv);

                $oReturn->script("Swal.fire({
                                    type: 'success',
                                    title: 'Contrato Generado Exitosamente, Codigo: $codigoContratoOk Pendiente de Aprobacion...!',
                                })");

                $oReturn->script('finalizar1(\'' . $aprobar_automatico . '\', ' . $idContrato . ')');
                $oReturn->script("jsRemoveWindowLoad()");
            } else {
                $oReturn->script("Swal.fire({
                                    type: 'error',
                                    title: 'Oops...',
                                    text: 'Ingrese Codigo de Contrato para continuar..!'
                                })");
            }
        } else {

            //query id clpv en caso de no existir
            if (empty($clpv)) {
                $sql = "SELECT id_clpv from isp.contrato_clpv WHERE id = $idContrato";
                $clpv = consulta_string($sql, 'id_clpv', $oCon, 0);
            }

            if (empty($limite)) {
                $limite = 0;
            }
            $sql = "UPDATE isp.contrato_clpv set 
                                        codigo = '$codigoContrato',
                                        ruc_clpv = '$ruc_cli',
                                        nombre = '$nombres', 
                                        email = '$email', 
                                        telefono = '$telefono', 
                                        apellido = '$apellidos',
                                        nom_clpv = '$nombre',
                                        fecha_contrato = '$fechaContrato',
                                        fecha_firma = '$fechaFirma',
                                        fecha_corte = '$fechaCorte',
                                        fecha_cobro = '$fechaCobro',
                                        duracion = '$duracionContrato',
                                        penalidad = '$penalidadContrato',
                                        cobro_directo = '$tipoCobroContrato',
                                        detalle = '$detalleContrato',
                                        sobrenombre = '$sobrenombre',
                                        limite = '$limite',
                                        cobrador = '$cobrador',
                                        vendedor = '$vendedor',
                                        cheque_sn = '$aceptaCheque',
                                        tipo_contrato = '$tipo_contrato',
                                        observaciones = '$detalleContrato',
                                        tipo_duracion = $tipoDuracion, 
                                        fecha_c_vence = '$fechaVencimiento',
                                        id_pais = $pais,
                                        email_factura = '$email_factura'  ,
                                        tipo_factura = '$tipo_factura',
                                        ruletera      = '$ruletera',
                                        id_tipo_cobro = $id_tipo_cobro,
                                        id_ruletera = $id_ruletera,
                                        tipo_contrato_de_cobro = '$tipo_contrato_de_cobro',
                                        tipo_cliente = $tipo_cliente,
                                        id_tipo_cont_serv = $tipo_servicio_contrato,
                                        moneda_id = $selec_moneda_id,
                                        facturable_lotes_sn = '$fact_lotes'
                                        where id_empresa = $empresa and
                                        id_clpv = $clpv and
                                        id = $idContrato";
            $oCon->QueryT($sql);

            if ($id_api == 5 && $estado_api == 'A') {
                $sql = "SELECT id_cliente_mk FROM isp.contrato_clpv WHERE id = $idContrato AND id_clpv = $clpv";
                $id_cliente_mk = consulta_string_func($sql, 'id_cliente_mk', $oCon, 0);

                $sql = "SELECT webservice_token FROM isp.int_datos_webservice";
                $webservice_token = consulta_string_func($sql, 'webservice_token', $oCon, 0);

                $Webservice = new Webservice($oCon);
                $parametros = $Webservice->parametrosWS();

                $datosEnvio = array(
                    "token" => $webservice_token,
                    "idcliente" => intval($id_cliente_mk),
                    "datos" => [
                        "nombre" => $nombre,
                        "correo" => $email,
                        "telefono" => $telefono,
                        "movil" => $telefono,
                        "cedula" => $ruc_cli
                    ]

                );

                $tipo_comando   = "ACTUALIZAR_CLIENTE";
                $tipo_sistema   = 1;
                $envio_get      = "";
                $envio_post     = $datosEnvio;
                array_push($parametros, $id_api, $tipo_comando, $tipo_sistema);

                $respuesta_update  = $Webservice->enviaComando($parametros, $envio_get, $envio_post);
            }

            //VALIDACION POSTGRESS 
            if (strlen($creditoContrato) == 0) {
                $creditoContrato = 0;
            }
            //selecciona nombre del vendedor
            $sql_vend = "select vend_nom_vend from saevend where vend_cod_vend = '$vendedor'";
            $vend_nom_vend = consulta_string($sql_vend, 'vend_nom_vend', $oIfx, '');

            $sqlClpv = "update saeclpv set clpv_nom_clpv = '$nombre', 
                                            clpv_nom_come = '$nombre',
                                            clpv_fec_modi = '$fecha_s', 
                                            clpv_ruc_clpv = '$ruc_cli',
                                            clv_con_clpv = '$tipo'";

            if (!empty($precio)) {
                $sqlClpv .= ", clpv_pre_ven = '$precio'";
            }

            if (!empty($vendedor)) {
                $sqlClpv .= ", clpv_cod_vend = '$vendedor',
                                clpv_ved_clpv = '$vend_nom_vend'";
            }

            $sqlClpv .= ", clpv_lim_cred = '$creditoContrato',
                        clpv_fec_naci = '$fecha_naci'
                        where clpv_cod_empr = $empresa and
                        clpv_cod_clpv = $clpv";
            $oIfx->QueryT($sqlClpv);

            /*$ sqlClpv = "update saeclpv set clv_con_clpv = '$tipo'";

            if (!empty($precio)) {
                $sqlClpv .= ", clpv_pre_ven = '$precio'";
            }

            if (!empty($vendedor)) {
                $sqlClpv .= ", clpv_cod_vend = '$vendedor',
                                clpv_ved_clpv = '$vend_nom_vend'";
            }

            $sqlClpv .= ", clpv_lim_cred = '$creditoContrato',
                        clpv_fec_naci = '$fecha_naci'
                        where clpv_cod_empr = $empresa and
                        clpv_cod_clpv = $clpv";
            $oIfx->QueryT($sqlClpv); */

            $Contratos = new Contratos($oCon, $oIfx, $empresa, $sucursal, $clpv, $idContrato);
            $Contratos->registraAuditoriaContratos(2, $usuario_web, '');

            $oReturn->script("Swal.fire({
                                position: 'center',
                                type: 'success',
                                title: 'Modificado Exitosamente...!',
                                showConfirmButton: false,
                                timer: 1500
                            })");

            $oReturn->script('finalizar(\'' . $aprobar_automatico . '\')');
            $oReturn->script("jsRemoveWindowLoad()");
        }

        $oIfx->QueryT('COMMIT WORK;');
        $oCon->QueryT('COMMIT;');

        //fotos
        if (!empty($foto)) {
            $sHtmlFoto = '<img src="' . path(DIR_ARCHIVOS) . '/' . $foto . '" style="width: 100px; height: 100px;">';
            $oReturn->assign('divFotoContrato', 'innerHTML', $sHtmlFoto);
        }

        $sql = "SELECT codigo, id_tipo_cont_serv from isp.contrato_clpv where id = $idContrato";
        $codigo_contrato_  = consulta_string($sql, 'codigo', $oCon, '');
        $id_tipo_cont_serv  = consulta_string($sql, 'id_tipo_cont_serv', $oCon, '');

        $sql = "SELECT codigo_servicio_sn from isp.int_parametros_general where id_empresa = $empresa";
        $oCon->Query($sql);
        $codigo_servicio_sn = $oCon->f('codigo_servicio_sn');
        $oCon->Free();

        if ($codigo_servicio_sn == 'S' && !empty($id_tipo_cont_serv)) {
            //REMPLAZADO EL 12/10/2023 A PEDIDO DE GLOBAL
            /*  $sql = "SELECT codigo from isp.int_tipo_servicio where id = $id_tipo_cont_serv";
                $codigo_cid_1       = consulta_string($sql, 'codigo', $oCon, '');

                $codigo_cid_fn      = $codigo_cid_1 . $codigo;

                $lbl_cid = '<label class="control-label" for="codigoContrato">Código de pago:  <span> ' . $codigo_cid_fn . ' </span></label>';
                */

            $sql = "SELECT a.id_contrato, string_agg(a.codigo_cid , '<br>') as datos_2
                    FROM isp.int_contrato_caja_pack a 
                    WHERE a.estado IN ('A', 'P', 'C', 'I') AND a.activo IN ('S') GROUP BY 1";
            unset($array_cid);
            $array_cid = array_dato($oCon, $sql, 'id_contrato', 'datos_2');

            $codigo_cid_fn = $array_cid[$idContrato];

            $lbl_cid = '<label class="control-label" for="codigoContrato">Código de pago:  <br> <span> ' . $codigo_cid_fn . ' </span></label>';
            $oReturn->assign('codigoCID', 'innerHTML', $lbl_cid);
        }

        $div_id_contrato = '<label class="control-label" for="codigoContrato">ID: <span> ' . $idContrato . '</span></label>';

        $oReturn->assign('idContrato', 'value', $idContrato);
        $oReturn->assign('divIdContrato', 'innerHTML', $div_id_contrato);
    } catch (Exception $e) {
        // rollback
        $oIfx->QueryT('ROLLBACK WORK;');
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}


function resumenEquipoPaquetes($aForm, $array_servicios, $id_contrato)
{
    session_start();

    global $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $array_servicios = json_decode($array_servicios, true);

    $politica_bqn = $aForm['politica_bqn'];

    //PLANES
    $sql = "SELECT id, paquete, id_tipo_prod FROM isp.int_paquetes";
    $array_paquetes = array_dato($oCon, $sql, 'id', 'paquete');
    $array_tipo_prod = array_dato($oCon, $sql, 'id', 'id_tipo_prod');

    //tipo contrato
    $sql = "SELECT tipo_contrato, estado from isp.contrato_clpv WHERE id = $id_contrato";
    $tipo_contrato = consulta_string_func($sql, 'tipo_contrato', $oCon, 0);

    //servicios de cada tipo
    $sql = "SELECT servicios from isp.int_tipo_contrato WHERE id = $tipo_contrato";
    $servicios_tipo = consulta_string_func($sql, 'servicios', $oCon, 0);

    //nombre tipo prod
    $sql = "SELECT id, nombre from isp.int_tipo_prod ";
    $array_nombre_tp = array_dato($oCon, $sql, 'id', 'nombre');

    $data_tipo_servicio = explode(",", $servicios_tipo);

    $total_suscripcion = 0;
    for ($i = 0; $i < count($data_tipo_servicio); $i++) {
        $id_tipo = $data_tipo_servicio[$i];

        $txt_tipo = "equipoCantidad" . $id_tipo;
        $equipoCantidad = $aForm[$txt_tipo];

        $txt_total = "equipoTotal" . $id_tipo;
        $equipoSuscripcion = $aForm[$txt_total];

        $total_suscripcion = $total_suscripcion + $equipoSuscripcion;
    }

    for ($i = 0; $i < count($array_servicios); $i++) {
        $id_prod = $array_servicios[$i];
        $id_tipo_prod = $array_tipo_prod[$id_prod];
        $txt_cant_eq = "equipoCantidad" . $id_tipo_prod;
        $cantidad = $aForm[$txt_cant_eq];

        $txt_precio = "precio_" . $id_prod;
        $precio = $aForm[$txt_precio];

        $precio = $cantidad * $precio;
        $total_mensualidad = $total_mensualidad + $precio;
    }

    if ($politica_bqn != 0 && !empty($politica_bqn)) {
        $pol_bqn = ' <h4 class="text-danger" align="center">Política BQN: ' . $politica_bqn . '</h4>';
    }

    $sHtml = '<div class="modal-dialog modal-lg" role="document" style="width:50%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" id="myModalLabel" align="center">RESUMEN DE EQUIPOS<small></small></h5>
                    </div>
                    <div class="modal-body" style="margin-top:0xp;">
                        ' . $pol_bqn . '
                        <h3 class="text-danger" align="center">Total Suscripci&oacute;n: ' . number_format($total_suscripcion, 2, '.', ',') . '</h3>
                        <h3 class="text-danger" align="center">Total Mensualidad: ' . number_format($total_mensualidad, 2, '.', ',') . '</h3>
                        <br>
                        <table class="table table-bordered table-striped table-hover" style="width: 100%;">';
    for ($i = 0; $i < count($array_servicios); $i++) {
        $id_prod = $array_servicios[$i];
        $id_tipo_prod = $array_tipo_prod[$id_prod];
        $nombre_tipo_prod = $array_nombre_tp[$id_tipo_prod];
        $nom_prod = $array_paquetes[$id_prod];

        $txt_precio = "precio_" . $id_prod;
        $precio = $aForm[$txt_precio];

        $txt_cant_eq = "equipoCantidad" . $id_tipo_prod;
        $cantidad = $aForm[$txt_cant_eq];


        $sHtml .= '<tr>
                                    <td align="left" class="text-primary">SERVICIO ' . strtoupper($nombre_tipo_prod) . ' </td>
                                    <td align="right" class="text-primary">CANTIDAD EQUIPOS: ' . $cantidad . '</td>
                                </tr>';

        for ($j = 0; $j < $cantidad; $j++) {
            $sHtml .= '<tr>
                                    <td>' . $nom_prod . '</td>
                                    <td align="right">' . number_format($precio, 2, '.', ',') . '</td>
                                </tr>';
        }
    }

    $sHtml .= '         </table>
                    </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" onclick="agregarEquipos()">Guardar</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>';

    $sHtml_ok = $sHtml;

    $oReturn->script("$('#miModalOk').modal('show')");
    $oReturn->assign("miModalOk", "innerHTML", $sHtml_ok);

    return $oReturn;
}

function agregarEquipoPaquetes($aForm, $array_servicios)
{
    session_start();

    global $DSN_Ifx, $DSN;

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $array_servicios = json_decode($array_servicios, true);

    $politica_bqn   = $aForm['politica_bqn'];
    $gestion_bqn_sn = $_SESSION['gestion_bqn_sn'];

    //INFORMACION SERVICIO
    $sql = "SELECT id, prod_cod_prod, tipo, id_tipo_prod FROM isp.int_paquetes";
    $array_cod_prod = array_dato($oCon, $sql, 'id', 'prod_cod_prod');
    $array_tipo_pa = array_dato($oCon, $sql, 'id', 'tipo');
    $array_tipo_prod = array_dato($oCon, $sql, 'id', 'id_tipo_prod');

    //TIPO DE SERVICIO
    $sql = "SELECT id, nombre from isp.int_tipo_prod ";
    $array_nombre_tp = array_dato($oCon, $sql, 'id', 'nombre');

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];
    $idUser = $_SESSION['U_ID'];

    //VARIABLES A FORM
    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $observacionesOrdenContrato = trim(strtoupper(($aForm['observacionesOrdenContrato'])));

    if ($equipoCantidadM > 0) {
        $equipoCantidadMS = $equipoCantidadM;
        $equipoCantidadM = 1;
    }

    $totalSuscripcion = $equipoTotalP + $equipoTotalA + $equipoTotalM;

    $fecha = date("Y-m-d H:i:s");

    try {
        //CONTROL DE TAREAS
        $sql = "SELECT estado, fecha_c_vence, tipo_contrato from isp.contrato_clpv WHERE id = $idContrato";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $estado_c = $oCon->f('estado');
                $fecha_c_vence = $oCon->f('fecha_c_vence');
                $tipo_contrato = $oCon->f('tipo_contrato');
            }
        }
        $oCon->Free();

        if ($estado_c != 'PE' && $estado_c != 'PA' && $estado_c != 'CA') {
            $Tareas = new Tareas($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato, null, null, null);
            //INGRESA TAREA
            $id_proceso = 17; //INSTALACION DE UN NUEVO SERCIVIO
            $observaciones = 'INSTALACION DE NUEVO SERVICIO';
            $observaciones .= PHP_EOL . $observacionesOrdenContrato;
            $idTarea = $Tareas->ingresarTarea($id_proceso, $fecha, $observaciones, '', '', '', $idUser, '', '', '');
        }
        $Equipos = new Equipos($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato, null);

        $oCon->QueryT('BEGIN;');

        //INGRESA INT_CONTRATO_CAJA - INT_CONTRATO_CAJA_PACK
        for ($i = 0; $i < count($array_servicios); $i++) {
            $id_prod = $array_servicios[$i];
            $tipo_pa = $array_tipo_pa[$id_prod];
            $tipo_prod = $array_tipo_prod[$id_prod];
            $cod_prod = $array_cod_prod[$id_prod];

            $txt_precio = "precio_" . $id_prod;
            $precio = $aForm[$txt_precio];

            $txt_cant_eq = "equipoCantidad" . $tipo_prod;
            $cantidad = $aForm[$txt_cant_eq];

            $arrayOk = [];

            for ($j = 0; $j < $cantidad; $j++) {

                $array_e = array(
                    null, null, null, null, null, '', null, null, null, 'P',
                    $idUser, $fecha, $fecha_c_vence, null, $tipo_prod, $tipo_pa, null, null,
                    null, null, null, null, null, null, null, null
                );

                if ($i > 0 && $tipo_contrato == 7 || $tipo_contrato == 12) {
                    $id_tipo_prod_valida = $array_e[14];

                    if ($id_tipo_prod_valida == 8 || $id_tipo_prod_valida == 2) {
                        $id = $Equipos->registraCajaContrato($array_e);
                    } else {
                        $sql = "SELECT MAX(id) as id_caja_i from isp.int_contrato_caja WHERE id_contrato = $idContrato AND id_tipo_prod = 2";
                        if ($oCon->Query($sql)) {
                            if ($oCon->NumFilas() > 0) {
                                $id_caja = $oCon->f('id_caja_i');
                            }
                        }
                        $oCon->Free();

                        $id = $id_caja;
                    }
                } else {
                    $id = $Equipos->registraCajaContrato($array_e);
                }

                $arrayOk[] = array($cod_prod, $precio, 'P');

                if ($id > 0) {
                    $Equipos->registraCajaContratoPaquetes($id, $arrayOk, $idUser);
                    if ($estado_c != 'PA') {
                        if ($idTarea > 0) {
                            $Tareas->ingresarServiciosTarea('', $id);
                        }
                    }

                    if ($gestion_bqn_sn == 'S') {
                        $sql = "UPDATE isp.int_contrato_caja SET politica_bqn = '$politica_bqn' WHERE id = $id";
                        $oCon->QueryT($sql);
                    }
                }
            }
        }

        //INGRESO DE INFORMACION EN LA SAECLSE
        $Equipos->registraServiciosContratos();
        //ACTUALIZA EL NUMERO DE EQUIPOS EN LA CONTRATO_CLPV
        $Equipos->actualizaCajaContrato();
        //DATOS DE LA SUSCRIPCION DEL CONTRATO
        for ($i = 0; $i < count($array_servicios); $i++) {
            $id_prod = $array_servicios[$i];
            $tipo_pa = $array_tipo_pa[$id_prod];
            $tipo_prod = $array_tipo_prod[$id_prod];
            $cod_prod = $array_cod_prod[$id_prod];
            $nombre_tipo_prod = $array_nombre_tp[$tipo_prod];

            $txt_precio = "equipoPrecio" . $tipo_prod;
            $precio = $aForm[$txt_precio];

            $txt_cant_eq = "equipoCantidad" . $tipo_prod;
            $cantidad = $aForm[$txt_cant_eq];

            $total = $precio * $cantidad;

            if ($estado_c != "PE" && $estado_c != "PA") {
                $cero = 0;
                //INSERTA LA TABLA DE PAGOS EN CASO DE NECESITAR UN NUEVO SERVICIO A UN CONTRATO YA ACTIVO O INSTALADO
                $descripcion = "CARGO POR INSTALACION DE " . $nombre_tipo_prod;

                $sql = "INSERT into isp.contrato_pago (id_contrato, id_clpv, fecha, secuencial, estado, mes, anio, tarifa, 
                                        can_add, pre_add, tot_add, valor_pago, valor_dia, valor_uso, valor_no_uso,
                                        dias, dias_uso, dias_no_uso, detalle, tipo)
                                values($idContrato, $codigoCliente, '$fecha', 0, 'PE', '$mes', '$anio', $totalSuscripcion,
                                        $cero, $cero, $cero, $cero, $cero, $cero, $cero,
                                        $cero, $cero, $cero, '$descripcion', 'A')";

                $oCon->QueryT($sql);


                $sql = "select max(id) as id from isp.contrato_pago where id_contrato = $idContrato and id_clpv = $codigoCliente and fecha = '$fecha'";
                $idCuota = consulta_string_func($sql, 'id', $oCon, 0);

                $Equipos->suscripcionContrato(0, $tipo_prod, $tipo_pa, $cantidad, $precio, $total, '');

                $Equipos->registraTablaPagoPack(null, null, $idCuota, $id_prod, $cod_prod, $fecha, $total, $cero, $cero, $cero, $cero, $cero, 'A', $detalle, 'N', 'A');
            } else {
                $Equipos->suscripcionContrato(0, $tipo_prod, $tipo_pa, $cantidad, $precio, $total, '');
            }
        }

        $sql = "SELECT num_digitos, aprobar_automatico from isp.int_parametros WHERE id_empresa = $idempresa AND id_sucursal = $idsucursal";
        $aprobar_automatico = consulta_string_func($sql, 'aprobar_automatico', $oCon, 0);

        $oCon->QueryT('COMMIT;');
        $oReturn->script('$("#miModalPaquetes").modal("hide");');
        $oReturn->script('$("#miModalOk").modal("hide");');
        $oReturn->script("Swal.fire({
                            position: 'center',
                            type: 'success',
                            title: 'Procesado Correctamente...!',
                            showConfirmButton: false,
                            timer: 1500
                        })");
        $oReturn->script('finalizar(\'' . $aprobar_automatico . '\')');
        $oReturn->script('reporteEquipos();');
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }


    return $oReturn;
}

function agregarEquipoPaquetesOld($aForm)
{
    session_start();

    global $DSN_Ifx, $DSN;

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $array_c = $_SESSION['A_CI_PAQ']; //array cajas
    $array_m = $_SESSION['A_MI_PAQ']; //array paquetes

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];
    $idUser = $_SESSION['U_ID'];

    //vaiables del formulario
    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $observacionesOrdenContrato = trim(strtoupper(($aForm['observacionesOrdenContrato'])));

    //caja principal
    $equipoCantidadP = $aForm['equipoCantidadP'];
    $equipoPrecioP = $aForm['equipoPrecioP'];
    $equipoTotalP = $aForm['equipoTotalP'];

    //caja adicional
    $equipoCantidadA = $aForm['equipoCantidadA'];
    $equipoPrecioA = $aForm['equipoPrecioA'];
    $equipoTotalA = $aForm['equipoTotalA'];

    //modem principal
    $equipoCantidadM = $aForm['equipoCantidadM'];
    $equipoPrecioM = $aForm['equipoPrecioM'];
    $equipoTotalM = $aForm['equipoTotalM'];
    $paquetesModem = $aForm['paquetesModem'];

    if ($equipoCantidadM > 0) {
        $equipoCantidadMS = $equipoCantidadM;
        $equipoCantidadM = 1;
    }

    $totalSuscripcion = $equipoTotalP + $equipoTotalA + $equipoTotalM;

    $fecha = date("Y-m-d H:i:s");

    //paquetes caja
    $valida = false;
    $valida_a = false;
    unset($arrayOk);
    unset($arrayOk_a);
    for ($j = 0; $j < count($array_c); $j++) {
        $codProd = $array_c[$j];

        $check = $aForm['check_' . $codProd];
        $precio = $aForm['precio_' . $codProd];

        $check_a = $aForm['check_a_' . $codProd];
        $precio_a = $aForm['precio_a_' . $codProd];

        if ($precio > 0 && !empty($check)) {
            $valida = true;
            $arrayOk[] = array($codProd, $precio, 'P');
        }

        if ($precio_a > 0 && !empty($check_a)) {
            $valida_a = true;
            $arrayOk_a[] = array($codProd, $precio_a, 'P');
        }
    }

    //paquetes modem
    $valida_m = false;
    unset($arrayOk_m);
    if (!empty($paquetesModem)) {
        $precio = $aForm['precio_m_' . $paquetesModem];
        if ($precio > 0) {
            $arrayOk_m[] = array($paquetesModem, $precio, 'P');

            $sql = "SELECT id from isp.int_tipo_prod WHERE id not in (1,2,4,5) AND estado = 'A'";
            $oCon->Query($sql);
            $i = 0;
            do {
                $id = $oCon->f('id');

                if (!empty($_SESSION['prod_cod_prod_' . $id . '']) && !empty($_SESSION['precio_' . $id . ''])) {
                    $codigo_planes_int = $_SESSION['prod_cod_prod_' . $id . ''];
                    $precio_planes_int = $_SESSION['precio_' . $id . ''];

                    $arrayOk_m[] = array($codigo_planes_int, $precio_planes_int, 'P');

                    unset($_SESSION['prod_cod_prod_' . $id . '']);
                    unset($_SESSION['precio_' . $id . '']);
                }
            } while ($oCon->SiguienteRegistro());
            $oCon->Free();

            $valida_m = true;
            if (count($array_m) > 0) {
                foreach ($array_m as $val) {
                    $codProd = $val[0];

                    $check = $aForm['check_m_' . $codProd];
                    $precio = $aForm['precio_m_' . $codProd];

                    if ($precio > 0 && !empty($check)) {
                        $arrayOk_m[] = array($codProd, $precio, 'A');
                    }
                }
            }
        }
    }

    $validaC = false;
    if ($equipoCantidadP > 0) {
        if ($valida == true) {
            $validaC = true;
        } else {
            $validaC = false;
        }
    }

    $validaA = false;
    if ($equipoCantidadA > 0) {
        if ($valida_a == true) {
            $validaA = true;
        } else {
            $validaA = false;
        }
    }

    $validaM = false;
    if ($equipoCantidadM > 0) {
        if ($valida_m == true) {
            $validaM = true;
        } else {
            $validaM = false;
        }
    }

    //validacion
    if ($validaC == true || $validaA == true || $validaM == true) {

        try {

            //query control de tareas
            $sql = "SELECT estado, fecha_c_vence from isp.contrato_clpv WHERE id = $idContrato";
            if ($oCon->Query($sql)) {
                if ($oCon->NumFilas() > 0) {
                    $estado_c = $oCon->f('estado');
                    $fecha_c_vence = $oCon->f('fecha_c_vence');
                }
            }
            $oCon->Free();

            if ($estado_c != 'PE' && $estado_c != 'PA' && $estado_c != 'CA') {

                $Tareas = new Tareas($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato, null, null, null);

                //grabar tarea
                $id_proceso = 17; // proceso de instalacion de equipos
                $observaciones = 'INSTALACION DE NUEVO SERVICIO';
                $observaciones .= PHP_EOL . $observacionesOrdenContrato;
                $idTarea = $Tareas->ingresarTarea($id_proceso, $fecha, $observaciones, '', '', '', $idUser, '', '', '');
            }

            $Equipos = new Equipos($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato, null);

            $oCon->QueryT('BEGIN;');

            for ($i = 1; $i <= $equipoCantidadP; $i++) {

                $array_e = array(
                    null, null, null, null, null, '', null, null, null, 'P',
                    $idUser, $fecha, $fecha_c_vence, null, 1, 'P', null, null,
                    null, null, null, null, null, null, null, null
                );

                $id = $Equipos->registraCajaContrato($array_e);

                if ($id > 0) {
                    $Equipos->registraCajaContratoPaquetes($id, $arrayOk, $idUser);
                    if ($estado_c != 'PA') {
                        if ($idTarea > 0) {
                            $Tareas->ingresarServiciosTarea('', $id);
                        }
                    }
                }
            }

            for ($i = 1; $i <= $equipoCantidadA; $i++) {

                $array_e = array(
                    null, null, null, null, null, '', null, null, null, 'P',
                    $idUser, $fecha, $fecha_c_vence, null, 1, 'A', null, null,
                    null, null, null, null, null, null, null, null
                );

                $id = $Equipos->registraCajaContrato($array_e);

                if ($id > 0) {
                    $Equipos->registraCajaContratoPaquetes($id, $arrayOk_a, $idUser);
                    if ($estado_c != 'PA') {
                        if ($idTarea > 0) {
                            $Tareas->ingresarServiciosTarea('', $id);
                        }
                    }
                }
            }

            for ($i = 1; $i <= $equipoCantidadM; $i++) {

                $array_e = array(
                    null, null, null, null, null, '', null, null, null, 'P',
                    $idUser, $fecha, $fecha_c_vence, null, 2, 'P', null, null,
                    null, null, null, null, null, null, null, null
                );

                $id = $Equipos->registraCajaContrato($array_e);

                if ($id > 0) {
                    $Equipos->registraCajaContratoPaquetes($id, $arrayOk_m, $idUser);
                    if ($estado_c != 'PA') {
                        if ($idTarea > 0) {
                            $Tareas->ingresarServiciosTarea('', $id);
                        }
                    }
                }
            }

            //metodo que ingresa informacion en SAECLSE
            $Equipos->registraServiciosContratos();

            //metodo que actualiza numero de cajas en cabecera de contrato
            $Equipos->actualizaCajaContrato();

            /* proceso para cargar cuota */



            //array equipo
            $array_e['C'] = 'CAJA';
            $array_e['M'] = 'MODEM';

            //array tipo
            $array_t['P'] = 'PRINCIPAL';
            $array_t['A'] = 'ADICIONAL';

            if ($equipoCantidadP > 0) {
                $id_prod = $array_i['C']['P'][0];
                $cod_prod = $array_i['C']['P'][1];
                $detalle = $array_e['C'] . ' - ' . $array_t['C'] . ' : ' . $equipoCantidadP;
                $Equipos->suscripcionContrato($idCuota, 'C', 'P', $equipoCantidadP, $equipoPrecioP, $equipoTotalP, '');
                if ($idCuota > 0) {
                    $Equipos->registraTablaPagoPack(null, null, $idCuota, $id_prod, $cod_prod, $fecha, $equipoTotalP, $cero, $cero, $cero, $cero, $cero, 'A', $detalle, 'N', 'A');
                }
            }

            if ($equipoCantidadA > 0) {
                $id_prod = $array_i['C']['A'][0];
                $cod_prod = $array_i['C']['A'][1];
                $detalle = $array_e['C'] . ' - ' . $array_t['C'] . ' : ' . $equipoCantidadA;
                $Equipos->suscripcionContrato($idCuota, 'C', 'A', $equipoCantidadA, $equipoPrecioA, $equipoTotalA, '');
                if ($idCuota > 0) {
                    $Equipos->registraTablaPagoPack(null, null, $idCuota, $id_prod, $cod_prod, $fecha, $equipoTotalA, $cero, $cero, $cero, $cero, $cero, 'A', $detalle, 'N', 'A');
                }
            }

            if ($equipoCantidadMS > 0) {
                $id_prod = $array_i['M']['P'][0];
                $cod_prod = $array_i['M']['P'][1];
                $detalle = $array_e['M'] . ' - ' . $array_t['M'] . ' : ' . $equipoCantidadMS;
                $Equipos->suscripcionContrato($idCuota, 'M', 'P', $equipoCantidadMS, $equipoPrecioM, $equipoTotalM, '');
                if ($idCuota > 0) {
                    $Equipos->registraTablaPagoPack(null, null, $idCuota, $id_prod, $cod_prod, $fecha, $equipoTotalM, $cero, $cero, $cero, $cero, $cero, 'A', $detalle, 'N', 'A');
                }
            }

            $oCon->QueryT('COMMIT;');

            $oReturn->script('$("#miModalPaquetes").modal("hide");');

            $oReturn->script("Swal.fire({
                position: 'center',
                type: 'success',
                title: 'Procesado Correctamente...!',
                showConfirmButton: false,
                timer: 1500
            })");

            $oReturn->script('reporteEquipos();');
        } catch (Exception $e) {
            $oCon->QueryT('ROLLBACK;');
            $oReturn->alert($e->getMessage());
        }
    } else {
        $oReturn->script("Swal.fire({
                        type: 'error',
                        title: 'Oops...',
                        text: 'Seleccione al menos un Plan con precio mayor a cero para continuar...!'
                    })");
    }

    return $oReturn;
}



function parametrosEquipo($aForm = '', $id, $idCliente, $idContrato)
{

    //Definiciones
    global $DSN_Ifx, $DSN;
    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    try {

        $Equipos = new Equipos($oCon, $oIfx, $idempresa, $idsucursal, $idCliente, $idContrato, $id);

        $sHtml = $Equipos->consultarParametrosEquipo(0);

        $oReturn->assign("miModal", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function calculaFechaVence($aForm = '')
{
    session_start();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $fechaContrato = $aForm['fechaContrato'];
    $duracionContrato = $aForm['duracionContrato'];
    $fechaVencimiento = $aForm['fechaVencimiento'];

    try {

        $tipoDuracion = 1;

        if ($tipoDuracion == 1) {
            $oReturn->script('$("#duracionContrato").removeAttr("readonly")');
            $oReturn->script('$("#fechaVencimiento").attr("readonly","readonly");');
            $fechaVence = date("Y-m-d", strtotime($fechaContrato . "+ $duracionContrato month"));
        } elseif ($tipoDuracion == 2) {
            $oReturn->script('$("#duracionContrato").removeAttr("readonly")');
            $oReturn->script('$("#fechaVencimiento").attr("readonly","readonly");');
            $fechaVence = date("Y-m-d", strtotime($fechaContrato . "+ $duracionContrato days"));
        } elseif ($tipoDuracion == 3) {
            $oReturn->assign('duracionContrato', 'value', 0);
            $oReturn->script('$("#duracionContrato").attr("readonly","readonly");');
            $oReturn->script('$("#fechaVencimiento").removeAttr("readonly")');
            $fechaVence = $fechaContrato;
        }

        $oReturn->assign('fechaVencimiento', 'value', $fechaVence);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }


    return $oReturn;
}

function guardarReferencia($aForm = '', $idReferencia = 0, $referenciaNombre = '', $referenciaParent = 0, $referenciaTelefono = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    $idUser = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $referenciaNombre = strtoupper(trim($referenciaNombre));
    $ref = $aForm['referenciaNombre'];
    $referenciaIden = $aForm['referenciaIden'];

    $fecha = date("Y-m-d");

    try {

        $classContratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato);

        $oCon->QueryT('BEGIN;');

        if ($idReferencia > 0) {
            $classContratos->modificaReferencia($idReferencia, $referenciaNombre, $referenciaIden, $referenciaParent, $referenciaTelefono);
        } else {
            $classContratos->registraReferencia($referenciaNombre, $referenciaIden, $referenciaParent, $referenciaTelefono, $idUser);
        }

        $oReturn->alert('Procesado Correctamente...');

        $oReturn->assign('idReferencia', 'value', 0);
        $oReturn->assign('referenciaNombre', 'value', '');
        $oReturn->assign('referenciaIden', 'value', '');
        $oReturn->assign('referenciaTelefono', 'value', '');
        $oReturn->script('$("#referenciaParent").val("").trigger("change.select2");');
        $oReturn->script('reporteReferencias();');
        $oCon->QueryT('COMMIT;');
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function reporteReferencias($aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idUser = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        $sHtml = '<table class="table table-bordered table-striped table-condensed table-hover" style="width: 95%;" align="center">';
        $sHtml .= '<tr>
					<td colspan="4"><h5>REFERENCIAS <small>Reporte Informacion</small></h5></td>
                </tr>';
        $sHtml .= '<tr>';
        $sHtml .= '<td>Nombre</td>';
        $sHtml .= '<td>Identificaci&oacute;n</td>';
        $sHtml .= '<td>Parentezco</td>';
        $sHtml .= '<td>Telefono</td>';
        $sHtml .= '<td>Editar</td>';
        $sHtml .= '</tr>';

        $sql = "select id_parentezco, nombre_parent from comercial.parentezco";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayParent);
                do {
                    $arrayParent[$oCon->f('id_parentezco')] = $oCon->f('nombre_parent');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "select id, nombre, id_parent, telefono, ruc
				from isp.contrato_referencia
				where id_empresa = $idempresa and
				id_sucursal = $idsucursal and
				id_clpv = $codigoCliente and
				id_contrato = $idContrato";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id = $oCon->f('id');
                    $nombre = $oCon->f('nombre');
                    $ruc = $oCon->f('ruc');
                    $id_parent = $oCon->f('id_parent');
                    $telefono = $oCon->f('telefono');

                    $sHtml .= '<tr>';
                    $sHtml .= '<td align="left">' . $nombre . '</td>';
                    $sHtml .= '<td align="left">' . $ruc . '</td>';
                    $sHtml .= '<td align="left">' . $arrayParent[$id_parent] . '</td>';
                    $sHtml .= '<td align="left">' . $telefono . '</td>';
                    $sHtml .= '<td align="left">
									<div class="btn btn-warning btn-sm" onclick="editarReferencia(' . $id . ', \'' . $nombre . '\', \'' . $id_parent . '\', \'' . $telefono . '\');">
										<i class="fa fa-pencil"></i>
									</div>
								</td>';
                    $sHtml .= '</tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $oReturn->assign('divReporteReferencias', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function reporteMedioPago_old($aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oConA = new Dbo;
    $oConA->DSN = $DSN;
    $oConA->Conectar();

    $oReturn = new xajaxResponse();

    $idUser = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        $sHtml .= '<table class="table table-bordered table-striped table-condensed table-hover" style="width: 95%;" align="center">';
        $sHtml .= '<tr>
                        <td colspan="7"><h5>MEDIOS DE PAGO <small>Reporte Informacion</small></h5></td>
                    </tr>';
        $sHtml .= '<tr>';
        $sHtml .= '<td>Forma Pago</td>';
        $sHtml .= '<td>Banco</td>';
        $sHtml .= '<td>Entidad</td>';
        $sHtml .= '<td>Tipo Cuenta</td>';
        $sHtml .= '<td>Numero</td>';
        $sHtml .= '<td>Estado</td>';
        $sHtml .= '<td>Editar</td>';
        $sHtml .= '</tr>';

        $sql = "select id, id_pago, id_tipo, id_banco, id_tarjeta, tarjeta, 
                cuenta, tipo_cuenta, estado, fecha
                from isp.contrato_medio_pago
                where id_empresa = $idempresa and
                id_sucursal = $idsucursal and
                id_clpv = $codigoCliente and
                id_contrato = $idContrato";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id = $oCon->f('id');
                    $id_pago = $oCon->f('id_pago');
                    $id_tipo = $oCon->f('id_tipo');
                    $id_banco = $oCon->f('id_banco');
                    $id_tarjeta = $oCon->f('id_tarjeta');
                    $tarjeta = $oCon->f('tarjeta');
                    $cuenta = $oCon->f('cuenta');
                    $tipo_cuenta = $oCon->f('tipo_cuenta');
                    $estado = $oCon->f('estado');
                    $fecha = $oCon->f('fecha');

                    $numero = '';
                    if (!empty($cuenta)) {
                        $numero = $cuenta;
                    } else {
                        $numero = $tarjeta;
                    }

                    $fpag_des_fpag = '';
                    if (!empty($id_pago)) {
                        $sql = "select fpag_des_fpag from saefpag where fpag_cod_empr = $idempresa and fpag_cod_fpag = '$id_pago'";
                        $fpag_des_fpag = consulta_string_func($sql, 'fpag_des_fpag', $oIfx, '');
                    }

                    $banco = '';
                    if (!empty($id_banco)) {
                        $sql = "select banco from isp.int_bancos where id = $id_banco";
                        $banco = consulta_string_func($sql, 'banco', $oConA, '');
                    }

                    $tipo_tarjeta = '';
                    if (!empty($id_tarjeta)) {
                        $sql = "select tipo_tarjeta from isp.int_tipo_tarjeta where id = $id_tarjeta";
                        $tipo_tarjeta = consulta_string_func($sql, 'tipo_tarjeta', $oConA, '');
                    }

                    $nom_cuenta = '';
                    if ($tipo_cuenta == 1) {
                        $nom_cuenta = 'AHORROS';
                    } elseif ($tipo_cuenta == 2) {
                        $nom_cuenta = 'CORRIENTE';
                    }

                    $sHtml .= '<tr>';
                    $sHtml .= '<td align="left">' . $fpag_des_fpag . '</td>';
                    $sHtml .= '<td align="left">' . $banco . '</td>';
                    $sHtml .= '<td align="left">' . $tipo_tarjeta . '</td>';
                    $sHtml .= '<td align="left">' . $nom_cuenta . '</td>';
                    $sHtml .= '<td align="left">' . $numero . '</td>';
                    $sHtml .= '<td align="center">' . $estado . '</td>';
                    $sHtml .= '<td align="center">
                                    <div class="btn btn-warning btn-sm" onclick="editarMedioPago(' . $id . ', \'' . $id_pago . '\', \'' . $id_banco . '\');">
                                            <i class="fa fa-pencil"></i>
                                    </div>
                                </td>';
                    $sHtml .= '</tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $oReturn->assign('divReporteMedioPago', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function reporteMedioPago($aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oIfxA = new Dbo;
    $oIfxA->DSN = $DSN_Ifx;
    $oIfxA->Conectar();

    $oIfxB = new Dbo;
    $oIfxB->DSN = $DSN_Ifx;
    $oIfxB->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oConA = new Dbo;
    $oConA->DSN = $DSN;
    $oConA->Conectar();

    $oReturn = new xajaxResponse();

    $idUser = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];


    $sql = "select clpv_est_soli from saeclpv where clpv_cod_empr = $idempresa and clpv_cod_clpv = $codigoCliente ";
    $clpv_est_soli = (consulta_string_func($sql, 'clpv_est_soli', $oIfxA, ''));


    try {

        $sHtml .= '<table class="table table-bordered table-striped table-condensed table-hover" style="width: 95%;" align="center">';
        $sHtml .= '<tr>
                        <td colspan="10"><h5>MEDIOS DE PAGO <small>Reporte Informacion</small></h5></td>
                    </tr>';
        $sHtml .= '<tr>';
        $sHtml .= '<td>Forma Pago</td>';
        $sHtml .= '<td>Banco</td>';
        $sHtml .= '<td>Entidad</td>';
        $sHtml .= '<td>Tipo Cuenta</td>';
        $sHtml .= '<td>Numero</td>';

        $sHtml .= '<td>Mes. Tarj</td>';
        $sHtml .= '<td>Año. Tarj</td>';

        $sHtml .= '<td>Estado</td>';
        $sHtml .= '<td>Editar</td>';
        $sHtml .= '</tr>';

        $sql = "select id, id_pago, id_tipo, id_banco, id_tarjeta, tarjeta, 
                cuenta, tipo_cuenta, estado, fecha,mes_traj,anio_tarj
                from isp.contrato_medio_pago
                where id_empresa = $idempresa and
                id_sucursal = $idsucursal and
                id_clpv = $codigoCliente and
                id_contrato = $idContrato";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id = $oCon->f('id');
                    $id_pago = $oCon->f('id_pago');
                    $id_tipo = $oCon->f('id_tipo');
                    $id_banco = $oCon->f('id_banco');
                    $id_tarjeta = $oCon->f('id_tarjeta');
                    $tarjeta = $oCon->f('tarjeta');
                    $cuenta = $oCon->f('cuenta');
                    $tipo_cuenta = $oCon->f('tipo_cuenta');
                    $estado = $oCon->f('estado');
                    $fecha = $oCon->f('fecha');

                    $mes_traj = $oCon->f('mes_traj');
                    $anio_tarj = $oCon->f('anio_tarj');

                    $numero = '';
                    if (!empty($cuenta)) {
                        $numero = $cuenta;
                    } else {
                        $numero = $tarjeta;
                    }

                    $fpag_des_fpag = '';
                    if (!empty($id_pago)) {
                        $sql = "select fpag_des_fpag from saefpag where fpag_cod_empr = $idempresa and fpag_cod_fpag = '$id_pago'";
                        $fpag_des_fpag = consulta_string_func($sql, 'fpag_des_fpag', $oIfx, '');
                    }

                    $banco = '';
                    if (!empty($id_banco)) {
                        $sql = "select banco from isp.int_bancos where id = $id_banco";
                        $banco = consulta_string_func($sql, 'banco', $oConA, '');
                        //$sql ="select banc_nom_banc from saebanc where banc_cod_banc=$id_banco";
                        //$banco = consulta_string_func($sql, 'banc_nom_banc', $oIfxB, '');
                    }

                    $tipo_tarjeta = '';
                    if (!empty($id_tarjeta)) {
                        $sql = "select tipo_tarjeta from isp.int_tipo_tarjeta where id = $id_tarjeta";
                        $tipo_tarjeta = consulta_string_func($sql, 'tipo_tarjeta', $oConA, '');
                    }

                    $nom_cuenta = '';
                    if ($tipo_cuenta == 1) {
                        $nom_cuenta = 'AHORROS';
                    } elseif ($tipo_cuenta == 2) {
                        $nom_cuenta = 'CORRIENTE';
                    }

                    $sHtml .= '<tr>';
                    $sHtml .= '<td align="left">' . $fpag_des_fpag . '</td>';
                    $sHtml .= '<td align="left">' . $banco . '</td>';
                    $sHtml .= '<td align="left">' . $tipo_tarjeta . '</td>';
                    $sHtml .= '<td align="left">' . $nom_cuenta . '</td>';
                    $sHtml .= '<td align="left">' . $numero . '</td>';

                    $sHtml .= '<td align="left">' . $mes_traj . '</td>';
                    $sHtml .= '<td align="left">' . $anio_tarj . '</td>';

                    $sHtml .= '<td align="center">' . $estado . '</td>';
                    $sHtml .= '<td align="center">
                                    <div class="btn btn-warning btn-sm" onclick="editarMedioPago(' . $id . ', \'' . $id_pago . '\', \'' . $id_banco . '\');">
                                            <i class="fa fa-pencil"></i>
                                    </div>
									<div class="btn btn-danger btn-sm" onclick="eliminarMedioPago(' . $id . ', \'' . $id_pago . '\', \'' . $id_banco . '\');">
								<i class="fa fa-trash"></i>
						</div>
                                </td>';
                    $sHtml .= '<td align="center">
						
					</td>';
                    $sHtml .= '</tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        if ($clpv_est_soli == 'S') {
            //echo 'aqui';
            //$oReturn->assign('pago', 'value', $id_pago);

            $optionMedioPago = '';
            $sql = "select f.fpag_cod_fpag, f.fpag_des_fpag
                from saefpag f
                where
                f.fpag_cod_empr = $idempresa and
                f.fpag_cod_sucu = $idsucursal 
				and f.fpag_cod_fpag = 147";
            if ($oIfx->Query($sql)) {
                if ($oIfx->NumFilas() > 0) {
                    do {
                        $optionMedioPago .= '<option value="' . $oIfx->f('fpag_cod_fpag') . '">' . $oIfx->f('fpag_des_fpag') . '</option>';
                    } while ($oIfx->SiguienteRegistro());
                }
            }
            $oIfx->Free();
        }

        //$oReturn->assign('pago', 'innerHTML', $optionMedioPago);
        $oReturn->assign('divReporteMedioPago', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}


function eliminarMedioPago($aForm = '', $id)
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $pago = $aForm['pago'];
    //$idMedioPago = $aForm['idMedioPago'];

    //  LECTURA SUCIA
    //

    try {

        $sql_delete = "DELETE from isp.contrato_medio_pago  where id = $id and id_empresa= $idempresa and id_sucursal= $idsucursal ";
        $oCon->QueryT($sql_delete);

        $oReturn->alert('Medio de pago eliminado...!');
        $oReturn->script('validarFormaPago(this);');
        $oReturn->script('reporteMedioPago()');
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}


function cargar_ciudad($aForm = '', $op = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();
    $idempresa = $_SESSION['U_EMPRESA'];
    $provincia = $aForm['provincia'];

    //

    $oReturn->script('limpiar_lista();');

    $sql = "select ciud_cod_ciud, ciud_nom_ciud from saeciud where
                ciud_cod_prov = $provincia order by ciud_nom_ciud";

    $i = 0;
    $msn = "-- Seleccione una Opcion --";

    if ($oIfx->Query($sql)) {
        if ($oIfx->NumFilas() > 0) {
            do {
                $id = $oIfx->f('ciud_cod_ciud');
                $ciud = $oIfx->f('ciud_nom_ciud');
                $oReturn->script(('anadir_elemento_comun(' . $i . ',\'' . $id . '\', \'' . $ciud . '\' )'));
                $i++;
            } while ($oIfx->SiguienteRegistro());
            $oReturn->script(('anadir_elemento_comun(' . $i . ',"", \'' . $msn . '\' )'));
        } else {
            $oReturn->script('limpiar_lista();');
            $oReturn->script(('anadir_elemento_comun(' . $i . ',"", \'' . $msn . '\' )'));
        }
    }
    $oIfx->Free();

    $oReturn->assign('ciudad', 'value', $op);

    return $oReturn;
}

function cargar_canton($aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();
    $idempresa = $_SESSION['U_EMPRESA'];
    $canton = $aForm['canton'];

    //  LECTURA SUCIA
    //

    $oReturn->script('limpiar_lista_canton();');

    $sql = "select parr_cod_parr, parr_des_parr from saeparr where parr_cod_cant = '$canton'";

    $i = 0;
    $msn = "-- Seleccione una Opcion --";

    if ($oIfx->Query($sql)) {
        if ($oIfx->NumFilas() > 0) {
            do {
                $id = $oIfx->f('parr_cod_parr');
                $ciud = $oIfx->f('parr_des_parr');
                $oReturn->script(('anadir_elemento_comun_canton(' . $i . ',\'' . $id . '\', \'' . $ciud . '\' )'));
                $i++;
            } while ($oIfx->SiguienteRegistro());
            $oReturn->script(('anadir_elemento_comun_canton(' . $i . ',"", \'' . $msn . '\' )'));
        } else {
            $oReturn->script('limpiar_lista_canton();');
            $oReturn->script(('anadir_elemento_comun_canton(' . $i . ',"", \'' . $msn . '\' )'));
        }
    }
    $oIfx->Free();

    return $oReturn;
}

function validarFormaPago_old($aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $pago = $aForm['pago'];
    $idMedioPago = $aForm['idMedioPago'];

    //  LECTURA SUCIA
    //

    try {

        $etiquetaBtn = 'Agregar';
        if (!empty($idMedioPago)) {
            $sql = "select id_pago, id_tipo, id_banco, id_tarjeta, tarjeta, 
                    cuenta, tipo_cuenta
                    from isp.contrato_medio_pago
                    where id = $idMedioPago";
            if ($oCon->Query($sql)) {
                if ($oCon->NumFilas() > 0) {
                    $id_pago = $oCon->f('id_pago');
                    $id_tipo = $oCon->f('id_tipo');
                    $id_banco = $oCon->f('id_banco');
                    $id_tarjeta = $oCon->f('id_tarjeta');
                    $tarjeta = $oCon->f('tarjeta');
                    $cuenta = $oCon->f('cuenta');
                    $tipo_cuenta = $oCon->f('tipo_cuenta');

                    $etiquetaBtn = 'Modificar';
                }
            }
            $oCon->Free();
        }

        //tipo de pago
        $sql = "select fpag_cot_fpag from saefpag where fpag_cod_empr = $idempresa and fpag_cod_sucu = $idsucursal and fpag_cod_fpag = '$pago'";
        $fpag_cot_fpag = consulta_string_func($sql, 'fpag_cot_fpag', $oIfx, '');

        unset($arrayVisibles);
        $arrayVisibles[0] = 'none';
        $arrayVisibles[1] = 'none';
        $arrayVisibles[2] = 'none';
        $arrayVisibles[3] = 'none';
        $arrayVisibles[4] = 'none';

        if ($fpag_cot_fpag == 'TAR') {
            $arrayVisibles[0] = 'in-line';
            $arrayVisibles[1] = 'none';
            $arrayVisibles[2] = 'none';
            $arrayVisibles[3] = 'in-line';
            $arrayVisibles[4] = 'none';
            $arrayVisibles[5] = 'in-line';
            $arrayVisibles[6] = 'in-line';
        } elseif ($fpag_cot_fpag == 'DEP') {
            $arrayVisibles[0] = 'none';
            $arrayVisibles[1] = 'in-line';
            $arrayVisibles[2] = 'in-line';
            $arrayVisibles[3] = 'none';
            $arrayVisibles[4] = 'in-line';
            $arrayVisibles[5] = 'none';
            $arrayVisibles[6] = 'none';
        }

        $fu->AgregarCampoListaSQL('pagoTipoTarjeta', 'Tipo|left', "select id, tipo_tarjeta
                                                                    from isp.int_tipo_tarjeta
                                                                    where id_empresa = $idempresa and
                                                                    id_sucursal = $idsucursal", false, 170, 150);

        $fu->AgregarCampoListaSQL('pagoBanco', 'Banco|left', "select id, banco
                                                                from isp.int_bancos
                                                                where id_empresa = $idempresa and
                                                                id_sucursal = $idsucursal", false, 170, 150);

        $fu->AgregarCampoLista('pagoTipoCuenta', 'Tipo Cuenta|left', false, 170, 150);
        $fu->AgregarOpcionCampoLista('pagoTipoCuenta', 'AHORROS', '1');
        $fu->AgregarOpcionCampoLista('pagoTipoCuenta', 'CORRIENTE', '2');

        $fu->AgregarCampoTexto('pagoTarjeta', '# Tarjeta|left', false, '', 200, 100);

        $fu->AgregarCampoTexto('pagoCuenta', '# Cuenta|left', false, '', 200, 100);

        $fu->AgregarCampoFecha('pagoFechaVence', 'Fecha Vence|left', true, date('Y') . '/' . date('m') . '/' . date('d'));

        $fu->AgregarCampoPassword('pagoClave', 'Codigo|left', false, '', 50, 9);

        $fu->cCampos["pagoTipoTarjeta"]->xValor = $id_tarjeta;
        $fu->cCampos["pagoBanco"]->xValor = $id_banco;
        $fu->cCampos["pagoTipoCuenta"]->xValor = $tipo_cuenta;
        $fu->cCampos["pagoTarjeta"]->xValor = $tarjeta;
        $fu->cCampos["pagoCuenta"]->xValor = $cuenta;

        $sHtml .= '<table class="table table-striped table-condensed" style="width: 100%;" align="center">';
        $sHtml .= '<tr>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[0] . '">' . $fu->ObjetoHtmlLBL('pagoTipoTarjeta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[0] . '">' . $fu->ObjetoHtml('pagoTipoTarjeta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[1] . '">' . $fu->ObjetoHtmlLBL('pagoBanco') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[1] . '">' . $fu->ObjetoHtml('pagoBanco') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[2] . '">' . $fu->ObjetoHtmlLBL('pagoTipoCuenta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[2] . '">' . $fu->ObjetoHtml('pagoTipoCuenta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[3] . '">' . $fu->ObjetoHtmlLBL('pagoTarjeta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[3] . '">' . $fu->ObjetoHtml('pagoTarjeta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[4] . '">' . $fu->ObjetoHtmlLBL('pagoCuenta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[4] . '">' . $fu->ObjetoHtml('pagoCuenta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[5] . '">' . $fu->ObjetoHtmlLBL('pagoFechaVence') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[5] . '">' . $fu->ObjetoHtml('pagoFechaVence') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[6] . '">' . $fu->ObjetoHtmlLBL('pagoClave') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[6] . '">' . $fu->ObjetoHtml('pagoClave') . '</td>';
        $sHtml .= '<td align="center">
                        <div class="btn btn-success btn-sm" onclick="agregarMedioPago();">
                            <span class="glyphicon glyphicon-plus-sign"></span>
                            ' . $etiquetaBtn . ' Medio Pago
                        </div>
                    </td>';
        $sHtml .= '</tr>';
        $sHtml .= '</table>';

        $oReturn->assign('divDetalleFormaPago', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function agregarMedioPago_old($aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $oReturn = new xajaxResponse();

    $idUser = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $idMedioPago = $aForm['idMedioPago'];
    $pago = $aForm['pago'];
    $pagoTipoTarjeta = $aForm['pagoTipoTarjeta'];
    $pagoBanco = $aForm['pagoBanco'];
    $pagoTipoCuenta = $aForm['pagoTipoCuenta'];
    $pagoTarjeta = $aForm['pagoTarjeta'];
    $pagoCuenta = $aForm['pagoCuenta'];
    $fecha = date("Y-m-d");
    $fechaServer = date("Y-m-d H:i:s");

    //  LECTURA SUCIA
    //

    try {

        $oCon->QueryT('BEGIN;');

        //tipo de pago
        $sql = "select fpag_cot_fpag from saefpag where fpag_cod_empr = $idempresa and fpag_cod_sucu = $idsucursal and fpag_cod_fpag = '$pago'";
        $fpag_cot_fpag = consulta_string_func($sql, 'fpag_cot_fpag', $oIfx, '');

        if (empty($idMedioPago)) {

            $sql = "insert into isp.contrato_medio_pago(id_empresa, id_sucursal, id_clpv, id_contrato,
                                    id_pago, id_tipo, id_banco, id_tarjeta, tarjeta, cuenta, tipo_cuenta, 
                                    estado, user_web, fecha, fecha_server)
                                    values($idempresa, $idsucursal, $codigoCliente, $idContrato,
                                    '$pago', '$fpag_cot_fpag', '$pagoBanco', '$pagoTipoTarjeta', '$pagoTarjeta',
                                    '$pagoCuenta', '$pagoTipoCuenta', 'A', $idUser, '$fecha', '$fechaServer')";
            $oCon->QueryT($sql);
        } else {
            $sql = "update isp.contrato_medio_pago set id_pago = '$pago', 
                                                    id_tipo = '$fpag_cot_fpag', 
                                                    id_banco = '$pagoBanco', 
                                                    id_tarjeta = '$pagoTipoTarjeta', 
                                                    tarjeta = '$pagoTarjeta', 
                                                    cuenta = '$pagoCuenta', 
                                                    tipo_cuenta = '$pagoTipoCuenta'
                                                where id = $idMedioPago";
            $oCon->QueryT($sql);
        }

        //actualiza forma de pago
        $sql = "update isp.contrato_clpv set forma_pago = '$pago'
                                where id_empresa = $idempresa and
                                id_sucursal = $idsucursal and
                                id_clpv = $codigoCliente and
                                id = $idContrato";
        $oCon->QueryT($sql);

        $oReturn->alert('Procesado Correctamente...');

        $oCon->QueryT('COMMIT;');
        $oReturn->script('reporteMedioPago()');
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}


function validarFormaPago($aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $pago = $aForm['pago'];
    $idMedioPago = $aForm['idMedioPago'];

    //  LECTURA SUCIA
    //

    try {

        $etiquetaBtn = 'Agregar';
        if (!empty($idMedioPago)) {
            $sql = "select id_pago, id_tipo, id_banco, id_tarjeta, tarjeta, 
                    cuenta, tipo_cuenta , nom_clpv, ruc_clpv,mes_traj,anio_tarj
                    from isp.contrato_medio_pago
                    where id = $idMedioPago";
            if ($oCon->Query($sql)) {
                if ($oCon->NumFilas() > 0) {
                    $id_pago = $oCon->f('id_pago');
                    $id_tipo = $oCon->f('id_tipo');
                    $id_banco = $oCon->f('id_banco');
                    $id_tarjeta = $oCon->f('id_tarjeta');
                    $tarjeta = $oCon->f('tarjeta');
                    $cuenta = $oCon->f('cuenta');
                    $tipo_cuenta = $oCon->f('tipo_cuenta');
                    $etiquetaBtn = 'Modificar';

                    $nom_clpv = $oCon->f('nom_clpv');
                    $ruc_clpv = $oCon->f('ruc_clpv');
                    $mes_traj = $oCon->f('mes_traj');
                    $anio_tarj = $oCon->f('anio_tarj');
                }
            }
            $oCon->Free();
        }

        //tipo de pago
        $sql = "select fpag_cot_fpag from saefpag where fpag_cod_empr = $idempresa and fpag_cod_sucu = $idsucursal and fpag_cod_fpag = '$pago'";
        $fpag_cot_fpag = consulta_string_func($sql, 'fpag_cot_fpag', $oIfx, '');

        unset($arrayVisibles);
        $arrayVisibles[0] = 'none';
        $arrayVisibles[1] = 'none';
        $arrayVisibles[2] = 'none';
        $arrayVisibles[3] = 'none';
        $arrayVisibles[4] = 'none';
        $arrayVisibles[7] = 'none';
        $arrayVisibles[8] = 'none';
        $arrayVisibles[5] = 'none';
        $arrayVisibles[6] = 'none';

        if ($fpag_cot_fpag == 'TAR') {
            $arrayVisibles[0] = 'in-line';
            $arrayVisibles[1] = 'in-line';
            $arrayVisibles[2] = 'none';
            $arrayVisibles[3] = 'in-line';
            $arrayVisibles[4] = 'none';
            $arrayVisibles[5] = 'in-line';
            $arrayVisibles[6] = 'in-line';
            $arrayVisibles[7] = 'in-line';
            $arrayVisibles[8] = 'in-line';
            $arrayVisibles[9] = 'in-line';
        } elseif ($fpag_cot_fpag == 'DEP') {
            $arrayVisibles[0] = 'none';
            $arrayVisibles[1] = 'in-line';
            $arrayVisibles[2] = 'in-line';
            $arrayVisibles[3] = 'none';
            $arrayVisibles[4] = 'in-line';
            $arrayVisibles[5] = 'none';
            $arrayVisibles[6] = 'none';
            $arrayVisibles[7] = 'in-line';
            $arrayVisibles[8] = 'in-line';
            $arrayVisibles[9] = 'none';
        }

        $fu->AgregarCampoListaSQL('pagoTipoTarjeta', 'Tipo|left', "select id, tipo_tarjeta
                                                                    from isp.int_tipo_tarjeta
                                                                    where id_empresa = $idempresa and
                                                                    id_sucursal = $idsucursal", false, 170, 150);

        $fu->AgregarCampoListaSQL('pagoBanco', 'Banco|left', "select id, banco
                                                                from isp.int_bancos
                                                                where id_empresa = $idempresa and
                                                                id_sucursal = $idsucursal", false, 170, 150);


        /*$ifu->AgregarCampoListaSQL('pagoBanco', 'Banco|left', "select banc_cod_banc,banc_nom_banc
                                                                from saebanc
                                                                where banc_cod_empr = $idempresa and
                                                                banc_cod_sucu = $idsucursal", false, 170, 150);*/

        $fu->AgregarCampoLista('pagoTipoCuenta', 'Tipo Cuenta|left', false, 170, 150);
        $fu->AgregarOpcionCampoLista('pagoTipoCuenta', 'AHORROS', '1');
        $fu->AgregarOpcionCampoLista('pagoTipoCuenta', 'CORRIENTE', '2');

        $fu->AgregarCampoTexto('pagoTarjeta', '# Tarjeta|left', false, '', 200, 100);

        $fu->AgregarCampoTexto('pagoCuenta', '# Cuenta|left', false, '', 200, 100);

        $fu->AgregarCampoFecha('pagoFechaVence', 'Fecha Vence|left', true, date('Y') . '/' . date('m') . '/' . date('d'));

        $fu->AgregarCampoPassword('pagoClave', 'CCV|left', false, '', 50, 9);

        //for ($i = 1; $i <= 10; $i++) {
        //$hoy = date("m");


        if (empty($mes_traj) || empty($anio_tarj)) {
            //            $year = date("Y");
            //
            //            $hoy = date("d-m-Y");
            //            //sumo 1 mes
            //            $hoy = date("d-m-Y", strtotime($hoy . "+ 1 month"));
            //
            //            $hoy = substr($hoy, 3, 2);
        } else {
            $hoy = $mes_traj;
            $year = $anio_tarj;
        }

        $fu->AgregarCampoListaSQL('dia_co', 'Fecha|left', "select dia from comercial.dias_tarjeta limit 12", 50, 50);
        $fu->AgregarCampoListaSQL('anio_co', '', "select year from comercial.year_tarjeta", 50, 70);
        //$fu->AgregarCampoLista('dia_co', 'Fecha|left', false, 50, 50);
        //$fu->AgregarOpcionCampoLista('dia_co', "select dia from dias_tarjeta", '1');
        //$fu->AgregarOpcionCampoLista('dia_co', '02', '2');
        //}


        // NUEVO
        $fu->AgregarCampoTexto('nomb_dep', 'Nombre-Apellidos|left', false, $nom_clpv, 200, 100);
        $fu->AgregarCampoTexto('ced_dep', 'Identificacion|left', false, $ruc_clpv, 200, 100);


        $fu->cCampos["pagoTipoTarjeta"]->xValor = $id_tarjeta;
        $fu->cCampos["pagoBanco"]->xValor = $id_banco;
        $fu->cCampos["pagoTipoCuenta"]->xValor = $tipo_cuenta;
        $fu->cCampos["pagoTarjeta"]->xValor = $tarjeta;
        $fu->cCampos["pagoCuenta"]->xValor = $cuenta;
        $fu->cCampos["dia_co"]->xValor = $hoy;
        $fu->cCampos["anio_co"]->xValor = $year;

        $sHtml .= '<table class="table table-striped table-condensed" style="width: 100%;" align="center">';
        $sHtml .= '<tr>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[0] . '">' . $fu->ObjetoHtmlLBL('pagoTipoTarjeta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[0] . '">' . $fu->ObjetoHtml('pagoTipoTarjeta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[1] . '">' . $fu->ObjetoHtmlLBL('pagoBanco') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[1] . '">' . $fu->ObjetoHtml('pagoBanco') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[2] . '">' . $fu->ObjetoHtmlLBL('pagoTipoCuenta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[2] . '">' . $fu->ObjetoHtml('pagoTipoCuenta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[3] . '">' . $fu->ObjetoHtmlLBL('pagoTarjeta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[3] . '">' . $fu->ObjetoHtml('pagoTarjeta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[4] . '">' . $fu->ObjetoHtmlLBL('pagoCuenta') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[4] . '">' . $fu->ObjetoHtml('pagoCuenta') . '</td>';
        //$sHtml .= '<td style="display: ' . $arrayVisibles[5] . '">' . $fu->ObjetoHtmlLBL('pagoFechaVence') . '</td>';
        //$sHtml .= '<td style="display: ' . $arrayVisibles[5] . '">' . $fu->ObjetoHtml('pagoFechaVence') . '</td>';

        $sHtml .= '</tr>';
        $sHtml .= '<tr>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[5] . '">' . $fu->ObjetoHtmlLBL('dia_co') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[5] . '">' . $fu->ObjetoHtml('dia_co') . '/' . $fu->ObjetoHtml('anio_co') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[6] . '">' . $fu->ObjetoHtmlLBL('pagoClave') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[6] . '">' . $fu->ObjetoHtml('pagoClave') . '</td>';
        //$sHtml .= '<td style="display: ' . $arrayVisibles[9] . '">' . $fu->ObjetoHtmlLBL('anio_co') . '</td>';
        //$sHtml .= '<td style="display: ' . $arrayVisibles[9] . '">' . $fu->ObjetoHtml('anio_co') . '</td>';
        $sHtml .= '</tr>';

        $sHtml .= '<tr>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[7] . '">' . $fu->ObjetoHtmlLBL('nomb_dep') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[7] . '">' . $fu->ObjetoHtml('nomb_dep') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[8] . '">' . $fu->ObjetoHtmlLBL('ced_dep') . '</td>';
        $sHtml .= '<td style="display: ' . $arrayVisibles[8] . '">' . $fu->ObjetoHtml('ced_dep') . '</td>';

        //$sHtml .= '<td style="display: none">' . $fu->ObjetoHtmlLBL('ced_dep') . '</td>';
        //$sHtml .= '<td style="display: none">' . $fu->ObjetoHtml('ced_dep') . '</td>';


        $sHtml .= '<td align="center">
                        <div class="btn btn-success btn-sm" onclick="agregarMedioPago();">
                            <span class="glyphicon glyphicon-plus-sign"></span>
                            ' . $etiquetaBtn . ' Medio Pago
                        </div>
                    </td>';
        $sHtml .= '</tr>';
        $sHtml .= '</table>';

        $oReturn->assign('divDetalleFormaPago', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }


    return $oReturn;
}

function agregarMedioPago($aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $oReturn = new xajaxResponse();

    $idUser = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $idMedioPago = $aForm['idMedioPago'];
    $pago = $aForm['pago'];
    $pagoTipoTarjeta = $aForm['pagoTipoTarjeta'];
    $pagoBanco = $aForm['pagoBanco'];
    $pagoTipoCuenta = $aForm['pagoTipoCuenta'];
    $pagoTarjeta = $aForm['pagoTarjeta'];
    $pagoCuenta = $aForm['pagoCuenta'];
    $fecha = date("Y-m-d");
    $fechaServer = date("Y-m-d H:i:s");
    $nomb_dep = $aForm['nomb_dep'];
    $ced_dep = $aForm['ced_dep'];
    $pagoClave = $aForm['pagoClave'];

    $mes_traj = $aForm['dia_co'];
    $anio_tarj = $aForm['anio_co'];

    //    print_r($mes_traj);exit;

    //  LECTURA SUCIA
    //

    try {

        $oCon->QueryT('BEGIN;');

        //tipo de pago
        $sql = "select fpag_cot_fpag from saefpag where fpag_cod_empr = $idempresa and fpag_cod_sucu = $idsucursal and fpag_cod_fpag = '$pago'";
        $fpag_cot_fpag = consulta_string_func($sql, 'fpag_cot_fpag', $oIfx, '');

        //CONTROL PARA POSTGRESS
        if (strlen($pagoBanco) == 0) {
            $pagoBanco = 0;
        }

        if (strlen($pagoTipoTarjeta) == 0) {
            $pagoTipoTarjeta = 0;
        }

        if (strlen($pagoTarjeta) == 0) {
            $pagoTarjeta = 0;
        }

        if (strlen($pagoTipoCuenta) == 0) {
            $pagoTipoCuenta = 0;
        }

        if (empty($idMedioPago)) {

            $sql = "insert into isp.contrato_medio_pago(
                                id_empresa,         id_sucursal,        id_clpv,        id_contrato,
                                id_pago,            id_tipo,            id_banco,       id_tarjeta, 
                                tarjeta,            cuenta,             tipo_cuenta,    estado, 
                                user_web,           fecha,              fecha_server ,  nom_clpv,
                                ruc_clpv,pagoClave,mes_traj,anio_tarj )
                        values( $idempresa,         $idsucursal,        $codigoCliente, $idContrato,
                                '$pago',            '$fpag_cot_fpag',   '$pagoBanco',   '$pagoTipoTarjeta', 
                                '$pagoTarjeta',     '$pagoCuenta',      '$pagoTipoCuenta', 'A', 
                                $idUser,            '$fecha',           '$fechaServer' , '$nomb_dep' ,
                                '$ced_dep','$pagoClave','$mes_traj','$anio_tarj'  )";
            $oCon->QueryT($sql);
        } else {
            $sql = "update isp.contrato_medio_pago set id_pago = '$pago', 
                                    id_tipo         = '$fpag_cot_fpag', 
                                    id_banco        = '$pagoBanco', 
                                    id_tarjeta      = '$pagoTipoTarjeta', 
                                    tarjeta         = '$pagoTarjeta', 
                                    cuenta          = '$pagoCuenta', 
                                    tipo_cuenta     = '$pagoTipoCuenta' ,
                                    nom_clpv        = '$nomb_dep' ,
                                    ruc_clpv        = '$ced_dep',
									pagoClave       = '$pagoClave',
									mes_traj 		= '$mes_traj',
									anio_tarj		= '$anio_tarj'
                                where id = $idMedioPago";
            $oCon->QueryT($sql);
        }

        //actualiza forma de pago
        $sql = "update isp.contrato_clpv set forma_pago = '$pago'
                                where id_empresa = $idempresa and
                                id_sucursal = $idsucursal and
                                id_clpv = $codigoCliente and
                                id = $idContrato";

        //        $oReturn->alert($sql);
        $oCon->QueryT($sql);

        $oReturn->alert('Procesado Correctamente...');

        $oCon->QueryT('COMMIT;');
        $oReturn->script('reporteMedioPago()');
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}


function agregarNotas($aForm = '', $notaTitulo = '', $notaMensaje = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $oReturn = new xajaxResponse();

    $idUser = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $notaPrioridad = $aForm['notaPrioridad'];
    $notaTitulo = strtoupper($notaTitulo);
    $notaMensaje = strtoupper($notaMensaje);
    $notaUsuario = $aForm['notaUsuario'];

    $notaAdjunto = '';
    if (!empty($aForm['notaAdjunto'])) {
        $notaAdjunto = substr($aForm['notaAdjunto'], 3);
    }

    $fecha = date("Y-m-d");

    try {

        $classContratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato);

        $oCon->QueryT('BEGIN;');

        $classContratos->registraNotasContratos($idUser, $notaPrioridad, $notaTitulo, $notaMensaje, $notaAdjunto, $notaUsuario, $fecha);

        $oReturn->alert('Nota Ingresada Correctamente...');

        $oReturn->assign('notaTitulo', 'value', '');
        $oReturn->assign('notaMensaje', 'value', '');
        $oReturn->assign('notaAdjunto', 'value', '');
        $oReturn->script('$("#notaUsuario").val("").trigger("change.select2");');

        $oCon->QueryT('COMMIT;');
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function reporteNotas($aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $oReturn = new xajaxResponse();

    $idUser = $_SESSION['U_ID'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        $classContratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato);

        $sHtml .= '<div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title" id="myModalLabel">NOTAS</h5>
                        </div>
                        <div class="modal-body">';

        $sHtml .= $classContratos->reporteNotasContratos($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato);

        $sHtml .= '</div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>';

        $oReturn->assign('miModal', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cargar_lista_zona($aForm = '', $cod = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    //

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $clpv_cod_sucu = $aForm['clpv_cod_sucu'];

    $oReturn = new xajaxResponse();

    $sql = "select zona_cod_zona, zona_nom_zona 
            from saezona 
            where zona_cod_empr = $idempresa and
            zona_cod_sucu = $clpv_cod_sucu order by 2";

    $i = 1;
    if ($oIfx->Query($sql)) {
        $oReturn->script('eliminar_lista_zona();');
        if ($oIfx->NumFilas() > 0) {
            do {
                $oReturn->script(('anadir_elemento_zona(' . $i++ . ',\'' . $oIfx->f('zona_cod_zona') . '\', \'' . $oIfx->f('zona_nom_zona') . '\' )'));
            } while ($oIfx->SiguienteRegistro());
        }
    }

    $oReturn->assign('zona', 'value', $cod);

    return $oReturn;
}

function listaProdServCliente($aForm = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oIfxA = new Dbo;
    $oIfxA->DSN = $DSN_Ifx;
    $oIfxA->Conectar();

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de sesion
    unset($_SESSION['ARRAY_CLPV_PRODSERV']);

    $nombreBuscar = $aForm['nombreBuscar'];

    try {

        //lectura sucia
        //

        //variables de session
        $idempresa = $_SESSION['U_EMPRESA'];
        $idsucursal = $_SESSION['U_SUCURSAL'];

        //variables del formulario
        $codigoCliente = $aForm['codigoCliente'];
        $idContrato = $aForm['idContrato'];

        //query clpv
        $sqlClpv = "select clse_cod_clse, clse_cod_clpv, clse_cod_prod,
                    clse_nom_prod, clse_cod_bode, clse_cod_nomp,
                    clse_pre_clse, clse_cant_add, clse_pre_add, clse_tot_add,
                    clse_cco_clse, clse_cod_contr, clse_tip_cobr, clse_cobr_sn,
					clse_est_inst, clse_prod_inst
                    from saeclse
                    where clse_cod_empr = $idempresa and
                    clse_cod_clpv = $codigoCliente and
					clse_cod_contr = $idContrato";
        if ($oIfx->Query($sqlClpv)) {
            if ($oIfx->NumFilas() > 0) {

                $table .= '<table class="table table-striped table-bordered table-condensed" align="center" style="width: 98%;">
                            <tr>
                                <td colspan="12" align="center">REPORTE SERVICIOS / PRODUCTOS</td>
                            </tr>

                            <tr>
                                <td>BODEGA</td>
                                <td>CODIGO</td>
                                <td>NOMBRE</td>
                                <td>TIPO PRECIO</td>
                                <td>PRECIO</td>
                                <td>CANT ADICIONAL</td>
                                <td>PRECIO ADICIONAL</td>
								<td>TOTAL ADICIONAL</td>
								<td>COBRO</td>
                                <td>ELIMINAR</td>
								<td>EQUIPO</td>
                            </tr>';
                unset($array);
                do {
                    $clse_cod_clse = $oIfx->f('clse_cod_clse');
                    $clse_cod_clpv = $oIfx->f('clse_cod_clpv');
                    $clse_cod_prod = $oIfx->f('clse_cod_prod');
                    $clse_nom_prod = $oIfx->f('clse_nom_prod');
                    $clse_cod_bode = $oIfx->f('clse_cod_bode');
                    $clse_cod_nomp = $oIfx->f('clse_cod_nomp');
                    $clse_pre_clse = $oIfx->f('clse_pre_clse');
                    $clse_ds1_clse = $oIfx->f('clse_cant_add');
                    $clse_ds2_clse = $oIfx->f('clse_pre_add');
                    $clse_cco_clse = $oIfx->f('clse_cco_clse');
                    $clse_cod_contr = $oIfx->f('clse_cod_contr');
                    $clse_tip_cobr = $oIfx->f('clse_tip_cobr');
                    $clse_tot_add = $oIfx->f('clse_tot_add');
                    $clse_cobr_sn = $oIfx->f('clse_cobr_sn');

                    $array[] = array($clse_cod_clse, $clse_cod_clpv);

                    //campos formulario
                    $ifu->AgregarCampoLista($clse_cod_clpv . '_tipo_cobro_' . $clse_cod_clse, '|LEFT', false, 110, 100);
                    $sql = "select id, tipo from tipo_cobro_prod";
                    if ($oCon->Query($sql)) {
                        if ($oCon->NumFilas() > 0) {
                            do {
                                $ifu->AgregarOpcionCampoLista($clse_cod_clpv . '_tipo_cobro_' . $clse_cod_clse, $oCon->f('tipo'), $oCon->f('id'));
                            } while ($oCon->SiguienteRegistro());
                        }
                    }
                    $oCon->Free();

                    //bodega
                    $ifu->AgregarCampoLista($clse_cod_clpv . '_id_bodega_' . $clse_cod_clse, '|LEFT', false, 150, 100);
                    $sql = "select  b.bode_cod_bode, b.bode_nom_bode 
                            from saebode b, saesubo s
                            where b.bode_cod_bode = s.subo_cod_bode and
                            b.bode_cod_empr = $idempresa and
                            s.subo_cod_empr = $idempresa";
                    if ($oIfxA->Query($sql)) {
                        if ($oIfxA->NumFilas() > 0) {
                            do {
                                $bode_cod_bode = $oIfxA->f('bode_cod_bode');
                                $bode_nom_bode = $oIfxA->f('bode_nom_bode');
                                $ifu->AgregarOpcionCampoLista($clse_cod_clpv . '_id_bodega_' . $clse_cod_clse, $bode_nom_bode, $bode_cod_bode);
                            } while ($oIfxA->SiguienteRegistro());
                        }
                    }
                    $oIfxA->Free();
                    $ifu->AgregarComandoAlPonerEnfoque($clse_cod_clpv . '_id_bodega_' . $clse_cod_clse, 'this.blur();');

                    //tipo de precio
                    $ifu->AgregarCampoLista($clse_cod_clpv . '_tprecio_' . $clse_cod_clse, '|LEFT', false, 110, 100);
                    $sql = "select nomp_cod_nomp, nomp_nomb_nomp from saenomp where nomp_cod_empr = $idempresa";
                    if ($oIfxA->Query($sql)) {
                        if ($oIfxA->NumFilas() > 0) {
                            do {
                                $nomp_cod_nomp = $oIfxA->f('nomp_cod_nomp');
                                $nomp_nomb_nomp = $oIfxA->f('nomp_nomb_nomp');
                                $ifu->AgregarOpcionCampoLista($clse_cod_clpv . '_tprecio_' . $clse_cod_clse, $nomp_nomb_nomp, $nomp_cod_nomp);
                            } while ($oIfxA->SiguienteRegistro());
                        }
                    }
                    $oIfxA->Free();

                    $ifu->AgregarCampoNumerico($clse_cod_clpv . '_precio_' . $clse_cod_clse, 'Precio|left', false, $clse_pre_clse, 80, 9);

                    $ifu->AgregarCampoNumerico($clse_cod_clpv . '_desc1_' . $clse_cod_clse, 'Ds1|left', false, $clse_ds1_clse, 80, 9);

                    $ifu->AgregarCampoNumerico($clse_cod_clpv . '_desc2_' . $clse_cod_clse, 'Ds2|left', false, $clse_ds2_clse, 80, 9);

                    $ifu->cCampos[$clse_cod_clpv . '_id_contrato_' . $clse_cod_clse]->xValor = $clse_cod_contr;
                    $ifu->cCampos[$clse_cod_clpv . '_tipo_cobro_' . $clse_cod_clse]->xValor = $clse_tip_cobr;
                    $ifu->cCampos[$clse_cod_clpv . '_id_bodega_' . $clse_cod_clse]->xValor = $clse_cod_bode;
                    $ifu->cCampos[$clse_cod_clpv . '_tprecio_' . $clse_cod_clse]->xValor = $clse_cod_nomp;
                    $ifu->cCampos[$clse_cod_clpv . '_ccosto_' . $clse_cod_clse]->xValor = $clse_cco_clse;

                    $opChecked = '';
                    if ($clse_cobr_sn == 'S') {
                        $opChecked = 'checked';
                    }

                    $input = '<input type="checkbox" name="' . $clse_cod_clpv . '_cobro_' . $clse_cod_clse . '" id="' . $clse_cod_clpv . '_cobro_' . $clse_cod_clse . '" value="S" ' . $opChecked . '/>';

                    $table .= '<tr>
                                    <td align="left">' . $ifu->ObjetoHtml($clse_cod_clpv . '_id_bodega_' . $clse_cod_clse) . '</td>
                                    <td align="left">' . $clse_cod_prod . '</td>
                                    <td align="left">' . $clse_nom_prod . '</td>
                                    <td align="left">' . $ifu->ObjetoHtml($clse_cod_clpv . '_tprecio_' . $clse_cod_clse) . '</td>
                                    <td align="right">' . $ifu->ObjetoHtml($clse_cod_clpv . '_precio_' . $clse_cod_clse) . '</td>
                                    <td align="right">' . $ifu->ObjetoHtml($clse_cod_clpv . '_desc1_' . $clse_cod_clse) . '</td>
                                    <td align="right">' . $ifu->ObjetoHtml($clse_cod_clpv . '_desc2_' . $clse_cod_clse) . '</td>
                                    <td align="right">' . $clse_tot_add . '</td>
                                    <td align="center">' . $input . '</td>
                                   <td align="center">
                                        <div class="btn btn-danger btn-sm" onclick="eliminarProdServ(' . $clse_cod_clpv . ', ' . $clse_cod_clse . ');">
                                            <span class="glyphicon glyphicon-remove"></span>
                                        </div>
                                   </td>
                                    <td align="center">
                                        <div class="btn btn-info btn-sm" onclick="equipoServicio();">
                                            <span class="glyphicon glyphicon-cog"></span>
                                        </div>
                                   </td>
                            </tr>';
                } while ($oIfx->SiguienteRegistro());
                $table .= '<tr>
                                <td colspan="12" align="right">
                                    <div class="btn btn-primary btn-success btn-sm" onclick="modificarProdServ();">
                                        <span class="glyphicon glyphicon-floppy-saved"></span>
                                        Modificar Servicios
                                    </div>
                                </td>
                            </tr>';
                $table .= '</table>';
            }
        }
        $oIfx->Free();

        $_SESSION['ARRAY_CLPV_PRODSERV'] = $array;

        $oReturn->assign("divReporteProdServClpv", "innerHTML", $table);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function consultaPrecio($aForm = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $tprecioProdServ = $aForm['tprecioProdServ'];
    $idBodegaProdServ = $aForm['idBodegaProdServ'];
    $codProdProdServ = $aForm['codProdProdServ'];

    try {

        //lectura sucia
        //

        $sql = "select ppr_pre_raun 
                from saeppr 
                where ppr_cod_empr = $idempresa and 
                ppr_cod_bode = $idBodegaProdServ and 
                ppr_cod_prod = '$codProdProdServ' and
                ppr_cod_nomp = $tprecioProdServ";
        //$oReturn->alert($sql);
        $ppr_pre_raun = consulta_string_func($sql, 'ppr_pre_raun', $oIfx, 0);

        //impuestos
        $sql = "select nvl(prbo_iva_porc,0) as iva,
				nvl(prbo_ice_porc,0) as ice,
				nvl(prbo_val_irbp, 0) as irbp
				from saeprbo
				where prbo_cod_empr = $idempresa and
				prbo_cod_bode = $idBodegaProdServ and
				prbo_cod_prod = '$codProdProdServ'";
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                $iva = $oIfx->f('iva');
                $ice = $oIfx->f('ice');
                $irbp = $oIfx->f('irbp');
            }
        }
        $oIfx->Free();

        //calculo
        if ($ice > 0) {
            $iceTotal = round($ppr_pre_raun * $ice / 100, 2);
            $ppr_pre_raun += $iceTotal;
        }

        if ($iva > 0) {
            $ivaTotal = round($ppr_pre_raun * $iva / 100, 2);
        }

        if ($irbp > 0) {
            //$irbpTotal = round($ppr_pre_raun * $irbp / 100, 2);
        }

        $total = round($ppr_pre_raun + $ivaTotal, 2);

        $oReturn->assign('precioProdServ', 'value', $total);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function guardarProdServ($aForm = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oIfxA = new Dbo;
    $oIfxA->DSN = $DSN_Ifx;
    $oIfxA->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //varibales formulario
    $codigoCliente = $aForm['codigoCliente'];
    $sucursal = $aForm['clpv_cod_sucu'];
    $idContrato = $aForm['idContrato'];
    $idBodegaProdServ = $aForm['idBodegaProdServ'];
    $prodProdServ = $aForm['prodProdServ'];
    $codProdProdServ = $aForm['codProdProdServ'];
    $tprecioProdServ = $aForm['tprecioProdServ'];
    $precioProdServ = $aForm['precioProdServ'];
    $desc1ProdServ = $aForm['desc1ProdServ'];
    $desc2ProdServ = $aForm['desc2ProdServ'];
    $tipo_cobro = $aForm['tipo_cobro'];
    $aplicaCobro = $aForm['aplicaCobro'];
    $prodSuscripcion = $aForm['prodSuscripcion'];

    try {

        //clase Contratos
        $classContratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato);
        $classTareas = new Tareas();

        // commit

        $oCon->QueryT('BEGIN;');

        $total = round($desc1ProdServ * $desc2ProdServ, 2);

        //estado contrato
        $sql = "select estado, id_dire 
				from isp.contrato_clpv 
				where id = $idContrato and
				id_clpv = $codigoCliente";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $estado = $oCon->f('estado');
                $id_dire = $oCon->f('id_dire');
            }
        }
        $oCon->Free();

        $sqlInsert = "insert into saeclse(clse_cod_empr, clse_cod_sucu, clse_cod_bode,
                    clse_cod_prod, clse_nom_prod, clse_cod_nomp, clse_cco_clse,
                    clse_pre_clse, clse_cant_add, clse_pre_add, clse_tot_add,
                    clse_cod_clpv, clse_cod_contr, clse_tip_cobr, clse_cobr_sn,
					clse_prod_inst, clse_est_clse)
                    values($idempresa, $sucursal, $idBodegaProdServ,
                    '$codProdProdServ', '$prodProdServ', '$tprecioProdServ', '',
                    '$precioProdServ', '$desc1ProdServ', '$desc2ProdServ',  '$total',
                    $codigoCliente, $idContrato, '$tipo_cobro', '$aplicaCobro',
					'$prodSuscripcion', 'PE')";
        $oIfx->QueryT($sqlInsert);

        $sql = "select clse_cod_clse, clse_cod_prod
				from saeclse 
				where clse_cod_prod = (select prod_cod_prod 
				from saeprod
				where prod_cod_prod = clse_cod_prod and
				prod_cod_empr = clse_cod_empr and
				prod_cod_sucu = clse_cod_sucu and
				prod_cod_cabl = 1) and
				clse_cod_clpv = $codigoCliente and
				clse_cod_contr = $idContrato and
				clse_cobr_sn = 'S'";
        //$oReturn->alert($sql);
        if ($oIfxA->Query($sql)) {
            if ($oIfxA->NumFilas() > 0) {
                do {
                    $clse_cod_clse = $oIfxA->f('clse_cod_clse');
                    $clse_cod_prod = $oIfxA->f('clse_cod_prod');

                    $sql = "update saeclse set clse_cobr_sn = 'N'
							where 
							clse_cod_clse = $clse_cod_clse and
							clse_cod_prod = '$clse_cod_prod' and
							clse_cod_clpv = $codigoCliente and
							clse_cod_contr = $idContrato ";
                    $oIfx->QueryT($sql);
                } while ($oIfxA->SiguienteRegistro());
            }
        }
        $oIfxA->Free();

        $classContratos->sumaTotalesServicio($oCon, $oIfx, $idContrato, $codigoCliente);

        if ($estado == 'AP') {
            $fecha = date("Y-m-d");
            $observaciones = 'INSTALACION DE SERVICIOS';
            $arrayProd[] = array($codProdProdServ);
            $classTareas->ingresarTarea($oCon, $oIfx, $codigoCliente, $idContrato, 1, $fecha, $observaciones, $id_dire, $franja, $motivo, $arrayProd);
        }

        $sql = "update isp.contrato_clpv set estado_instalacion = 'N'
				where id = $idContrato and
				id_clpv = $codigoCliente";
        $oCon->QueryT($sql);


        $oIfx->QueryT('COMMIT WORK;');
        $oCon->QueryT('COMMIT;');

        //$oReturn->alert('Ingresado Correctamente...');
        $oReturn->script('listaProdServCliente();');
        $oReturn->assign('prodProdServ', 'value', '');
        $oReturn->assign('codProdProdServ', 'value', '');
        $oReturn->assign('precioProdServ', 'value', '');
        $oReturn->assign('desc1ProdServ', 'value', '');
        $oReturn->assign('desc2ProdServ', 'value', '');
        $oReturn->assign('prodSuscripcion', 'value', '');
    } catch (Exception $e) {
        // rollback
        $oIfx->QueryT('ROLLBACK WORK;');
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function modificarProdServ($aForm = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $array = $_SESSION['ARRAY_CLPV_PRODSERV'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //varibales formulario
    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        $classContratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato);

        // commit

        $oCon->QueryT('BEGIN;');

        if (count($array) > 0) {
            foreach ($array as $val) {
                $clse_cod_clse = $val[0];
                $clse_cod_clpv = $val[1];

                $tipo_cobro = $aForm[$clse_cod_clpv . '_tipo_cobro_' . $clse_cod_clse];
                $idBodegaProdServ = $aForm[$clse_cod_clpv . '_id_bodega_' . $clse_cod_clse];
                $tprecioProdServ = $aForm[$clse_cod_clpv . '_tprecio_' . $clse_cod_clse];
                $precioProdServ = $aForm[$clse_cod_clpv . '_precio_' . $clse_cod_clse];
                $desc1ProdServ = $aForm[$clse_cod_clpv . '_desc1_' . $clse_cod_clse];
                $desc2ProdServ = $aForm[$clse_cod_clpv . '_desc2_' . $clse_cod_clse];
                $cobro = $aForm[$clse_cod_clpv . '_cobro_' . $clse_cod_clse];

                $aplicaCobro = 'N';
                if (!empty($cobro)) {
                    $aplicaCobro = 'S';
                }

                $total = $desc1ProdServ * $desc2ProdServ;

                $sqlUpdate = "update saeclse set clse_cod_bode = $idBodegaProdServ,
                            clse_cod_nomp = '$tprecioProdServ',
                            clse_pre_clse = '$precioProdServ', 
                            clse_cant_add = '$desc1ProdServ', 
							clse_pre_add = '$desc2ProdServ',
							clse_cobr_sn = '$aplicaCobro',
							clse_tot_add = '$total'
                            where 
                            clse_cod_clpv = $clse_cod_clpv and
                            clse_cod_clse = $clse_cod_clse and
							clse_cod_contr = $idContrato";
                $oIfx->QueryT($sqlUpdate);
            }

            $classContratos->sumaTotalesServicio($oCon, $oIfx, $idContrato, $codigoCliente);

            $oIfx->QueryT('COMMIT WORK;');
            $oCon->QueryT('COMMIT;');

            $oReturn->alert('Procesado Correctamente...');
            $oReturn->script('listaProdServCliente();');
        } else {
            $oReturn->alert('No existen registros para procesar...');
        }
    } catch (Exception $e) {
        // rollback
        $oIfx->QueryT('ROLLBACK WORK;');
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function eliminarProdServ($aForm = '', $clpv = 0, $clse = 0)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    try {

        $idempresa = $_SESSION['U_EMPRESA'];
        $idsucursal = $_SESSION['U_SUCURSAL'];

        //varibales formulario
        $codigoCliente = $aForm['codigoCliente'];
        $idContrato = $aForm['idContrato'];

        $classContratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $codigoCliente, $idContrato);

        // commit

        $oCon->QueryT('BEGIN;');

        $sqlDelete = "delete from saeclse where clse_cod_clpv = $clpv and clse_cod_clse = $clse and clse_cod_contr = $idContrato";
        $oIfx->QueryT($sqlDelete);

        $classContratos->sumaTotalesServicio($oCon, $oIfx, $idContrato, $codigoCliente);

        $oIfx->QueryT('COMMIT WORK;');
        $oCon->QueryT('COMMIT;');

        $oReturn->script('listaProdServCliente();');
    } catch (Exception $e) {
        // rollback
        $oIfx->QueryT('ROLLBACK WORK;');
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cargarlistaProdServ($aForm = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();


    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $idBodegaProdServ = $aForm['idBodegaProdServ'];

    $sql = "select p.prod_cod_prod, p.prod_nom_prod
            from saeprbo pr, saeprod p 
            where
            p.prod_cod_prod = pr.prbo_cod_prod and
            p.prod_cod_empr = pr.prbo_cod_empr and
            p.prod_cod_sucu = pr.prbo_cod_sucu and
            p.prod_cod_empr = $idempresa and
            pr.prbo_cod_bode = $idBodegaProdServ
            order by 2";
    $i = 1;
    if ($oIfx->Query($sql)) {
        $oReturn->script('eliminar_lista_prod();');
        if ($oIfx->NumFilas() > 0) {
            do {
                $oReturn->script(('anadir_elemento_prod(' . $i++ . ',\'' . $oIfx->f('prod_cod_prod') . '\', \'' . $oIfx->f('prod_nom_prod') . '\' )'));
            } while ($oIfx->SiguienteRegistro());
        }
    }
    $oIfx->Free();

    return $oReturn;
}

function cargarListaContrato($aForm = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();


    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $codigoCliente = $aForm['codigoCliente'];

    $sql = "select id, codigo from isp.contrato_clpv where id_clpv = $codigoCliente";
    $i = 1;
    if ($oCon->Query($sql)) {
        $oReturn->script('eliminar_lista_contrato();');
        if ($oCon->NumFilas() > 0) {
            do {
                $oReturn->script(('anadir_elemento_contrato(' . $i++ . ',\'' . $oCon->f('id') . '\', \'' . $oCon->f('codigo') . '\' )'));
            } while ($oCon->SiguienteRegistro());
        }
    }
    $oCon->Free();

    return $oReturn;
}

function agregarEntidad($aForm = '', $op = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $empresa = $_SESSION['U_EMPRESA'];
    $sucursal = $_SESSION['U_SUCURSAL'];
    $usuario_web = $_SESSION['U_ID'];
    $pais_cod = $_SESSION['U_PAIS_COD'];

    //variables del formulario
    $clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $direccion = ($aForm['direccion']);
    $email = trim($aForm['emai_ema_emai']);
    $fechaSever = date("Y-m-d H:i:s");

    $id_api = $_SESSION['id_api'];
    $estado_api = $_SESSION['estado_api'];

    /* if (empty($sucursal)) {
        $sqlSucursal = "select clpv_cod_sucu from saeclpv where clpv_cod_clpv = $clpv";
        $sucursal = consulta_string_func($sqlSucursal, 'clpv_cod_sucu', $oIfx, 0);
    } */

    try {

        // commit

        $oCon->QueryT('BEGIN;');

        //op

        if ($op == 1) {

            $idDireccion        = $aForm['idDireccion'];
            $tipo_direccion     = $aForm['tipo_direccion'];
            $id_calle           = $aForm['calle_direccion'];
            $tipo_casa          = $aForm['tipo_casa'];
            $rutaDire           = $aForm['rutaDire'];
            $ordenRutaDire      = $aForm['ordenRutaDire'];
            $codigoRutaDire     = (string)$aForm['codigoRutaDire'];
            $sectorDire         = $aForm['sectorDire'];
            $barrioDire         = $aForm['barrioDire'];
            $callePrincipal     = strtoupper(trim(($aForm['callePrincipal'])));
            $numeroDire         = trim($aForm['numeroDire']);
            $calleSecundaria    = strtoupper(trim(($aForm['calleSecundaria'])));
            $edificioDire       = strtoupper(trim(($aForm['edificioDire'])));
            $dire_dir_dire      = strtoupper(trim(($aForm['direccion'])));
            $referenciaDire     = strtoupper(trim(($aForm['referenciaDire'])));
            $antiguedadDire     = trim($aForm['antiguedadDire']);
            $latitud            = trim($aForm['latitud']);
            $longuitud          = trim($aForm['longuitud']);
            $conjDire           = $aForm['conjDire'];

            //CAMBIO PARA INGRESAR LA PROVINCIA, CANTON Y PARROQUIA EN LAisp.contrato_CLPV /  04-03-2022
            $provincia          = $aForm['dprovc'];
            $canton             = $aForm['muniDire'];
            $ciudad             = $aForm['ciudDire'];
            $parroquia          = $aForm['parrDire'];
            $direccionCompleta  = $aForm['direccion'];
            $posteContrato      = $aForm['posteContrato'];
            $cajaContrato       = $aForm['cajaContrato'];

            if (empty($tipo_direccion)) {
                $tipo_direccion = 0;
            }

            if (empty($tipo_casa)) {
                $tipo_casa = 0;
            }

            if (empty($sectorDire)) {
                $sectorDire = 0;
            }

            if (empty($antiguedadDire)) {
                $antiguedadDire = 0;
            }

            if (empty($rutaDire)) {
                $rutaDire = "null";
            }

            //inserta direccion

            $sqlCtrl = "insert into isp.control_clpv(id_empresa, id_clpv, tipo, opcion, user_web, fecha_server) 
						values($empresa, $clpv, 'D', 1, $usuario_web, '$fechaSever')";
            $oCon->QueryT($sqlCtrl);
            //direccion
            $sql = "SELECT MAX(dire_cod_dire) as dire_cod_dire from saedire where dire_cod_empr = $empresa and dire_cod_clpv = $clpv and dire_cod_contr = $idContrato";
            $idDireccion = consulta_string_func($sql, 'dire_cod_dire', $oIfx, 0);

            if (strlen($id_poste) == 0) {
                $id_poste = 0;
            }
            if (strlen($id_caja) == 0) {
                $id_caja = 0;
            }
            if (strlen($latitud) == 0) {
                $latitud = 0;
            }
            if (strlen($longuitud) == 0) {
                $longuitud = 0;
            }
            if (strlen($pais_cod) == 0) {
                $pais_cod = 0;
            }
            if (strlen($provincia) == 0) {
                $provincia = 0;
            }
            if (strlen($canton) == 0) {
                $canton = 0;
            }
            if (strlen($ciudad) == 0) {
                $ciudad = 0;
            }
            if (strlen($parroquia) == 0) {
                $parroquia = 0;
            }
            if (strlen($sectorDire) == 0) {
                $sectorDire = 0;
            }
            if (strlen($barrioDire) == 0) {
                $barrioDire = 0;
            }
            if (strlen($tipo_direccion) == 0) {
                $tipo_direccion = 0;
            }
            if (strlen($callePrincipal) == 0) {
                $callePrincipal = 0;
            }
            if (strlen($calleSecundaria) == 0) {
                $calleSecundaria = 0;
            }
            if (strlen($conjDire) == 0) {
                $conjDire = 0;
            }
            if (strlen($tipo_casa) == 0) {
                $tipo_casa = 0;
            }
            if (strlen($referenciaDire) == 0) {
                $referenciaDire = 0;
            }
            if (strlen($id_poste) == 0) {
                $id_poste = 0;
            }
            if (strlen($id_caja) == 0) {
                $id_caja = 0;
            }
            if (strlen($direccionCompleta) == 0) {
                $direccionCompleta = 0;
            }
            if (strlen($cajaContrato) == 0) {
                $cajaContrato = 0;
            }
            if (strlen($posteContrato) == 0) {
                $posteContrato = 0;
            }
            if (strlen($idDireccion) == 0) {
                $idDireccion = 0;
            }
            if (strlen($rutaDire) == 0) {
                $rutaDire = 0;
            }
            if (strlen($codigoRutaDire) == 0) {
                $codigoRutaDire = 0;
            }
            if (strlen($ordenRutaDire) == 0) {
                $ordenRutaDire = 0;
            }


            //update contrato
            $sql = "UPDATE 
                    isp.contrato_clpv 
                    SET 
                    id_pais         = '$pais_cod',
                    id_provincia    = '$provincia',
                    id_canton       = '$canton',
                    id_ciudad       = '$ciudad',
                    id_parroquia    = '$parroquia',";
            if ($sectorDire != 0) {
                $sql .= "id_sector       = '$sectorDire',
                            id_barrio       = '$barrioDire',";
            }

            $sql .= "id_bloque       = '$tipo_direccion',
                    id_calle        = '$id_calle',
                    nomb_conjunto   = '$callePrincipal',
                    num_conjunto    = '$numeroDire',
                    estrato         = '$calleSecundaria',
                    id_conjunto     = '$conjDire',
                    departamento    = '$tipo_casa',
					referencia      = '$referenciaDire',
                    id_poste        = '$id_poste',
                    id_caja         = '$id_caja',
                    direccion       = '$direccionCompleta',
                    caja            = '$cajaContrato',
                    precinto        = '$cajaContrato',
                    poste           = '$posteContrato',
					id_dire         =  $idDireccion,
					latitud         = '$latitud',
					longitud        = '$longuitud',
					id_ruta         = $rutaDire,
					ruta            = '$codigoRutaDire',
					orden_ruta      = '$ordenRutaDire'
					WHERE 
					id = $idContrato ";
            $oCon->QueryT($sql);

            if ($id_api == 5 && $estado_api == 'A') {
                $sql = "SELECT id_cliente_mk FROM isp.contrato_clpv WHERE id = $idContrato AND id_clpv = $clpv";
                $id_cliente_mk = consulta_string_func($sql, 'id_cliente_mk', $oCon, 0);

                if ($id_cliente_mk > 0) {
                    $sql = "SELECT webservice_token FROM isp.int_datos_webservice";
                    $webservice_token = consulta_string_func($sql, 'webservice_token', $oCon, 0);

                    $Webservice = new Webservice($oCon);
                    $parametros = $Webservice->parametrosWS();

                    $datosEnvio = array(
                        "token" => $webservice_token,
                        "idcliente" => intval($id_cliente_mk),
                        "datos" => [
                            "direccion_principal" => $direccionCompleta
                        ]

                    );

                    $tipo_comando   = "ACTUALIZAR_CLIENTE";
                    $tipo_sistema   = 1;
                    $envio_get      = "";
                    $envio_post     = $datosEnvio;
                    array_push($parametros, $id_api, $tipo_comando, $tipo_sistema);

                    $respuesta_update  = $Webservice->enviaComando($parametros, $envio_get, $envio_post);
                }
            }

            $oReturn->script("Swal.fire({
                type: 'success',
                title: 'Ingresado Correctamente..!',
                showConfirmButton: false,
                timer: 1000
            })");

            $oReturn->script("reporteDireCliente();");
        } elseif ($op == 2) {

            //variables telefono
            $tipo_telefono = $aForm['tipo_telefono'];
            $telefono = trim($aForm['telefono_cli']);
            $tipo_operador = $aForm['tipo_operador'];

            if (empty($tipo_operador)) {
                $tipo_operador = 0;
            }

            $sqlSucursal = "select clpv_cod_sucu from saeclpv where clpv_cod_clpv = $clpv";
            $sucursal = consulta_string_func($sqlSucursal, 'clpv_cod_sucu', $oIfx, 0);

            //inserta telefono
            $sqlTelf = "insert into saetlcp(tlcp_cod_empr, tlcp_cod_sucu, tlcp_cod_clpv, tlcp_tip_ticp, tlcp_tlf_tlcp, tlcp_cod_oper, tlcp_cod_contr)
                                    values($empresa, $sucursal, $clpv, '$tipo_telefono', '$telefono', $tipo_operador, $idContrato)";
            $oIfx->QueryT($sqlTelf);

            //control inserta datos
            $sqlCtrl = "insert into isp.control_clpv(id_empresa, id_clpv, tipo, opcion, user_web, fecha_server) 
                        values($empresa, $clpv, 'T', 1, $usuario_web, '$fechaSever')";
            $oCon->QueryT($sqlCtrl);

            $campoTelf = "celular";
            if ($tipo_telefono != 1) {
                $campoTelf = "telefono";
            }

            $sql = "update isp.contrato_clpv set $campoTelf = '$telefono' where id = $idContrato";
            $oCon->QueryT($sql);

            $oReturn->assign('tipo_telefono', 'value', '');
            $oReturn->assign('telefono_cli', 'value', '');
            $oReturn->assign('tipo_operador', 'value', '');
            $oReturn->script("reporteTelefonoCliente();");
        } elseif ($op == 3) {

            $sqlSucursal = "select clpv_cod_sucu from saeclpv where clpv_cod_clpv = $clpv";
            $sucursal = consulta_string_func($sqlSucursal, 'clpv_cod_sucu', $oIfx, 0);

            //inserta telefono
            $sqlEmai = "insert into saeemai(emai_cod_empr, emai_cod_sucu, emai_cod_clpv, emai_ema_emai, emai_cod_contr)
                                    values($empresa, $sucursal, $clpv, '$email', $idContrato)";
            $oIfx->QueryT($sqlEmai);

            //control inserta datos
            $sqlCtrl = "insert into isp.control_clpv(id_empresa, id_clpv, tipo, opcion, user_web, fecha_server) 
                        values($empresa, $clpv, 'E', 1, $usuario_web, '$fechaSever')";
            $oCon->QueryT($sqlCtrl);

            $sql = "update isp.contrato_clpv set email = '$email' where id = $idContrato";
            $oCon->QueryT($sql);

            $oReturn->assign('emai_ema_emai', 'value', '');
            $oReturn->script("reporteEmailCliente();");
        }

        //$oReturn->alert('Procesado Correctamente');
        $oIfx->QueryT('COMMIT WORK;');
        $oCon->QueryT('COMMIT;');
    } catch (Exception $e) {
        // rollback
        $oIfx->QueryT('ROLLBACK WORK;');
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function reporteTelefonoCliente($aForm = '')
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de sesion
    unset($_SESSION['ARRAY_CLPV_TELF']);
    $empresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        //lectura sucia
        //

        $sHtml .= '<table class="table table-bordered table-striped table-condensed" style="width: 98%; margin-top: 10px;" align="center">';
        $sHtml .= '<tr>
                    <td align="center" colspan="7">REPORTE # TELEFONO</td>
                </tr>';

        if ($clpv) {
            //Telefonos
            $sqlDire = "select tlcp_cod_tlcp, tlcp_tlf_tlcp, tlcp_tip_ticp, tlcp_cod_oper, tlcp_noty_sn
                    from saetlcp
                    where tlcp_cod_empr = $empresa and
                    tlcp_cod_clpv = $clpv and
					tlcp_cod_contr = $idContrato";
            if ($oIfx->Query($sqlDire)) {
                if ($oIfx->NumFilas() > 0) {
                    $i = 1;
                    unset($arrayDire);

                    $sHtml .= '<tr>
                        <td></td>
                        <td></td>
                    </tr>';
                    do {
                        $dire_cod_dire = $oIfx->f('tlcp_cod_tlcp');
                        $dire_dir_dire = $oIfx->f('tlcp_tlf_tlcp');
                        $tlcp_tip_ticp = $oIfx->f('tlcp_tip_ticp');
                        $tlcp_cod_oper = $oIfx->f('tlcp_cod_oper');
                        $tlcp_noty_sn = $oIfx->f('tlcp_noty_sn');

                        $arrayDire[] = array($dire_cod_dire);

                        //tipo telefono
                        $fu->AgregarCampoLista('tipoTelf_' . $dire_cod_dire, '|LEFT', false, 100, 100);
                        $sql = "select codigo, tipo from comercial.tipo_telefono";
                        if ($oCon->Query($sql)) {
                            if ($oCon->NumFilas() > 0) {
                                do {
                                    $codigo = $oCon->f('codigo');
                                    $tipo = $oCon->f('tipo');
                                    $fu->AgregarOpcionCampoLista('tipoTelf_' . $dire_cod_dire, $tipo, $codigo);
                                } while ($oCon->SiguienteRegistro());
                            }
                        }
                        $oCon->Free();

                        $fu->cCampos["tipoTelf_" . $dire_cod_dire]->xValor = $tlcp_tip_ticp;

                        $campoTelefono = '';
                        if ($tlcp_tip_ticp == 'C') {
                            $checkedNoty = '';
                            if ($tlcp_noty_sn == 'S') {
                                $checkedNoty = 'checked';
                            }
                            $campoTelefono = '<input type="radio" name="celNotificacion" id="celNotificacion" value="' . $dire_cod_dire . '" ' . $checkedNoty . '/>';
                        }

                        $sHtml .= '<tr>';
                        $sHtml .= '<td align="left">' . $fu->ObjetoHtml('tipoTelf_' . $dire_cod_dire) . '</td>';
                        $sHtml .= '<td align="left">
									<input type="text" id="tele_' . $dire_cod_dire . '" name="tele_' . $dire_cod_dire . '" class="form-control" value="' . $dire_dir_dire . '">
								</td>';
                        $sHtml .= '<td align="center">
                                <button type="button" class="btn btn-success btn-sm">
                                    <i class="fa-brands fa-whatsapp"></i>
                                </button>
                                ' . $campoTelefono . '
                                </td>';
                        $sHtml .= '<td align="center">
									<div class="btn btn-warning btn-sm" onclick="updateEntidad(2);">
										<span class="glyphicon glyphicon-floppy-saved"></span>
									</div>
                                </td>';
                        $sHtml .= '<td align="center">
									<div class="btn btn-danger btn-sm" onclick="eliminarEntidad(' . $dire_cod_dire . ', 2);">
										<span class="glyphicon glyphicon-remove"></span>
									</div>
                                </td>';
                        $sHtml .= '</tr>';
                        $i++;
                    } while ($oIfx->SiguienteRegistro());
                }
            }
            $oIfx->Free();
        }

        $sHtml .= '</table>';


        $_SESSION['ARRAY_CLPV_TELF'] = $arrayDire;

        $oReturn->assign("divReporteTelefono", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function updateEntidad($aForm = '', $op = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $arrayDire = $_SESSION['ARRAY_CLPV_DIRE'];
    $arrayTele = $_SESSION['ARRAY_CLPV_TELF'];
    $arrayEmai = $_SESSION['ARRAY_CLPV_EMAI'];
    $usuario_web = $_SESSION['U_ID'];
    $empresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $fechaSever = date("Y-m-d H:i:s");

    try {

        // commit

        $oCon->QueryT('BEGIN;');

        //op

        if ($op == 2) {

            if (count($arrayTele) > 0) {
                foreach ($arrayTele as $valTele) {
                    $dire_cod_dire = $valTele[0];
                    $direccion = $aForm['tele_' . $dire_cod_dire];
                    $tipoTelf = $aForm['tipoTelf_' . $dire_cod_dire];
                    $tipoTelfO = $aForm['tipoTelfO_' . $dire_cod_dire];
                    $celNotificacion = $aForm['celNotificacion'];

                    $opNoty = "N";
                    if ($dire_cod_dire == $celNotificacion) {
                        $opNoty = "S";
                    }

                    if (empty($tipoTelfO)) {
                        $tipoTelfO = 0;
                    }

                    $sqlDire = "update saetlcp set tlcp_tlf_tlcp = '$direccion', 
                                                    tlcp_tip_ticp = '$tipoTelf', 
                                                    tlcp_cod_oper = $tipoTelfO,
                                                    tlcp_noty_sn = '$opNoty'
                                                    where tlcp_cod_clpv = $clpv and 
                                                    tlcp_cod_tlcp = $dire_cod_dire and
                                                    tlcp_cod_contr = $idContrato";
                    //$oReturn->alert($sqlDire);
                    $oIfx->QueryT($sqlDire);

                    //update contrato
                    $campoTelf = "celular";
                    if ($tipoTelf != 'C') {
                        $campoTelf = "telefono";
                    }

                    $sql = "update isp.contrato_clpv set $campoTelf = '$direccion' where id = $idContrato";
                    $oCon->QueryT($sql);
                }

                //control modificado datos
                $sqlCtrl = "insert into isp.control_clpv(id_empresa, id_clpv, tipo, opcion, user_web, fecha_server) 
                            values($empresa, $clpv, 'T', 2, $usuario_web, '$fechaSever')";
                $oCon->QueryT($sqlCtrl);

                $oReturn->script("reporteTelefonoCliente()");
            }
        } elseif ($op == 3) {

            if (count($arrayEmai) > 0) {
                foreach ($arrayEmai as $valEmai) {
                    $dire_cod_dire = $valEmai[0];
                    $direccion = $aForm['emai_' . $dire_cod_dire];

                    $sqlDire = "update saeemai set emai_ema_emai = '$direccion' 
                                where emai_cod_clpv = $clpv and 
                                emai_cod_emai = $dire_cod_dire and
                                emai_cod_contr = $idContrato";
                    $oIfx->QueryT($sqlDire);
                }

                $sql = "update isp.contrato_clpv set email = '$direccion' where id = $idContrato";
                $oCon->QueryT($sql);

                //control modificado datos
                $sqlCtrl = "insert into isp.control_clpv(id_empresa, id_clpv, tipo, opcion, user_web, fecha_server) 
                            values($empresa, $clpv, 'E', 2, $usuario_web, '$fechaSever')";
                $oCon->QueryT($sqlCtrl);

                $oReturn->script("reporteEmailCliente()");
            }
        }

        $oReturn->script("Swal.fire({
            position: 'top-end',
            type: 'success',
            title: 'Ingresado Correctamente..!',
            showConfirmButton: false,
            timer: 1000
        })");
        $oIfx->QueryT('COMMIT WORK;');
        $oCon->QueryT('COMMIT;');
    } catch (Exception $e) {
        // rollback
        $oIfx->QueryT('ROLLBACK WORK;');
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function eliminarEntidad($aForm = '', $id = 0, $op = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $usuario_web = $_SESSION['U_ID'];
    $empresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $clpv = $aForm['codigoCliente'];
    $fechaSever = date("Y-m-d H:i:s");

    try {

        // commit

        $oCon->QueryT('BEGIN;');

        //op

        if ($op == 1) {

            $sqlDire = "delete from saedire where dire_cod_clpv = $clpv and dire_cod_dire = $id";
            $oIfx->QueryT($sqlDire);

            //control modificado datos
            $sqlCtrl = "insert into isp.control_clpv(id_empresa, id_clpv, tipo, opcion, user_web, fecha_server) 
						values($empresa, $clpv, 'D', 3, $usuario_web, '$fechaSever')";
            $oCon->QueryT($sqlCtrl);

            $oReturn->script("reporteDireCliente()");
        } elseif ($op == 2) {

            $sqlDire = "delete from saetlcp where tlcp_cod_clpv = $clpv and tlcp_cod_tlcp = $id";
            $oIfx->QueryT($sqlDire);

            //control modificado datos
            $sqlCtrl = "insert into isp.control_clpv(id_empresa, id_clpv, tipo, opcion, user_web, fecha_server) 
						values($empresa, $clpv, 'T', 3, $usuario_web, '$fechaSever')";
            $oCon->QueryT($sqlCtrl);

            $oReturn->script("reporteTelefonoCliente()");
        } elseif ($op == 3) {

            $sqlDire = "delete from saeemai where emai_cod_clpv = $clpv and emai_cod_emai = $id";
            $oIfx->QueryT($sqlDire);

            //control modificado datos
            $sqlCtrl = "insert into isp.control_clpv(id_empresa, id_clpv, tipo, opcion, user_web, fecha_server) 
						values($empresa, $clpv, 'E', 3, $usuario_web, '$fechaSever')";
            $oCon->QueryT($sqlCtrl);

            $oReturn->script("reporteEmailCliente()");
        }


        //$oReturn->alert('Procesado Correctamente');
        $oIfx->QueryT('COMMIT WORK;');
        $oCon->QueryT('COMMIT;');
    } catch (Exception $e) {
        // rollback
        $oIfx->QueryT('ROLLBACK WORK;');
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function reporteEmailCliente($aForm = '')
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de sesion
    unset($_SESSION['ARRAY_CLPV_EMAI']);
    $empresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        //lectura sucia
        //

        $sHtml = '<table class="table table-bordered table-striped table-condensed" style="width: 100%; margin-top: 10px;" align="center">';
        $sHtml .= '<tr>
                    <td align="center" colspan="3">REPORTE E-MAIL</td>
                </tr>';

        //Direcciones
        $sqlDire = "select emai_cod_emai, emai_ema_emai
                    from saeemai
                    where emai_cod_empr = $empresa and
                    emai_cod_clpv = $clpv and
					emai_cod_contr = $idContrato";
        //$oReturn->alert($sqlDire);
        if ($oIfx->Query($sqlDire)) {
            if ($oIfx->NumFilas() > 0) {
                $i = 1;
                unset($arrayDire);
                do {
                    $dire_cod_dire = $oIfx->f('emai_cod_emai');
                    $dire_dir_dire = $oIfx->f('emai_ema_emai');

                    $arrayDire[] = array($dire_cod_dire);

                    $sHtml .= '<tr>';
                    $sHtml .= '<td align="left">' . $dire_cod_dire . '</td>';
                    $sHtml .= '<td align="left">
									<input type="text" id="emai_' . $dire_cod_dire . '" name="emai_' . $dire_cod_dire . '" class="form-control min" value="' . $dire_dir_dire . '">
								</td>';
                    $sHtml .= '<td align="center">
									<div class="btn btn-warning btn-sm" onclick="updateEntidad(3);">
										<span class="glyphicon glyphicon-floppy-saved"></span>
									</div>
                                </td>';
                    $sHtml .= '<td align="center">
									<div class="btn btn-danger btn-sm" onclick="eliminarEntidad(' . $dire_cod_dire . ', 3);">
										<span class="glyphicon glyphicon-remove"></span>
									</div>
                                </td>';
                    $sHtml .= '</tr>';
                    $i++;
                } while ($oIfx->SiguienteRegistro());
            }
        }
        $oIfx->Free();

        $sHtml .= '</table>';


        $_SESSION['ARRAY_CLPV_EMAI'] = $arrayDire;

        $oReturn->assign("divReporteEmail", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function reporteDireClienteOld($aForm = '')
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de sesion
    unset($_SESSION['ARRAY_CLPV_EMAI']);
    $idempresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        //lectura sucia
        //

        //sector direccion
        $sql = "select id, sector from comercial.sector_direccion";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arraySector);
                do {
                    $arraySector[$oCon->f('id')] = $oCon->f('sector');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //barrio direccion
        $sql = "select id, barrio from isp.int_barrio";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayBarrio);
                do {
                    $arrayBarrio[$oCon->f('id')] = $oCon->f('barrio');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "select id, tipo from comercial.tipo_direccion";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayTipoDire);
                do {
                    $arrayTipoDire[$oCon->f('id')] = $oCon->f('tipo');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml .= '<table class="table table-bordered table-striped table-condensed" style="width: 98%; margin-top: 10px;" align="center">';
        $sHtml .= '<tr>
                    <td align="center" colspan="9" >REPORTE DIRECCION</td>
                </tr>';

        $sHtml .= '<tr>';
        $sHtml .= '<td>Tipo</td>';
        $sHtml .= '<td>Ruta</td>';
        $sHtml .= '<td>Sector</td>';
        $sHtml .= '<td>Barrio</td>';
        $sHtml .= '<td>Direcci&oacute;n</td>';
        $sHtml .= '<td>Referencia</td>';
        $sHtml .= '<td>Editar</td>';
        $sHtml .= '<td>Eliminar</td>';
        $sHtml .= '</tr>';

        //Direcciones
        $sqlDire = "SELECT dire_cod_dire, dire_dir_dire,
                    dire_cod_tipo, dire_cod_vivi, dire_cod_sect,
                    dire_barr_dire, dire_call1_dire, dire_call2_dire,
                    dire_nume_dire, dire_edif_dire, dire_refe_dire,
                    dire_anti_dire, dire_est_dire, dire_id_ruta,
					dire_cod_ruta, dire_cobr_sn
                    from isp.contrato_clpv
                    where dire_cod_clpv = $clpv and
                    dire_cod_empr = $idempresa and
                    dire_cod_contr = $idContrato";
        //$oReturn->alert($sqlDire);
        if ($oIfx->Query($sqlDire)) {
            if ($oIfx->NumFilas() > 0) {
                do {
                    $dire_cod_dire = $oIfx->f('dire_cod_dire');
                    $dire_cod_tipo = $oIfx->f('dire_cod_tipo');
                    $dire_dir_dire = $oIfx->f('dire_dir_dire');
                    $dire_refe_dire = $oIfx->f('dire_refe_dire');
                    $dire_call1_dire = $oIfx->f('dire_call1_dire');
                    $dire_call2_dire = $oIfx->f('dire_call2_dire');
                    $dire_cod_sect = $oIfx->f('dire_cod_sect');
                    $dire_barr_dire = $oIfx->f('dire_barr_dire');
                    $dire_nume_dire = $oIfx->f('dire_nume_dire');
                    $dire_est_dire = $oIfx->f('dire_est_dire');
                    $dire_id_ruta = $oIfx->f('dire_id_ruta');
                    $dire_cod_ruta = $oIfx->f('dire_cod_ruta');
                    $dire_cobr_sn = $oIfx->f('dire_cobr_sn');

                    $imgEditar = '';
                    if ($dire_est_dire == 'A') {
                        $imgEditar = '<div class="btn btn-warning btn-sm" onclick="editarDireccion(' . $dire_cod_dire . ');">
                                            <span class="glyphicon glyphicon-pencil"></span>
                                        </div>';

                        $imgEliminar = '<div class="btn btn-danger btn-sm" onclick="eliminarEntidad(' . $dire_cod_dire . ', 1);">
                                            <span class="glyphicon glyphicon-remove"></span>
                                        </div>';
                    }

                    //rutas
                    $ruta = '';
                    if (!empty($dire_id_ruta)) {
                        $sql = "SELECT concat(codigo, ' | ', nombre) as ruta from isp.int_rutas WHERE id = $dire_id_ruta";
                        $ruta = consulta_string_func($sql, 'ruta', $oCon, '');
                    }

                    $sHtml .= '<tr>';
                    $sHtml .= '<td align="left">' . $arrayTipoDire[$dire_cod_tipo] . '</td>';
                    $sHtml .= '<td align="left">' . $ruta . ' - ' . $dire_cod_ruta . '</td>';
                    $sHtml .= '<td align="left">' . $arraySector[$dire_cod_sect] . '</td>';
                    $sHtml .= '<td align="left">' . $arrayBarrio[$dire_barr_dire] . '</td>';
                    $sHtml .= '<td align="left">' . $dire_dir_dire . '</td>';
                    $sHtml .= '<td align="left">' . $dire_refe_dire . '</td>';
                    $sHtml .= '<td align="center">' . $imgEditar . '</td>';
                    $sHtml .= '<td align="center">' . $imgEliminar . '</td>';
                    $sHtml .= '</tr>';
                } while ($oIfx->SiguienteRegistro());
            }
        }
        $oIfx->Free();

        $sHtml .= '</table>';

        $oReturn->assign("divReporteDireccion", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function reporteDireCliente($aForm = '')
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon1 = new Dbo;
    $oCon1->DSN = $DSN;
    $oCon1->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de sesion
    unset($_SESSION['ARRAY_CLPV_EMAI']);
    $idempresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        //lectura sucia
        //

        //sector direccion
        $sql = "select id, sector from comercial.sector_direccion";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arraySector);
                do {
                    $arraySector[$oCon->f('id')] = $oCon->f('sector');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        //barrio direccion
        $sql = "select id, barrio from isp.int_barrio";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayBarrio);
                do {
                    $arrayBarrio[$oCon->f('id')] = $oCon->f('barrio');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "select id, tipo from comercial.tipo_direccion";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayTipoDire);
                do {
                    $arrayTipoDire[$oCon->f('id')] = $oCon->f('tipo');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml .= '<table class="table table-bordered table-striped table-condensed" style="width: 98%; margin-top: 10px;" align="center">';
        $sHtml .= '<tr>
                    <td align="center" colspan="9" >REPORTE DIRECCIONES</td>
                </tr>';

        $sHtml .= '<tr>';
        $sHtml .= '<td>Ruta</td>';
        $sHtml .= '<td>Sector</td>';
        $sHtml .= '<td>Barrio</td>';
        $sHtml .= '<td>Direcci&oacute;n</td>';
        $sHtml .= '<td>Referencia</td>';
        $sHtml .= '</tr>';

        //Direcciones
        $sqlDire = "SELECT id_ruta, id_sector,
                    id_barrio, direccion, referencia
                    from isp.contrato_clpv
                    where id = $idContrato";
        //$oReturn->alert($sqlDire);
        if ($oCon->Query($sqlDire)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id_ruta = $oCon->f('id_ruta');
                    $id_sector = $oCon->f('id_sector');
                    $id_barrio = $oCon->f('id_barrio');
                    $direccion = $oCon->f('direccion');
                    $referencia = $oCon->f('referencia');

                    $imgEditar = '<div class="btn btn-warning btn-sm" onclick="editarDireccion(' . $idContrato . ');">
                                            <span class="glyphicon glyphicon-pencil"></span>
                                        </div>';

                    //rutas
                    $ruta = '';
                    if (!empty($id_ruta)) {
                        $sql = "SELECT concat(codigo, ' | ', nombre) as ruta from isp.int_rutas WHERE id = $id_ruta";
                        $ruta = consulta_string_func($sql, 'ruta', $oCon1, '');
                    }

                    $sHtml .= '<tr>';
                    $sHtml .= '<td align="left">' . $ruta . '</td>';
                    $sHtml .= '<td align="left">' . $arraySector[$id_sector] . '</td>';
                    $sHtml .= '<td align="left">' . $arrayBarrio[$id_barrio] . '</td>';
                    $sHtml .= '<td align="left">' . $direccion . '</td>';
                    $sHtml .= '<td align="left">' . $referencia . '</td>';
                    $sHtml .= '</tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml .= '</table>';

        $oReturn->assign("divReporteDireccion", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cargarPoste($aForm = '', $id = 0)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $sectorDire = $aForm['sectorDire'];
    $barrioDire = $aForm['barrioDire'];

    $sql = "select id, poste 
			from isp.int_postes 
			where id_empresa = $idempresa and
			id_sector = $sectorDire and 
			id_barrio = $barrioDire 
			order by 2";
    $i = 1;
    if ($oCon->Query($sql)) {
        $oReturn->script('eliminar_lista_poste();');
        if ($oCon->NumFilas() > 0) {
            do {
                $oReturn->script(('anadir_elemento_poste(' . $i++ . ',\'' . $oCon->f('id') . '\', \'' . $oCon->f('poste') . '\' )'));
            } while ($oCon->SiguienteRegistro());
        }
    }
    $oCon->Free();

    return $oReturn;
}

function cargarCaja($aForm = '', $id = 0)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $posteDire = $aForm['posteDire'];

    $sql = "select id, caja 
			from isp.int_caja
			where id_empresa = $idempresa and
			id_poste = $posteDire
			order by 2";
    $i = 1;
    if ($oCon->Query($sql)) {
        $oReturn->script('eliminar_lista_caja();');
        if ($oCon->NumFilas() > 0) {
            do {
                $oReturn->script(('anadir_elemento_caja(' . $i++ . ',\'' . $oCon->f('id') . '\', \'' . $oCon->f('caja') . '\' )'));
            } while ($oCon->SiguienteRegistro());
        }
    }
    $oCon->Free();

    return $oReturn;
}

function cargarPuerto($aForm = '', $id = 0)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $cajaDire = $aForm['cajaDire'];

    $sql = "select id, puerto 
			from isp.int_caja_det
			where 
			id_caja = $cajaDire and
			estado = 'P'
			order by 2";
    $i = 1;
    if ($oCon->Query($sql)) {
        $oReturn->script('eliminar_lista_puerto();');
        if ($oCon->NumFilas() > 0) {
            do {
                $oReturn->script(('anadir_elemento_puerto(' . $i++ . ',\'' . $oCon->f('id') . '\', \'' . $oCon->f('puerto') . '\' )'));
            } while ($oCon->SiguienteRegistro());
        }
    }
    $oCon->Free();

    return $oReturn;
}

function reporteContratoCliente($aForm = '')
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oConA = new Dbo;
    $oConA->DSN = $DSN;
    $oConA->Conectar();

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de sesion
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $codigoCliente = $aForm['codigoCliente'];
    $fechaHoy = date("Y-m-d");

    try {

        $sHtml .= '<table class="table table-bordered table-striped table-condensed" style="width: 98%; margin-top: 10px;" align="center">';
        $sHtml .= '<tr>
                        <td align="left" colspan="16">
							<div class="btn btn-success btn-sm" onclick="reporteContratoCliente();">
								<span class="glyphicon glyphicon-refresh"></span>
								Actualizar
							</div> 
						</td>
                    </tr>';
        $sHtml .= '<tr>
                        <td align="left" colspan="16" class="bg-primary">REPORTE CONTRATO CLIENTE</td>
                    </tr>';
        $sHtml .= '<tr>
						<td>ID</td>
                        <td>CODIGO</td>
						<td>DIRECCION</td>
                        <td>FECHA CONTRATO</td>
                        <td>FECHA FIRMA</td>
                        <td>DIA CORTE</td>
                        <td>DIA COBRO</td>
						<td>COBRO</td>
                        <td>DURACION</td>
                        <td>PENALIDAD</td>
                        <td>USUARIO</td>
						<td>TARIFA</td>
						<td>DEUDA</td>
						<td>ESTADO</td>
                        <td>E-CUENTA</td>
						<td>IMPRIMIR</td>
                    </tr>';
        //Direcciones
        $sqlContrato = "select id, id_sucursal, fecha_contrato, fecha_firma, duracion, penalidad,
                        user_web, estado, fecha_corte, fecha_cobro, codigo, direccion,
                        cobro_directo, id_dire, tarifa
                        from isp.contrato_clpv
                        where id_empresa = $idempresa and
                        id_clpv = $codigoCliente";
        //$oReturn->alert($sqlDire);
        if ($oCon->Query($sqlContrato)) {
            if ($oCon->NumFilas() > 0) {
                $i = 1;
                do {
                    $id = $oCon->f('id');
                    $fecha_contrato = $oCon->f('fecha_contrato');
                    $id_sucursal = $oCon->f('id_sucursal');
                    $fecha_firma = $oCon->f('fecha_firma');
                    $fecha_corte = $oCon->f('fecha_corte');
                    $fecha_cobro = $oCon->f('fecha_cobro');
                    $duracion = $oCon->f('duracion');
                    $penalidad = $oCon->f('penalidad');
                    $user_web = $oCon->f('user_web');
                    $estado = $oCon->f('estado');
                    $codigo = $oCon->f('codigo');
                    $id_dire = $oCon->f('id_dire');
                    $cobro_directo = $oCon->f('cobro_directo');
                    $direccion = $oCon->f('direccion');
                    $tarifa = $oCon->f('tarifa');

                    //nombre usuario
                    $sqlUser = "select concat(usuario_apellido, ' ', usuario_nombre) as nombre from comercial.usuario where usuario_id = $user_web";
                    $nombre = consulta_string_func($sqlUser, 'nombre', $oConA, '');

                    $disabledFecha = 'disabled';
                    $imgImprimir = '';
                    $classEstado = '';
                    if ($estado == 'PE') {
                        $classEstado = 'bg-info';
                        $disabledFecha = 'enabled';
                    } elseif ($estado == 'AP') {
                        $classEstado = 'bg-success';
                        $imgImprimir = '<div class="btn btn-success btn-sm" onclick="imprimirContrato(' . $id . ');">
											<span class="glyphicon glyphicon-print"></span>
										</div>';
                    } elseif ($estado == 'RE') {
                        $classEstado = 'bg-danger';
                    }

                    $classContratos = new Contratos($oConA, $oIfx, $idempresa, $id_sucursal, $codigoCliente, $id);
                    $valorDeuda = $classContratos->consultaMontoMesAdeuda();

                    $sHtml .= '<tr>';
                    $sHtml .= '<td align="left">' . $id . '</td>';
                    $sHtml .= '<td align="left">' . $codigo . '</td>';
                    $sHtml .= '<td align="left">' . $direccion . '</td>';
                    $sHtml .= '<td align="left">' . fecha_mysql_dmy($fecha_contrato) . '</td>';
                    $sHtml .= '<td align="left">' . fecha_mysql_dmy($fecha_firma) . '</td>';
                    $sHtml .= '<td align="right">' . $fecha_corte . '</td>';
                    $sHtml .= '<td align="right">' . $fecha_cobro . '</td>';
                    $sHtml .= '<td align="center">' . $cobro_directo . '</td>';
                    $sHtml .= '<td align="right">' . $duracion . ' (Meses)</td>';
                    $sHtml .= '<td align="right">' . $penalidad . ' %</td>';
                    $sHtml .= '<td align="left">' . $nombre . '</td>';
                    $sHtml .= '<td align="right">' . number_format($tarifa, 2, '.', ',') . '</td>';
                    $sHtml .= '<td align="right">' . number_format($valorDeuda, 2, '.', ',') . '</td>';
                    $sHtml .= '<td class="' . $classEstado . '" align="center">' . $estado . '</td>';
                    $sHtml .= '<td align="center">
                                    <div class="btn btn-warning btn-sm" onclick="estadoCuentaContrato(' . $id . ');">
                                        <span class="glyphicon glyphicon-list-alt"></span>
                                    </div>
                                </td>';
                    $sHtml .= '<td align="center">' . $imgImprimir . '</td>';
                    $sHtml .= '</tr>';
                    $i++;
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml .= '</table>';


        $oReturn->assign("divReporteContrato", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}


function cxc_det_form($id_clpv, $id_contrato, $aForm = '')
{
    global $DSN, $DSN_Ifx;
    session_start();

    $oIfx = new Dbo();
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $oReturn = new xajaxResponse();

    // ESTADO DE CUENTA
    $html_cxc .= ' <table class="table table-striped table-condensed table-bordered table-hover" style="width: 98%; margin-top: 20px;" align="center">
                    <tr>
                        <td class="fecha_letra">No-</td>
						<td class="fecha_letra" align="center">Fecha</td>
                        <td class="fecha_letra" align="center">Detalle</td>
                        <td class="fecha_letra" align="center">Periodo Consumo</td> 
						<td class="fecha_letra" align="center">Valor</td>
                    </tr>';
    $sql = "SELECT P.COD_PROD, P.FECHA, C.ANIO, C.MES, P.DETALLE,  P.TARIFA AS CREDITO, 'CRE' AS TIPO, 0 AS ORDEN, 0 as id_factura
                    from isp.contrato_PAGO_PACK P ,isp.contrato_PAGO C WHERE
                    C.ID	      = P.ID_PAGO AND
                    C.ID_CLPV     = P.ID_CLPV AND
                    C.ID_CONTRATO = P.ID_CONTRATO AND
                    P.ID_CONTRATO = $id_contrato AND 
                    P.ID_CLPV     = $id_clpv
                    
                    UNION
                    
                    SELECT 'PAGO FC' AS COD_PROD,  C.FECHA, C.ANIO, C.MES, C.DETALLE, F.VALOR AS DEBITO , 'DEB' AS TIPO, 1 AS ORDEN, F.ID_FACTURA
                    from isp.contrato_FACTURA F,isp.contrato_PAGO C  WHERE
                    C.ID          = F.ID_PAGO AND
                    C.ID_CLPV     = F.ID_CLPV AND
                    C.ID_CONTRATO = F.ID_CONTRATO AND
                    F.ID_CONTRATO = $id_contrato AND 
                    F.ID_CLPV     = $id_clpv
                    ORDER BY 2, ORDEN ASC; ";
    $i = '1';
    if ($oCon->Query($sql)) {
        if ($oCon->NumFilas() > 0) {
            do {
                $cod_prod = $oCon->f('cod_prod');
                $fecha = $oCon->f('fecha');
                $anio = $oCon->f('anio');
                $mes = Mes_func($oCon->f('mes'));
                $credito = $oCon->f('credito');
                $tipo = $oCon->f('tipo');
                $detalle = $oCon->f('detalle');
                $id_factura = $oCon->f('id_factura');

                $factura = '';
                if ($id_factura == 0) {
                    $sql = "select prod_nom_prod from saeprod where prod_cod_empr = $idempresa and prod_cod_prod = '$cod_prod' ";
                    $cod_prod = consulta_string_func($sql, 'prod_nom_prod', $oIfx, 0);
                } else {
                    $sql = "select fact_num_preimp from saefact where fact_cod_empr = $idempresa and fact_cod_fact = $id_factura ";
                    $factura = '# ' . consulta_string_func($sql, 'fact_num_preimp', $oIfx, '');
                }

                if (!empty($detalle)) {
                    $cod_prod = $detalle;
                }

                $html_cxc .= '<tr height="20" style="cursor: pointer">';
                $html_cxc .= '<td>' . $i . '</td>';
                $html_cxc .= '<td>' . $fecha . '</td>';
                $html_cxc .= '<td>' . $cod_prod . '' . $factura . '</td>';
                $html_cxc .= '<td>' . $mes . ' / ' . $anio . '</td>';
                $html_cxc .= '<td align="right">' . $credito . '</td>';
                $html_cxc .= '</tr>';

                $i++;
            } while ($oCon->SiguienteRegistro());
        }
    }
    $oCon->Free();

    $html_cxc .= ' </table>';

    $sHtml = '<div class="modal-dialog modal-lg" style="width: 90%; height: :90%;">
                    <form id="formtec" name="formtec" method="post">
                        <div class="modal-content">
                            <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">ESTADO DE CUENTA DETALLADO</h4>
                            </div>
                            <div class="modal-body">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="col-md-4">
                                        <label for="fecha_ini_cxc" class="control-label">* Fecha Inicio:</label>
                                        <input type="date" name="fecha_ini_cxc" step="1" value="' . date("Y-m-d") . '" class="form-control input-sm"> 
                                    </div>

                                    <div class="col-md-4">
                                        <label for="fecha_fin_cxc" class="control-label">* Fecha Fin:</label>
                                        <input type="date" name="fecha_fin_cxc" step="1" value="' . date("Y-m-d") . '" class="form-control input-sm"> 
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12" id="cxc_html">
                                    ' . $html_cxc . '
                            </div>';
    $sHtml .= '          </div>
                    </form>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger btn" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
             </div>';

    $oReturn->script("$('#miModalCxc').modal('show')");
    $oReturn->assign("miModalCxc", "innerHTML", $sHtml);

    return $oReturn;
}

function genera_correo($idempresa, $clpv_cod, $idcontrato, $idpago)
{
    global $DSN, $DSN_Ifx;
    session_start();

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo();
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    $idsucursal = $_SESSION['U_SUCURSAL'];

    //clases contratos
    $Contratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $clpv_cod, $idcontrato);

    $arrayContrato = $Contratos->consultarContrato();
    $telefono = $Contratos->consultaTelefonos();
    $correo = $Contratos->consultaEmail();

    foreach ($arrayContrato as $val) {
        $id = $val[0];
        $id_empresa = $val[1];
        $id_sucursal = $val[2];
        $id_clpv = $val[3];
        $id_ciudad = $val[4];
        $codigo = $val[5];
        $nom_clpv = $val[6];
        $ruc_clpv = $val[7];
        $fecha_contrato = $val[8];
        $fecha_firma = $val[9];
        $fecha_corte = $val[10];
        $fecha_cobro = $val[11];
        $duracion = $val[12];
        $penalidad = $val[13];
        $estado = $val[14];
        $vendedor = $val[15];
        $user_web = $val[16];
        $fecha_server = $val[17];
        $tarifa = $val[18];
        $id_dire = $val[19];
        $saldo_mora = $val[20];
        $fecha_instalacion = $val[21];
        $detalle = $val[22];
        $sobrenombre = $val[23];
        $limite = $val[24];
        $cobrador = $val[25];
        $tipo_contrato = $val[26];
        $cheque_sn = $val[27];
        $cobro_directo = $val[28];
        $id_sector = $val[29];
        $id_barrio = $val[30];
        $direccion = $val[31];
        $referencia = $val[32];
        $telef = $val[33];
        $email = $val[34];
        $latitud = $val[35];
        $longitud = $val[36];
        $abonado = $val[37];
        $estado_tmp = $val[38];
        $nombre = $val[39];
        $apellido = $val[40];
        $foto = $val[41];
        $observaciones = $val[42];
        $tipo_duracion = $val[43];
        $fecha_c_vence = $val[44];
        $estadoNombre = $val[45];
        $estadoClass = $val[46];
        $sector = $val[47];
        $barrio = $val[48];
        $tipoContrato = $val[49];
        $vend_nom_vend = $val[50];
        $nom_cobrador = $val[51];
        $estadoColor = $val[52];
        $tipo_ncf = $val[53];
        $tarifa_e = $val[54];
        $descuento_p = $val[55];
        $descuento_v = $val[56];
    } // fin

    $html = '<div class="modal-dialog modal-ms">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">ENVIO CORREO</h4>
                    </div>
                    <div class="modal-body">                                   
                        <div class="form-row">    
                            <table class="table table-striped table-condensed" style="width: 98%; margin-bottom: 0px;" align="center">		
                                <tr height="25">
                                    <td><label  class="control-label">Cliente:</label></td>
                                    <td class="fecha_letra">' . $nom_clpv . '</td>
                                </tr>
                                <tr height="25">
                                    <td>Correo:</td>
                                    <td class="fecha_letra">
                                        <input type="text" class="form-control input-sm" id="correo_mod" name="correo_mod" style="text-align:right" value="' . $correo . '" />
                                    </td>
                                </tr>
								<tr>
									<td>Recibo Pago:</td>
									<td>
										 <div class="input-group">
											<input type="radio" aria-label="..." checked>
										</div>
									</td>
								</tr>
                            </table>
                        </div>

                    </div>
                    <div class="modal-footer">   
                        <button type="button" class="btn btn-primary" onclick="procesar_correo(' . $idempresa . ', ' . $clpv_cod . ',  ' . $idcontrato . ',  ' . $idpago . ')">Procesar</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>     ';

    $oReturn->assign("miModalCorreo", "innerHTML", $html);

    return $oReturn;
}

function genera_pdf_esta_cta($idempresa, $clpv_cod, $idcontrato, $idpago)
{
    session_start();
    global $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de session
    unset($_SESSION['pdf']);
    $_SESSION['pdf'] = genera_pdf_esta_cta_int2($idempresa, $clpv_cod, $idcontrato, $idpago);
    $oReturn->script('generar_pdf_int()');

    return $oReturn;
}

function procesar_correo($idempresa, $clpv_cod, $idcontrato, $idpago, $aForm = '')
{
    session_start();
    global $DSN_Ifx, $DSN;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo();
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    $idEmpresa = $_SESSION['U_EMPRESA'];
    $correo = trim($aForm['correo_mod']);

    //variables de session
    /*unset($_SESSION['pdf']);
    $_SESSION['pdf'] = genera_pdf_esta_cta_int2($idempresa, $clpv_cod, $idcontrato, $idpago);
    $documento = $_SESSION['pdf'];

    /*$html2pdf = new HTML2PDF('P', 'A3', 'fr');
    $html2pdf->setTestTdInOnePage(false);
    $html2pdf->WriteHTML($documento);
    $html2pdf->Output('documento.pdf', 'F');

    $dompdf = new DOMPDF();
    //$dompdf->set_paper("A4", "portrait");
    $dompdf->load_html(($documento));
    $dompdf->render();
    $pdf = $dompdf->output();
    file_put_contents("documento.pdf", $pdf);*/

    $sql = "SELECT id_time FROM config_email c, doc_time t WHERE
                t.id_time   = c.id_tipo and
                t.documento = 'ESTADO CUENTA CABLE' ";
    $id_tipo = consulta_string_func($sql, 'id_time', $oCon, '1');
    $title = 'ESTADO DE CUENTA';

    $sql = "select clpv_nom_clpv from saeclpv where clpv_cod_empr = $idEmpresa and clpv_cod_clpv = $clpv_cod ";
    $nom_clpv = consulta_string_func($sql, 'clpv_nom_clpv', $oIfx, 'SN');

    $sql = "select id, fecha, secuencial, estado, dias,
                    estado_fact, id_factura, estado, mes, anio,
                    tarifa, abono, valor_pago, can_add, pre_add,
                    tot_add, valor_uso, valor_no_uso, dias_uso,
                    dias_no_uso , id_factura
                    from isp.contrato_pago
                    where id_clpv = $clpv_cod and
                    id_contrato   = $idcontrato and
                    id            = $idpago";
    $msn_secu = '';
    if ($oCon->Query($sql)) {
        $msn_secu = Mes_func($oCon->f("mes")) . ' - ' . $oCon->f("anio");
        $id_factura = $oCon->f("id_factura");
        $id_pago = $oCon->f("id");
    }
    $oCon->Free();

    $sql = "SELECT c.id_factura from isp.contrato_factura c WHERE c.id_contrato = $idcontrato AND c.id_pago = $id_pago ";
    $id_factura = consulta_string_func($sql, 'id_factura', $oCon, '0');

    //$oReturn->alert($correo.'--'.$nom_clpv);
    $correo_adj = envio_correo_int($correo, $nom_clpv, $id_factura);

    $oReturn->alert($correo_adj);

    return $oReturn;
}

function estadoCuentaContrato($aForm = '', $id = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oReturn = new xajaxResponse();

    try {

        $oIfx = new Dbo;
        $oIfx->DSN = $DSN_Ifx;
        $oIfx->Conectar();

        $oCon = new Dbo;
        $oCon->DSN = $DSN;
        $oCon->Conectar();

        //variables de sesion
        $idempresa = $_SESSION['U_EMPRESA'];
        $idsucursal = $_SESSION['U_SUCURSAL'];

        //variables del formulario
        $id_clpv = $aForm['codigoCliente'];

        //clases contratos
        $Contratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $id_clpv, $id);

        $sHtml = $Contratos->detalleContrato(0);

        $oReturn->assign('miModal', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function estadoCuentaContratoDisp($id_contrato)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oReturn = new xajaxResponse();

    try {

        $oIfx = new Dbo;
        $oIfx->DSN = $DSN_Ifx;
        $oIfx->Conectar();

        $oCon = new Dbo;
        $oCon->DSN = $DSN;
        $oCon->Conectar();

        //variables de sesion
        $idempresa = $_SESSION['U_EMPRESA'];
        $idsucursal = $_SESSION['U_SUCURSAL'];

        $sql = "SELECT id_clpv from isp.contrato_clpv where id = $id_contrato";
        $id_clpv = consulta_string_func($sql, 'id_clpv', $oIfx, '');

        //clases contratos
        $Contratos = new Contratos($oCon, $oIfx, $idempresa, $idsucursal, $id_clpv, $id_contrato);

        $sHtml = $Contratos->detalleContrato(0);

        $oReturn->assign('miModalContratosDisp', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cargarSecuencial($grupo = '')
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de sesion
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];


    try {

        //lectura sucia
        ////

        //iniciales grpv
        $sql = "select grpv_ini_grpv from saegrpv where grpv_cod_grpv = '$grupo'";
        $grpv_ini_grpv = consulta_string_func($sql, 'grpv_ini_grpv', $oIfx, '');

        //cliente
        $sql = "select max(clpv_cod_char) as secuencial
                from saeclpv 
                where clpv_cod_empr = $idempresa and 
                clpv_clopv_clpv = 'CL' and
                grpv_cod_grpv = '$grupo'";
        //$oReturn->alert($sql);
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                $secuencial = $oIfx->f('secuencial');
            }
        }
        $oIfx->Free();

        //numero de caracteres
        $secuencialNew = intval(preg_replace('/[^0-9]+/', '', $secuencial), 10);
        //$secuencialNew++;

        $numCaraceter_0 = strlen($grpv_ini_grpv);
        $numCaraceter_1 = strlen($secuencialNew);
        $numeroRelleno = $numCaraceter_0 + $numCaraceter_1;

        $ceros = secuencial(2, '', $secuencialNew, 11 - $numeroRelleno);

        $secuencialClpv = $grpv_ini_grpv . '-' . $ceros;

        return $secuencialClpv;
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function updateContrato($aForm = '', $id = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $empresa = $_SESSION['U_EMPRESA'];
    $usuario_web = $_SESSION['U_ID'];

    //variables del formulario
    $clpv = $aForm['codigoCliente'];
    $codigo = $aForm['numContrato_' . $id];
    $direccion = $aForm['direContrato_' . $id];
    $fecha_contrato = $aForm['fecha_contrato_' . $id];
    $fecha_firma = $aForm['fecha_firma_' . $id];
    $fecha_corte = $aForm['fecha_corte_' . $id];
    $fecha_cobro = $aForm['fecha_cobro_' . $id];
    $tipo_cobro = $aForm['tipo_cobro_' . $id];

    try {

        // commit
        $oCon->QueryT('BEGIN;');

        $sql = "update isp.contrato_clpv set codigo = '$codigo', 
										id_dire = '$direccion',
										cobro_directo = '$tipo_cobro'";
        if (!empty($fecha_contrato)) {
            $sql .= " , fecha_contrato = '$fecha_contrato',
					fecha_firma = '$fecha_firma',
					fecha_corte = '$fecha_corte',
					fecha_cobro = '$fecha_cobro'";
        }

        $sql .= " where id = $id and id_empresa = $empresa";

        $oCon->QueryT($sql);

        $oReturn->alert('Contrato Modificado Correctamente..!');
        $oReturn->script('reporteContratoCliente();');

        $oCon->QueryT('COMMIT;');
    } catch (Exception $e) {
        // rollback
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function getEmpresaLogo($idEmpresa)
{
    global $DSN_Ifx;

    $oIfxLogin = new Dbo();
    $oIfxLogin->DSN = $DSN_Ifx;
    $oIfxLogin->Conectar();

    $sql = "select empr_path_logo from saeempr where empr_cod_empr = $idEmpresa ";
    if ($oIfxLogin->Query($sql)) {
        if ($oIfxLogin->NumFilas() > 0) {
            $rutaImagen = $oIfxLogin->f('empr_path_logo');
            $rutaImagen = str_replace(' ', '%20', $rutaImagen);

            $rutaImagen = "logos/" . basename($rutaImagen);


            return $rutaImagen;
        }
    } else
        return false;
    $oIfxLogin->Free();
}

function convertir_png_a_base64($path = '')
{
    $data = '';
    $type = pathinfo($path, PATHINFO_EXTENSION);
    $data = file_get_contents($path);
    $base64 = 'data:image/' . $type . ';base64,' . base64_encode($data);
    return $base64;
}

function imprimirContrato($aForm = '', $id_tip_contr, $formato)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();


    $oCon1 = new Dbo;
    $oCon1->DSN = $DSN;
    $oCon1->Conectar();


    $oCon2 = new Dbo;
    $oCon2->DSN = $DSN;
    $oCon2->Conectar();

    $oCon3 = new Dbo;
    $oCon3->DSN = $DSN;
    $oCon3->Conectar();

    $oCon4 = new Dbo;
    $oCon4->DSN = $DSN;
    $oCon4->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oIplan = new Dbo;
    $oIplan->DSN = $DSN_Ifx;
    $oIplan->Conectar();

    $oReturn = new xajaxResponse();
    unset($_SESSION['pdf']);
    unset($_SESSION['pdf_2']);

    //variables de sesion
    $empresa        = $_SESSION['U_EMPRESA'];
    $idsucursal     = $_SESSION['U_SUCURSAL'];
    $usuario_web    = $_SESSION['U_ID'];
    $id             = $aForm['idContrato'];
    $tipo           = $aForm['tipo'];

    //variables del formulario
    $clpv           = $aForm['codigoCliente'];

    //DATOS DE LA EMPRESA
    $sql = "SELECT * from saeempr where empr_cod_empr='$empresa'";
    $empr_repres        = consulta_string($sql, 'empr_repres', $oIfx, '');
    $ced_repres         = consulta_string($sql, 'empr_ced_repr', $oIfx, '');
    $empr_cod_ciud      = consulta_string($sql, 'empr_cod_ciud', $oIfx, 0);
    $empr_path_logo     = consulta_string($sql, 'empr_path_logo', $oIfx, '');
    $direccionempr      = consulta_string($sql, 'empr_dir_empr', $oIfx, '');
    $empr_nom_empr      = consulta_string($sql, 'empr_nom_empr', $oIfx, '');
    $empr_ruc_empr      = consulta_string($sql, 'empr_ruc_empr', $oIfx, '');
    $empr_cod_prov      = consulta_string($sql, 'empr_cod_prov', $oIfx, '');
    $empr_cod_cant      = consulta_string($sql, 'empr_cod_cant', $oIfx, '');
    $empr_tel_resp      = consulta_string($sql, 'empr_tel_resp', $oIfx, '');
    $empr_mai_empr      = consulta_string($sql, 'empr_mai_empr', $oIfx, '');
    $empr_cel_empr      = consulta_string($sql, 'empr_fax_empr', $oIfx, '');
    $empr_fec_resu      = consulta_string($sql, 'empr_fec_resu', $oIfx, '');
    $empr_nomcome_empr  = consulta_string($sql, 'empr_nomcome_empr', $oIfx, '');


    $sql = "SELECT sucu_dir_sucu, sucu_telf_secu,sucu_email_secu, sucu_fax_secu, sucu_nom_sucu from saesucu where sucu_cod_sucu='$idsucursal'";
    $sucu_dir_sucu        = consulta_string($sql, 'sucu_dir_sucu', $oIfx, '');
    $sucu_telf_secu       = consulta_string($sql, 'sucu_telf_secu', $oIfx, '');
    $sucu_email_secu      = consulta_string($sql, 'sucu_email_secu', $oIfx, '');
    $sucu_fax_secu        = consulta_string($sql, 'sucu_fax_secu', $oIfx, '');
    $sucu_nom_secu        = consulta_string($sql, 'sucu_nom_sucu', $oIfx, '');

    $path_img = explode("/", $empr_path_logo);
    $count = count($path_img) - 1;

    $path_logo_img = DIR_FACTELEC . 'Include/Clases/Formulario/Plugins/reloj/' . $path_img[$count];


    // $path_logo_img = '';
    if ($path_logo_img != '') {
        $empr_logo = '<img src="' . $path_logo_img . '" style="width:100px;">';
    } else {
        $empr_logo = '<span><font color="red">SIN LOGO</font></span>';
    }

    /// RUBRICA DE EMPRESA 
    $path_rubr = DIR_FACTELEC . 'imagenes/isp_digital/firma/rubrica.png'; //

    //echo $path_rubr; exit;
    //$path_rubr = '';
    if ($path_rubr != '') {
        $empr_rub = '<img src="' . $path_rubr . '" style="width:150px;">';
        $empr_rub_cv = '<img src="' . $path_rubr . '" style="width:100px;">';
    } else {
        $empr_rub = '<span><font color="red">SIN LOGO</font></span>';
        $empr_rub_cv = '<span><font color="red">SIN LOGO</font></span>';
    }
    //////////////////////////////////////////////////////////////////////////////

    //IMAGENES CABLE SELVA
    $img_base_path = DIR_FACTELEC . 'modulos/int_clientes/images/';

    $img_cable_selva_header = $img_base_path . 'cable_selva/bg_header.png';
    $img_cable_selva_body   = $img_base_path . 'cable_selva/bg_body.png';
    $img_cable_selva_footer = $img_base_path . 'cable_selva/bg1_3.png';
    $img_cable_selva_footer = $img_base_path . 'cable_selva/bg1_3.png';

    $img_cable_vision_promo_parte1 = $img_base_path . 'cablevision/step1.jpg';
    $img_cable_vision_promo_parte2 = $img_base_path . 'cablevision/step2.jpg';


    //////////////////////////////////////////////////////////////////////////////

    //IMAGENES PERU
    $serv = DIR_FACTELEC . 'modulos/int_clientes/images/peru/serv.jpeg';
    $serv_1 = $serv;

    //LOGO ANEXO PERU
    $img_logo_anexo = $path_logo_img;

    //IMG1 PERU
    $img_1 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/1.png';
    //IMG2 PERU
    $img_2 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/2.jpg';
    //IMG3 PERU
    $img_3 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/3.jpg';
    //IMG4 PERU
    $img_4 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/4.png';
    //IMG5 PERU
    $img_5 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/5.png';
    //IMG6 PERU
    $img_6 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/6.png';
    //IMG7 PERU
    $img_7 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/7.png';
    //IMG8 PERU
    $img_8 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/8.jpg';
    //IMG9 PERU
    $img_9 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/9.png';
    //IMG10 PERU
    $img_10 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/10.png';
    //IMG11 PERU
    $img_11 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/11.jpg';
    //IMG12 PERU
    $img_12 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/12.jpeg';
    //IMG13 PERU
    $img_13 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/13.png';
    //IMG14 PERU
    $img_14 = DIR_FACTELEC . 'modulos/int_clientes/images/peru/14.png';

    $wsp_img = DIR_FACTELEC . 'modulos/int_clientes/images/peru/wsp.png';

    $qr  =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/QR.jpg';
    //CABLEVISION CONTRATO
    $check_si   =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/checksi.jpg';
    $check_no   =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/checkno.jpg';
    $ncanalescv =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/canales.jpg';
    $whatspe    =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/WS.jpg';
    $canaleshd  =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/canaleshd.jpg';
    $canalessd  =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/canalessd.jpg';
    $imgoscip1  =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/O1.jpg';
    $imgoscip2  =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/O2.jpg';
    $sign       =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/sign.jpg';
    $cali       =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/cali.jpg';
    $not        =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/not.jpg';
    $dual       =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/dual.jpg';
    $speed      =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/speed.jpg';
    $home       =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/home.jpg';
    $heat       =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/heat.jpg';
    $clud       =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/clud.jpg';
    $play       =  DIR_FACTELEC . 'modulos/int_clientes/images/peru/play.jpg';
    //DATOS DEL CLIENTE


    $sql = "select tipo_contrato,tipo_cliente,fecha_contrato, nom_clpv, direccion, ruc_clpv, email, telefono, celular, id_barrio, codigo, duracion, identificador, referencia, 
    nomb_conjunto, departamento, monto_pago, vendedor, id_clpv, id_provincia, id_canton, id_ciudad, id_parroquia, fecha_corte, tipo_contrato_de_cobro, suscripcion, sobrenombre,
    id_tipo_cont_serv from isp.contrato_clpv where id=$id";
    $fecha_con          = consulta_string($sql, 'fecha_contrato', $oCon, '');
    $nom_clpv           = consulta_string($sql, 'nom_clpv', $oCon, '');
    $fecha_nacimiento   = consulta_string($sql, 'fecha_contrato', $oCon, '');
    $direccion          = consulta_string($sql, 'direccion', $oCon, '');
    $direccion_ref      = consulta_string($sql, 'referencia', $oCon, '');
    $ruc_clpv           = consulta_string($sql, 'ruc_clpv', $oCon, '');
    $email              = consulta_string($sql, 'email', $oCon, '');
    $num_referencia     = consulta_string($sql, 'telefono', $oCon, '');
    $num_celular        = empty(consulta_string($sql, 'celular', $oCon, '')) ? " no tiene" : consulta_string($sql, 'celular', $oCon, '');
    $id_barrio          = consulta_string($sql, 'id_barrio', $oCon, '');
    $codigo             = consulta_string($sql, 'codigo', $oCon, '');
    $duracion           = consulta_string($sql, 'duracion', $oCon, '');
    $codigo_contrato    = consulta_string($sql, 'codigo', $oCon, '');
    $identificador      = consulta_string($sql, 'identificador', $oCon, '');
    $tipo_cliente       = consulta_string($sql, 'tipo_cliente', $oCon, '');
    $tipo_contrato      = consulta_string($sql, 'tipo_contrato', $oCon, '');
    $referencia         = consulta_string($sql, 'referencia', $oCon, '');
    $lugar              = consulta_string($sql, 'nomb_conjunto', $oCon, '');
    $departamento       = consulta_string($sql, 'departamento', $oCon, '');
    $mensualidad        = consulta_string($sql, 'monto_pago', $oCon, '');
    $vendedor           = consulta_string($sql, 'vendedor', $oCon, '');
    $id_clpv            = consulta_string($sql, 'id_clpv', $oCon, '');
    $id_provincia_clpv  = consulta_string($sql, 'id_provincia', $oCon, '');
    $id_canton_clpv     = consulta_string($sql, 'id_canton', $oCon, '');
    $id_ciudad_clpv     = consulta_string($sql, 'id_ciudad', $oCon, '');
    $id_parroquia_clpv  = consulta_string($sql, 'id_parroquia', $oCon, '');
    $fecha_corte        = consulta_string($sql, 'fecha_corte', $oCon, '');
    $tipo_de_cobro      = consulta_string($sql, 'tipo_contrato_de_cobro', $oCon, '');
    $instalacionclpv    = consulta_string($sql, 'suscripcion', $oCon, '');
    $sobrenombreclpv    = consulta_string($sql, 'sobrenombre', $oCon, '');
    $tipo_cont_serv     = consulta_string($sql, 'id_tipo_cont_serv', $oCon, '');

    

    if ($tipo_de_cobro == 'POSTPAGO') {
        //$checkpostpago = $check_si;
        $checkpostpago = '<img class="left" src="' . $check_si . '" width="10"/>';
        $checkprepago = '<img class="left" src="' . $check_no . '" width="10"/>';
    } else if ($tipo_de_cobro == 'PREPAGO') {
        //$checkprepago = $check_si;
        $checkprepago = '<img class="left" src="' . $check_si . '" width="10"/>';
        $checkpostpago = '<img class="left" src="' . $check_no . '" width="10"/>';
    } else {
        $checkpostpago = '<img class="left" src="' . $check_no . '" width="10"/>';
        $checkprepago = '<img class="left" src="' . $check_no . '" width="10"/>';
    }

    $sql_inst_cuot = "SELECT count(id) as contador from isp.int_suscribir where id_contrato = $id and estado != 'AN' and  precio > 0";
    $inst_cuot = intval(consulta_string($sql_inst_cuot, 'contador', $oCon, 0));

    if ($inst_cuot > 1) {
        $nocontado = '<img class="left" src="' . $check_si . '" width="10"/>';
        $contado = '<img class="left" src="' . $check_no . '" width="10"/>';
        $sininst = '<img class="left" src="' . $check_no . '" width="10"/>';
        $sql_precioinst = "SELECT max(precio) AS precio from isp.int_suscribir where id_contrato = $id";
        $precioinstdif  = consulta_string($sql_precioinst, 'precio', $oCon, '');
    } else if ($inst_cuot == 1) {
        $nocontado = '<img class="left" src="' . $check_no . '" width="10"/>';
        $contado = '<img class="left" src="' . $check_si . '" width="10"/>';
        $sininst = '<img class="left" src="' . $check_no . '" width="10"/>';
        $sql_precioinst = "SELECT max(precio) AS precio from isp.int_suscribir where id_contrato = $id";
        $precioinstcont  = consulta_string($sql_precioinst, 'precio', $oCon, '');
    } else {
        $nocontado = '<img class="left" src="' . $check_no . '" width="10"/>';
        $contado = '<img class="left" src="' . $check_no . '" width="10"/>';
        $sininst = '<img class="left" src="' . $check_si . '" width="10"/>';
    }

    $sql_referencias = "SELECT nombre from isp.contrato_referencia where id_contrato = $id";
    $referencia_parient  = consulta_string($sql_referencias, 'nombre', $oCon, '');

    if ($tipo_cont_serv == 1) {
        $id_serv_empr = '<b>X</b>';
    } else if ($tipo_cont_serv == 2) {
        $id_serv_hog = '<b>X</b>';
    } else {
        $id_serv_empr = '';
        $id_serv_hog = '';
    }
    
    $sql_tipo  = "SELECT clv_con_clpv, clpv_fec_naci from public.saeclpv where clpv_cod_clpv = $id_clpv";
    $fecha_nacimientocon = consulta_string($sql_tipo, 'clpv_fec_naci', $oCon, '');
    $tipo_iden = consulta_string($sql_tipo, 'clv_con_clpv', $oCon, '');
    if ($tipo_iden == '01') {
        $nat_jur =
            '<table border="1" cellpadding ="1px">
            <tr>
                <td align="center" colspan="6"><b>Persona Jurídica</b></td>
            </tr>
            <tr>
                <td colspan="1" style="width: 100px; height: 20px;">Nombre Comercial</td>
                <td colspan="1" style="width: 100px; height: 20px;">nombreemplco</td>
                <td colspan="1" style="width: 100px; height: 20px;">R:T:N</td>
                <td colspan="1" style="width: 96px; height: 20px;"></td>
                <td colspan="1" style="width: 96px; height: 20px;">Registro mercantil</td>
                <td colspan="1" style="width: 96px; height: 20px;"></td>
            </tr>
            <tr>
                <td colspan="1" style="width: 100px; height: 20px;">Fecha Mercantil</td>
                <td colspan="1" style="width: 100px; height: 20px;">diasco/mesco/anioco</td>
                <td colspan="1" style="width: 100px; height: 20px;">No.Tomo</td>
                <td colspan="1" style="width: 96px; height: 20px;"></td>
                <td colspan="1" style="width: 96px; height: 20px;">Actividad Económica</td>
                <td colspan="1" style="width: 96px; height: 20px;"></td>
            </tr>
            <tr>
                <td colspan="1" style="width: 100px; height: 20px;">Dirección Completa</td>
                <td colspan="5" style="width: 88px; height: 20px;">direemplco direrefemplco</td>
            </tr>
            <tr>
                <td colspan="1" style="width: 100px; height: 20px;">Teléfono</td>
                <td colspan="1" style="width: 100px; height: 20px;">teleemplco</td>
                <td colspan="1" style="width: 100px; height: 20px;">Fax</td>
                <td colspan="1" style="width: 96px; height: 20px;"></td>
                <td colspan="1" style="width: 96px; height: 20px;">Cel</td>
                <td colspan="1" style="width: 96px; height: 20px;"></td>
            </tr>
            <tr>
                <td colspan="1" style="width: 100px; height: 20px;">Nombre del Representante</td>
                <td colspan="2" style="width: 94px; height: 20px;">referenciabo</td>
                <td colspan="1" style="width: 100px; height: 20px;">Cargo Desempeñado</td>
                <td colspan="2" style="width: 94px; height: 20px;"></td>
            </tr>
        </table>
        <br>';

        $espacios = '<br><br><br><br><br><br><br>';
    } else if ($tipo_iden == '02' || $tipo_iden == '03') {
        $nat_jur =
            '<table border="1" cellpadding ="1px">
            <tr>
                <td align="center" colspan="6"><b>Persona Individual</b></td>
            </tr>
            <tr>
                <td colspan="1" style="width: 99px; height: 20px;">Nombre Completo</td>
                <td colspan="1" style="width: 99px; height: 20px;">nombreemplco</td>
                <td colspan="1" style="width: 99px; height: 20px;">R:T:N</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
                <td colspan="1" style="width: 98px; height: 20px;">Estado Civil</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
            </tr>
            <tr>
                <td colspan="1" style="width: 99px; height: 20px;">Número de Identidad</td>
                <td colspan="1" style="width: 99px; height: 20px;">idenco</td>
                <td colspan="1" style="width: 99px; height: 20px;">Nacionalidad</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
                <td colspan="1" style="width: 98px; height: 20px;">Fecha Nacimiento </td>
                <td colspan="1" style="width: 98px; height: 20px;">nacimientoco</td>
            </tr>
            <tr>
                <td colspan="1" style="width: 99px; height: 20px;">Profesión u Oficio </td>
                <td colspan="1" style="width: 99px; height: 20px;"></td>
                <td colspan="1" style="width: 99px; height: 20px;">Ocupación</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
                <td colspan="1" style="width: 98px; height: 20px;">Edad</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
            </tr>
            <tr>
                <td colspan="1" style="width:  97px; height: 20px;">Dirección Completa</td>
                <td colspan="5" style="width: 494px; height: 20px;">direemplco direrefemplco</td>
            </tr>
            <tr>
                <td colspan="1" style="width: 99px; height: 20px;">Teléfono</td>
                <td colspan="1" style="width: 99px; height: 20px;">teleemplco</td>
                <td colspan="1" style="width: 99px; height: 20px;">Fax</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
                <td colspan="1" style="width: 98px; height: 20px;">Cel</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
            </tr>
            <tr>
                <td colspan="1" style="width: 99px; height: 20px;">Casa Propia</td>
                <td colspan="1" style="width: 99px; height: 20px;">Si___ No___ </td>
                <td colspan="1" style="width: 99px; height: 20px;">Propietario del Inmueble</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
                <td colspan="1" style="width: 98px; height: 20px;">Renta Mensual</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
            </tr>
            <tr>
                <td colspan="1" style="width: 99px; height: 20px;">Tiempo de Ocupar el Inmueble</td>
                <td colspan="1" style="width: 99px; height: 20px;">Si___ No___</td>
                <td colspan="1" style="width: 99px; height: 20px;">Tiene familia en USA</td>
                <td colspan="1" style="width: 98px; height: 20px;">Si___No___</td>
                <td colspan="1" style="width: 98px; height: 20px;">Ingresos Mensuales</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
            </tr>
            <tr>
                <td colspan="1" style="width:  97px; height: 20px;">Referencia laboral dentro de la empresa</td>
                <td colspan="5" style="width: 494px; height: 20px;"></td>
            </tr>
            <tr>
                <td colspan="1" style="width: 99px; height: 20px;">Nombre del Conyuge</td>
                <td colspan="1" style="width: 99px; height: 20px;">referenciabo</td>
                <td colspan="1" style="width: 99px; height: 20px;">Ingresos del Cónyuge</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
                <td colspan="1" style="width: 98px; height: 20px;">Donde Labora</td>
                <td colspan="1" style="width: 98px; height: 20px;"></td>
            </tr>
        </table>
        <br>';

        $espacios = '<br>';
    }

    $sql_nom_iden = "SELECT identificacion from comercial.tipo_iden_clpv where tipo = '$tipo_iden'";
    $iden_con_clpv = consulta_string($sql_nom_iden, 'identificacion', $oCon, '');

    // echo $sql;exit;
    $id_caja           = consulta_string($sql, 'id', $oCon, '');

    $sql_tipo_contrato = "select tipo from isp.int_tipo_contrato tc  where tc.id = $tipo_contrato";
    $tipo_contrato_nombre   = consulta_string($sql_tipo_contrato, 'tipo', $oCon, '');

    $sql_plan = "select a.id as id_caja_pack, c.nombre, b.paquete, d.estado, a.precio, a.estado as id_estado, b.id_tipo_prod, d.color, b.egress as v_bajada, b.ingress as v_subida
                FROM isp.int_contrato_caja_pack a INNER JOIN
                        isp.int_paquetes b ON a.id_prod = b.id INNER JOIN
                        isp.int_tipo_prod c ON b.id_tipo_prod = c.id INNER JOIN
                        isp.int_estados_equipo d ON a.estado = d.id
                WHERE 
                        a.id_contrato = $id AND
                        a.id_clpv = $id_clpv AND
                        a.estado NOT IN ('E')";

    $lista_planes_html = '';

    // echo $sql_plan;exit;
    $altura_tipo_plan  = 0;
    $altura_tipo_plan_base  = 33;
    $altura_tipo_plan_base_2  = -45.5;

    $img_pie_altura = -155;
    $rubrico_altura = -165;
    $firma_contrato_altura = -165;
    $datos_clpv_altura = -115;

    if ($oIplan->Query($sql_plan)) {
        if ($oIplan->NumFilas() > 0) {
            do {
                $paquetes   = $oIplan->f('paquete');
                $precio     = $oIplan->f('precio');

                $lista_planes_html .= '<li style="width: 30px; height: 20px; border: 1px solid rgb(0,32,96);">
                                        <pre>        ' . $paquetes . ' ----&gt; s/. ' . $precio . '</pre>
                                        <span class="checkmark">
                                            <div class="checkmark_stem"></div>
                                            <div class="checkmark_kick"></div>
                                        </span>
                                    </li><br>';

                $altura_tipo_plan = $altura_tipo_plan + 10;
            } while ($oIplan->SiguienteRegistro());
        }
    }
    $oIplan->Free();

    $titilo_plan = $tipo_contrato_nombre;
    $lista_planes_contenedor_html = '';

    if ($tipo_contrato == 2) {
        $titilo_plan = 'PLANES DE INTERNET';
    }
    if ($tipo_contrato == 7) {
        $titilo_plan = 'PLANES DE INTERNET + CABLE (DÚO)';
    }

    $lista_planes_contenedor_html = '<td>
                                        <ul style="font-weight: normal; color: rgb(0,32,96); list-style-type:none; font-family: Arial; font-size: 9.5px; text-align: center; width: 550px;">
                                            <li style="text-align: center;"><strong>' . $titilo_plan . '</strong></li>
                                            <br>' . $lista_planes_html . '
                                        </ul>
                                    </td>';




    // echo $lista_planes_html;exit;

    // CONSULTA CONTRATO INTERNET
    $sql_int = "SELECT a.id as id_caja_pack, c.nombre, b.paquete, d.estado, a.precio, a.estado as id_estado, b.id_tipo_prod, d.color
                                    FROM isp.int_contrato_caja_pack a INNER JOIN
                                            isp.int_paquetes b ON a.id_prod = b.id INNER JOIN
                                            isp.int_tipo_prod c ON b.id_tipo_prod = c.id INNER JOIN
                                            isp.int_estados_equipo d ON a.estado = d.id
                                    WHERE a.id_caja = $id AND 
                                            a.id_contrato = $id_contrato AND 
                                            a.id_clpv = $id_clpv AND
                                            a.estado NOT IN ('E')";

    if (empty($vendedor)) {
        $vendedor = 0;
    }
    $sql = "SELECT vend_nom_vend from saevend where vend_cod_vend = '$vendedor'";
    $vendedoremp       = consulta_string($sql, 'vend_nom_vend', $oCon, 'No especifica');

    if (empty($id_clpv)) {
        $id_clpv = 0;
    }
    $sql_clpv_nacimi = "SELECT clpv_fec_naci from saeclpv where clpv_cod_clpv = $id_clpv";
    $fecha_nacimiento_cliente   = consulta_string($sql_clpv_nacimi, 'clpv_fec_naci', $oCon, 'SIN REGISTRAR');

    if (empty($departamento)) {
        $departamento = 0;
    }
    $sql = "SELECT nombre from comercial.dire_siglas where id=$departamento";
    $calleprincipal     = consulta_string($sql, 'nombre', $oCon, 'No especifica');


    if (empty($tipo_cliente)) {
        $tipo_cliente = 1;
    }

    if ($tipo_cliente == 1) {
        $si_t_e = '____';
        $si_dis = '____';
        $no_t_e = '__<b>X</b>__';
        $no_dis = '__<b>X</b>__';
    }
    if ($tipo_cliente == 2) { //discapac
        $si_t_e = '';
        $si_dis = '__<b>X</b>__';
        $no_t_e = '__<b>X</b>__';
        $no_dis = '';
    }

    if ($tipo_cliente == 3) { //tercera edad
        $si_t_e = '__<b>X</b>__';
        $si_dis = '____';
        $no_t_e = '____';
        $no_dis = '__<b>X</b>__';
    }


    $dia_con = substr($fecha_con, 8, 2);
    $mes_con = substr($fecha_con, 5, 2);
    $año_con = substr($fecha_con, 0, 4);
    //echo $fecha_con;exit;

    //echo $dia_con.'---'.$mes_con.'----',$año_con;exit;


    $sql = "SELECT imagen from contrato_firmas where id_contrato = $id";
    $imagen_firma       = consulta_string($sql, 'imagen', $oCon, '');

    $exister_firma = 'N';
    if (!empty($imagen_firma)) {
        $identificador     = '<img width="200px;" height="100px;" src="data:image/png;base64,' . $imagen_firma . '">';
        $identificadorcv     = '<img width="100px;" height="100px;" src="data:image/png;base64,' . $imagen_firma . '">';

        $exister_firma = 'S';
    } else {
    }
    if ($exister_firma == 'N') {
        $identificador = '<br>
                          <br>
                          <br>
                          <br>
                          <br>
                          <br>
                          <br>
                          <br>';
                          
        $identificadorcv = '<br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>';
    } 

    //var_dump($identificadorcv);exit;



    $paquetes = '';
    //DATOS DE PAQUETE
    $sqlInt = "SELECT b.paquete, a.precio, a.cod_prod, a.codigo_cid 
                from isp.int_contrato_caja_pack a, isp.int_paquetes b 
                WHERE a.cod_prod = b.prod_cod_prod and a.id_contrato = $id and a.estado in ('A','P','C') and a.activo = 'S' AND b.id_tipo_prod = 2";
    if ($oCon->Query($sqlInt)) {
        if ($oCon->NumFilas() > 0) {
            do {
                $id_paquete = $oCon->f('paquete');
                $precio     = $oCon->f('precio');
                $codigo_cid = $oCon->f('codigo_cid');

                $paquetes .= '<tr>
                                <td style="width: 40%;">' . $id_paquete . '</td>
                                <td style="width: 45%;"></td>
                                <td style="width: 15%;">' . $precio . '</td>
                            </tr>';


                $cod_prod = $oCon->f('cod_prod');

                $sql_i = "SELECT prod_nom_prod, prod_cod_cate from saeprod WHERE prod_cod_prod='$cod_prod'";
                $nom_plan = consulta_string($sql_i, 'prod_nom_prod', $oIfx, '');
                $tipo_categoria = consulta_string($sql_i, 'prod_cod_cate', $oIfx, '');
                $planes_nam .= $nom_plan . ', ';

                $sql_vel = "SELECT i.egress, i.ingress , tipo from isp.int_paquetes i WHERE i.prod_cod_prod = '$cod_prod' ";
                $bajada_plan  = consulta_string_func($sql_vel, 'egress', $oCon1, '') . ',';
                $subida_plan = consulta_string_func($sql_vel, 'ingress', $oCon1, '') . ',';
                $tipo_plan  = consulta_string_func($sql_vel, 'tipo', $oCon1, '') . ',';


                $bajada_plan = substr($bajada_plan, 0, strlen($bajada_plan) - 1);
                $subida_plan = substr($subida_plan, 0, strlen($subida_plan) - 1);

                $subida_plan_min = $subida_plan * 0.7;
                $bajada_plan_min = $bajada_plan * 0.7;

                $sql_n = "SELECT c.cate_nom_cate from saecate c WHERE c.cate_cod_cate = '$tipo_categoria'";
                $tipo_categoria_txt = consulta_string($sql_n, 'cate_nom_cate', $oIfx, '');
            } while ($oCon->SiguienteRegistro());
        }
    }
    $oCon->Free();

    $sqlInt = "SELECT sum(precio) as precio_fin
                from isp.int_contrato_caja_pack 
                WHERE id_contrato = $id and estado in ('A','P','C') and activo = 'S'";
    if ($oCon->Query($sqlInt)) {
        if ($oCon->NumFilas() > 0) {
            do {
                $precio_fin = $oCon->f('precio_fin');
                $cuota1  = $precio_fin * 12;
                $cuota2  = $precio_fin * 11;
                $cuota3  = $precio_fin * 10;
                $cuota4  = $precio_fin * 9;
                $cuota5  = $precio_fin * 8;
                $cuota6  = $precio_fin * 7;
                $cuota7  = $precio_fin * 6;
                $cuota8  = $precio_fin * 5;
                $cuota9  = $precio_fin * 4;
                $cuota10 = $precio_fin * 3;
                $cuota11 = $precio_fin * 2;
                $cuota12 = $precio_fin * 1;
            } while ($oCon->SiguienteRegistro());
        }
    }
    $oCon->Free();

    $array_fec  = explode('-', $fecha_con);
    $anio       = $array_fec[0];
    $mes        = $array_fec[1];
    $dia        = $array_fec[2];

    $anio1      = $array_fec[0];
    $mes1       = $array_fec[1];
    $dia1       = $array_fec[2];

    list($ano, $mes, $dia)  = explode("-", $fecha_nacimiento);
    $ano_diferencia         = date("Y") - $ano;
    $mes_diferencia         = date("m") - $mes;
    $dia_diferencia         = date("d") - $dia;
    if ($dia_diferencia < 0 || $mes_diferencia < 0) {
        $ano_diferencia--;
    }

    $sql_c = "SELECT contr_text_contr from isp.int_txt_contrato WHERE contr_cod_contr = $id_tip_contr";
    $oCon->Query($sql_c);
    $texto_contrato = $oCon->f('contr_text_contr', false);
    $oCon->Free();

    //NOMBRE CIUDAD
    if (empty($id_ciudad_clpv)) {
        $id_ciudad_clpv = '0';
    }
    $sql_c = "SELECT ciud_nom_ciud from saeciud where ciud_cod_ciud='$empr_cod_ciud'";
    $name_city = consulta_string($sql_c, 'ciud_nom_ciud', $oIfx, 'SIN CIUDAD');

    $sql_cclpv = "SELECT ciud_nom_ciud from saeciud where ciud_cod_ciud='$id_ciudad_clpv'";
    $nombre_ciudad_clpv = consulta_string($sql_cclpv, 'ciud_nom_ciud', $oIfx, 'SIN CIUDAD');

    //NOMBRE PROVINCIA
    if (empty($id_provincia_clpv)) {
        $id_provincia_clpv = '0';
    }
    $sql_p = "SELECT prov_des_prov from saeprov where prov_cod_prov='$empr_cod_prov'";
    $nombre_provincia = consulta_string($sql_p, 'prov_des_prov', $oIfx, 'SIN PROVINCIA');

    $sql_pclpv = "SELECT prov_des_prov from saeprov where prov_cod_prov='$id_provincia_clpv'";
    $nombre_provincia_clpv = consulta_string($sql_pclpv, 'prov_des_prov', $oIfx, 'SIN PROVINCIA');

    //NOMBRE PARROQUIA
    if (empty($id_parroquia_clpv)) {
        $id_parroquia_clpv = '0';
    }
    $sql_parrclpv = "SELECT parr_des_parr from saeparr where parr_cod_parr='$id_parroquia_clpv'";
    $nombre_parroquia_clpv = consulta_string($sql_parrclpv, 'parr_des_parr', $oIfx, 'SIN PARROQUIA');

    //NOMBRE CANTON
    if (strlen($empr_cod_cant) == 0) {
        $empr_cod_cant = 0;
    }
    $sql_ca = "SELECT cant_des_cant from saecant where cant_cod_cant='$empr_cod_cant'";
    $nombre_canton = consulta_string($sql_ca, 'cant_des_cant', $oIfx, 'SIN CANTON');

    $sql_caclpv = "SELECT cant_des_cant from saecant where cant_cod_cant='$id_canton_clpv'";
    $nombre_canton_clpv = consulta_string($sql_caclpv, 'cant_des_cant', $oIfx, 'SIN CANTON');

    $fecha_final = $dia1 . '/' . $mes1 . '/' . $anio1;

    $emprhttp = explode(" ", $empr_nom_empr);
    $emprhttp = $emprhttp[0];
    $emprhttp = strtolower($emprhttp);

    $today = date("Y-m-d");
    $current_year = date("Y");

    $date = date_create($fecha_nacimiento_cliente);
    $fecha_nacimiento_cliente = date_format($date, "d-m-Y");


    if ($tipo_contrato == 2) { //Internet

        $contrato = "SELECT a.id as id_caja_pack, c.nombre, b.paquete, d.estado, a.precio, a.estado as id_estado, b.id_tipo_prod, d.color, b.egress as v_bajada, b.ingress as v_subida
        FROM isp.int_contrato_caja_pack a INNER JOIN
                isp.int_paquetes b ON a.id_prod = b.id INNER JOIN
                isp.int_tipo_prod c ON b.id_tipo_prod = c.id INNER JOIN
                isp.int_estados_equipo d ON a.estado = d.id
        WHERE 
                a.id_contrato = $id AND
                a.id_clpv = $id_clpv AND
                a.estado NOT IN ('E')";

        // echo $contrato;exit;

        if ($oCon3->Query($contrato)) {
            if ($oCon3->NumFilas() > 0) {
                do {
                    $paquetes_internet = $oCon3->f('paquete');
                    $precio_int = $oCon3->f('precio');
                    $v_bajada = $oCon3->f('v_bajada');


                    if (empty($v_bajada)) {

                        $baja = '';
                    } else {
                        $baja = $v_bajada . ' Mb';
                    }

                    $infsuscr = '
                        <tr>
                            <td style="font-size: 73%; width: 90px;" align="center">' . $paquetes_internet . '</td>
                            <td style="font-size: 80%; width: 88px;" align="center">' . $baja . '</td>
                            <td style="font-size: 80%; width: 88px;" align="center">' . $precio_int . '</td>
                        </tr>
                    ';
                } while ($oCon3->SiguienteRegistro());
            }
        }
        $oCon3->Free();

        $bnf_ctr .= '
            <tr>
                <td style="width:150px;"align="center">1</td>
                <td style="width:150px;"align="center">ONT</td>
                <td style="width:150px;"align="center">BUENO</td>
                <td style="width:150px;"align="center">0.00</td>
            </tr>
        ';

        $empaquetamiento = 'SI ___; NO _<b>X</b>_.';

        $varservicios = 'Telefonia ___ Internet fijo _X_ Televisón ___';

        $srv_int_tv = 'INTERNET';

        $ctr_pck .= '
                <tr>
                    <td style="width:150px;"align="center">' . $paquetes_internet . '</td>
                    <td style="width:150px;"align="center"></td>
                    <td style="width:150px;"align="center">' . $precio_int . '</td>
                </tr>
            ';

        $inter .= '<b>X</b>';
    }



    if ($tipo_contrato == 1 || $tipo_contrato == 4) { //TV

        $contrato = "SELECT a.id as id_caja_pack, c.nombre, b.paquete, d.estado, a.precio, a.estado as id_estado, b.id_tipo_prod, d.color, b.egress as v_bajada, b.ingress as v_subida
            FROM isp.int_contrato_caja_pack a INNER JOIN
                    isp.int_paquetes b ON a.id_prod = b.id INNER JOIN
                    isp.int_tipo_prod c ON b.id_tipo_prod = c.id INNER JOIN
                    isp.int_estados_equipo d ON a.estado = d.id
            WHERE 
                    a.id_contrato = $id AND
                    a.id_clpv = $id_clpv AND
                    a.estado NOT IN ('E')";

        //echo $contrato;exit;

        if ($oCon3->Query($contrato)) {
            if ($oCon3->NumFilas() > 0) {
                do {
                    $paquetes_tv = $oCon3->f('paquete');
                    $precio_tv = $oCon3->f('precio');
                    $v_bajada = $oCon3->f('v_bajada');


                    if (empty($v_bajada)) {

                        $baja = '';
                    } else {
                        $baja = $v_bajada . ' Mb';
                    }

                    $infsuscr = '
                        <tr>
                            <td style="font-size: 73%; width: 88px;" align="center">' . $paquetes_tv . '</td>
                            <td style="font-size: 80%; width: 88px;" align="center">' . $baja . '</td>
                            <td style="font-size: 80%; width: 88px;" align="center">' . $precio_tv . '</td>
                        </tr>
                    ';
                } while ($oCon3->SiguienteRegistro());
            }
        }
        $oCon3->Free();

        $bnf_ctr .= '
                <tr>
                    <td style="width:150px;"align="center">1</td>
                    <td style="width:150px;"align="center">CATV</td>
                    <td style="width:150px;"align="center">BUENO</td>
                    <td style="width:150px;"align="center">0.00</td>
                </tr>
            ';

        $empaquetamiento = 'SI ___; NO _<b>X</b>_.';

        $varservicios = 'Telefonia ___ Internet fijo ___ Televisón _X_';

        $srv_int_tv = 'TV ANALOGA';

        $ctr_pck .= '
                <tr>
                    <td style="width:150px;"align="center">' . $paquetes_tv . '</td>
                    <td style="width:150px;"align="center"></td>
                    <td style="width:150px;"align="center">' . $precio_tv . '</td>
                </tr>
            ';

        $audi_vid .= '<b>X</b>';
    }

    if ($tipo_contrato == 3 || $tipo_contrato == 7) { //TV+int 

        $contrato = "select a.id as id_caja_pack, c.nombre, b.paquete, d.estado, a.precio, a.estado as id_estado, b.id_tipo_prod, d.color, b.egress as v_bajada, b.ingress as v_subida
                    FROM isp.int_contrato_caja_pack a INNER JOIN
                            isp.int_paquetes b ON a.id_prod = b.id INNER JOIN
                            isp.int_tipo_prod c ON b.id_tipo_prod = c.id INNER JOIN
                            isp.int_estados_equipo d ON a.estado = d.id
                    WHERE 
                            a.id_contrato = $id AND
                            a.id_clpv = $id_clpv AND
                            a.estado NOT IN ('E')";

        //echo $contrato;exit;
        $paqunidos = '';
        $planes_precio = '';
        $servicioscheck = '';
        if ($oCon3->Query($contrato)) {
            if ($oCon3->NumFilas() > 0) {
                do {
                    $paquetes_internet = $oCon3->f('paquete');
                    $paqunidos .= $oCon3->f('paquete');
                    $precio_int = $oCon3->f('precio');
                    $v_bajada = $oCon3->f('v_bajada');


                    if (empty($v_bajada)) {

                        $baja = '';
                    } else {
                        $baja = $v_bajada . ' Mb';
                    }

                    $servicioscheck .= '
                    <tr>
                        <td style="vertical-align: middle;"><img class="left" src="' . $check_si . '" width="11"/></td>
                        <td style="font-size: 95%; vertical-align: middle; "><b>' . $paquetes_internet . '</b></td>
                    </tr>
                    '; 


                    $planes_precio .= '
                        <tr style="background-color: #dcede4;">
                            <td style="font-size: 75%; width: 140px; vertical-align: middle;"><b>' . $paquetes_internet . '</b></td>
                            <td style="font-size: 75%; width: 140px; vertical-align: middle;">' . $precio_int . '</td>
                        </tr>
                    ';

                    $infsuscr .= '
                        <tr>
                            <td style="font-size: 73%; width: 88px;" align="center">' . $paquetes_internet . '</td>
                            <td style="font-size: 80%; width: 88px;" align="center">' . $baja . '</td>
                            <td style="font-size: 80%; width: 88px;" align="center">' . $precio_int . '</td>
                        </tr>
                    ';
                } while ($oCon3->SiguienteRegistro());
            }
        }


        $oCon3->Free();

        $bnf_ctr .= '
                <tr>
                    <td style="width:150px;"align="center">1</td>
                    <td style="width:150px;"align="center">ONT</td>
                    <td style="width:150px;"align="center">BUENO</td>
                    <td style="width:150px;"align="center">0.00</td>
                </tr>

                <tr>
                    <td style="width:150px;"align="center">2</td>
                    <td style="width:150px;"align="center">CATV</td>
                    <td style="width:150px;"align="center">BUENO</td>
                    <td style="width:150px;"align="center">0.00</td>
                </tr>

            ';

        $empaquetamiento = 'SI _<b>X</b>_; NO ____';

        $varservicios = 'Telefonia ___ Internet fijo _X_ Televisón _X_';



        $srv_int_tv = 'TV ANALOGA + INTERNET';

        $ctr_pck .= '
                <tr>
                    <td style="width:150px;"align="center">' . $paquetes_internet . '</td>
                    <td style="width:150px;"align="center"></td>
                    <td style="width:150px;"align="center">' . $precio_int . '</td>
                </tr>
                
                <tr>
                    <td style="width:150px;"align="center">' . $paquetes_tv . '</td>
                    <td style="width:150px;"align="center"></td>
                    <td style="width:150px;"align="center">' . $precio_tv . '</td>
                </tr>

            ';

        $inter .= '<b>X</b>';
        $audi_vid .= '<b>X</b>';
    }

    $texto_contrato = preg_replace("/intercon/", $inter, $texto_contrato);
    $texto_contrato = preg_replace("/videcon/", $audi_vid, $texto_contrato);
    $texto_contrato = preg_replace("/si_no_empaqco/", $empaquetamiento, $texto_contrato);
    $texto_contrato = preg_replace("/siterc/", $si_t_e, $texto_contrato);
    $texto_contrato = preg_replace("/noterc/", $no_t_e, $texto_contrato);
    $texto_contrato = preg_replace("/sidisc/", $si_dis, $texto_contrato);
    $texto_contrato = preg_replace("/nodisc /", $no_dis, $texto_contrato);

    $texto_contrato = preg_replace("/referenciaco/", $referencia, $texto_contrato);
    $texto_contrato = preg_replace("/viviendaco/", $lugar, $texto_contrato);
    $texto_contrato = preg_replace("/principalco/", $calleprincipal, $texto_contrato);
    $texto_contrato = preg_replace("/mensualco/", $mensualidad, $texto_contrato);
    $texto_contrato = preg_replace("/vendedorco/", $vendedoremp, $texto_contrato);
    $texto_contrato = preg_replace("/fechanaco/", $fecha_nacimiento_cliente, $texto_contrato);
    $texto_contrato = preg_replace("/planintco/", $paquetes_internet, $texto_contrato);
    $texto_contrato = preg_replace("/plantvco/", $paquetes_tv, $texto_contrato);
    $texto_contrato = preg_replace("/paquetetv_int/", $bnf_ctr, $texto_contrato);
    $texto_contrato = preg_replace("/serv_preco/", $ctr_pck, $texto_contrato);
    $texto_contrato = preg_replace("/tipo_servco/", $srv_int_tv, $texto_contrato);
    $texto_contrato = preg_replace("/direccionsucu/", $sucu_dir_sucu, $texto_contrato);
    $texto_contrato = preg_replace("/telefonosucu/", $sucu_telf_secu, $texto_contrato);
    $texto_contrato = preg_replace("/faxsucu/", $sucu_fax_secu, $texto_contrato);
    $texto_contrato = preg_replace("/corresucu/", $sucu_email_secu, $texto_contrato);
    $texto_contrato = preg_replace("/nomsucu/", $sucu_nom_secu, $texto_contrato);
    $texto_contrato = preg_replace("/contratoco/", $codigo, $texto_contrato);
    $texto_contrato = preg_replace("/rubco/", $empr_rub, $texto_contrato); //rubrica contrato/firma de la empresa     
    $texto_contrato = preg_replace("/rubcvco/", $empr_rub_cv, $texto_contrato); //rubrica contrato/firma de la empresa
    $texto_contrato = preg_replace("/preciofin/", $precio_fin, $texto_contrato);
    $texto_contrato = preg_replace("/precioint/", $precio_int, $texto_contrato);
    $texto_contrato = preg_replace("/preciotv/", $precio_tv, $texto_contrato);
    $texto_contrato = preg_replace("/provinciaclpv/", $nombre_provincia_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/cantonclpv/", $nombre_canton_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/ciudadclpv/", $nombre_ciudad_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/parroqiuiaclpv/", $nombre_parroquia_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/natjurco/", $nat_jur, $texto_contrato);
    $texto_contrato = preg_replace("/espacioscontr/", $espacios, $texto_contrato);
    $texto_contrato = preg_replace("/referenciabo/", $referencia_parient, $texto_contrato);
    $texto_contrato = preg_replace("/nacimientoco/", $fecha_nacimientocon, $texto_contrato);
    $texto_contrato = preg_replace("/QRIMG/", $qr, $texto_contrato);
    $texto_contrato = preg_replace("/varservicios/", $varservicios, $texto_contrato);
    $texto_contrato = preg_replace("/infsuscr/", $infsuscr, $texto_contrato);
    $texto_contrato = preg_replace("/cortecontr/", $fecha_corte, $texto_contrato);
    $texto_contrato = preg_replace("/planes_precio/", $planes_precio, $texto_contrato);

    $texto_contrato = preg_replace("/firmacontratoimg/", $identificador, $texto_contrato);
    $texto_contrato = preg_replace("/celularemprco/", $empr_cel_empr, $texto_contrato);
    $texto_contrato = preg_replace("/paquetesco/", $paquetes, $texto_contrato);
    $texto_contrato = preg_replace("/contratocodco /", $codigo_contrato, $texto_contrato);
    $texto_contrato = preg_replace("/mesesco/", $duracion, $texto_contrato);
    $texto_contrato = preg_replace("/ciudadco/", $name_city, $texto_contrato);
    $texto_contrato = preg_replace("/empresaco/", $empr_nom_empr, $texto_contrato);
    $texto_contrato = preg_replace("/comercialco/", $empr_nomcome_empr, $texto_contrato);
    $texto_contrato = preg_replace("/idenco/", $empr_ruc_empr, $texto_contrato);
    $texto_contrato = preg_replace("/provinciaco/", $nombre_provincia, $texto_contrato);
    $texto_contrato = preg_replace("/cantonco/", $nombre_canton, $texto_contrato);
    $texto_contrato = preg_replace("/representanteco/", $empr_repres, $texto_contrato);
    $texto_contrato = preg_replace("/direccionemprco/", $direccionempr, $texto_contrato);
    $texto_contrato = preg_replace("/telefonoco/", $empr_tel_resp, $texto_contrato);
    $texto_contrato = preg_replace("/correoco/", $empr_mai_empr, $texto_contrato);
    $texto_contrato = preg_replace("/empresahttpco/", $emprhttp, $texto_contrato);
    $texto_contrato = preg_replace("/diasco/", $dia_con, $texto_contrato);
    $texto_contrato = preg_replace("/mesco/", $mes_con, $texto_contrato);
    $texto_contrato = preg_replace("/anioco/", $año_con, $texto_contrato);
    $texto_contrato = preg_replace("/siterc/", $año_con, $texto_contrato);
    $texto_contrato = preg_replace("/nombreemplco/", $nom_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/dniemplco/", $ruc_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/direemplco/", $direccion, $texto_contrato);
    $texto_contrato = preg_replace("/direrefemplco/", $direccion_ref, $texto_contrato);
    $texto_contrato = preg_replace("/teleemplco/", $num_referencia, $texto_contrato);
    $texto_contrato = preg_replace("/emialemplco/", $email, $texto_contrato);
    $texto_contrato = preg_replace("/CLAUSULA/", 'CLÁUSULA', $texto_contrato);
    $texto_contrato = preg_replace("/PRESTACION/", 'PRESTACIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/Ri­os,/", 'Rí­os', $texto_contrato);
    $texto_contrato = preg_replace("/Bucaran/", 'Bucarán', $texto_contrato);
    $texto_contrato = preg_replace("/numeros/", 'números', $texto_contrato);
    $texto_contrato = preg_replace("/telefono/", 'teléfono', $texto_contrato);
    $texto_contrato = preg_replace("/electronico/", 'electrónico', $texto_contrato);
    $texto_contrato = preg_replace("/denominara/", 'denominará', $texto_contrato);
    $texto_contrato = preg_replace("/cedula/", 'cédula', $texto_contrato);
    $texto_contrato = preg_replace("/canton/", 'cantón', $texto_contrato);
    $texto_contrato = preg_replace("/direccion/", 'dirección', $texto_contrato);
    $texto_contrato = preg_replace("/clausulas/", 'cláusulas', $texto_contrato);
    $texto_contrato = preg_replace("/ano/", 'año', $texto_contrato);
    $texto_contrato = preg_replace("/continuacion/", 'continuación', $texto_contrato);
    $texto_contrato = preg_replace("/prestacion/", 'prestación', $texto_contrato);
    $texto_contrato = preg_replace("/sera/", 'será', $texto_contrato);
    $texto_contrato = preg_replace("/titulos/", 'títulos', $texto_contrato);
    $texto_contrato = preg_replace("/juridico/", 'jurídico', $texto_contrato);
    $texto_contrato = preg_replace("/Movil/", 'Móvil', $texto_contrato);
    $texto_contrato = preg_replace("/traves/", 'través', $texto_contrato);
    $texto_contrato = preg_replace("/Telefonia/", 'Telefonía', $texto_contrato);
    $texto_contrato = preg_replace("/satelite/", 'satélite', $texto_contrato);
    $texto_contrato = preg_replace("/suscripción/", 'suscripción', $texto_contrato);
    $texto_contrato = preg_replace("/modificacion/", 'modificación', $texto_contrato);
    $texto_contrato = preg_replace("/duracion/", 'duración', $texto_contrato);
    $texto_contrato = preg_replace("/anticipacion/", 'anticipación', $texto_contrato);
    $texto_contrato = preg_replace("/renovara/", 'renovará', $texto_contrato);
    $texto_contrato = preg_replace("/automaticamente/", 'automáticamente', $texto_contrato);
    $texto_contrato = preg_replace("/terminos/", 'términos', $texto_contrato);
    $texto_contrato = preg_replace("/comun/", 'común', $texto_contrato);
    $texto_contrato = preg_replace("/adhesion/", 'adhesión', $texto_contrato);
    $texto_contrato = preg_replace("/debera/", 'deberá', $texto_contrato);
    $texto_contrato = preg_replace("/notificacion/", 'notificación', $texto_contrato);
    $texto_contrato = preg_replace("/Organica/", 'Orgánica', $texto_contrato);
    $texto_contrato = preg_replace("/estara/", 'estará', $texto_contrato);
    $texto_contrato = preg_replace("/reciproca/", 'recíproca', $texto_contrato);
    $texto_contrato = preg_replace("/demas/", 'demás', $texto_contrato);
    $texto_contrato = preg_replace("/asi/", 'así', $texto_contrato);
    $texto_contrato = preg_replace("/finalizacion/", 'finalización', $texto_contrato);
    $texto_contrato = preg_replace("/periodo/", 'período', $texto_contrato);
    $texto_contrato = preg_replace("/obligacion/", 'obligación', $texto_contrato);
    $texto_contrato = preg_replace("/unicamente/", 'únicamente', $texto_contrato);
    $texto_contrato = preg_replace("/terminacion/", 'terminación', $texto_contrato);
    $texto_contrato = preg_replace("/adquisicion/", 'adquisición', $texto_contrato);
    $texto_contrato = preg_replace("/practicas/", 'prácticas', $texto_contrato);
    $texto_contrato = preg_replace("/dane/", 'dañe', $texto_contrato);
    $texto_contrato = preg_replace("/disolucion/", 'disolución', $texto_contrato);
    $texto_contrato = preg_replace("/liquidacion/", 'liquidación', $texto_contrato);
    $texto_contrato = preg_replace("/minima/", 'mínima', $texto_contrato);
    $texto_contrato = preg_replace("/fisicos/", 'físicos', $texto_contrato);
    $texto_contrato = preg_replace("/electronicos/", 'electrónicos', $texto_contrato);
    $texto_contrato = preg_replace("/asumira/", 'asumirá', $texto_contrato);
    $texto_contrato = preg_replace("/FACTURACION/", 'FACTURACIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/via/", 'vía', $texto_contrato);
    $texto_contrato = preg_replace("/eleccion/", 'elección', $texto_contrato);
    $texto_contrato = preg_replace("/procedera/", 'procederá', $texto_contrato);
    $texto_contrato = preg_replace("/cobraran/", 'cobrarán', $texto_contrato);
    $texto_contrato = preg_replace("/aritmeticos/", 'aritméticos', $texto_contrato);
    $texto_contrato = preg_replace("/conciliara/", 'conciliará', $texto_contrato);
    $texto_contrato = preg_replace("/razon/", 'razón', $texto_contrato);
    $texto_contrato = preg_replace("/tramite/", 'trámite', $texto_contrato);
    $texto_contrato = preg_replace("/originara/", 'originará', $texto_contrato);
    $texto_contrato = preg_replace("/incorporara/", 'incorporará', $texto_contrato);
    $texto_contrato = preg_replace("/reflejara/", 'reflejará', $texto_contrato);
    $texto_contrato = preg_replace("/economicas/", 'económicas', $texto_contrato);
    $texto_contrato = preg_replace("/ocasion/", 'ocasión', $texto_contrato);
    $texto_contrato = preg_replace("/senor/", 'señor', $texto_contrato);
    $texto_contrato = preg_replace("/senalado/", 'señalado', $texto_contrato);
    $texto_contrato = preg_replace("/senalar/", 'señalar', $texto_contrato);
    $texto_contrato = preg_replace("/ADHESION/", 'ADHESIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/pagina/", 'página', $texto_contrato);
    $texto_contrato = preg_replace("/suscripcion/", 'suscripción', $texto_contrato);
    $texto_contrato = preg_replace("/realizara/", 'realizará', $texto_contrato);
    $texto_contrato = preg_replace("/RENOVACION/", 'RENOVACIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/INSTALACION/", 'INSTALACIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/ACTIVACION/", 'ACTIVACIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/desee/", 'deseé', $texto_contrato);
    $texto_contrato = preg_replace("/TERMINACION/", 'TERMINACIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/podra/", 'podrá', $texto_contrato);
    $texto_contrato = preg_replace("/tendra/", 'tendrá', $texto_contrato);
    $texto_contrato = preg_replace("/segun/", 'según', $texto_contrato);
    $texto_contrato = preg_replace("/MINIMA/", 'MÍNIMA', $texto_contrato);
    $texto_contrato = preg_replace("/pagara/", 'pagará', $texto_contrato);
    $texto_contrato = preg_replace("/remitiran/", 'remitirán', $texto_contrato);
    $texto_contrato = preg_replace("/electronica/", 'electrónica', $texto_contrato);
    $texto_contrato = preg_replace("/aprobacion/", 'aprobación', $texto_contrato);
    $texto_contrato = preg_replace("/fisica/", 'física', $texto_contrato);
    $texto_contrato = preg_replace("/emitio/", 'emitió', $texto_contrato);
    $texto_contrato = preg_replace("/seguira/", 'seguirá', $texto_contrato);
    $texto_contrato = preg_replace("/facturacion/", 'facturación', $texto_contrato);
    $texto_contrato = preg_replace("/conciliacion/", 'conciliación', $texto_contrato);
    $texto_contrato = preg_replace("/remitira/", 'remitirá', $texto_contrato);
    $texto_contrato = preg_replace("/credito/", 'crédito', $texto_contrato);
    $texto_contrato = preg_replace("/conexion/", 'conexión', $texto_contrato);
    $texto_contrato = preg_replace("/Debito/", 'Débito', $texto_contrato);
    $texto_contrato = preg_replace("/visitaran/", 'visitarán', $texto_contrato);
    $texto_contrato = preg_replace("/SEPTIMA/", 'SÉPTIMA', $texto_contrato);
    $texto_contrato = preg_replace("/CONEXION/", 'CONEXIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/activacion/", 'activación', $texto_contrato);
    $texto_contrato = preg_replace("/electricas/", 'eléctricas', $texto_contrato);
    $texto_contrato = preg_replace("/verificacion/", 'verificación', $texto_contrato);
    $texto_contrato = preg_replace("/tecnica/", 'técnica', $texto_contrato);
    $texto_contrato = preg_replace("/verificaran/", 'verificarán', $texto_contrato);
    $texto_contrato = preg_replace("/RECEPCION/", 'RECEPCIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/instalo/", 'instaló', $texto_contrato);
    $texto_contrato = preg_replace("/exigira/", 'exigirá', $texto_contrato);
    $texto_contrato = preg_replace("/calculo/", 'cálculo', $texto_contrato);
    $texto_contrato = preg_replace("/autorizacion/", 'autorización', $texto_contrato);
    $texto_contrato = preg_replace("/operacion/", 'operación', $texto_contrato);
    $texto_contrato = preg_replace("/explotacion/", 'explotación', $texto_contrato);
    $texto_contrato = preg_replace("/Regulacion/", 'Regulación', $texto_contrato);
    $texto_contrato = preg_replace("/configuracion/", 'configuración', $texto_contrato);
    $texto_contrato = preg_replace("/tecnico/", 'técnico', $texto_contrato);
    $texto_contrato = preg_replace("/sancion/", 'sanción', $texto_contrato);
    $texto_contrato = preg_replace("/informacion/", 'información', $texto_contrato);
    $texto_contrato = preg_replace("/proteccion/", 'protección', $texto_contrato);
    $texto_contrato = preg_replace("/interrupcion/", 'interrupción', $texto_contrato);
    $texto_contrato = preg_replace("/funcion/", 'función', $texto_contrato);
    $texto_contrato = preg_replace("/suspension/", 'suspensión', $texto_contrato);
    $texto_contrato = preg_replace("/relacion/", 'relación', $texto_contrato);
    $texto_contrato = preg_replace("/Atencion/", 'Atención', $texto_contrato);
    $texto_contrato = preg_replace("/Radiodifusion/", 'Radiodifusión', $texto_contrato);
    $texto_contrato = preg_replace("/Suscripcion/", 'Suscripción', $texto_contrato);
    $texto_contrato = preg_replace("/titulo/", 'título', $texto_contrato);
    $texto_contrato = preg_replace("/juridica/", 'jurídica', $texto_contrato);
    $texto_contrato = preg_replace("/DECIMA/", 'DÉCIMA', $texto_contrato);
    $texto_contrato = preg_replace("/indices/", 'índices', $texto_contrato);
    $texto_contrato = preg_replace("/telefonica/", 'telefónica', $texto_contrato);
    $texto_contrato = preg_replace("/tecnicos/", 'técnicos', $texto_contrato);
    $texto_contrato = preg_replace("/economico/", 'económico', $texto_contrato);
    $texto_contrato = preg_replace("/calculos/", 'cálculos', $texto_contrato);
    $texto_contrato = preg_replace("/Garantizaran/", 'Garantizarán', $texto_contrato);
    $texto_contrato = preg_replace("/implementacion/", 'implementación', $texto_contrato);
    $texto_contrato = preg_replace("/recibiran/", 'recibirán', $texto_contrato);
    $texto_contrato = preg_replace("/tarifarios/", 'tarifários', $texto_contrato);
    $texto_contrato = preg_replace("/UNDECIMA/", 'UNDÉCIMA', $texto_contrato);
    $texto_contrato = preg_replace("/reactivacion/", 'reactivación', $texto_contrato);
    $texto_contrato = preg_replace("/telefonico/", 'telefónico', $texto_contrato);
    $texto_contrato = preg_replace("/inspeccion/", 'inspección', $texto_contrato);
    $texto_contrato = preg_replace("/instalara/", 'instalará', $texto_contrato);
    $texto_contrato = preg_replace("/senal/", 'señal', $texto_contrato);
    $texto_contrato = preg_replace("/energia/", 'energía', $texto_contrato);
    $texto_contrato = preg_replace("/electrica/", 'eléctrica', $texto_contrato);
    $texto_contrato = preg_replace("/publica/", 'pública', $texto_contrato);
    $texto_contrato = preg_replace("/TECNICO.-/", 'TÉCNICO.-', $texto_contrato);
    $texto_contrato = preg_replace("/atencion/", 'atención', $texto_contrato);
    $texto_contrato = preg_replace("/Telefono/", 'Teléfono', $texto_contrato);
    $texto_contrato = preg_replace("/Tecnicas/", 'Técnicas', $texto_contrato);
    $texto_contrato = preg_replace("/reparacion/", 'reparación', $texto_contrato);
    $texto_contrato = preg_replace("/SEPTIMA/", 'SÉPTIMA', $texto_contrato);
    $texto_contrato = preg_replace("/jurisdiccion/", 'jurisdicción', $texto_contrato);
    $texto_contrato = preg_replace("/Aceptacion/", 'Aceptación', $texto_contrato);
    $texto_contrato = preg_replace("/Clausula/", 'Cláusula', $texto_contrato);
    $texto_contrato = preg_replace("/VIGESIMA/", 'VIGÉSIMA', $texto_contrato);
    $texto_contrato = preg_replace("/clausula/", 'cláusula', $texto_contrato);
    $texto_contrato = preg_replace("/Seran/", 'Serán', $texto_contrato);
    $texto_contrato = preg_replace("/INFORMACION/", 'INFORMACIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/promocion/", 'promoción', $texto_contrato);
    $texto_contrato = preg_replace("/AUTORIZACION/", 'AUTORIZACIÓN', $texto_contrato);
    $texto_contrato = preg_replace("/accion/", 'acción', $texto_contrato);
    $texto_contrato = preg_replace("/Institucion/", 'Institución', $texto_contrato);
    $texto_contrato = preg_replace("/valida/", 'válida', $texto_contrato);
    $texto_contrato = preg_replace("/numreference_cli/", $num_referencia, $texto_contrato);
    $texto_contrato = preg_replace("/numcelular_cli/", $num_celular, $texto_contrato);
    $texto_contrato = preg_replace("/ciudad_remp/", $name_city, $texto_contrato);
    $texto_contrato = preg_replace("/dia_remp/", $dia1, $texto_contrato);
    $texto_contrato = preg_replace("/mes_remp/", $mes1, $texto_contrato);
    $texto_contrato = preg_replace("/anio_remp/", $anio1, $texto_contrato);
    $texto_contrato = preg_replace("/fima_remp/", $fima_remp, $texto_contrato);
    $texto_contrato = preg_replace("/{codigo_remp}/", $codigo, $texto_contrato);
    $texto_contrato = preg_replace("/lugarco/", $name_city, $texto_contrato);
    $texto_contrato = preg_replace("/br1/", '<br>', $texto_contrato);
    $texto_contrato = preg_replace("/fechaco/", $fecha_final, $texto_contrato);
    $texto_contrato = preg_replace("/constemprco/", $empr_fec_resu, $texto_contrato);
    $texto_contrato = preg_replace("/emprlogo/", $empr_logo, $texto_contrato);
    $texto_contrato = preg_replace("/today/", $today, $texto_contrato);
    $texto_contrato = preg_replace("/serv1/", $serv_1, $texto_contrato);
    $texto_contrato = preg_replace("/imglogoanexo/", $img_logo_anexo, $texto_contrato);
    $texto_contrato = preg_replace("/img_1/", $img_1, $texto_contrato);
    $texto_contrato = preg_replace("/img_2/", $img_2, $texto_contrato);
    $texto_contrato = preg_replace("/img_3/", $img_3, $texto_contrato);
    $texto_contrato = preg_replace("/img_4/", $img_4, $texto_contrato);
    $texto_contrato = preg_replace("/img_5/", $img_5, $texto_contrato);
    $texto_contrato = preg_replace("/img_6/", $img_6, $texto_contrato);
    $texto_contrato = preg_replace("/img_7/", $img_7, $texto_contrato);
    $texto_contrato = preg_replace("/img_8/", $img_8, $texto_contrato);
    $texto_contrato = preg_replace("/img_9/", $img_9, $texto_contrato);
    $texto_contrato = preg_replace("/imagen_10/", $img_10, $texto_contrato);
    $texto_contrato = preg_replace("/imagen_11/", $img_11, $texto_contrato);
    $texto_contrato = preg_replace("/imagen_12/", $img_12, $texto_contrato);
    $texto_contrato = preg_replace("/imagen_13/", $img_13, $texto_contrato);
    $texto_contrato = preg_replace("/imagen_14/", $img_14, $texto_contrato);
    $texto_contrato = preg_replace("/wsp_img/", $wsp_img, $texto_contrato);
    $texto_contrato = preg_replace("/sello_img/", $sell, $texto_contrato);

    // parametros cable selva
    $texto_contrato = preg_replace("/bg_header.png/", convertir_png_a_base64($img_cable_selva_header), $texto_contrato);
    $texto_contrato = preg_replace("/bg_body.png/", convertir_png_a_base64($img_cable_selva_body), $texto_contrato);
    $texto_contrato = preg_replace("/bg1_3.png/", convertir_png_a_base64($img_cable_selva_footer), $texto_contrato);

    $texto_contrato = preg_replace("/step1.jpg/", convertir_png_a_base64($img_cable_vision_promo_parte1), $texto_contrato);
    $texto_contrato = preg_replace("/step2.jpg/", convertir_png_a_base64($img_cable_vision_promo_parte2), $texto_contrato);

    $texto_contrato = preg_replace("/val_mesuealidad/", $mensualidad, $texto_contrato);
    $texto_contrato = preg_replace("/val_cuota_en_palabra/", numero_a_palabra($mensualidad), $texto_contrato);
    $texto_contrato = preg_replace("/val_instalacion/", $instalacionclpv, $texto_contrato);
    $texto_contrato = preg_replace("/val_instal_en_palabra/", numero_a_palabra($instalacionclpv), $texto_contrato);


    // Valor a pagar KALU
    $texto_contrato = preg_replace("/cuoton/", $cuota1, $texto_contrato);
    $texto_contrato = preg_replace("/cuotto/", $cuota2, $texto_contrato);
    $texto_contrato = preg_replace("/cuotth/", $cuota3, $texto_contrato);
    $texto_contrato = preg_replace("/cuotfo/", $cuota4, $texto_contrato);
    $texto_contrato = preg_replace("/cuotfi/", $cuota5, $texto_contrato);
    $texto_contrato = preg_replace("/cuotsi/", $cuota6, $texto_contrato);
    $texto_contrato = preg_replace("/cuotse/", $cuota7, $texto_contrato);
    $texto_contrato = preg_replace("/cuotei/", $cuota8, $texto_contrato);
    $texto_contrato = preg_replace("/cuotni/", $cuota9, $texto_contrato);
    $texto_contrato = preg_replace("/cuotte/", $cuota10, $texto_contrato);
    $texto_contrato = preg_replace("/cuotel/", $cuota11, $texto_contrato);
    $texto_contrato = preg_replace("/cuottw/", $cuota12, $texto_contrato);
    
    // Contrato Visionmagica
    $texto_contrato = preg_replace("/check_si/", $check_si, $texto_contrato);
    $texto_contrato = preg_replace("/check_no/", $check_no, $texto_contrato);
    $texto_contrato = preg_replace("/checkpostpago/", $checkpostpago, $texto_contrato);
    $texto_contrato = preg_replace("/checkprepago/", $checkprepago, $texto_contrato);
    $texto_contrato = preg_replace("/instalacion/", $instalacionclpv, $texto_contrato);
    $texto_contrato = preg_replace("/nocontado/", $nocontado, $texto_contrato);
    $texto_contrato = preg_replace("/sicontado/", $contado, $texto_contrato);
    $texto_contrato = preg_replace("/sininst/", $sininst, $texto_contrato);
    $texto_contrato = preg_replace("/coutas_inst/", $inst_cuot, $texto_contrato);
    $texto_contrato = preg_replace("/precioinstdif/", $precioinstdif, $texto_contrato);
    $texto_contrato = preg_replace("/precioinstcont/", $precioinstcont, $texto_contrato);
    $texto_contrato = preg_replace("/sobrenombreclpv/", $sobrenombreclpv, $texto_contrato);
    $texto_contrato = preg_replace("/ncanalescv/", $ncanalescv, $texto_contrato);
    $texto_contrato = preg_replace("/whatspe/", $whatspe, $texto_contrato);
    $texto_contrato = preg_replace("/canaleshd/", $canaleshd, $texto_contrato);
    $texto_contrato = preg_replace("/canalessd/", $canalessd, $texto_contrato);
    $texto_contrato = preg_replace("/frmacvision/", $identificadorcv, $texto_contrato);
    $texto_contrato = preg_replace("/imgoscip1/", $imgoscip1, $texto_contrato);
    $texto_contrato = preg_replace("/imgoscip2/", $imgoscip2, $texto_contrato);
    $texto_contrato = preg_replace("/iden_con_clpv/", $iden_con_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/segp2/", $sign, $texto_contrato);
    $texto_contrato = preg_replace("/trofp2/", $cali, $texto_contrato);
    $texto_contrato = preg_replace("/prohip2/", $not , $texto_contrato);
    $texto_contrato = preg_replace("/simep2/", $dual, $texto_contrato);
    $texto_contrato = preg_replace("/velop2/", $speed, $texto_contrato);
    $texto_contrato = preg_replace("/tcasp1/", $home, $texto_contrato);
    $texto_contrato = preg_replace("/audfp1/", $heat, $texto_contrato);
    $texto_contrato = preg_replace("/nubudp1/", $clud, $texto_contrato);
    $texto_contrato = preg_replace("/jugplp1/", $play, $texto_contrato);
    $texto_contrato = preg_replace("/paqunidos/", $paqunidos, $texto_contrato);
    $texto_contrato = preg_replace("/listserv/", $servicioscheck, $texto_contrato);

    // Contrato Accessnet
    $texto_contrato = preg_replace("/id_serv_empr/", $id_serv_empr, $texto_contrato);
    $texto_contrato = preg_replace("/id_serv_hog/", $id_serv_hog, $texto_contrato);
    /*  Este seccion de codigo remplaza las imagenes por su equivalente en base64 de acuerdo a un patro string en el formato html
        img::<carpetaPadre>_<carpetaHijo>_<nombreImagen>::<formatoImagen>::img
        ejm: img::cablevision_step2::jpg::img
        ejm html: <img src="img::cablevision_step2::jpg::img" style="width: 92%;object-fit:contain;text-align: center;">
    */

    /*
    $pattern = '/(img)::(\w+)::(\w+)::(img)/i';
    preg_match_all($pattern,$texto_contrato,$out, PREG_PATTERN_ORDER);
    foreach($out[2] as $x => $val) {
        $imgpath = explode('_',$val);
        $new_path='';
        foreach($imgpath as $i => $value) {
            
            if($i<(sizeof($imgpath)-1)){
                $new_path.=$value.'/';
            }else{
                $new_path.=$value;
            }
            
        }
        $img_base64 = '';
        $img_base64 = convertir_png_a_base64($img_base_path.$new_path.'.'.$out[3][$x]);
        $texto_contrato = preg_replace($pattern, $img_base64, $texto_contrato);
    }
    */

    /* Fin de seccion de remplazo de imagenes */


    $texto_contrato = preg_replace("/{nom_empr}/", $empr_nom_empr, $texto_contrato);
    $texto_contrato = preg_replace("/{ruc_empr}/", $empr_ruc_empr, $texto_contrato);
    $texto_contrato = preg_replace("/{anio_actual}/", substr($current_year, 0, 3), $texto_contrato);



    $texto_contrato = preg_replace("/siteco/", 'aaaassasasassa', $texto_contrato);



    $texto_contrato = preg_replace("/nombreclienteco/", $nom_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/identificacionco/", $ruc_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/emailco/", $email, $texto_contrato);

    $texto_contrato = preg_replace("/direccionco/", $direccion, $texto_contrato);

    $texto_contrato = preg_replace("/CLAUSULA/", 'CLÁUSULA', $texto_contrato);
    $texto_contrato = preg_replace("/optica/", 'óptica', $texto_contrato);
    $texto_contrato = preg_replace("/Inalambrico/", 'Inalámbrico', $texto_contrato);
    $texto_contrato = preg_replace("/Cibercafe/", 'Cibercafé', $texto_contrato);
    $texto_contrato = preg_replace("/maxima/", 'máxima', $texto_contrato);
    $texto_contrato = preg_replace("/Minima/", 'Mí­nima', $texto_contrato);
    $texto_contrato = preg_replace("/Comparticion/", 'Compartición', $texto_contrato);
    $texto_contrato = preg_replace("/minima/", 'mí­nima', $texto_contrato);
    $texto_contrato = preg_replace("/Electronico/", 'Electrónico', $texto_contrato);
    $texto_contrato = preg_replace("/Descripcion/", 'Descripción', $texto_contrato);
    $texto_contrato = preg_replace("/instalacion/", 'instalación', $texto_contrato);
    $texto_contrato = preg_replace("/dias/", 'días', $texto_contrato);
    $texto_contrato = preg_replace("/{fecha_ins}/", $fecha_final, $texto_contrato);
    $texto_contrato = preg_replace("/{nom_plan}/", $planes_nam, $texto_contrato);
    $texto_contrato = preg_replace("/{cod_cid}/", $codigo_cid, $texto_contrato);

    $texto_contrato = preg_replace("/{cliente}/", $nom_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/{beneficio_permanencia}/", '&nbsp;' . $observacion, $texto_contrato);
    $texto_contrato = preg_replace("/{valor_instala}/", $suscripcion, $texto_contrato);
    $texto_contrato = preg_replace("/{plazo_instala}/", '', $texto_contrato);
    $texto_contrato = preg_replace("/{codigo_remp}/", $codigo, $texto_contrato);

    $texto_contrato = preg_replace("/{max_subida}/", $subida_plan, $texto_contrato);
    $texto_contrato = preg_replace("/{max_bajada}/", $bajada_plan, $texto_contrato);

    $texto_contrato = preg_replace("/{min_subida}/", $subida_plan_min, $texto_contrato);
    $texto_contrato = preg_replace("/{min_bajada}/", $bajada_plan_min, $texto_contrato);

    $texto_contrato = preg_replace("/{valor_mensual}/", round($tarifa_sin_iva, 2), $texto_contrato);
    $texto_contrato = preg_replace("/{valor_otros}/", '0.00', $texto_contrato);
    $texto_contrato = preg_replace("/{valor_total}/", round($tarifa, 2), $texto_contrato);
    $texto_contrato = preg_replace("/{cliente_dni}/", $ruc_clpv, $texto_contrato);
    $texto_contrato = preg_replace("/{dni_vendedor}/", '1309105235', $texto_contrato);
    $texto_contrato = preg_replace("/{fima_remp}/", $fima_remp, $texto_contrato);
    $texto_contrato = preg_replace("/{duracion_contrato}/", $duracion, $texto_contrato);

    if ($tipo_categoria_txt == 'COORPORATIVO') {
        $texto_contrato = preg_replace("/{corporativo_select}/", 'X', $texto_contrato);
        $texto_contrato = preg_replace("/{residencial_select}/", '', $texto_contrato);
    } elseif ($tipo_categoria_txt == 'RESIDENCIAL') {
        $texto_contrato = preg_replace("/{residencial_select}/", 'X', $texto_contrato);
        $texto_contrato = preg_replace("/{corporativo_select}/", '', $texto_contrato);
    } else {
        $texto_contrato = preg_replace("/{corporativo_select}/", '', $texto_contrato);
        $texto_contrato = preg_replace("/{residencial_select}/", '', $texto_contrato);
    }

    $texto_contrato = preg_replace("/espacioco/", '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;', $texto_contrato);
    $texto_contrato = preg_replace("/dias/", 'dí­as', $texto_contrato);
    $texto_contrato = preg_replace("/planes_por_contrato/", $lista_planes_contenedor_html, $texto_contrato);

    $texto_contrato = preg_replace("/porcentaje_altura_plan/", ($altura_tipo_plan_base + $altura_tipo_plan), $texto_contrato);
    $texto_contrato = preg_replace("/porcentaje_altura_p2/", ($altura_tipo_plan_base_2 + $altura_tipo_plan), $texto_contrato);


    $texto_contrato = preg_replace("/img_pie_altura/", ($img_pie_altura + $altura_tipo_plan), $texto_contrato);
    $texto_contrato = preg_replace("/datos_clpv_altura/", ($datos_clpv_altura + $altura_tipo_plan), $texto_contrato);
    $texto_contrato = preg_replace("/rubrico_altura/", ($rubrico_altura + $altura_tipo_plan), $texto_contrato);
    $texto_contrato = preg_replace("/firma_contrato_altura/", ($firma_contrato_altura + $altura_tipo_plan), $texto_contrato);




    if (!empty($id_barrio)) {
        $sql_b = "SELECT barrio from isp.int_barrio WHERE id=$id_barrio";
        $name_barrio = consulta_string($sql_b, 'barrio', $oCon, ' ');
        $texto_contrato = preg_replace("/barrio_remp/", $name_barrio, $texto_contrato);
    }

    $tipo = 2;
    ////////////////////////////FACTURACION PDF////////////////////////////
    /*
    $texto_contrato = base64_encode($texto_contrato);

    $headers = array(
        "Content-Type:application/json"
    );

    $data_html = array(
        "contenido" => $texto_contrato,
        "opciones" => array(
            "tamano_pagina" => array(
                "tamano" => 'Letter'
            )
        ));

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_URL, URL_JIREH_DOCUMENTOS . "/core/reporte/convertir/html2pdf");
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data_html));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $data_pdf = curl_exec($ch);

    $ruta_pdf = DIR_FACTELEC . 'Include/archivos/aviso.pdf';
    header('Content-Type: application/pdf');
    file_put_contents($ruta_pdf, $data_pdf);

    $sHtml .= '<a href="' . $_COOKIE["JIREH_INCLUDE"] . '/archivos/aviso.pdf" download="aviso.pdf" id="txt">';
    $sHtml .= '<button type="button" class="btn btn-success btn-sm" style="width: 100%" title="">';
    $sHtml .= '<i class="fa fa-download" aria-hidden="true"></i> ';
    $sHtml .= 'Pulse aqui para descargar';
    $sHtml .= '</button>';
    $sHtml .= '</a>';

    $oReturn->script("Swal.fire({
                        type: 'success',
                        title: 'Aviso generado correctamente',
                        html: '$sHtml'
                    })");
*/
    ////////////////////////////FIN////////////////////////////
    ////////////////////////////FACTURACION NORMAL////////////////////////////


    $html = "";
    $html .= '<br>';
    $html .= '<p style=" text-align: justify;">' . $texto_contrato . '</p>';
    $html1 = "";

    $logo_desenfonque = $logo . "_desenfoque.jpg";

    if ($id_tip_contr == 1 || $id_tip_contr == 2) {
        $documento .= '<page backtop="10mm" backbottom="15mm" backleft="15mm" backright="15mm" backimgx="right" backimgy="bottom" backimgw="15%" >';
        $documento .= $html;
        $documento .= '</page>';
    } else {
        $documento .= '<page backtop="10mm" backbottom="15mm" backleft="15mm" backright="15mm" backimgx="right" backimgy="bottom" backimgw="15%" >';
        $documento .= $html;
        $documento .= '</page>';
    }


    // echo ($documento);
    // exit;

    $_SESSION['pdf'] = $documento;

    if (strpos($documento, 'oversize_cable_selva') !== false) {
        // $oReturn->script('processHTML2PDF(`' . $documento . '`)');
        $oReturn->script('print_as_document(`' . $documento . '`)');
        // $oReturn->script('print_as_document2(`' . $documento . '`)');
    } else {
        $oReturn->script('generar_pdf3(\'' . $formato . '\')');
    }

    $oReturn->assign('detalle_paquetes', 'innerHTML', $paquetes);


    ////////////////////////////FIN////////////////////////////
    return $oReturn;
}

function numero_a_palabra($n){


    $formatterES = new NumberFormatter("es-ES", NumberFormatter::SPELLOUT);
    $izquierda = intval(floor($n));
    $derecha = intval(($n - floor($n)) * 100);
    
    return ($derecha>0)?$formatterES->format($izquierda) . " coma " . $formatterES->format($derecha):$formatterES->format($izquierda);
}

function imprimirAnexo()
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oReturn = new xajaxResponse();

    $oReturn->script('generar_pdf2()');

    return $oReturn;
}

function listadoContratos($aForm = '', $id_clpv = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oConA = new Dbo;
    $oConA->DSN = $DSN;
    $oConA->Conectar();

    $fu = new Formulario;
    $fu->DSN = $DSN;

    $ifu = new Formulario;
    $ifu->DSN = $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de sesion
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    if (empty($id_clpv)) {
        //variables del formulario
        $id_clpv = $aForm['codigoCliente'];
    }

    $idContrato = $aForm['idContrato'];

    try {

        if (!empty($idContrato)) {
            $sql = "SELECT ruc_clpv
                    from isp.contrato_clpv
                    WHERE id = $idContrato";
            if ($oIfx->Query($sql)) {
                if ($oIfx->NumFilas() > 0) {
                    do {
                        $clpv_ruc_clpv = $oIfx->f('ruc_clpv');
                    } while ($oIfx->SiguienteRegistro());
                }
            }
            $oIfx->Free();
        }


        $sql = "SELECT sucu_cod_sucu, sucu_nom_sucu
                from saesucu
                WHERE sucu_cod_empr = $idempresa";
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                unset($arraySucursal);
                do {
                    $arraySucursal[$oIfx->f('sucu_cod_sucu')] = $oIfx->f('sucu_nom_sucu');
                } while ($oIfx->SiguienteRegistro());
            }
        }
        $oIfx->Free();

        //nom clpv
        $sql = "select clpv_nom_clpv from saeclpv where clpv_cod_clpv = '$id_clpv'";
        $clpv_nom_clpv = consulta_string_func($sql, 'clpv_nom_clpv', $oIfx, '');

        $sHtml = '<div class="modal-dialog modal-lg" role="document" style="width: 98%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel">Contratos Cliente ' . $clpv_nom_clpv . '</h4>
                        </div>
                        <div class="modal-body">';

        //query contrato
        $sql = "select id, id_sucursal, direccion, codigo, estado, fecha_contrato,
                fecha_firma, fecha_cobro, fecha_corte, cobro_directo,
                duracion, penalidad
                from isp.contrato_clpv
                where id_empresa = $idempresa and
                id_clpv = $id_clpv";
        //$oReturn->alert($sql);
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $sHtml .= '<table class="table table-bordered table-condensed table-hover">';
                $sHtml .= '<tr>';
                $sHtml .= '<td class="bg-primary" align="center" colspan="10">CONTRATOS REGISTRADOS</td>';
                $sHtml .= '</tr>';
                $sHtml .= '<tr>';
                $sHtml .= '<td>No.</td>';
                $sHtml .= '<td>SUCURSAL</td>';
                $sHtml .= '<td>CODIGO</td>';
                $sHtml .= '<td>FECHA</td>';
                $sHtml .= '<td>DIRECCION</td>';
                $sHtml .= '<td>ESTADO</td>';
                $sHtml .= '<td>BALANCE</td>';
                $sHtml .= '<td>ELEGIR</td>';
                $sHtml .= '</tr>';
                $i = 1;
                do {
                    $id = $oCon->f('id');
                    $id_sucursal = $oCon->f('id_sucursal');
                    $codigo = $oCon->f('codigo');
                    $direccion = $oCon->f('direccion');
                    $estado = $oCon->f('estado');
                    $fecha_contrato = $oCon->f('fecha_contrato');

                    $Contratos = new Contratos($oConA, $oIfx, $idempresa, $id_sucursal, $id_clpv, $id);
                    $deuda = $Contratos->consultaMontoMesAdeuda();

                    //nombre usuario
                    $sqlEstado = "select estado from isp.estado_contrato where id = '$estado'";
                    $nomEstado = consulta_string_func($sqlEstado, 'estado', $oConA, '');

                    $img = '';
                    if ($idsucursal == $id_sucursal) {
                        $img = '<div class="btn btn-success btn-sm" onclick="seleccionarContrato(' . $id_clpv . ', ' . $id . ');">
                                    <span class="glyphicon glyphicon-hand-right"></span>
                                </div>';
                    }
                    $sHtml .= '<tr>';
                    $sHtml .= '<td>' . $i++ . '</td>';
                    $sHtml .= '<td>' . $arraySucursal[$id_sucursal] . '</td>';
                    $sHtml .= '<td>' . $codigo . '</td>';
                    $sHtml .= '<td>' . fecha_mysql_dmy($fecha_contrato) . '</td>';
                    $sHtml .= '<td>' . $direccion . '</td>';
                    $sHtml .= '<td>' . $nomEstado . '</td>';
                    $sHtml .= '<td align="right" style="color: red; font-size: 15px; font-weight: bold;">' . $deuda . '</td>';
                    $sHtml .= '<td align="center">' . $img . '</td>';
                    $sHtml .= '</tr>';
                } while ($oCon->SiguienteRegistro());

                $sHtml .= '</table>';
            } else {
                $sHtml .= '<div class="alert alert-warning">Cliente no tiene Contratos Generados...!</div>';
            }
        }
        $oCon->Free();


        $sHtml .= '</div>
                        <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="continuarContrato(' . $id_clpv . ')">Generar Nuevo Contrato</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>';

        $oReturn->assign("miModal", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function barrio($cod)
{
    //Definiciones
    global $DSN_Ifx, $DSN, $DSN_Post;
    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $sql = "select barrio from isp.int_barrio where id='$cod'";
    if ($oCon->Query($sql)) {
        if ($oCon->NumFilas() > 0) {
            $nombre = $oCon->f('barrio');
        }
    }
    return $nombre;
}

function vivienda($cod)
{
    //Definiciones
    global $DSN_Ifx, $DSN, $DSN_Post;
    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $sql = "select tipo from tipo_casa where id='$cod'";
    if ($oCon->Query($sql)) {
        if ($oCon->NumFilas() > 0) {
            $nombre = $oCon->f('tipo');
        }
    }
    return $nombre;
}

function guardarAdjuntos($aForm = '')
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];
    $usuario_web = $_SESSION['U_ID'];

    //variables del formulario
    $cliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $adjunto = substr($aForm['archivo'], 12);
    $titulo = $aForm['titulo'];
    $fechaServer = date("Y-m-d H:i:s");

    if (!empty($titulo) && !empty($adjunto)) {
        try {

            $oCon->QueryT('BEGIN;');

            $sql = "insert into comercial.adjuntos_clpv (id_empresa, id_sucursal, id_clpv, id_contrato, titulo, ruta, estado, fecha_server, user_web)
										values($idempresa, $idsucursal, $cliente, $idContrato, '$titulo', '$adjunto', 'A', '$fechaServer', $usuario_web)";
            $oCon->QueryT($sql);

            $oCon->QueryT('COMMIT;');

            $oReturn->script("Swal.fire({
                                    type: 'success',
                                    title: 'Exito',
                                    text: 'Archivo subido de manera correcta'
                                })");

            //$oReturn->assign('titulo', 'value', '');
            $oReturn->assign('archivo', 'value', '');
            $oReturn->script('consultarAdjuntos();');
        } catch (Exception $e) {
            $oCon->QueryT('ROLLBACK;');
            $oReturn->alert($e->getMessage());
        }
    } else {
        $oReturn->alert('Ingrese Titulo y Archivo Adjunto..!');
    }

    return $oReturn;
}

function consultarAdjuntos($aForm = '')
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon2 = new Dbo();
    $oCon2->DSN = $DSN;
    $oCon2->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables de formulario
    $cliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        $sHtml .= '<table class="table table-condensed table-striped table-bordered table-hover" style="width: 98%;">';
        $sHtml .= '<tr>';
        $sHtml .= '<td colspan="4"><h5>ADJUNTOS <small>Reporte Informacion</small></h5></td>';
        $sHtml .= '</tr>';
        $sHtml .= '<tr>';
        $sHtml .= '<td>No.</td>';
        $sHtml .= '<td>Titulo</td>';
        $sHtml .= '<td>Adjunto</td>';
        $sHtml .= '<td>Eliminar</td>';
        $sHtml .= '</tr>';

        $sql = "select id, titulo, ruta
				from comercial.adjuntos_clpv
				where id_clpv = $cliente and
				id_contrato = $idContrato and
				id_empresa = $idempresa and estado = 'A'";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $i = 1;
                do {
                    $id = $oCon->f('id');
                    $titulo = $oCon->f('titulo');
                    $ruta = $oCon->f('ruta');

                    $optionTipoAdj = '';
                    $sql = "SELECT tipo
                            from isp.int_adjuntos_tipo
                            WHERE estado = 'A' and id = '$titulo'  and id_empresa=$idempresa";
                    if ($oCon2->Query($sql)) {
                        if ($oCon2->NumFilas() > 0) {
                            do {
                                $optionTipoAdj .= $oCon2->f('tipo');
                            } while ($oCon2->SiguienteRegistro());
                        }
                    }
                    $oCon2->Free();

                    $sHtml .= '<tr>';
                    $sHtml .= '<td>' . $i++ . '</td>';
                    $sHtml .= '<td>' . $optionTipoAdj . '</td>';
                    $sHtml .= '<td><a href="#" onclick="dowloand(\'' . $ruta . '\')">' . $ruta . '</a></td>';
                    $sHtml .= '<td><div align="center">
                                        <button type="button" class="btn btn-sm btn-danger" title="Eliminar adjunto" onclick="eliminarAdj(' . $id . ')"><i class="fa-solid fa-trash"></i>
                                        </button>
                                    </div>
                                </td>';
                    $sHtml .= '</tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $oReturn->assign('divReporteAdjuntos', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function generaDataMap($aForm = '')
{

    global $DSN_Ifx, $DSN;
    session_start();

    $oReturn = new xajaxResponse();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    //  LECTURA SUCIA
    //

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables de formulario
    $cliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $nombre = $aForm['nombre'];
    $latitud = trim($aForm['latitud']);
    $longuitud = trim($aForm['longuitud']);
    $callePrincipal = $aForm['callePrincipal'];
    $numeroDire = $aForm['numeroDire'];
    $calleSecundaria = $aForm['calleSecundaria'];

    $direccion = $callePrincipal . '-' . $numeroDire . '-' . $calleSecundaria;

    try {

        if (!empty($latitud) && !empty($longuitud)) {
            $xml .= '<markers>';
            $xml .= '<marker id="1" name="' . $nombre . '" address="' . $direccion . '" lat="' . $latitud . '" lng="' . $longuitud . '" type="restaurant"/>';
            $xml .= '</markers>';

            //MultiFirma
            $nomXml = "data.xml";

            $serv = "xml";

            $archivo = fopen($serv . '/' . $nomXml, "w+");

            fwrite($archivo, utf8_encode($xml));
            fclose($archivo);

            $path = "xml/data.xml";

            $oReturn->script('centrarMapa(' . $latitud . ', ' . $longuitud . ');');
            $oReturn->script('downloadUrl(\'' . $path . '\', generaLecturaXML);');
        }
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function obtenerCoordenadas($aForm = '')
{
    global $DSN_Ifx, $DSN;
    session_start();

    $oReturn = new xajaxResponse();

    $address = $aForm['direccion'];

    $address = urlencode($address);
    $url = "https://maps.google.com/maps/api/geocode/json?sensor=false&address=" . $address;
    $response = file_get_contents($url);
    $json = json_decode($response, true);

    $lat = $json['results'][0]['geometry']['location']['lat'];
    $lng = $json['results'][0]['geometry']['location']['lng'];

    $oReturn->assign('latitud', 'value', $lat);
    $oReturn->assign('longuitud', 'value', $lng);
    $oReturn->script('generaDataMap()');

    return $oReturn;
}

function genera_documento($id = '', $clavAcce = 'no_autorizado')
{
    session_start();
    global $DSN_Ifx;

    $oReturn = new xajaxResponse();

    //variables de session
    $idsucursal = $_SESSION['U_SUCURSAL'];
    $_SESSION['pdf'] = reporte_factura($id, $clavAcce, $idsucursal);


    $oReturn->script('generar_pdf()');

    return $oReturn;
}

function equipoServicio($aForm = '')
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oConA = new Dbo;
    $oConA->DSN = $DSN;
    $oConA->Conectar();

    $oReturn = new xajaxResponse();

    //clases contratos
    $classContratos = new Contratos();

    //variables de sesion
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $id_clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        $sHtml = $classContratos->modalEquipoServicio($oIfx, $oCon, $idempresa, $idsucursal, $idContrato, $id_clpv);

        $oReturn->assign('miModal', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function operacionServicio($aForm = '')
{

    global $DSN_Ifx, $DSN;
    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $classTelnet = new Telnet();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $id_clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    $activity = 5; //***Pedir la actividad***//

    try {

        $sql = "select olt
                from isp.int_registros_ont
                where id_empresa = $idempresa and
                id_sucursal = $idsucursal and
                id_contrato = $idContrato and
                state = 'A'";
        $idOlt = consulta_string_func($sql, 'olt', $oCon, 0);

        $sockTelnet = socket_create(AF_INET, SOCK_STREAM, getprotobyname('tcp'));

        $conexion = $classTelnet->conexionTelnet($oCon, $sockTelnet, $idOlt);

        if ($conexion == 'Conectado exitosamente!') {
            $corteServicio = $classTelnet->servicio($oCon, $sockTelnet, $idempresa, $idsucursal, $idOlt, $activity, $idContrato);
            $cierraConexion = $classTelnet->cierraConexion($sockTelnet);
        }

        $oReturn->alert($conexion);
        $oReturn->alert($corteServicio);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }
    return $oReturn;
}

function ordenesTrabajo($aForm = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $contratos = $aForm['idContrato'];
    $cliente = $aForm['codigoCliente'];

    try {

        $sql = "select id, descripcion from isp.int_tipo_proceso";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayProceso);
                do {
                    $arrayProceso[$oCon->f('id')] = $oCon->f('descripcion');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "select id, descripcion from isp.int_estados";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayEstado);
                do {
                    $arrayEstado[$oCon->f('id')] = $oCon->f('descripcion');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "select usuario_id, concat(usuario_nombre, ' ', usuario_apellido) as user
				from comercial.usuario";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayUsuario);
                do {
                    $arrayUsuario[$oCon->f('usuario_id')] = $oCon->f('user');
                } while ($oCon->SiguienteRegistro);
            }
        }
        $oCon->Free();

        $sHtml .= '<div class="modal-dialog" role="document" style="width: 80%;">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title text-primary" id="myModalLabel">Ordenes de Trabajo</h4>
							</div>
							<div class="modal-body" id="classModalBody">';

        $sql = "select id, id_motivo, secuencial, fecha, estado, 
				observaciones, id_proceso, fecha_server, user_web
				FROM isp.instalacion_clpv
				where id_empresa = $idempresa and
				id_clpv = $cliente and
				id_contrato = $contratos";
        //$oReturn->alert($sql);
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $sHtml .= '<table class="table table-condensed table-bordered table-striped">';
                $sHtml .= '<td>No.</td>';
                $sHtml .= '<td>Fecha</td>';
                $sHtml .= '<td>Proceso</td>';
                $sHtml .= '<td>Secuencial</td>';
                $sHtml .= '<td>Observaciones</td>';
                $sHtml .= '<td>Estado</td>';
                $sHtml .= '<td>Fecha Registro</td>';
                $sHtml .= '<td>User</td>';
                $sHtml .= '<td>Materiales</td>';
                $sHtml .= '<td>Print</td>';
                $sHtml .= '</tr>';
                $i = 1;
                do {
                    $id = $oCon->f('id');
                    $id_proceso = $oCon->f('id_proceso');
                    $id_motivo = $oCon->f('id_motivo');
                    $secuencial = $oCon->f('secuencial');
                    $fecha = $oCon->f('fecha');
                    $estado = $oCon->f('estado');
                    $observaciones = $oCon->f('observaciones');
                    $fecha_server = $oCon->f('fecha_server');
                    $user_web = $oCon->f('user_web');

                    $sHtml .= '<tr>';
                    $sHtml .= '<td>' . $i . '</td>';
                    $sHtml .= '<td>' . fecha_mysql_dmy($fecha) . '</td>';
                    $sHtml .= '<td>' . $arrayProceso[$id_proceso] . '</td>';
                    $sHtml .= '<td>' . $secuencial . '</td>';
                    $sHtml .= '<td>' . $observaciones . '</td>';
                    $sHtml .= '<td>' . $arrayEstado[$estado] . '</td>';
                    $sHtml .= '<td>' . $fecha_server . '</td>';
                    $sHtml .= '<td>' . $arrayUsuario[$user_web] . '</td>';
                    $sHtml .= '<td align="center">
									<div class="btn btn-success btn-sm" onclick="verMateriales(' . $id . ', ' . $cliente . ', ' . $contratos . ');">
										<span class="glyphicon glyphicon-th-list"></span>
									</div>
								</td>';
                    $sHtml .= '<td align="center">
									<div class="btn btn-primary btn-sm" onclick="vistaPrevia_1(' . $id . ', ' . $cliente . ', ' . $contratos . ');">
										<span class="glyphicon glyphicon-print"></span>
									</div>
								</td>';
                    $sHtml .= '</tr>';

                    $i++;
                } while ($oCon->SiguienteRegistro());
                $sHtml .= '</table>';
            }
        }
        $oCon->Free();

        $sHtml .= '</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
						</div>
					</div>
				</div>';

        $oReturn->assign("miModal", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function verMateriales($aForm = '', $id = 0, $id_clpv, $id_contrato = 0)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $contratos = $aForm['idContrato'];
    $cliente = $aForm['codigoCliente'];

    try {

        $sql = "select bode_cod_bode, bode_nom_bode from saebode";
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                unset($arrayBodega);
                do {
                    $arrayBodega[$oIfx->f('bode_cod_bode')] = $oIfx->f('bode_nom_bode');
                } while ($oIfx->SiguienteRegistro());
            }
        }
        $oIfx->Free();

        $sql = "select usuario_id, concat(usuario_nombre, ' ', usuario_apellido) as user
				from comercial.usuario";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayUsuario);
                do {
                    $arrayUsuario[$oCon->f('usuario_id')] = $oCon->f('user');
                } while ($oCon->SiguienteRegistro);
            }
        }
        $oCon->Free();

        $sHtml .= '<div class="modal-dialog" role="document" style="width: 60%;">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title text-primary" id="myModalLabel">Materiales</h4>
							</div>
							<div class="modal-body" id="classModalBody">';

        $sHtml .= '<div class="table-responsive">';

        $sql = "select id_bodega, id_prod, cantidad, estado, facturable, user_web,
				fecha_server
				from instalacion_materiales
				where id_instalacion = $id";
        //$oReturn->alert($sql);
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $sHtml .= '<table class="table table-condensed table-bordered table-striped">';
                $sHtml .= '<td>No.</td>';
                $sHtml .= '<td>Bodega</td>';
                $sHtml .= '<td>Item</td>';
                $sHtml .= '<td>Descripcion</td>';
                $sHtml .= '<td>Cantidad</td>';
                $sHtml .= '<td>User</td>';
                $sHtml .= '<td>Fecha Registro</td>';
                $sHtml .= '</tr>';
                $i = 1;
                do {
                    $id = $oCon->f('id');
                    $id_bodega = $oCon->f('id_bodega');
                    $id_prod = $oCon->f('id_prod');
                    $cantidad = $oCon->f('cantidad');
                    $facturable = $oCon->f('facturable');
                    $estado = $oCon->f('estado');
                    $fecha_server = $oCon->f('fecha_server');
                    $user_web = $oCon->f('user_web');

                    $sql = "select prod_nom_prod from saeprod where prod_cod_prod = '$id_prod'";
                    $prod_nom_prod = consulta_string_func($sql, 'prod_nom_prod', $oIfx, '');

                    $sHtml .= '<tr>';
                    $sHtml .= '<td>' . $i . '</td>';
                    $sHtml .= '<td>' . $arrayBodega[$id_bodega] . '</td>';
                    $sHtml .= '<td>' . $id_prod . '</td>';
                    $sHtml .= '<td>' . $prod_nom_prod . '</td>';
                    $sHtml .= '<td>' . $cantidad . '</td>';
                    $sHtml .= '<td>' . $arrayUsuario[$user_web] . '</td>';
                    $sHtml .= '<td>' . $fecha_server . '</td>';
                    $sHtml .= '</tr>';

                    $i++;
                } while ($oCon->SiguienteRegistro());
                $sHtml .= '</table>';
            }
        }
        $oCon->Free();

        $sHtml .= '</div>';

        $sHtml .= '</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
						 </div>
					</div>
				</div>';

        $oReturn->assign("miModalMateriales", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function vistaPrevia_1($aForm = '', $idComprobante = 0, $id_clpv = 0, $id_contrato = 0)
{

    //Definiciones
    global $DSN_Ifx, $DSN;
    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    unset($_SESSION['pdf_instalaciones']);

    try {

        $sql = "select id_proceso FROM isp.instalacion_clpv where id_contrato = $id_contrato and id_clpv = $id_clpv and id = $idComprobante";
        $id_proceso = consulta_string_func($sql, 'id_proceso', $oCon, 0);

        $sql = "select formato from isp.int_tipo_proceso where id = $id_proceso";
        $formato = consulta_string_func($sql, 'formato', $oCon, 0);

        //$oReturn->alert($id_contrato.'--'.$id_clpv.'--'.$idComprobante.'--'.$id_proceso.'--'.$formato);

        if ($id_proceso == 1) {
            unset($_SESSION[$formato]);
            $_SESSION[$formato] = formatoInstalacionContrato($id_clpv, $id_contrato, $idComprobante);
        } else {
            unset($_SESSION[$formato]);
            $_SESSION[$formato] = formatoCorteContrato($id_clpv, $id_contrato, $idComprobante);
        }


        $oReturn->script('generar_pdf_1(\'' . $formato . '\')');
    } catch (Exception $e) {

        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function secuencial_pedido($op, $serie, $as_codigo_pedido, $ceros_sql)
{
    $ls_codigos = str_pad($as_codigo_pedido, $ceros_sql, "0", STR_PAD_LEFT);

    return $ls_codigos;
}

function cero_mas($caracter, $num)
{
    if ($num > 0) {
        for ($i = 1; $i <= $num; $i++) {
            $arreglo[$i] = $caracter;
        }

        while (list($i, $Valor) = each($arreglo)) {
            $cadena .= $Valor;
        }
    } else {
        $cadena = '';
    }

    return $cadena;
}

function completaCeros($aForm = '')
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    //Definiciones
    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    //variable del formulario
    $num_digitos = $aForm['num_digitos'];
    $codigoContrato = $aForm['codigoContrato'];

    $ceros = secuencial(2, '', $codigoContrato - 1, $num_digitos);

    $oReturn->assign("codigoContrato", "value", $ceros);

    return $oReturn;
}

/* Guarda Imagen de Trazado */

function guardarTrazado($aForm = '', $codigo)
{

    global $DSN_Ifx, $DSN;
    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon1 = new Dbo;
    $oCon1->DSN = $DSN;
    $oCon1->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $base64 = $codigo;
    $fechaServer = date("Y-m-d H:i:s");

    try {

        // commit
        $oCon->QueryT('BEGIN;');

        $sql = "SELECT table_name FROM information_schema.columns 
                WHERE table_name='contrato_firmas' 
                AND table_schema = 'public'";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $table_name    = $oCon->f('table_name');
            }
        }
        $oCon->Free();

        if (empty($table_name)) {

            $oCon1->QueryT('BEGIN;');

            $sqlCreateTable = 'CREATE TABLE "public"."contrato_firmas" (
                                "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
                                INCREMENT 1
                                MINVALUE  1
                                MAXVALUE 2147483647
                                START 1
                                CACHE 1
                                ),
                                "id_contrato" int4 NOT NULL,
                                "imagen" text COLLATE "pg_catalog"."default" NOT NULL,
                                "created_at" timestamp(0),
                                "updated_at" timestamp(0)
                                );';
            $oCon1->QueryT($sqlCreateTable);

            $sqlClavePrimaria = 'ALTER TABLE "public"."contrato_firmas" ADD CONSTRAINT "contrato_firmas_pkey" PRIMARY KEY ("id");';
            $oCon1->QueryT($sqlClavePrimaria);

            $oCon1->QueryT('COMMIT;');
        }

        $imagen = preg_replace('#^data:image/\w+;base64,#i', '', $base64);

        $sql = "DELETE FROM contrato_firmas WHERE id_contrato = $idContrato";
        $oCon->QueryT($sql);

        $sql = "INSERT INTO contrato_firmas(id_contrato, imagen, created_at) VALUES($idContrato,'$imagen','$fechaServer')";

        $oCon->QueryT($sql);

        $oCon->QueryT('COMMIT;');
        $oReturn->script("Swal.fire({
                            type: 'success',
                            title: 'Exito',
                            text: 'Firma guardada de manera correcta'
                        })");
        $oReturn->script("seleccionarContrato($codigoCliente, $idContrato);");
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function continuarContrato($aForm = '', $id)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $ruc_cli = $aForm['ruc_cli'];
    $tipo = $aForm['identificacion'];

    $clpv_cod_clpv = 0;
    $clpv_ruc_clpv = '';
    $clpv_nom_clpv = '';
    $nombre = '';
    $apellido = '';

    try {

        $sql = "select clpv_cod_clpv, clpv_ruc_clpv, clpv_nom_clpv
                    from saeclpv where
                    clpv_cod_empr = $idempresa and
                    clpv_cod_clpv = $id ";
        //$oReturn->alert($sql);
        if ($oIfx->Query($sql)) {
            if ($oIfx->NumFilas() > 0) {
                $clpv_cod_clpv = $oIfx->f('clpv_cod_clpv');
                $clpv_ruc_clpv = $oIfx->f('clpv_ruc_clpv');
                $clpv_nom_clpv = $oIfx->f('clpv_nom_clpv');

                if ($clpv_cod_clpv > 0) {
                    $sql = "select nombre, apellido from isp.contrato_clpv where id_clpv = $clpv_cod_clpv";
                    if ($oCon->Query($sql)) {
                        $nombre = $oCon->f('nombre');
                        $apellido = $oCon->f('apellido');
                    }
                    $oCon->Free();
                }
                $oReturn->script('$("#nom_clpv").val("' . $clpv_nom_clpv . '");');
                $oReturn->script('$("#ruc_cli").val("' . $clpv_ruc_clpv . '");');
                $oReturn->script('$("#nombres").val("' . $nombre . '");');
                $oReturn->script('$("#apellidos").val("' . $apellido . '");');
                $oReturn->script('$("#miModal").modal("hide");');
            }
        }
        $oIfx->Free();
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function mirarPlanes($aForm, $int_tipo_serv_con)
{
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    unset($_SESSION['A_CI_PAQ']);
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    try {

        if (empty($idempresa)) {
            throw new Exception("Sesión finalizada, vuelva a ingresar para continuar.");
        }

        $id_api             = $_SESSION['id_api'];
        $estado_api         = $_SESSION['estado_api'];
        $gestion_bqn_sn     = $_SESSION['gestion_bqn_sn'];

        //variables del formulario
        $idContrato = $aForm['idContrato'];

        //tipo contrato
        $sql = "SELECT tipo_contrato, estado from isp.contrato_clpv WHERE id = $idContrato";
        $tipo_contrato = consulta_string_func($sql, 'tipo_contrato', $oCon, 0);
        $estado = consulta_string_func($sql, 'estado', $oCon, 0);

        //servicios de cada tipo
        $sql = "SELECT servicios from isp.int_tipo_contrato WHERE id = $tipo_contrato";
        $servicios_tipo = consulta_string_func($sql, 'servicios', $oCon, 0);

        //query validez del estado
        $sql = "SELECT aplica_servicios from isp.estado_contrato WHERE id = '$estado'";
        $aplica_servicios = consulta_string_func($sql, 'aplica_servicios', $oCon, 'N');

        if ($aplica_servicios == 'S') {

            $sql = "SELECT tipo, valor, equipo FROM isp.int_config_inst";
            $array_config_inst = array_dato($oCon, $sql, 'equipo', 'valor');

            $modal_contenido = '<div class="modal-dialog modal-lg" role="document" style="width:98%;">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <h5 class="modal-title" id="myModalLabel"><h3 class="text-primary"  align="center"> Selección de planes </h3><small></small></h5>
                                        </div>
                                        <div class="modal-body" style="margin-top:0xp;">
                                            <div class="col-md-12">
                                                    <ul class="nav nav-tabs" role="tablist"><br>';

            if ($id_api == 4 && $estado_api == 'A' && $gestion_bqn_sn == 'S') {
                $Webservice = new Webservice($oCon);

                $parametros = $Webservice->parametrosWS();

                $tipo_comando   = "LISTADO_ROUTERS";
                $tipo_sistema   = 1;
                $envio_get      = "";
                $envio_post     = "";
                array_push($parametros, $id_api, $tipo_comando, $tipo_sistema);

                $listado_routers  = $Webservice->enviaComando($parametros, $envio_get, $envio_post);

                $router_1 = '';
                if (count($listado_routers) > 0) {
                    $optionRouter = '<option value="0">Seleccione una opcion..</option>';
                    for ($i = 0; $i < count($listado_routers); $i++) {
                        $id             = $listado_routers[$i]["id"];
                        $id_olt_r       = $listado_routers[$i]["id_olt"];
                        $nombre         = $listado_routers[$i]["nombre"];

                        $selected = "";

                        if ($id_router == $id) {
                            $selected = "selected";
                        }

                        $optionRouter .= '<option value="' . $id . '" ' . $selected . '>' . $nombre . '</option>';
                    }
                }

                $modal_contenido .= '<div class="row">
                                        <div class="col-md-6">
                                            <div class="list-group">
                                                <a href="#" class="list-group-item list-group-item-action active">Servidor</a>
                                                <div class="list-group-item">
                                                    <select id="id_server_bqn" name="id_server_bqn" class="form-control input-sm" style="width:100%" onchange="cargarListasRouter()">
                                                        ' . $optionRouter . '
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="list-group">
                                                <a href="#" class="list-group-item list-group-item-action active">Politica</a>
                                                <div class="list-group-item">
                                                    <select id="politica_bqn" name="politica_bqn" class="form-control input-sm" style="width:100%">
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>';
            }
            $data_tipo_servicio = explode(",", $servicios_tipo);

            //PESTAÑAS
            for ($i = 0; $i < count($data_tipo_servicio); $i++) {

                $id_tipo = $data_tipo_servicio[$i];

                $sql = "SELECT nombre
                            from isp.int_tipo_prod 
                            where id = $id_tipo";
                if ($oCon->Query($sql)) {
                    if ($oCon->NumFilas() > 0) {
                        do {
                            $nom_tipo_contrato = $oCon->f('nombre');

                            $op_active_c = '';
                            if ($i == 0) {
                                $op_active_c = 'active';
                            }
                            $modal_contenido .= '<li role="presentation" id="tabId' . $id_tipo . '" class="' . $op_active_c . '"><a href="#tab' . $id_tipo . '" aria-controls="tab' . $id_tipo . '" role="tab" data-toggle="tab">' . $nom_tipo_contrato . '</a></li>';
                        } while ($oCon->SiguienteRegistro());
                    }
                }
                $oCon->Free();
            }

            //VENTANAS
            $modal_contenido .= '</ul><div class="tab-content">';
            for ($i = 0; $i < count($data_tipo_servicio); $i++) {

                $id_tipo = $data_tipo_servicio[$i];

                $sql = "SELECT nombre
                            from isp.int_tipo_prod 
                            where id = $id_tipo";
                if ($oCon->Query($sql)) {
                    if ($oCon->NumFilas() > 0) {
                        do {
                            $nom_tipo_contrato = $oCon->f('nombre');

                            $op_active_c = '';
                            if ($i == 0) {
                                $op_active_c = 'active';
                            }
                            $precio_instalacion = $array_config_inst[$id_tipo];
                            if (empty($precio_instalacion)) {
                                $precio_instalacion = 0;
                            }
                            $modal_contenido .= '<div role="tabpanel" class="tab-pane ' . $op_active_c . '" id="tab' . $id_tipo . '">
                                                    <div class="row" style="margin-bottom: 10px;">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-12">
                                                                    <h3 class="text-primary">Suscripci&oacute;n ' . $nom_tipo_contrato . ' </h3>
                                                                    
                                                                    <div class="form-group">

                                                                    
                                                                    <div class="input-group input-group-sm">
                                                                          </div>

                                               
                                                                        <div class="col-md-4">
                                                                            <label for="equipoCantidadP">Cantidad:</label>
                                                                            <input type="text" id="equipoCantidad' . $id_tipo . '" name="equipoCantidad' . $id_tipo . '" class="form-control" value="1" style="text-align: right;" onkeyup="calcularTotalEquipo(' . $id_tipo . ')"/>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <label for="equipoPrecioP">Precio:</label>
                                                                            <input type="text" id="equipoPrecio' . $id_tipo . '" name="equipoPrecio' . $id_tipo . '" class="form-control" value="' . $precio_instalacion . '" style="text-align: right;" onkeyup="calcularTotalEquipo(' . $id_tipo . ')" />
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <label for="equipoTotalP">Total:</label>
                                                                            <input type="text" id="equipoTotal' . $id_tipo . '" name="equipoTotal' . $id_tipo . '" class="form-control" value="0" style="text-align: right; color: red;" readonly />
                                                                        </div>
                                                                    </div>
                                                                    
                                                                    <div class="form-group">
                                                                        <div class="col-md-12 table-responsive" style="margin-top: 20px;">
                                                                            <table id="tablePaquetes' . $id_tipo . '" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%;" align="center">
                                                                                <thead>
                                                                                    <tr>
                                                                                        <td>Codigo</td>
                                                                                        <td>Servicio</td>
                                                                                        <td>Tipo</td>
                                                                                        <td>Precio</td>
                                                                                        <td>Seleccionar</td>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>';
                        } while ($oCon->SiguienteRegistro());
                    }
                }
                $oCon->Free();
            }

            $modal_observaciones = '</div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="control-label text-primary">Observaciones:</label>
                                                <textarea id="observacionesOrdenContrato" name="observacionesOrdenContrato" class="form-control" rows="3" style="width:100%"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" onclick="agregarEquipoPaquetes(' . $idContrato . ')">Ver Resumen</button>
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                                    </div>
                                </div>
                            </div>';

            $modal_ok .= $modal_contenido;
            $modal_ok .= $modal_observaciones;

            $oReturn->assign('miModalPaquetes', 'innerHTML', $modal_ok);
            $oReturn->script('$("#miModalPaquetes").modal("show")');

            //EJECUTA SCRIPT PARA TABLAS
            for ($i = 0; $i < count($data_tipo_servicio); $i++) {

                $id_tipo = $data_tipo_servicio[$i];

                $oReturn->script("ejecutarScripts($idContrato,$id_tipo, $int_tipo_serv_con);");
                $oReturn->script("calcularTotalEquipo($id_tipo)");
            }
            $oReturn->script('$("#miModal").modal("hide")');
        } else {
            $oReturn->script("Swal.fire({
                type: 'error',
                title: 'Contrato no habilitado para agregar servicios'
            })");
        }
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function contarEquiposContrato($aForm = '')
{

    //Definiciones
    global $DSN;
    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $codigoCliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        $sql = "select id, serial
				from isp.int_dispositivos
				where id_empresa = $idempresa";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayDispositivo);
                do {
                    $arrayDispositivo[$oCon->f('id')] = $oCon->f('serial');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "select id, estado, color
				from isp.int_estados_equipo";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayEstado);
                do {
                    $arrayEstado[] = array($oCon->f('id'), $oCon->f('estado'), $oCon->f('color'));
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $total = 0;
        $sql = "SELECT COUNT(*) as contador, id_dispositivo, estado
				from isp.int_contrato_caja
				WHERE id_clpv = $codigoCliente AND
				id_contrato = $idContrato AND
				id_empresa = $idempresa
				GROUP BY 2,3
				ORDER BY 2,3";
        //$oReturn->alert($sql);
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($array);
                unset($arrayContadorCaja);
                do {
                    $array[] = array($oCon->f('id_dispositivo'));
                    $arrayContadorCaja[$oCon->f('id_dispositivo')][$oCon->f('estado')] = $oCon->f('contador');

                    $total += $oCon->f('contador');
                } while ($oCon->SiguienteRegistro());
                $array = array_unique($array);
            }
        }
        $oCon->Free();

        $sHtml = '<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseExample" aria-expanded="true" aria-controls="collapseExample"
					title="Presionar aqui para mirar el listado de equipos agrupado por estado">
					<i class="fa fa-plus-circle"></i> Resumen de Equipos (' . $total . ')
					</a>';
        $sHtml .= '<div class="collapse" id="collapseExample">';
        $sHtml .= '<div class="well" style="width: 99%; margin-left: 2px;">';

        $sHtml .= '<div class="table-responsive">';
        $sHtml .= '<table class="table table-condensed table-striped table-hover table-bordered" style="width: 100%;" align="center">';
        $sHtml .= '<tr>';
        $sHtml .= '<th>DISPOSITIVO</th>';

        if (count($arrayEstado) > 0) {
            foreach ($arrayEstado as $valEstado) {
                $sHtml .= '<th>' . $valEstado[1] . '</th>';
            }
        }

        $sHtml .= '<th>TOTAL</th>';
        $sHtml .= '</tr>';

        if (count($array) > 0) {
            unset($arrayCajaTotal);
            foreach ($array as $val) {
                $id_dispositivo = $val[0];

                $sHtml .= '<tr>';

                $sHtml .= '<td style="font-size: 14px;">' . $arrayDispositivo[$id_dispositivo] . '</td>';

                $totalCajas = 0;
                if (count($arrayEstado) > 0) {
                    foreach ($arrayEstado as $valEstado) {
                        $numCajasEstado = $arrayContadorCaja[$id_dispositivo][$valEstado[0]];

                        if (empty($numCajasEstado)) {
                            $numCajasEstado = 0;
                        }

                        $onclick = "";
                        if ($numCajasEstado > 0) {
                            $onclick = 'onclick="listaEquiposPorEstado(' . $id_dispositivo . ', \'' . $valEstado[0] . '\');"';
                        }

                        $sHtml .= '<td style="font-size: 14px; cursor: pointer" align="right" ' . $onclick . '><span class="text-right pull-right badge bg-' . $valEstado[2] . '">' . $numCajasEstado . '</span></td>';
                        $totalCajas += $numCajasEstado;

                        $arrayCajaTotal[$valEstado[0]] += $numCajasEstado;
                    }
                }
                $sHtml .= '<td align="right"><span class="text-right pull-right badge bg-red">' . $totalCajas . '</span></td>';
                $sHtml .= '</tr>';
            }

            $sHtml .= '<tr>';
            $sHtml .= '<td style="font-size: 14px;" class="text-right text-danger fecha_letra">Total:</td>';

            $total = 0;
            $granTotal = 0;
            if (count($arrayEstado) > 0) {
                foreach ($arrayEstado as $valEstado) {
                    $granTotal = $arrayCajaTotal[$valEstado[0]];
                    $sHtml .= '<td style="font-size: 14px;" class="text-right text-danger fecha_letra">' . $granTotal . '</td>';
                    $total += $granTotal;
                }
            }
            $sHtml .= '<td align="right"><span class="text-right pull-right badge bg-red">' . $total . '</span></td>';
            $sHtml .= '</tr>';
        }

        $sHtml .= '</table>';
        $sHtml .= '</div>';
        $sHtml .= '</div>';
        $sHtml .= '</div>';

        $oReturn->assign("divButtonCollapse", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function algoritmoCodigo($numero, $num_digitos, $num_letras)
{

    $array_n = str_split($numero);
    $codigo = '';
    if (!$num_digitos) {
        $num_digitos = 0;
    }
    if (!$num_letras) {
        $num_letras = 0;
    }

    for ($i = 0; $i < $num_letras; $i++) {
        $num = $array_n[$i];
        switch ($num) {
            case 0:
                $codigo .= 'Z';
                break;
            case 1:
                $codigo .= 'O';
                break;
            case 2:
                $codigo .= 'T';
                break;
            case 3:
                $codigo .= 'R';
                break;
            case 4:
                $codigo .= 'F';
                break;
            case 5:
                $codigo .= 'I';
                break;
            case 6:
                $codigo .= 'S';
                break;
            case 7:
                $codigo .= 'E';
                break;
            case 8:
                $codigo .= 'G';
                break;
            case 9:
                $codigo .= 'N';
                break;
        }
    }

    for ($j = 0; $j < $num_digitos; $j++) {
        $num2 = $array_n[$j];
        $codigo .= $num2;
    }


    return $codigo;
}

function cargarCodigoRuta($aForm, $op)
{
    session_start();
    global $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    try {

        //ruta
        $rutaDire = $aForm['rutaDire'];

        if ($rutaDire > 0) {

            if ($op == 1) { //busca por contrato
                $sql = "SELECT max(orden_ruta) as maximo
						from isp.contrato_clpv
						WHERE id_ruta = $rutaDire";
                $max = consulta_string_func($sql, 'maximo', $oCon, 0);

                $oReturn->assign('ordenRutaDire', 'value', ($max + 1));
            } elseif ($op == 2) { //depende formulario

                $max = $aForm['ordenRutaDire'] - 1;
            }

            //amar codigo
            $sql = "SELECT codigo, digitos from isp.int_rutas WHERE id = $rutaDire";
            $codigo = consulta_string_func($sql, 'codigo', $oCon, 0);
            $digitos = consulta_string_func($sql, 'digitos', $oCon, 0);

            $codigo_ok = $codigo . '' . secuencial_pedido(2, '0', $max, $digitos);

            $oReturn->assign('codigoRutaDire', 'value', $codigo_ok);
        }
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function aprobarContrato($aForm, $id_motivo, $op_factura, $aprobar_fecha_cuota, $aprobar_dias_sn = 'N', $cuotas_instalacion = 0, $descuento_cuotas_valor = "", $descuento_cuotas_porcentaje = "", $genera_cuotas_sn = 'N', $comentario_instalacion = '')
{

    global $DSN_Ifx, $DSN;
    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon2 = new Dbo;
    $oCon2->DSN = $DSN;
    $oCon2->Conectar();

    $oCon3 = new Dbo;
    $oCon3->DSN = $DSN;
    $oCon3->Conectar();

    $oReturn = new xajaxResponse();

    $userWeb            = $_SESSION['U_ID'];
    $idempresa          = $_SESSION['U_EMPRESA'];
    $idsucursal         = $_SESSION['U_SUCURSAL'];
    $difiere_inst_sn    = $_SESSION['difiere_inst_sn'];

    $idContrato         = $aForm['idContrato'];
    $tipo_iden          = $aForm['identificacion'];
    $fecha              = date("Y-m-d");
    $fechaServer        = date("Y-m-d H:i:s");
    $opTarea            = 1;
    $observaciones      = $comentario_instalacion;

    $descuento_cuotas_valor = (array)json_decode($descuento_cuotas_valor, true);
    $descuento_cuotas_porcentaje = (array)json_decode($descuento_cuotas_porcentaje, true);

    try {

        // commit
        $oCon->QueryT('BEGIN;');
        $oCon2->QueryT('BEGIN;');
        $oCon3->QueryT('BEGIN;');

        $sql = "SELECT estado, id_dire, tipo_contrato, instalador from isp.contrato_clpv WHERE id = $idContrato";
        $estado_c       = consulta_string_func($sql, 'estado', $oCon, 0);
        $id_dire        = consulta_string_func($sql, 'id_dire', $oCon, 0);
        $tipo_contrato  = consulta_string_func($sql, 'tipo_contrato', $oCon, 0);
        $valida_diferir = consulta_string_func($sql, 'instalador', $oCon, 0);

        if ($aprobar_dias_sn == 'true') {
            $aprobar_dias_sn = 'S';
        } else {
            $aprobar_dias_sn = 'N';
        }

        $sql = "SELECT count(*) as control from isp.int_contrato_caja WHERE id_contrato = $idContrato AND estado = 'P'";
        $control_c = consulta_string_func($sql, 'control', $oCon, 0);

        $sql = "SELECT count(*) as control FROM isp.instalacion_clpv WHERE id_contrato = $idContrato AND id_proceso = $opTarea AND estado != 'AN'";
        $control = consulta_string_func($sql, 'control', $oCon, 0);

        $sql = "SELECT count(*) as doc_obligatorios FROM isp.int_adjuntos_tipo WHERE estado = 'A'  AND obligatorio = 'S' AND tip_docu='$tipo_iden'";
        $doc_obligatorios = consulta_string_func($sql, 'doc_obligatorios', $oCon, 0);

        $tipo_obligatorio = '';
        $sql = "SELECT id FROM isp.int_adjuntos_tipo WHERE estado = 'A' AND obligatorio = 'S'";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id_adjunto = $oCon->f('id');

                    $tipo_obligatorio .= "'" . $id_adjunto . "',";
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $tipo_obligatorio = substr($tipo_obligatorio, 0, strlen($tipo_obligatorio) - 1);

        if (strlen($tipo_obligatorio) > 0) {
            $sql = "SELECT count(*) as control_adjuntos FROM comercial.adjuntos_clpv WHERE id_contrato = $idContrato AND estado = 'A' AND titulo in ($tipo_obligatorio)";
            $control_adjuntos = consulta_string_func($sql, 'control_adjuntos', $oCon, 0);
        } else {
            $control_adjuntos = 0;
            $doc_obligatorios = 0;
        }

        if ($control_adjuntos >= $doc_obligatorios) {
            if ($control_c > 0) {
                if ($control >= 0) {

                    //CONSULTA DE PARAMETROS

                    $classParametros = new int_parametros($oCon, $idempresa, $idsucursal);
                    $arrayParametros = $classParametros->consultarParametros();
                    $objectParametros = (object)$arrayParametros;
                    $codigo_automatico = $objectParametros->codigo_automatico;
                    $num_digitos = $objectParametros->num_digitos;
                    $num_letras = $objectParametros->num_letras;
                    $codigo_actual = $objectParametros->codigo_actual;
                    $abonado_actual = $objectParametros->abonado_actual;
                    $dia_corte = $objectParametros->dia_corte;
                    $dia_cobro = $objectParametros->dia_cobro;
                    $aprueba_instalacion = $objectParametros->aprueba_instalacion;
                    $cierre_instalacion = $objectParametros->cierre_instalacion;
                    $estado_aprueba = $objectParametros->estado_aprueba;
                    $aprobar_f = $objectParametros->aprobar_f;

                    if (!empty($estado_aprueba)) {
                        //duracion fecha_pago contrato
                        $sql = "SELECT id_dire, id_clpv, estado, tarifa
                            from isp.contrato_clpv 
                            where id = $idContrato and 
                            id_empresa = $idempresa";
                        if ($oCon->Query($sql)) {
                            if ($oCon->NumFilas() > 0) {
                                $id_dire = $oCon->f('id_dire');
                                $idClpv = $oCon->f('id_clpv');
                                $tarifa_contrato = $oCon->f('tarifa');
                            }
                        }
                        $oCon->Free();
                        //descuento cuotas
                        if (count($descuento_cuotas_valor) > 0 && count($descuento_cuotas_porcentaje) > 0) {
                            $i = 0;
                            foreach ($descuento_cuotas_valor as $valor_descuento) {
                                $valor_descuento = $valor_descuento["valorCuotaDescuento"];
                                $valor_porcentaje = $descuento_cuotas_porcentaje[$i]["porcentajeCuotaDescuento"];
                                $valor_porcentaje = str_replace('%', '', $valor_porcentaje);

                                if ($valor_descuento == "") {
                                    $valor_descuento = 0;
                                }
                                if ($valor_porcentaje == "") {
                                    $valor_porcentaje = 0;
                                }
                                $cuota_id = $i + 1;
                                $sql = "INSERT INTO isp.int_contrato_descuento(id_contrato, cuotas, descuento_p, descuento, incluye_pc,dias_consumo) VALUES ($idContrato, $cuota_id, $valor_porcentaje, $valor_descuento, '$primera_cuota_sn','$aprobar_dias_sn')";
                                $oCon2->QueryT($sql);
                                $i++;
                            }
                        }

                        //DESDE AQUI VA EL CAMBIO PARA DIFERIR LA INSTALACION DE MANERA PERSONALIZADA

                        if ($difiere_inst_sn == 'S' && $valida_diferir == '2') {
                            //INGRESO DE SUSCRIPCION
                            $array_suscribir = array();
                            $sql = "SELECT id, equipo, tipo, cantidad, total, detalle, precio
                                from isp.int_suscribir
                                WHERE id_clpv = $idClpv AND
                                id_contrato = $idContrato AND
                                estado = 'PE' and tipo = 'P'";
                            if ($oCon->Query($sql)) {
                                if ($oCon->NumFilas() > 0) {
                                    $suma = 0;
                                    do {
                                        $id = $oCon->f('id');
                                        $equipo = $oCon->f('equipo');
                                        $tipo = $oCon->f('tipo');
                                        $cantidad = $oCon->f('cantidad');
                                        $total = $oCon->f('total');
                                        $detalle = $oCon->f('detalle');
                                        $precio = $oCon->f('precio');
                                        $array_suscribir[] = array(
                                            "id" => $id,
                                            "equipo" => $equipo,
                                            "tipo" => $tipo,
                                            "cantidad" => $cantidad,
                                            "total" => $total,
                                            "detalle" => $detalle,
                                            "precio" => $precio
                                        );
                                        $suma += $total;
                                    } while ($oCon->SiguienteRegistro());
                                }
                            }
                            $oCon->Free();
                            if (count($array_suscribir) > 0) {
                                //config suscripcion
                                $sql = "SELECT equipo, id_prod, cod_prod
                                    from isp.int_config_inst
                                    WHERE id_empresa = $idempresa AND
                                    id_sucursal = $idsucursal";
                                $array_id_prod = array_dato($oCon, $sql, 'equipo', 'id_prod');
                                $array_cod_prod = array_dato($oCon, $sql, 'equipo', 'cod_prod');
                                $mes = date("m");
                                $anio = date("Y");
                                $cero = 0;

                                for ($i = 0; $i < count($array_suscribir); $i++) {
                                    $valor_cuota_c = $array_suscribir[$i]["total"];

                                    if ($valor_cuota_c > 0) {
                                        //insert tabla de pagos
                                        $sql = "INSERT into isp.contrato_pago (id_contrato, id_clpv, fecha, secuencial, estado, mes, anio, tarifa, 
                                                                        can_add, pre_add, tot_add, valor_pago, valor_dia, valor_uso, valor_no_uso,
                                                                        dias, dias_uso, dias_no_uso, detalle, tipo)
                                                                values($idContrato, $idClpv, '$fecha', 0, 'PE', '$mes', '$anio', $valor_cuota_c,
                                                                        $cero, $cero, $cero, $cero, $cero, $cero, $cero,
                                                                        $cero, $cero, $cero, 'CARGO POR INSTALACION', 'A')";
                                        $oCon->QueryT($sql);
                                    }
                                    $sql = "SELECT max(id) as id 
                                        FROM isp.contrato_pago 
                                        WHERE id_contrato = $idContrato AND
                                        id_clpv = $idClpv AND 
                                        fecha = '$fecha' AND 
                                        tipo = 'A'";
                                    $idCuota = consulta_string_func($sql, 'id', $oCon, 0);

                                    $id_tipo_prod = $array_suscribir[$i]["equipo"];

                                    if ($tipo_contrato == 7 || $tipo_contrato == 12 && $j > 0) {
                                        $sql = "SELECT max(id) as id_caja
                                        from isp.int_contrato_caja 
                                        WHERE id_contrato = $idContrato AND id_tipo_prod = 2 AND estado = 'P'";

                                        $id_caja_n = consulta_string_func($sql, 'id_caja', $oCon, 0);
                                    } else {
                                        $sql = "SELECT max(id) as id_caja
                                        from isp.int_contrato_caja 
                                        WHERE id_contrato = $idContrato AND id_tipo_prod = $id_tipo_prod AND estado = 'P'";

                                        $id_caja_n = consulta_string_func($sql, 'id_caja', $oCon, 0);
                                    }

                                    $sql = "SELECT max(id) as id_caja_pack
                                        from isp.int_contrato_caja_pack
                                        WHERE id_contrato = $idContrato AND id_caja = $id_caja_n";
                                    $id_caja_pack_n = consulta_string_func($sql, 'id_caja_pack', $oCon, 0);
                                    if (empty($detalle)) {
                                        $detalle = $array_e[$equipo] . ' - ' . $array_t[$tipo] . ' : ' . $cantidad;
                                    }

                                    $precio_sus = $array_suscribir[$i]["precio"];
                                    $id_prod = $array_id_prod[$id_tipo_prod];
                                    $cod_prod = $array_cod_prod[$id_tipo_prod];

                                    if (empty($id_prod) || empty($cod_prod)) {
                                        throw new Exception("No se encuentra configurado los planes para la suscripcion, configurarlos en la parametrizacion de cable operador");
                                    } else {
                                        $precio_ok = $precio_sus;
                                        if ($precio_ok > 0) {
                                            $sql = "INSERT into isp.contrato_pago_pack(id_empresa, id_sucursal, id_clpv, id_contrato,
                                                                            id_caja, id_pack, id_pago, id_prod, cod_prod, fecha, 
                                                                            tarifa, valor_pago, valor_dia, valor_uso, valor_no_uso,
                                                                            dias, dias_uso, estado, detalle, id_refe, user_web, fecha_server, descuento, valor_nc, tipo)
                                                                    values($idempresa, $idsucursal, $idClpv, $idContrato,
                                                                            $id_caja_n, $id_caja_pack_n, $idCuota, $id_prod, '$cod_prod', '$fecha',
                                                                            $precio_ok, $cero, $cero, $cero, $cero,
                                                                            $cero, $cero, 'A', '$detalle', $id, $userWeb, now(), 0, 0, 'A')";
                                            $oCon->QueryT($sql);
                                        }
                                    }
                                } //fin for
                                //abre ventana de facturacion
                                if ($aprobar_f == 'S' || $op_factura == true) {
                                    $ruta = 'int_facturacion/facturacion.php';
                                    $oReturn->script('abrirVentaFactura(\'../' . $ruta . '?sesionId=' . session_id() . '\', ' . $idClpv . ', ' . $idContrato . ')');
                                }
                            }
                        } else {
                            //INGRESO DE SUSCRIPCION
                            $array_suscribir = array();
                            $sql = "SELECT id, equipo, tipo, cantidad, total, detalle, precio
                                from isp.int_suscribir
                                WHERE id_clpv = $idClpv AND
                                id_contrato = $idContrato AND
                                estado = 'PE'";
                            if ($oCon->Query($sql)) {
                                if ($oCon->NumFilas() > 0) {
                                    $suma = 0;
                                    do {
                                        $id = $oCon->f('id');
                                        $equipo = $oCon->f('equipo');
                                        $tipo = $oCon->f('tipo');
                                        $cantidad = $oCon->f('cantidad');
                                        $total = $oCon->f('total');
                                        $detalle = $oCon->f('detalle');
                                        $precio = $oCon->f('precio');
                                        $array_suscribir[] = array(
                                            "id" => $id,
                                            "equipo" => $equipo,
                                            "tipo" => $tipo,
                                            "cantidad" => $cantidad,
                                            "total" => $total,
                                            "detalle" => $detalle,
                                            "precio" => $precio
                                        );
                                        $suma += $total;
                                    } while ($oCon->SiguienteRegistro());
                                }
                            }
                            $oCon->Free();
                            if (count($array_suscribir) > 0) {
                                //config suscripcion
                                $sql = "SELECT equipo, id_prod, cod_prod
                                    from isp.int_config_inst
                                    WHERE id_empresa = $idempresa AND
                                    id_sucursal = $idsucursal";
                                $array_id_prod = array_dato($oCon, $sql, 'equipo', 'id_prod');
                                $array_cod_prod = array_dato($oCon, $sql, 'equipo', 'cod_prod');
                                $mes = date("m");
                                $anio = date("Y");
                                $cero = 0;
                                $valor_cuota_c = $suma / $cuotas_instalacion;
                                for ($i = 1; $i <= $cuotas_instalacion; $i++) {
                                    if ($valor_cuota_c > 0) {
                                        //insert tabla de pagos
                                        $sql = "INSERT into isp.contrato_pago (id_contrato, id_clpv, fecha, secuencial, estado, mes, anio, tarifa, 
                                                                        can_add, pre_add, tot_add, valor_pago, valor_dia, valor_uso, valor_no_uso,
                                                                        dias, dias_uso, dias_no_uso, detalle, tipo)
                                                                values($idContrato, $idClpv, '$fecha', 0, 'PE', '$mes', '$anio', $valor_cuota_c,
                                                                        $cero, $cero, $cero, $cero, $cero, $cero, $cero,
                                                                        $cero, $cero, $cero, 'CARGO POR INSTALACION', 'A')";
                                        $oCon->QueryT($sql);
                                    }
                                    $sql = "SELECT max(id) as id 
                                        FROM isp.contrato_pago 
                                        WHERE id_contrato = $idContrato AND
                                        id_clpv = $idClpv AND 
                                        fecha = '$fecha' AND 
                                        tipo = 'A'";
                                    $idCuota = consulta_string_func($sql, 'id', $oCon, 0);

                                    for ($j = 0; $j < count($array_suscribir); $j++) {

                                        $id_tipo_prod = $array_suscribir[$j]["equipo"];

                                        if ($tipo_contrato == 7 || $tipo_contrato == 12 && $j > 0) {
                                            $sql = "SELECT max(id) as id_caja
                                            from isp.int_contrato_caja 
                                            WHERE id_contrato = $idContrato AND id_tipo_prod = 2 AND estado = 'P'";

                                            $id_caja_n = consulta_string_func($sql, 'id_caja', $oCon, 0);
                                        } else {
                                            $sql = "SELECT max(id) as id_caja
                                            from isp.int_contrato_caja 
                                            WHERE id_contrato = $idContrato AND id_tipo_prod = $id_tipo_prod AND estado = 'P'";

                                            $id_caja_n = consulta_string_func($sql, 'id_caja', $oCon, 0);
                                        }

                                        $sql = "SELECT max(id) as id_caja_pack
                                            from isp.int_contrato_caja_pack
                                            WHERE id_contrato = $idContrato AND id_caja = $id_caja_n";
                                        $id_caja_pack_n = consulta_string_func($sql, 'id_caja_pack', $oCon, 0);
                                        if (empty($detalle)) {
                                            $detalle = $array_e[$equipo] . ' - ' . $array_t[$tipo] . ' : ' . $cantidad;
                                        }
                                        if ($cuotas_instalacion > 0) {
                                            $valor_cuota = $valor_cuota / $cuotas_instalacion;
                                        }
                                        $precio_sus = $array_suscribir[$j]["precio"];
                                        $id_prod = $array_id_prod[$id_tipo_prod];
                                        $cod_prod = $array_cod_prod[$id_tipo_prod];

                                        if (empty($id_prod) || empty($cod_prod)) {
                                            throw new Exception("No se encuentra configurado los planes para la suscripcion, configurarlos en la parametrizacion de cable operador");
                                        } else {
                                            $precio_ok = $precio_sus / $cuotas_instalacion;
                                            if ($precio_ok > 0) {
                                                $sql = "INSERT into isp.contrato_pago_pack(id_empresa, id_sucursal, id_clpv, id_contrato,
                                                                                id_caja, id_pack, id_pago, id_prod, cod_prod, fecha, 
                                                                                tarifa, valor_pago, valor_dia, valor_uso, valor_no_uso,
                                                                                dias, dias_uso, estado, detalle, id_refe, user_web, fecha_server, descuento, valor_nc, tipo)
                                                                        values($idempresa, $idsucursal, $idClpv, $idContrato,
                                                                                $id_caja_n, $id_caja_pack_n, $idCuota, $id_prod, '$cod_prod', '$fecha',
                                                                                $precio_ok, $cero, $cero, $cero, $cero,
                                                                                $cero, $cero, 'A', '$detalle', $id, $userWeb, now(), 0, 0, 'A')";
                                                $oCon->QueryT($sql);
                                            }
                                        }
                                    }
                                } //fin for
                                //abre ventana de facturacion
                                if ($aprobar_f == 'S' || $op_factura == true) {
                                    $ruta = 'int_facturacion/facturacion.php';
                                    $oReturn->script('abrirVentaFactura(\'../' . $ruta . '?sesionId=' . session_id() . '\', ' . $idClpv . ', ' . $idContrato . ')');
                                }
                            }
                        }

                        $sql = "update isp.contrato_clpv set estado = '$estado_aprueba', fecha_instalacion = '$aprobar_fecha_cuota'
                                            where id = $idContrato and
                                            id_empresa = $idempresa and
                                            id_sucursal = $idsucursal and
                                            id_clpv = $idClpv";
                        $oCon->QueryT($sql);
                        //cajas
                        $sql = "SELECT id
                            from isp.int_contrato_caja
                            WHERE id_empresa = $idempresa AND
                            id_contrato = $idContrato AND
                            id_clpv = $idClpv AND
                            estado = 'P'";
                        if ($oCon->Query($sql)) {
                            if ($oCon->NumFilas() > 0) {
                                unset($arrayProd);
                                do {
                                    $arrayProd[] = array($oCon->f('id'));
                                } while ($oCon->SiguienteRegistro());
                            }
                        }
                        $oCon->Free();
                        $franja = 1;
                        $Tareas = new Tareas($oCon, $oIfx, $idempresa, $idsucursal, $idClpv, $idContrato, null, null, null);
                        $idTarea = $Tareas->ingresarTarea(1, $fecha, $observaciones, $id_dire, $franja, $id_motivo, $userWeb);
                        if (!empty($idTarea)) {
                            if (count($arrayProd) > 0) {
                                foreach ($arrayProd as $val) {
                                    $id_caja = $val[0];
                                    if (!empty($id_caja)) {
                                        $Tareas->ingresarServiciosTarea('', $id_caja);
                                    }
                                } //fin foreach
                            } //fin count
                        } //fin if id tarea

                        $bandera = 0;
                        //generacion de pruebas
                        if ($cierre_instalacion == 'S' && $aprueba_instalacion == 'N') {

                            $Equipos = new Equipos($oCon, null, $idempresa, $idsucursal, $idClpv, $idContrato, null);
                            $Equipos->registraCuotaPaqueteCaja(0, $aprobar_dias_sn, 'N', $aprobar_fecha_cuota);
                            $sql = "UPDATE instalacion_clpv SET estado = 'TE' WHERE id = $idTarea";
                            $oCon->QueryT($sql);
                            $sql = "update isp.contrato_clpv SET estado = 'AP' WHERE id = $idContrato";
                            $oCon->QueryT($sql);
                            $sql = "UPDATE isp.int_contrato_caja_pack SET estado = 'A' WHERE id_contrato = $idContrato AND estado = 'P'";
                            $oCon->QueryT($sql);
                            $sql = "UPDATE isp.int_contrato_caja SET estado = 'A' WHERE id_contrato = $idContrato AND estado = 'P'";
                            $oCon->QueryT($sql);
                            $bandera = 1;
                        } else if ($cierre_instalacion == 'N' && $aprueba_instalacion == 'S') {
                            $bandera = 1;
                        } else {
                            $oReturn->script("Swal.fire({
                                                type: 'error',
                                                title: 'Configurar General Incorrecta!',
                                                width: '40%'
                                                })");
                        }
                        if ($bandera == 1) {
                            $oCon->QueryT('COMMIT;');
                            $oCon2->QueryT('COMMIT;');
                            $oIfx->QueryT('COMMIT WORK;');
                            $oReturn->script("Swal.fire({
                                                type: 'success',
                                                title: 'Contrato Finalizado Correctamente..!',
                                                width: '40%'
                                            })");

                            if ($genera_cuotas_sn == 'S') {

                                $sql = "UPDATE isp.int_contrato_caja_pack SET estado = 'A' WHERE id_contrato = $idContrato AND estado = 'P'";
                                $oCon3->QueryT($sql);

                                $Equipos = new Equipos($oCon3, null, $idempresa, $idsucursal, $idClpv, $idContrato, null);
                                $var_tmp = $Equipos->registraCuotaPaqueteCaja(0, '', 'N', $aprobar_fecha_cuota);

                                $oCon3->QueryT('COMMIT;');
                            }
                            $oReturn->script("location.reload();");
                        } else {
                            $oReturn->script("jsRemoveWindowLoad();");
                        }
                    } else {
                        $oReturn->script("Swal.fire({
                        type: 'error',
                        title: 'Debe configurar el estado de intalación desde los parametros de cable operador..!',
                        width: '40%'
                    })");

                        $oReturn->script("jsRemoveWindowLoad();");
                    }
                } else {
                    $oReturn->script("Swal.fire({
                        type: 'error',
                        title: 'Cliente ya tiene registrada una Orden de Instalación..!',
                        width: '50%'
                    })");

                    $oReturn->script("jsRemoveWindowLoad();");
                }
            } else {
                $oReturn->script("Swal.fire({
                    type: 'error',
                    title: 'Cliente no tiene Servicios Registrados..!',
                    width: '50%'
                })");

                $oReturn->script("jsRemoveWindowLoad();");
            }
        } else {
            $oReturn->script("Swal.fire({
                type: 'error',
                title: 'Debe ingresar todos los documentos obligatorios para finalizar la generación',
                width: '50%'
            })");

            $oReturn->script("jsRemoveWindowLoad();");
        }
    } catch (Exception $e) {
        // rollback
        $oCon->QueryT('ROLLBACK;');
        $oCon2->QueryT('ROLLBACK;');
        $oCon3->QueryT('ROLLBACK;');
        $oIfx->QueryT('ROLLBACK;');
        $oReturn->script("jsRemoveWindowLoad();");
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}


//nuevo codigo
// NUEVO*********************************
function cargarMunicipio($aForm = '', $id = 0, $id_cant = 0, $id_ciud = 0, $id_parr = 0)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();


    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $dprovc = $aForm['dprovc'];

    $sql = "select sucu_cod_cant from saesucu where sucu_cod_empr = $idempresa and sucu_cod_sucu = $idsucursal  ";
    $cant_cod = consulta_string_func($sql, 'sucu_cod_cant', $oIfx, 0);
    $sql_tmp = '';
    if ($cant_cod > 0) {
        $sql_tmp = " and cant_cod_cant = $cant_cod ";
    }

    $sql = "select cant_cod_cant, cant_des_cant from saecant where cant_cod_prov = '$dprovc' and cant_est_cant = 'A'  ";
    $i = 1;
    if ($oIfx->Query($sql)) {
        $oReturn->script('eliminar_lista_mun();');
        if ($oIfx->NumFilas() > 0) {
            do {
                $cod_cant = $oIfx->f('cant_cod_cant');
                $oReturn->script(('anadir_elemento_mun(' . $i++ . ',\'' . $oIfx->f('cant_cod_cant') . '\', \'' . $cod_cant . ' ' . $oIfx->f('cant_des_cant') . '\' )'));
            } while ($oIfx->SiguienteRegistro());
        }
    }
    $oIfx->Free();

    $sql = "select ciud_cod_ciud, ciud_nom_ciud from saeciud where ciud_cod_prov = '$dprovc' ";
    $i = 1;
    if ($oIfx->Query($sql)) {
        $oReturn->script('eliminar_lista_ciud();');
        if ($oIfx->NumFilas() > 0) {
            do {
                $ciud_cod_ciud = $oIfx->f('ciud_cod_ciud');
                $oReturn->script(('anadir_elemento_ciud(' . $i++ . ',\'' . $oIfx->f('ciud_cod_ciud') . '\', \'' . $cod_cant . ' ' . $oIfx->f('ciud_nom_ciud') . '\' )'));
            } while ($oIfx->SiguienteRegistro());
        }
    }
    $oIfx->Free();

    $sql = "select parr_cod_parr, parr_des_parr from saeparr where parr_cod_cant = '$id_cant'";
    $i = 1;
    if ($oIfx->Query($sql)) {
        $oReturn->script('eliminar_lista_parr();');
        if ($oIfx->NumFilas() > 0) {
            do {
                $parr_cod_parr = $oIfx->f('parr_cod_parr');
                $oReturn->script(('anadir_elemento_parr(' . $i++ . ',\'' . $oIfx->f('parr_cod_parr') . '\', \'' . $cod_cant . ' ' . $oIfx->f('parr_des_parr') . '\' )'));
            } while ($oIfx->SiguienteRegistro());
        }
    }
    $oIfx->Free();

    $oReturn->assign('muniDire', 'value', $id);

    $oReturn->script("$('#muniDire').val($id_cant).trigger('change.select2');");
    $oReturn->script("$('#ciudDire').val($id_ciud).trigger('change.select2');");
    $oReturn->script("$('#parrDire').val($id_parr).trigger('change.select2');");

    return $oReturn;
}

function cargarCiudParr($aForm = '', $id = 0, $id_parr = 0)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();


    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $muniDire = $aForm['muniDire'];

    $sql = "select parr_cod_parr, parr_des_parr from saeparr where parr_cod_cant = '$muniDire'";
    $i = 1;
    if ($oIfx->Query($sql)) {
        $oReturn->script('eliminar_lista_parr();');
        if ($oIfx->NumFilas() > 0) {
            do {
                $parr_cod_parr = $oIfx->f('parr_cod_parr');
                $oReturn->script(('anadir_elemento_parr(' . $i++ . ',\'' . $oIfx->f('parr_cod_parr') . '\', \'' . $cod_cant . ' ' . $oIfx->f('parr_des_parr') . '\' )'));
            } while ($oIfx->SiguienteRegistro());
        }
    }
    $oIfx->Free();

    $oReturn->script("$('#parrDire').val('$id_parr').trigger('change.select2');");

    return $oReturn;
}

// Sigla de direcciones
function obtenerSiglaDire($id = '')
{

    //Definiciones
    global $DSN_Ifx, $DSN;
    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    try {

        $sql = "select a.id, a.nombre, a.sigla, b.id as grupo from comercial.dire_siglas a INNER JOIN comercial.dire_siglas_gr b on a.grupo = b.id where a.id = $id";
        $sigla = consulta_string_func($sql, 'sigla', $oCon, 0);
        $grupo = consulta_string_func($sql, 'grupo', $oCon, 0);

        if ($grupo == 1) {
            $oReturn->assign("siglaDirec", "value", $sigla);
        }
        if ($grupo == 2) {
            $oReturn->assign('siglaBloq', 'value', $sigla);
        }
        if ($grupo == 3) {
            $oReturn->assign('siglaCasa', 'value', $sigla);
        }
        if ($grupo == 4) {
            $oReturn->assign('siglaConj', 'value', $sigla);
        }

        $oReturn->script('crearDireccion()');
    } catch (Exception $e) {

        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function ActualizarUbicacionAdjunto($aForm = '', $idAdj = 0, $posicionId = 0)
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $UbicacionAdj = $aForm[$posicionId];

    $oReturn = new xajaxResponse();

    try {

        $oCon->QueryT('BEGIN;');

        $sql = "update comercial.adjuntos_clpv set ubicacion_fisica = '$UbicacionAdj'
        where id = $idAdj";

        $oCon->QueryT($sql);
        $oCon->QueryT('COMMIT;');

        $oReturn->alert('Actualizado Correctamente...!');
        $oReturn->script('consultarAdjuntos();');
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }
    return $oReturn;
}

function eliminarAdj($idAdj)
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $oReturn = new xajaxResponse();

    try {

        $oCon->QueryT('BEGIN;');

        $sql = "SELECT ruta from comercial.adjuntos_clpv where id = $idAdj";
        $ruta = consulta_string_func($sql, 'ruta', $oCon, 0);

        $sql = "UPDATE comercial.adjuntos_clpv SET estado = 'E' where id = $idAdj";
        $oCon->QueryT($sql);

        unlink(DIR_FACTELEC . 'modulos/int_clientes/adjuntos/abonados/' . $ruta);

        $oCon->QueryT('COMMIT;');

        $oReturn->script("Swal.fire(
            'Eliminado!',
            'El archivo ha sido eliminado.',
            'success'
        )");

        $oReturn->script('consultarAdjuntos();');
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }
    return $oReturn;
}

function guardarDatosFactura($aForm)
{

    global $DSN_Ifx, $DSN;
    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $userWeb = $_SESSION['U_ID'];

    $idContrato = $aForm['idContrato'];
    $fac_identificacion = $aForm['fac_identificacion'];
    $fac_ruc_cli = $aForm['fac_ruc_cli'];
    $fac_nombres = trim(strtoupper(($aForm['fac_nombres'])));
    $fac_dire = trim(strtoupper(($aForm['fac_dire'])));
    $fac_telefono = $aForm['fac_telefono'];
    $fac_email = $aForm['fac_email'];
    $fac_id = $aForm['fac_id'];

    try {

        // commit
        $oCon->QueryT('BEGIN;');

        if (empty($fac_id)) {
            $sql = "INSERT INTO isp.contrato_datos_factura(id_contrato, tipo_iden, ruc_clpv, nombre, telefono, direccion, email, estado, fecha_server, user_web)
                                                VALUES($idContrato, '$fac_identificacion', '$fac_ruc_cli', '$fac_nombres', '$fac_telefono', '$fac_dire', '$fac_email', 'A', now(), $userWeb)";
            $oCon->QueryT($sql);

            $sql = "SELECT max(id) as id FROM isp.contrato_datos_factura WHERE id_contrato = $idContrato";
            $id = consulta_string_func($sql, 'id', $oCon, 0);

            $oReturn->assign('fac_id', 'value', $id);
        } else {
            $sql = "UPDATE isp.contrato_datos_factura SET tipo_iden = '$fac_identificacion',
                                                     ruc_clpv = '$fac_ruc_cli', 
                                                     nombre = '$fac_nombres', 
                                                     telefono = '$fac_telefono', 
                                                     direccion = '$fac_dire', 
                                                     email = '$fac_email'
                                                    WHERE id = $fac_id";
            $oCon->QueryT($sql);
        }

        $oCon->QueryT('COMMIT;');

        $oReturn->script("Swal.fire({
            type: 'success',
            title: 'Procesado Correctamente..!'
        })");
    } catch (Exception $e) {
        // rollback
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}


function finalizarGeneracion($aForm = '', $idContrato, $fechaContrato, $duracionContrato, $op)
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    //variables de session
    $idempresa          = $_SESSION['U_EMPRESA'];
    $idsucursal         = $_SESSION['U_SUCURSAL'];
    $difiere_inst_sn    = $_SESSION['difiere_inst_sn'];

    //variables del formulario
    $UbicacionAdj = $aForm[$posicionId];

    $oReturn = new xajaxResponse();

    try {

        $oCon->QueryT('BEGIN;');

        //sector
        $optionMotivo = '';
        $sql = "SELECT id, motivo from isp.int_motivos_canc WHERE id_proceso = 1";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $optionMotivo .= '<option value="' . $oCon->f('id') . '">' . $oCon->f('motivo') . '</option>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "SELECT tarifa, estado from isp.contrato_clpv WHERE id = $idContrato";
        $oCon->Query($sql);
        $valorCuotas = $oCon->f('tarifa');
        $estado = $oCon->f('estado');
        $oCon->Free();

        $sql = "SELECT estado from isp.estado_contrato WHERE id = '$estado'";
        $oCon->Query($sql);
        $estado_txt = $oCon->f('estado');
        $oCon->Free();

        $sql = "SELECT id from isp.instalacion_clpv WHERE id_contrato = $idContrato AND id_proceso = 1 AND estado = 'PE'";
        $oCon->Query($sql);
        $control_instalacion = $oCon->f('id');
        $oCon->Free();

        if ($estado == 'PA' || $estado == 'PI' || $estado == 'PE') {

            if ($control_instalacion > 0) {
                $sHtml = '<div class="alert alert-success" style="text-align:center"role="alert">
                            <i class="fa-solid fa-circle-exclamation fa-10x"></i>
                            <br><br>
                            <h4>Ya cuenta con una orden de instalación pendiente.</h4> 
                        </div>';

                $oReturn->assign("divFinalizar", "innerHTML", $sHtml);
            } else {

                // HTML PARA LA FINALIZACION DEL CONTRATO
                $sHtml .= '
                            <div class="box box-primary direct-chat direct-chat-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title text-primary">Finalización de la generación del contrato</h3>

                                    <div class="box-tools pull-right">
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <h4 class="text-primary" align="center">Generación Cuotas</h4>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <label class="" for="aprobar_fecha_cuota">* Fecha Inicio</label>
                                                        <input type="date" class="form-control" id="aprobar_fecha_cuota" name="aprobar_fecha_cuota" value="' . $fechaContrato . '"/>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <label class="text-warning">Calculo días consumo <input type="checkbox" id="aprobar_dias_sn" name="aprobar_dias_sn" value="S" checked> </label>
                                                    </div>
                                                </div>';
                if ($op == 'N') {
                    $sHtml .=   '<div class="row">
                                                                    <div class="col-md-12">
                                                                        <label class="text-warning">Generar cuotas <input type="checkbox" id="genera_cuotas_sn" name="genera_cuotas_sn" value="S" checked> </label>
                                                                    </div>
                                                                </div>';
                }
                $sHtml .=   '<div class="row">
                                                <div class="col-md-12">
                                                    <button type="button" class="btn btn-block btn-primary" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapsefp" aria-expanded="true" aria-controls="collapsefp">
                                                        Cuotas con descuento
                                                    </button>
                                                    
                                                </div>
                                            </div>
                                            <div class="collapse" id="collapsefp">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div id="divCuotasConDescuento"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h4 class="text-primary" align="center">Generación Ordenes Servicio</h4>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <label class="" for="id_motivo">* Motivo Orden Servicio</label>
                                                    <select id="id_motivo" name="id_motivo" class="form-control select2" style="width:100%" onchange="crearDireccion(this)">
                                                        <option value="0">Seleccione una opcion..</option>
                                                        ' . $optionMotivo . '
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <label class="" for="id_motivo">Comentario Orden Servicio</label>
                                                    <textarea class="form-control" id="comentario_instalacion" placeholder="Ingrese un comentario para la orden de servicio"></textarea>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h4 class="text-primary text-left">Diferido Instalacion</h4>
                                                </div>
                                            </div>';

                if ($difiere_inst_sn == 'S') {
                    $sHtml .= '<div class="row">
                                                                <div class="col-md-7">
                                                                    <label class="" for="cuotas_instalacion">* Numero de cuotas a diferir la instalacion</label>
                                                                    <input type="number" class="form-control" id="cuotas_instalacion" name="cuotas_instalacion" value="1" onchange="validarCuotasIns()"/>
                                                                </div>
                                                                <div class="col-md-3">
                                                                <br>
                                                                    <div class="input-group input-group-sm">
                                                                        <label class="input-group-addon primary" for="estado" title="">Diferir instalación:</label>
                                                                        <label for="check_difiere_sn_1" class="text-danger text-center input-group-addon primary">
                                                                            No
                                                                            <input type="radio" id="check_difiere_sn_1" name="check_difiere_sn" value="1" checked onclick="valida_btn_inst()"/>
                                                                        </label>
                                                                        <label for="check_difiere_sn_2" class="text-danger text-center input-group-addon primary">
                                                                            Si
                                                                            <input type="radio" id="check_difiere_sn_2" name="check_difiere_sn" value="2" onclick="valida_btn_inst()"/>
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <br>
                                                                    <button id="btn_difiere_inst" class="btn btn-success btn-block" onclick="opciones_diferir(' . $idContrato . ')"> <i class="fa-solid fa-sliders"></i> Diferir instalación</button>
                                                                </div>
                                                            </div>';
                } else {
                    $sHtml .= '<div class="row">
                                                                <div class="col-md-12">
                                                                    <label class="" for="cuotas_instalacion">* Numero de cuotas a diferir la instalacion</label>
                                                                    <input type="number" class="form-control" id="cuotas_instalacion" name="cuotas_instalacion" value="1" onchange="validarCuotasIns()"/>
                                                                </div>
                                                            </div>';
                }


                $sHtml .= '<br>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <button type="button" class="btn btn-block btn-success" onClick="aprobarContrato(' . $duracionContrato . ')">
                                                        Finalizar generacion
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </div>
                                <div class="box-footer"></div>
                            </div>

                        
                            ';


                $oReturn->assign("divFinalizar", "innerHTML", $sHtml);
                $oReturn->script('cuotasConDescuento(' . $duracionContrato . ',' . $valorCuotas . ')');
                $oReturn->script("valida_btn_inst()");
                $oReturn->script("jsRemoveWindowLoad()");
            }
        } else {

            $sHtml = '<div class="alert alert-success" style="text-align:center"role="alert">
                        <i class="fa-solid fa-circle-exclamation fa-10x"></i>
                        <br><br>
                        <h4>El estado de contrato se encuentra ' . $estado_txt . ' por lo que ya no se puede volver a finalizar la generación.</h4> 
                    </div>';

            $oReturn->assign("divFinalizar", "innerHTML", $sHtml);
        }
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }
    return $oReturn;
}

function cuotasConDescuento($numeroCuotas, $valorCuota)
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $UbicacionAdj = $aForm[$posicionId];

    $oReturn = new xajaxResponse();

    try {

        $oCon->QueryT('BEGIN;');

        //HTML PARA COLOCAR LAS CUOTAS CON DESCUENTO

        $sHtml .=  '
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-2">
                                        </div>
                                        <div class="col-md-8">
                                            <h5 class="text-primary text-center">
                                                Coloque el valor en porcentaje o cantidad
                                            </h5>
                                        </div>
                                        <div class="col-md-2">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <h5 class="text-success text-center">
                                                Numero de cuota
                                            </h5>
                                        </div>
                                        <div class="col-md-2">
                                            <h5 class="text-success text-center">
                                                Valor en cantidad
                                            </h5>
                                        </div>
                                        <div class="col-md-2">
                                            <h5 class="text-success text-center">
                                                Valor en porcentaje %
                                            </h5>
                                        </div>
                                        <div class="col-md-2">
                                            <h5 class="text-success text-center">
                                                Valor a pagar $
                                            </h5>
                                        </div>
                                        <div class="col-md-2">
                                            <h5 class="text-success text-center">
                                                Seleccionar <i class="fa fa-check" aria-hidden="true"></i>
                                            </h5>
                                        </div>
                                    </div>';
        for ($i = 1; $i <= $numeroCuotas; $i++) {
            $sHtml .= '
                                    <br>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <h5 class="text-warning text-center">
                                                Cuota con descuento numero ' . $i . '
                                            </h5>
                                        </div>
                                        <div class="col-md-2">
                                            <input class="form-control"  type="text" id="cuotaValorNumero' . $i . '" value="0" readonly onkeyup="cargarPorcentajes(' . $i . ',' . $valorCuota . ')">
                                        </div>
                                        <div class="col-md-2">
                                            <input class="form-control"  type="text" id="cuotaPorcentajeNumero' . $i . '" value="0%" readonly onkeyup="cargarValores(' . $i . ',' . $valorCuota . ')">
                                        </div>
                                        <div class="col-md-2">
                                            <input class="form-control"  type="text" id="cuotaValorPagoNumero' . $i . '" value="0" readonly>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <input class="form-check-input" type="checkbox" onclick="activarCuota(' . $i . ',' . $valorCuota . ')">
                                        </div>
                                    </div>
                                    ';
            if ($i == $numeroCuotas) {
                $sHtml .= '<br>';
            }
        }
        $sHtml .=  '            </div>
                            </div>
                        </div>
                    ';

        $oReturn->assign("divCuotasConDescuento", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }
    return $oReturn;
}

function ServiciosParaInternet($aForm = '', $id_caja)
{
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    try {

        $sHtml = '';
        $sHtml .= '<div class="modal-dialog modal-lg" role="document" style="width:95%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title" id="myModalLabel">SELECCION DE SERVICIOS PARA INTERNET<small></small></h5>
                        </div>
                        <div class="modal-body" style="margin-top:0xp;">
                        <h4 class="text-primary">Listado de tipo de planes para internet</h4>
                                <ul class="nav nav-tabs" role="tablist">';

        $sql = "SELECT id, nombre from isp.int_tipo_prod WHERE id not in (1,2,4,5) AND estado = 'A'";
        $oCon->Query($sql);
        $i = 0;
        do {
            if ($i == 0) {
                $estado = 'class="active"';
            } else {
                $estado = '';
            }
            $nombre = $oCon->f('nombre');
            $nombre_para_div = str_replace(" ", "-", $nombre);
            $nombre_div = "div" . $nombre_para_div;
            $sHtml .= ' <li role="presentation" ' . $estado . '><a href="#' . $nombre_div . '" aria-controls="' . $nombre_div . '" role="tab" data-toggle="tab">' . $nombre . '</a></li>';
            $i++;
        } while ($oCon->SiguienteRegistro());
        $oCon->Free();

        $sHtml .= '         </ul>
                            <div class="tab-content">';
        $sql = "SELECT id, nombre from isp.int_tipo_prod WHERE id not in (1,2,4,5) AND estado = 'A'";
        $oCon->Query($sql);
        $i = 0;
        do {
            if ($i == 0) {
                $estado = 'active';
            } else {
                $estado = '';
            }
            $nombre = $oCon->f('nombre');
            $nombre_para_div = str_replace(" ", "-", $nombre);
            $nombre_div = "div" . $nombre_para_div;
            $sHtml .= ' <div role="tabpanel" class="tab-pane ' . $estado . '" id="' . $nombre_div . '">
                                                <div class="table-responsive" id="divDataTableServices' . $nombre_para_div . '" style="display: none;">
                                                    <div style="margin-bottom: 10px;"></div>
                                                    <table id="dataTableServices' . $nombre_para_div . '" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%;" align="center">
                                                        <thead>
                                                            <tr>
                                                                <td class="bg-info">Codigo</td>
                                                                <td class="bg-info">Producto</td>
                                                                <td class="bg-info">Precio</td>
                                                                <td class="bg-info">Seleccionar</td>
                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>';
            $i++;
        } while ($oCon->SiguienteRegistro());
        $oCon->Free();
        $sHtml .= '         </div>
                        </div>
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-2">
                                </div>
                                <div class="col-md-8">
                                    <button type="button" class="btn btn-success btn-block" onclick="cerrarModal()">
                                        Continuar <i class="fa fa-arrow-right" aria-hidden="true"></i>
                                    </button>
                                </div>
                                <div class="col-md-2">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>';

        $oReturn->script("$('#miModalOk').modal('show')");
        $oReturn->assign("miModalOk", "innerHTML", $sHtml);

        $sql = "SELECT id, nombre from isp.int_tipo_prod WHERE id not in (1,2,4,5) AND estado = 'A'";
        $oCon->Query($sql);
        $i = 0;
        do {
            $nombre = $oCon->f('nombre');
            $id = $oCon->f('id');
            $nombre_para_div = str_replace(" ", "-", $nombre);

            $id_div = "#divDataTableServices" . $nombre_para_div;
            $id_tabla = "#dataTableServices" . $nombre_para_div;

            $oReturn->script("consultaPlanes('$id','$id_div','$id_tabla')");
        } while ($oCon->SiguienteRegistro());
        $oCon->Free();
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }


    return $oReturn;
}

function seleccionarPaqueteInternet($aForm = '', $prod_cod_prod, $precio, $id_tipo_plan)
{
    session_start();

    $oReturn = new xajaxResponse();

    unset($_SESSION['prod_cod_prod_' . $id_tipo_plan . '']);
    unset($_SESSION['precio_' . $id_tipo_plan . '']);

    $_SESSION['prod_cod_prod_' . $id_tipo_plan . ''] = $prod_cod_prod;
    $_SESSION['precio_' . $id_tipo_plan . ''] = $precio;

    $oReturn->script("Swal.fire({
                        type: 'success',
                        title: 'Exito',
                        text: 'Plan con codigo " . $prod_cod_prod . " adicionado correctamente'
                    })");


    return $oReturn;
}

function eliminarServicioInter($aForm = '', $id)
{
    session_start();

    $oReturn = new xajaxResponse();

    unset($_SESSION['prod_cod_prod_' . $id . '']);
    unset($_SESSION['precio_' . $id . '']);

    $oReturn->script("agregarEquipoPaquetes()");

    return $oReturn;
}

function eliminarEquipo($id_caja, $id_clpv, $id_contrato)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    try {

        // commit
        $oCon->QueryT('BEGIN;');

        $sql = "SELECT id_tipo_prod from isp.int_contrato_caja WHERE id = $id_caja AND id_contrato = $id_contrato AND id_clpv = $id_clpv";
        $oCon->Query($sql);
        $id_tipo_prod = $oCon->f('id_tipo_prod');
        $oCon->Free();

        $sql = "DELETE from isp.int_suscribir WHERE id_contrato = $id_contrato AND id_clpv = $id_clpv AND equipo = '$id_tipo_prod'";
        $oCon->QueryT($sql);

        $sql = "DELETE from isp.int_contrato_caja_pack WHERE id_contrato = $id_contrato AND id_clpv = $id_clpv AND id_caja = $id_caja";
        $oCon->QueryT($sql);

        $sql = "DELETE from isp.int_contrato_caja WHERE id_contrato = $id_contrato AND id_clpv = $id_clpv AND id = $id_caja";
        $oCon->QueryT($sql);

        $oReturn->script("Swal.fire({
                            type: 'success',
                            title: 'Exito',
                            text: 'Eliminado correctamente'
                        })");
        $oReturn->script('reporteEquipos();');

        $oCon->QueryT('COMMIT;');
    } catch (Exception $e) {
        // rollback
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function monedaExtranjera($codigo_plan, $valor)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    try {

        unset($_SESSION['moneda_ext_' . $codigo_plan . '']);
        $_SESSION['moneda_ext_' . $codigo_plan . ''] = $valor;
    } catch (Exception $e) {
        // rollback
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function guardar_foto($aForm = '', $imagen)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $id_contrato = $aForm['idContrato'];

    try {

        // commit
        $oCon->QueryT('BEGIN;');

        $sql = "UPDATE isp.contrato_clpv set foto = '$imagen' WHERE id = $id_contrato";
        $oCon->QueryT($sql);

        $oReturn->script("Swal.fire({
                            type: 'success',
                            title: 'Exito',
                            text: 'Imagen guardada de manera correcta'
                        })");

        $oReturn->assign('img_user_1', 'src', $imagen);
        $oReturn->assign('img_user', 'src', $imagen);
        $oCon->QueryT('COMMIT;');
    } catch (Exception $e) {
        // rollback
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function mostrarServicios()
{
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    try {

        $sHtml = '';
        $sHtml .= '<div class="modal-dialog modal-lg" role="document" style="width:95%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title" id="myModalLabel">TIPOS DE SERVICIOS<small></small></h5>
                        </div>
                        <div class="modal-body" style="margin-top:0xp;">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="table-responsive">
                                        <h4 class="text-primary">Selecione los servicios que tendra el contrato</h4>
                                            <br>
                                            <div style="margin-bottom: 10px;"></div>
                                            <table class="table table-striped table-bordered table-hover table-condensed" style="width: 100%;" align="center">
                                                <tr>
                                                    <td style="background: rgba(4, 95, 180, 0.892); color: white; font-size: 12px">Servicio</td>
                                                    <td style="background: rgba(4, 95, 180, 0.892); color: white; font-size: 12px">Seleccionar</td>
                                                </tr>';

        $sql = "SELECT id, nombre from isp.int_tipo_prod WHERE estado = 'A' ORDER BY id";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id     = $oCon->f('id');
                    $tipo   = $oCon->f('nombre');

                    $datos = $id . "%" . $tipo;

                    $check = '<div align="center"> <label class="switch"> <input type="checkbox" class="classEquipoCantidad" id="tipo_servicio" name="tipo_servicio" value="' . $datos . '" onclick="agregarServicio()"> <span class="slider round"></span> </label> </div>';
                    $sHtml .= '<tr>
                                                                        <td>' . $tipo . '</td>
                                                                        <td>' . $check . '</td>
                                                                    </tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();
        $sHtml .= '</table>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <h4 class="text-primary">Tipo de contrato</h4>
                                        <br>
                                        <input type="hidden" class="form-control" id="tipo_contrato_id"></input>
                                        <textarea rows="10" cols="100" id="tipo_contrato_c" name="tipo_contrato_c" class="form-control" readonly></textarea> 
                                        <br>
                                        <button type="button" class="btn btn-success btn-block" onclick="confirmarTipoC()">
                                            Confirmar
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>';

        $oReturn->script("$('#miModal').modal('show')");
        $oReturn->assign("miModal", "innerHTML", $sHtml);
        $oReturn->script("jsRemoveWindowLoad()");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }


    return $oReturn;
}

function confirmarTipoC($datos)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $tipo_contrato_text = $datos['tipo_contrato_text'];
    $tipo_contrato_id   = $datos['tipo_contrato_id'];

    try {

        // commit
        $oCon->QueryT('BEGIN;');

        $sql = "SELECT id from isp.int_tipo_contrato WHERE servicios = '$tipo_contrato_id'";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id     = $oCon->f('id');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        if ($id > 0) {
            $oReturn->script('$("#tipo").val(' . $id . ');');
        } else {

            $sql = "INSERT INTO isp.int_tipo_contrato(tipo, estado, servicios, tipo_servicio)
                                                VALUES('$tipo_contrato_text','A','$tipo_contrato_id','P')";
            $oCon->QueryT($sql);

            $sql = "SELECT id from isp.int_tipo_contrato WHERE servicios = '$tipo_contrato_id'";
            if ($oCon->Query($sql)) {
                if ($oCon->NumFilas() > 0) {
                    do {
                        $id     = $oCon->f('id');
                    } while ($oCon->SiguienteRegistro());
                }
            }
            $oCon->Free();

            $oReturn->script('cargarTiposContratos(' . $id . ')');

            $oCon->QueryT('COMMIT;');
        }

        $oReturn->script("$('#miModal').modal('hide')");
    } catch (Exception $e) {
        // rollback
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cargarTiposContratos($id)
{
    //Definiciones
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    try {

        unset($array);

        $i = 1;
        $sql = "SELECT id, tipo from isp.int_tipo_contrato";
        $i = 1;
        if ($oCon->Query($sql)) {
            $oReturn->script('eliminar_lista_tipos();');
            if ($oCon->NumFilas() > 0) {
                do {
                    $oReturn->script(('anadir_elemento_tipos(' . $i++ . ',\'' . $oCon->f('id') . '\', \'' . $oCon->f('tipo') . '\' )'));
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $oReturn->script('$("#tipo").val(' . $id . ');');
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function validarDocumento($num_docu, $tipo_docu)
{
    //Definiciones
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $pais_cod = $_SESSION['U_PAIS_COD'];

    $tipo_docu = intval($tipo_docu);

    try {

        if ($pais_cod != 2 && $pais_cod != 6) {
            $sql = "SELECT identificacion, digitos from comercial.tipo_iden_clpv_pais WHERE id_iden_clpv = $tipo_docu AND pais_cod_pais = $pais_cod";
            if ($oCon->Query($sql)) {
                if ($oCon->NumFilas() > 0) {
                    do {
                        $digitos = $oCon->f('digitos');
                        $nom_docu = $oCon->f('identificacion');
                    } while ($oCon->SiguienteRegistro());
                }
            }
            $oCon->Free();

            if (strlen($digitos) > 0) {
                if (strlen($num_docu) != $digitos) {

                    $error = "El tipo de documento " . $nom_docu . " debe tener " . $digitos . " digitos";

                    $oReturn->script("Swal.fire({
                                            type: 'error',
                                            title: 'Oops...',
                                            text: '$error'
                                        })");

                    $oReturn->script('$("#ruc_cli").val("");');
                }
            }
        }
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function buscarContratosEquipo($aForm = '', $op = 0, $idHtml = 0)
{

    global $DSN_Ifx, $DSN;
    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $arraySector = $_SESSION['ARRAY_SECTOR_BARRIO'];
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $filtro = trim(strtoupper($aForm['filtro_' . $op]));

    if ($op == 7) {
        $filtro_tipo = "b.id_tarjeta like ('%$filtro%')";
    } else if ($op == 8) {
        $filtro_tipo = "b.vineta like ('%$filtro%')";
    }


    try {

        //array estado
        $sql = "select id, estado, color from isp.estado_contrato";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayEstado);
                unset($arrayEstadoColor);
                do {
                    $arrayEstado[$oCon->f('id')] = $oCon->f('estado');
                    $arrayEstadoColor[$oCon->f('id')] = $oCon->f('color');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml = '';
        $sHtml .= '<table class="table table-condensed table-bordered table-hover table-striped" style="width: 100%; margin: 0px;" align="center">';
        $sHtml .= '<tr>';
        $sHtml .= '<td class="warning fecha_letra">Abonado</th>';
        $sHtml .= '<td class="warning fecha_letra">Contrato</td>';
        $sHtml .= '<td class="warning fecha_letra">Nombres</td>';
        $sHtml .= '<td class="warning fecha_letra">Apodo</td>';
        $sHtml .= '<td class="warning fecha_letra">Sector</td>';
        $sHtml .= '<td class="warning fecha_letra">Direccion</td>';
        $sHtml .= '<td class="warning fecha_letra">Serial</td>';
        $sHtml .= '</tr>';

        //detectar dispositivo
        /* if (!is_numeric($filtro)) {
            $idSistema = 2;
            $idDispositivo = 0;
        } else {
            $idSistema = 1;
            $validaGospell = strpos($filtro, '10001');
            if ($validaGospell !== false) {
                $idDispositivo = 8;
            } else {
                $idDispositivo = 7;
            }
        } */

        $filtro_d = '';
        if ($idDispositivo > 0) {
            $filtro_d = " AND b.id_dispositivo = $idDispositivo";
        }

        $filtro_s = '';
        if ($idSistema > 0) {
            $filtro_s = " AND b.id_tipo_prod = $idSistema";
        }

        $sql = "select c.id, c.id_clpv, c.abonado, c.codigo, c.nom_clpv,
                c.sobrenombre, c.direccion, c.id_sector, c.id_barrio,
                c.referencia, c.telefono, b.id_tarjeta, c.estado
                from isp.contrato_clpv c, isp.int_contrato_caja b
                where c.id_clpv = b.id_clpv and
                c.id = b.id_contrato and
                c.id_empresa = b.id_empresa and
                c.id_empresa = $idempresa and
                $filtro_tipo 
                $filtro_d
                $filtro_s
                limit 50";
        //$oReturn->alert($sql);
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id = $oCon->f('id');
                    $id_clpv = $oCon->f('id_clpv');
                    $abonado = $oCon->f('abonado');
                    $codigo = $oCon->f('codigo');
                    $nom_clpv = $oCon->f('nom_clpv');
                    $sobrenombre = $oCon->f('sobrenombre');
                    $id_sector = $oCon->f('id_sector');
                    $id_barrio = $oCon->f('id_barrio');
                    $referencia = $oCon->f('referencia');
                    $telefono = $oCon->f('telefono');
                    $direccion = $oCon->f('direccion');
                    $id_tarjeta = $oCon->f('id_tarjeta');
                    $estado = $oCon->f('estado');

                    $sHtml .= '<tr style="cursor: pointer;" onclick="seleccionaItemBuscar(' . $id_clpv . ', ' . $id . ', ' . $idHtml . ')">';
                    $sHtml .= '<td class="danger" style="width: 8%;"><h6>' . $codigo . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 25%;"><h6>' . $nom_clpv . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 15%;"><h6>' . $sobrenombre . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 8%; color: ' . $arrayEstadoColor[$estado] . '"><h6>' . $arrayEstado[$estado] . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 15%;"><h6>' . $arraySector[$id_sector] . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 20%;"><h6>' . $direccion . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 9%;"><h6>' . $id_tarjeta . '</h6></td>';
                    $sHtml .= '</tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml .= '</table>';

        $oReturn->assign('divResultados_' . $idHtml, 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function consultarContratosNap($idNap)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oIfxA = new Dbo;
    $oIfxA->DSN = $DSN_Ifx;
    $oIfxA->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oConA = new Dbo;
    $oConA->DSN = $DSN;
    $oConA->Conectar();

    $oReturn = new xajaxResponse();

    //VARIABLES DE SESION
    $user_web = $_SESSION['U_ID'];
    $empresa = $_SESSION['U_EMPRESA'];
    $sucursal = $_SESSION['U_SUCURSAL'];

    try {

        $sql = "SELECT nombre FROM isp.int_nap WHERE id = $idNap";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $nombre = $oCon->f('nombre');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "SELECT id, nom_clpv, codigo, estado FROM isp.contrato_clpv";
        $array_nom = array_dato($oCon, $sql, 'id', 'nom_clpv');
        $array_codigo = array_dato($oCon, $sql, 'id', 'codigo');
        $array_estado = array_dato($oCon, $sql, 'id', 'estado');

        $sql = "SELECT id, estado, color from isp.estado_contrato";
        $array_estado_nom = array_dato($oCon, $sql, 'id', 'estado');
        $array_estado_col = array_dato($oCon, $sql, 'id', 'color');

        $sql = "SELECT id_contrato, id_tarjeta, vlan, puerto_nap, id_tipo_prod, vineta FROM isp.int_contrato_caja WHERE id_nap = $idNap";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $sHtml_1 = '<h3 class="box-title text-primary" style="text-align:center">CONTRATOS DENTRO DE LA NAP ' . $nombre . '</h3>';
                $sHtml_1 .= '<table id="table_contratos" class="table table-bordered table-condensed table-hover">';
                $sHtml_1 .= '<thead><tr>';
                $sHtml_1 .= '<td class="bg-primary">ID.</td>';
                $sHtml_1 .= '<td class="bg-primary">NOMBRE</td>';
                $sHtml_1 .= '<td class="bg-primary">CODIGO</td>';
                $sHtml_1 .= '<td class="bg-primary">ESTADO</td>';
                $sHtml_1 .= '<td class="bg-primary">SERIE</td>';
                $sHtml_1 .= '<td class="bg-primary">PUERTO</td>';
                $sHtml_1 .= '<td class="bg-primary">VLAN</td>';
                $sHtml_1 .= '<td class="bg-primary">VIÑETA</td>';
                $sHtml_1 .= '</tr></thead><tbody>';
                $i = 1;
                do {
                    $id_contrato = $oCon->f('id_contrato');
                    $id_tipo_prod = $oCon->f('id_tipo_prod');

                    $nombre = $array_nom[$id_contrato];
                    $codigo = $array_codigo[$id_contrato];
                    $id_estado = $array_estado[$id_contrato];

                    $estado = $array_estado_nom[$id_estado];
                    $color = $array_estado_col[$id_estado];

                    $div_estado = "<span class='label bg-" . $color . "' style='font-size:11px'>" . $estado . "</span> ";

                    $id_tarjeta = $oCon->f('id_tarjeta');
                    $puerto_nap = $oCon->f('puerto_nap');
                    $vlan = $oCon->f('vlan');
                    $vineta = $oCon->f('vineta');

                    if ($id_tipo_prod == 1 && empty($id_tarjeta)) {
                        $id_tarjeta = 'TV';
                    }

                    $sHtml_1 .= '<tr>';
                    $sHtml_1 .= '<td>' . $i++ . '</td>';
                    $sHtml_1 .= '<td>' . $nombre . '</td>';
                    $sHtml_1 .= '<td>' . $codigo . '</td>';
                    $sHtml_1 .= '<td>' . $div_estado . '</td>';
                    $sHtml_1 .= '<td>' . $id_tarjeta . '</td>';
                    $sHtml_1 .= '<td>' . $puerto_nap . '</td>';
                    $sHtml_1 .= '<td>' . $vlan . '</td>';
                    $sHtml_1 .= '<td>' . $vineta . '</td>';
                    $sHtml_1 .= '</tr>';
                } while ($oCon->SiguienteRegistro());
            } else {
                $sHtml_1 .= '<span class="fecha_letra">Sin Datos para mostrar...</span>';
            }
        }
        $oCon->Free();

        $sHtml_1 .= '</tbody></table>';


        $oReturn->assign("tablaContratos", "innerHTML", $sHtml_1);
        $oReturn->script("initTable();");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function consultarDisponibilidad($idNap)
{
    //Definiciones
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oIfxA = new Dbo;
    $oIfxA->DSN = $DSN_Ifx;
    $oIfxA->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oConA = new Dbo;
    $oConA->DSN = $DSN;
    $oConA->Conectar();

    $oReturn = new xajaxResponse();

    //VARIABLES DE SESION
    $user_web = $_SESSION['U_ID'];
    $empresa = $_SESSION['U_EMPRESA'];
    $sucursal = $_SESSION['U_SUCURSAL'];

    try {

        $sql = "SELECT nombre FROM isp.int_nap WHERE id = $idNap";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $nombre = $oCon->f('nombre');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "SELECT id_contrato, puerto_nap FROM isp.int_contrato_caja WHERE id_nap = $idNap AND estado not in ('E')";
        $array_puertos = array_dato($oCon, $sql, 'puerto_nap', 'id_contrato');

        $sql = "SELECT id, CONCAT(nom_clpv, ' - ', codigo) as nombres, estado from isp.contrato_clpv";
        $array_nombres = array_dato($oCon, $sql, 'id', 'nombres');
        $array_estados_c = array_dato($oCon, $sql, 'id', 'estado');

        $sql = "SELECT id, estado, color from isp.estado_contrato";
        $array_estado_nom = array_dato($oCon, $sql, 'id', 'estado');
        $array_estado_col = array_dato($oCon, $sql, 'id', 'color');

        $sql = "SELECT capacidad, poste FROM isp.int_nap WHERE id = $idNap";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $capacidad = $oCon->f('capacidad');
                    $poste = $oCon->f('poste');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $capacidad = intval($capacidad);

        $sHtml = '';
        $sHtml .= '<div class="modal-dialog modal-lg" role="document" style="width: 90%;">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h4 class="modal-title" id="myModalLabel">Disponibilidad</h4>
                            </div>
                            <div class="modal-body">
                                <div class="table-responsive">';

        $sHtml .= ' <div class="panel panel-primary">
                        <div class="panel-heading">Puertos ocupados y disponibles dentro de la nap ' . $nombre . ', poste: ' . $poste . ' </div>
                        <br>
                        <div class="container-fluid">
                            <div class="row">';
        for ($i = 1; $i <= $capacidad; $i++) {

            $puerto_ocupado = '';
            $puerto_ocupado = $array_puertos[$i];

            if (!empty($puerto_ocupado)) {

                $estado_contrato = $array_estados_c[$puerto_ocupado];
                $nombre_estado = $array_estado_nom[$estado_contrato];
                $color_estado = $array_estado_col[$estado_contrato];

                $color = "red";
                $txt = " Ocupado / <span class='label bg-" . $color_estado . "' style='font-size:11px'>" . $array_nombres[$puerto_ocupado] . " - " . $nombre_estado . "</span> ";
                $cursor = 'style="cursor: hand"';
                $txt_seleccionar = 'title="Ver contrato"';
                $accion = 'seleccionarPuerto(' . $idNap . ',' . $i . ',\'' . $poste . '\',\'' . $nombre . '\')';
            } else {
                $color = "green";
                $txt = " Disponible";
                $cursor = 'style="cursor: hand"';
                $txt_seleccionar = 'title="Seleccionar puerto ' . $i . '"';
                $accion = 'seleccionarPuerto(' . $idNap . ',' . $i . ',\'' . $poste . '\',\'' . $nombre . '\')';
            }

            $sHtml .= ' <div class="col-md-6">
                            <ul class="list-group" ' . $cursor . ' ' . $txt_seleccionar . ' onclick="' . $accion . '">
                                <li class="list-group-item"><i class="fa-sharp fa-solid fa-circle fa-2x" style="color: ' . $color . '"></i> Puerto: ' . $i . ' ' . $txt . ' </li>
                            </ul>
                        </div>';
        }
        $sHtml .= ' </div>
                    </div>
                </div>';

        $sHtml .= '  </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div> ';

        $oReturn->assign("miModalContratosDisp", "innerHTML", $sHtml);
        $oReturn->script("jsRemoveWindowLoad()");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function seleccionarPuerto($id_contrato, $id_nap, $puerto, $poste, $nombre_nap)
{
    global $DSN, $DSN_Ifx;
    session_start();

    $oIfx = new Dbo();
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon2 = new Dbo();
    $oCon2->DSN = $DSN;
    $oCon2->Conectar();

    try {

        $idempresa = $_SESSION['U_EMPRESA'];
        $idsucursal = $_SESSION['U_SUCURSAL'];

        $oReturn = new xajaxResponse();

        $sql = "SELECT id, nombre FROM isp.int_tipo_prod";
        $array_tip_prod = array_dato($oCon, $sql, 'id', 'nombre');

        $sql = "SELECT id, nombre FROM isp.int_nap";
        $array_naps = array_dato($oCon, $sql, 'id', 'nombre');

        $sql = "SELECT latitud, longitud FROM isp.int_nap WHERE id = $id_nap";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $latitud1   = $oCon->f('latitud');
                    $longitud1  = $oCon->f('longitud');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "SELECT id, id_tipo_prod, id_nap FROM isp.int_contrato_caja WHERE id_contrato = $id_contrato AND estado not in ('E')";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                $nap = '';
                /*if ($oCon->NumFilas() == 1) {
                    $id_contrato_caja = $oCon->f('id');

                    $oCon2->QueryT('BEGIN;');

                    $sql = "UPDATE isp.int_contrato_caja SET id_nap = $id_nap, puerto_nap = $puerto, latitud = '$latitud1', longitud = '$longitud1' WHERE id = $id_contrato_caja";
                    $oCon2->QueryT($sql);

                    $oCon2->QueryT('COMMIT;');

                    $sql = "SELECT id_nap, count(id_nap) as ocupadas FROM isp.int_contrato_caja WHERE id_nap is not null AND estado not in ('E') GROUP BY id_nap ";
                    $array_ocupadas = array_dato($oCon2, $sql, 'id_nap', 'ocupadas');

                    $archivo_naps = '';
                    $archivo_naps .= '<markers>'.PHP_EOL;
                    $sqlNaps = "SELECT id, nombre, poste, latitud, longitud, capacidad, can_uso, can_libre
                        from isp.int_nap
                        where estado = 'A'";
                    if ($oCon2->Query($sqlNaps)) {
                        if ($oCon2->NumFilas() > 0) {
                            do {
                                $id = $oCon2->f('id');
                                $nombre = $oCon2->f('nombre');
                                $poste = $oCon2->f('poste');
                                $latitud = $oCon2->f('latitud');
                                $longitud = $oCon2->f('longitud');
                                $capacidad = $oCon2->f('capacidad');

                                $can_uso = $array_ocupadas[$id];

                                if(empty($can_uso)){
                                    $can_uso = 0;
                                }

                                $can_libre = $capacidad - $can_uso;

                                $archivo_naps .= '<marker id="'.$id.'" nombre="'.$nombre.'" poste="'.$poste.'" latitud="'.$latitud.'" longitud="'.$longitud.'" capacidad="'.$capacidad.'" can_uso="'.$can_uso.'" can_libre="'.$can_libre.'"/>'.PHP_EOL;
                            } while ($oCon2->SiguienteRegistro());
                        }
                    }
                    $oCon2->Free();

                    $archivo_naps .= '</markers>';
                    $ruta = "upload/naps";
                    if (!file_exists($ruta)){
                        mkdir($ruta);
                    }

                    $nombre =  "naps_ubicacion.xml";
                    $archivo = fopen($ruta . '/' . $nombre, "w+");
                    //fwrite($archivo, $xml);
                    fwrite($archivo, utf8_encode($archivo_naps));
                    fclose($archivo);

                    $oReturn->script("$('#miModalContratosDisp').modal('hide')");
                    $oReturn->script("Swal.fire({
                        type: 'success',
                        title: 'Se guardo correctamente la nap $nombre_nap y puerto $puerto correctamente',
                    })");
                    $oReturn->script('initMap(\''.$latitud1.'\',\''.$longitud1.'\')');
                //}else{*/

                $sHtml = '<div class="modal-dialog modal-lg" style="width: 90%; height: :90%;">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            <h4 class="modal-title">SELECCIONE EL EQUIPO AL CUAL PERTENECE LA NAP Y PUERTO SELECCIONADO</h4>
                                                </div>
                                                <div class="modal-body">
                                                <table id="tableEquiposNap" class="table table-striped table-bordered table-hover table-condensed" style="align=center">
                                                <thead>
                                                    <tr>
                                                    <td colspan="13" class="bg-primary"><h5>LISTADO DE EQUIPOS REGISTRADOS EN EL CONTRATO</small></h5></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bg-primary">No</td>
                                                        <td class="bg-primary">Tipo</td>
                                                        <td class="bg-primary">Seleccionar</td>
                                                        <td class="bg-primary">Eliminar</td>
                                                    </tr>
                                                </thead>
                                                <tbody>';
                $i = 1;
                do {

                    $id_contrato_caja   = $oCon->f('id');
                    $id_tipo_prod       = $oCon->f('id_tipo_prod');
                    $id_nap_old         = $oCon->f('id_nap');

                    $nap                = $array_naps[$id_nap_old];

                    $div_delete = '';
                    if (!empty($nap)) {
                        $nap = "Nap actual: " . $nap;
                        $div_delete = '<div align="center"> <button class="btn btn-danger btn-sm" title="Eliminar" onclick="deleteNapEquipo(\'' . $id_contrato_caja . '\')"><i class="fa-solid fa-trash"></i></button></div>';
                    }
                    $div_select = '<div align="center"> <button class="btn btn-success btn-sm" title="Editar" onclick="selecNapEquipo(\'' . $id_contrato_caja . '\',\'' . $id_nap . '\',\'' . $puerto . '\',\'' . $latitud1 . '\',\'' . $longitud1 . '\',\'' . $nombre_nap . '\')"><i class="fa-solid fa-check"></i></button></div>';

                    $sHtml .= ' <tr>
                                            <td>' . $i++ . '</td>
                                            <td>' . $array_tip_prod[$id_tipo_prod] . '<br>' . $nap . '</td>
                                            <td>' . $div_select . '</td>
                                            <td>' . $div_delete . '</td>
                                        </tr>';
                } while ($oCon->SiguienteRegistro());
                $sHtml .= '             </tbody>
                                        </table>
                                    </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger btn" data-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        </div>
                    </div>';

                $oReturn->script("$('#miModalSelecDisp').modal('show')");
                $oReturn->assign("miModalSelecDisp", "innerHTML", $sHtml);
                //}
            } else {
                $oReturn->script("Swal.fire({
                    type: 'warning',
                    title: 'Para continuar debe seleccionar al menos un plan previamente',
                })");
            }
        }
        $oCon->Free();
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function selecNapEquipo($id_caja, $id_nap, $puerto, $latitud1, $longitud1, $nombre_nap)
{

    global $DSN, $DSN_Ifx;
    session_start();

    $oIfx = new Dbo();
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon2 = new Dbo();
    $oCon2->DSN = $DSN;
    $oCon2->Conectar();

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $oReturn = new xajaxResponse();
    try {

        $oCon2->QueryT('BEGIN;');

        $sql = "UPDATE isp.int_contrato_caja SET id_nap = $id_nap, puerto_nap = $puerto, latitud = '$latitud1', longitud = '$longitud1' WHERE id = $id_caja";
        $oCon2->QueryT($sql);

        $oCon2->QueryT('COMMIT;');

        $sql = "SELECT id_nap, count(id_nap) as ocupadas FROM isp.int_contrato_caja WHERE id_nap is not null AND estado not in ('E') GROUP BY id_nap ";
        $array_ocupadas = array_dato($oCon2, $sql, 'id_nap', 'ocupadas');
        $archivo_naps = '';
        $archivo_naps .= '<markers>' . PHP_EOL;

        $sqlNaps = "SELECT id, nombre, poste, latitud, longitud, capacidad, can_uso, can_libre
            from isp.int_nap
            where estado = 'A'";
        if ($oCon2->Query($sqlNaps)) {
            if ($oCon2->NumFilas() > 0) {
                do {
                    $id = $oCon2->f('id');
                    $nombre = $oCon2->f('nombre');
                    $poste = $oCon2->f('poste');
                    $latitud = $oCon2->f('latitud');
                    $longitud = $oCon2->f('longitud');
                    $capacidad = $oCon2->f('capacidad');
                    $can_uso = $array_ocupadas[$id];
                    if (empty($can_uso)) {
                        $can_uso = 0;
                    }
                    $can_libre = $capacidad - $can_uso;
                    $archivo_naps .= '<marker id="' . $id . '" nombre="' . $nombre . '" poste="' . $poste . '" latitud="' . $latitud . '" longitud="' . $longitud . '" capacidad="' . $capacidad . '" can_uso="' . $can_uso . '" can_libre="' . $can_libre . '"/>' . PHP_EOL;
                } while ($oCon2->SiguienteRegistro());
            }
        }
        $oCon2->Free();

        $archivo_naps .= '</markers>';
        $ruta = "upload/naps";
        if (!file_exists($ruta)) {
            mkdir($ruta);
        }

        $nombre =  "naps_ubicacion.xml";
        $archivo = fopen($ruta . '/' . $nombre, "w+");
        //fwrite($archivo, $xml);
        fwrite($archivo, utf8_encode($archivo_naps));
        fclose($archivo);

        $oReturn->script("Swal.fire({
            type: 'success',
            title: 'Se guardo correctamente la nap $nombre_nap y puerto $puerto correctamente',
        })");

        $oReturn->script("$('#miModalSelecDisp').modal('hide')");
        $oReturn->script("$('#miModalContratosDisp').modal('hide')");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function deleteNapEquipo($id_caja)
{

    global $DSN, $DSN_Ifx;
    session_start();

    $oIfx = new Dbo();
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon2 = new Dbo();
    $oCon2->DSN = $DSN;
    $oCon2->Conectar();

    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    $oReturn = new xajaxResponse();
    try {

        $oCon2->QueryT('BEGIN;');

        $sql = "UPDATE isp.int_contrato_caja SET id_nap = null, puerto_nap = null, latitud = '', longitud = '' WHERE id = $id_caja";
        $oCon2->QueryT($sql);

        $oCon2->QueryT('COMMIT;');

        $sql = "SELECT id_nap, count(id_nap) as ocupadas FROM isp.int_contrato_caja WHERE id_nap is not null AND estado not in ('E') GROUP BY id_nap ";
        $array_ocupadas = array_dato($oCon2, $sql, 'id_nap', 'ocupadas');
        $archivo_naps = '';
        $archivo_naps .= '<markers>' . PHP_EOL;

        $sqlNaps = "SELECT id, nombre, poste, latitud, longitud, capacidad, can_uso, can_libre
            from isp.int_nap
            where estado = 'A'";
        if ($oCon2->Query($sqlNaps)) {
            if ($oCon2->NumFilas() > 0) {
                do {
                    $id = $oCon2->f('id');
                    $nombre = $oCon2->f('nombre');
                    $poste = $oCon2->f('poste');
                    $latitud = $oCon2->f('latitud');
                    $longitud = $oCon2->f('longitud');
                    $capacidad = $oCon2->f('capacidad');
                    $can_uso = $array_ocupadas[$id];
                    if (empty($can_uso)) {
                        $can_uso = 0;
                    }
                    $can_libre = $capacidad - $can_uso;
                    $archivo_naps .= '<marker id="' . $id . '" nombre="' . $nombre . '" poste="' . $poste . '" latitud="' . $latitud . '" longitud="' . $longitud . '" capacidad="' . $capacidad . '" can_uso="' . $can_uso . '" can_libre="' . $can_libre . '"/>' . PHP_EOL;
                } while ($oCon2->SiguienteRegistro());
            }
        }
        $oCon2->Free();

        $archivo_naps .= '</markers>';
        $ruta = "upload/naps";
        if (!file_exists($ruta)) {
            mkdir($ruta);
        }

        $nombre =  "naps_ubicacion.xml";
        $archivo = fopen($ruta . '/' . $nombre, "w+");
        //fwrite($archivo, $xml);
        fwrite($archivo, utf8_encode($archivo_naps));
        fclose($archivo);

        $oReturn->script("Swal.fire({
            type: 'success',
            title: 'Eliminado correctamente',
        })");

        $oReturn->script("$('#miModalSelecDisp').modal('hide')");
        $oReturn->script("$('#miModalContratosDisp').modal('hide')");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cargarCantonCiudad($provincia)
{
    //Definiciones
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    try {

        $listaCantones = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($provincia)) {
            $sql = "SELECT cant_cod_cant, cant_des_cant from saecant where cant_cod_prov = '$provincia' and cant_est_cant = 'A'";
            $listaCantones .= lista_boostrap_func($oCon, $sql, 0, 'cant_cod_cant',  'cant_des_cant');
        }

        $oReturn->assign("muniDire", "innerHTML", $listaCantones);

        $oReturn->script("$('.select2').select2();");

        $listaCiudades = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($provincia)) {
            $sql = "SELECT ciud_cod_ciud, ciud_nom_ciud from saeciud where ciud_cod_prov = '$provincia' ";
            $listaCiudades .= lista_boostrap_func($oCon, $sql, 0, 'ciud_cod_ciud',  'ciud_nom_ciud');
        }

        $oReturn->assign("ciudDire", "innerHTML", $listaCiudades);

        $oReturn->script("$('.select2').select2();");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cargarParroquia($canton)
{
    //Definiciones
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    try {

        $listaParroquias = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($canton)) {
            $sql = "SELECT parr_cod_parr, parr_des_parr from saeparr where parr_cod_cant = '$canton'";
            $listaParroquias .= lista_boostrap_func($oCon, $sql, 0, 'parr_cod_parr',  'parr_des_parr');
        }

        $oReturn->assign("parrDire", "innerHTML", $listaParroquias);

        $oReturn->script("$('.select2').select2();");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cargarBarrio($sector)
{
    //Definiciones
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    $sql = "SELECT bloqueo_nap_sn from isp.int_parametros_general where id_empresa = $idempresa ";
    $bloqueo_nap_sn = consulta_string_func($sql, 'bloqueo_nap_sn', $oCon, 0);

    try {

        $listaBarrios = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($sector)) {
            $sql = "SELECT id, barrio from isp.int_barrio where id_sector = $sector order by id";
            $listaBarrios .= lista_boostrap_func($oCon, $sql, 0, 'id',  'barrio');
        }

        $oReturn->assign("barrioDire", "innerHTML", $listaBarrios);

        $oReturn->script("$('.select2').select2();");

        if ($bloqueo_nap_sn == 'S' && !empty($sector)) {
            $oReturn->script('consultar_naps_sector(' . $sector . ');');
        }
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function cargarCalle($barrio, $tipo_direccion)
{
    //Definiciones
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    try {

        $listaCalles = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($barrio) && !empty($tipo_direccion)) {
            $sql = "SELECT id, calle FROM isp.int_calle WHERE id_barrio = $barrio AND id_tipo = $tipo_direccion";
            $listaCalles .= lista_boostrap_func($oCon, $sql, 0, 'id',  'calle');
        }

        $oReturn->assign("calle_direccion", "innerHTML", $listaCalles);

        $oReturn->script("$('.select2').select2();");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function editarDireccion($aForm = '', $id = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $idempresa = $_SESSION['U_EMPRESA'];

    //variables del formulario
    $clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        //lectura sucia
        //

        $sqlDire = "SELECT id_provincia, id_canton,     id_ciudad,    id_parroquia, id_sector,     id_barrio,      
                           id_bloque,    nomb_conjunto, num_conjunto, estrato,      id_conjunto,   departamento,  poste,
                           caja,         id_ruta,      ruta,      orden_ruta,       direccion,     referencia,    latitud, 
                           longitud,     id_calle
                    from isp.contrato_clpv
                    where id = $idContrato";
        if ($oCon->Query($sqlDire)) {
            if ($oCon->NumFilas() > 0) {
                $id_provincia   = $oCon->f('id_provincia');
                $id_canton      = $oCon->f('id_canton');
                $id_ciudad      = $oCon->f('id_ciudad');
                $id_parroquia   = $oCon->f('id_parroquia');
                $id_sector      = $oCon->f('id_sector');
                $id_barrio      = $oCon->f('id_barrio');
                $id_bloque      = $oCon->f('id_bloque');
                $nomb_conjunto  = $oCon->f('nomb_conjunto');
                $num_conjunto   = $oCon->f('num_conjunto');
                $estrato        = $oCon->f('estrato');
                $id_conjunto    = $oCon->f('id_conjunto');
                $departamento   = $oCon->f('departamento');
                $poste          = $oCon->f('poste');
                $caja           = $oCon->f('caja');
                $id_ruta        = $oCon->f('id_ruta');
                $ruta           = $oCon->f('ruta');
                $orden_ruta     = $oCon->f('orden_ruta');
                $direccion      = $oCon->f('direccion');
                $referencia     = $oCon->f('referencia');
                $latitud        = $oCon->f('latitud');
                $longuitud      = $oCon->f('longitud');
                $id_calle       = $oCon->f('id_calle');
            }
        }
        $oCon->Free();

        //ASIGNA PROVINCIA
        $oReturn->assign("dprovc", "value", $id_provincia);

        //CARGA CANTONES
        $listaCantones = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($id_provincia)) {
            $sql = "SELECT cant_cod_cant, cant_des_cant from saecant where cant_cod_prov = '$id_provincia' and cant_est_cant = 'A'";
            $listaCantones .= lista_boostrap_func($oCon, $sql, $id_canton, 'cant_cod_cant',  'cant_des_cant');
        }

        $oReturn->assign("muniDire", "innerHTML", $listaCantones);

        //CARGA CIUDADES
        $listaCiudades = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($id_provincia)) {
            $sql = "SELECT ciud_cod_ciud, ciud_nom_ciud from saeciud where ciud_cod_prov = '$id_provincia' ";
            $listaCiudades .= lista_boostrap_func($oCon, $sql, $id_ciudad, 'ciud_cod_ciud',  'ciud_nom_ciud');
        }

        $oReturn->assign("ciudDire", "innerHTML", $listaCiudades);

        //CARGA PARROQUIAS
        $listaParroquias = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($id_canton)) {
            $sql = "SELECT parr_cod_parr, parr_des_parr from saeparr where parr_cod_cant = '$id_canton'";
            $listaParroquias .= lista_boostrap_func($oCon, $sql, $id_parroquia, 'parr_cod_parr',  'parr_des_parr');
        }

        $oReturn->assign("parrDire", "innerHTML", $listaParroquias);

        //ASIGNA SECTOR
        $oReturn->assign("sectorDire", "value", $id_sector);

        //CARGA BARRIOS
        $listaBarrios = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($id_sector)) {
            $sql = "SELECT id, barrio from isp.int_barrio where id_sector = $id_sector order by id";
            $listaBarrios .= lista_boostrap_func($oCon, $sql, $id_barrio, 'id',  'barrio');
        }

        $oReturn->assign("barrioDire", "innerHTML", $listaBarrios);

        //ASIGNA TIPO DE DIRECCION
        $oReturn->assign("tipo_direccion", "value", $id_bloque);

        $listaCalles = '<option value="0">Seleccione una opcion..</option>';

        if (!empty($id_barrio) && !empty($id_bloque)) {
            $sql = "SELECT id, calle FROM isp.int_calle WHERE id_barrio = $id_barrio AND id_tipo = $id_bloque";
            $listaCalles .= lista_boostrap_func($oCon, $sql, $id_calle, 'id',  'calle');
        }

        $oReturn->assign("calle_direccion", "innerHTML", $listaCalles);

        //ASIGNA TIPO DE CONJUNTO
        $oReturn->assign("conjDire", "value", $id_conjunto);

        //ASIGNA TIPO DE CASA
        $oReturn->assign("tipo_casa", "value", $departamento);

        //CARGA DATOS DE RUTA
        if (!empty($id_ruta)) {
            $oReturn->assign("rutaDire", "value", $id_ruta);
            $oReturn->assign("ordenRutaDire", "value", $orden_ruta);
            $oReturn->assign("codigoRutaDire", "value", $ruta);
        }

        //ASIGNA CALLE PRINCIPAL
        $oReturn->assign("callePrincipal", "value", $nomb_conjunto);

        //ASIGNA NUMERO DE CALLE
        $oReturn->assign("numeroDire", "value", $num_conjunto);

        //ASIGNA CALLE SECUNDARIA
        $oReturn->assign("calleSecundaria", "value", $estrato);

        //ASIGNA DIRECCION COMPLETA
        $oReturn->assign("direccion", "value", $direccion);

        //ASIGNA REFERENCIA
        $oReturn->assign("referenciaDire", "value", $referencia);

        $oReturn->script("$('.select2').select2();");
        $oReturn->script("llenarCalle()");

        //**GEOREFERENCIA*/
        $oReturn->assign("latitud", "value", $latitud);
        $oReturn->assign("longuitud", "value", $longuitud);
        $oReturn->assign("posteContrato", "value", $poste);
        $oReturn->assign("cajaContrato", "value", $caja);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function verificaDocumentoSunat($tipo_iden, $n_documento)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $idempresa = $_SESSION['U_EMPRESA'];

    $clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];

    try {

        $id_pais = $_SESSION['U_PAIS_COD'];

        $sqlDire = "SELECT p.identificacion
                    FROM comercial.tipo_iden_clpv i, comercial.tipo_iden_clpv_pais p
                    WHERE i.id_iden_clpv = p.id_iden_clpv AND
                    p.pais_cod_pais = $id_pais AND i.tipo = '$tipo_iden'";
        if ($oCon->Query($sqlDire)) {
            if ($oCon->NumFilas() > 0) {
                $identificacion   = $oCon->f('identificacion');
            }
        }
        $oCon->Free();

        $headers = array(
            "Content-Type:application/json"
        );

        if ($identificacion == 'RUC') {
            $sUrl = URL_JIREH_PERU_DNI_G . '/api/v1/ruc/' . $n_documento . '?token=abcxyz';

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_URL, $sUrl);
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            $respuesta = curl_exec($ch);
            $err     = curl_error($ch);
            curl_close($ch);

            if ($err) {
                $data = curl_error($ch);
            } else {
                $data = json_decode($respuesta, true);
            }

            $bandera_ruc = 1;

            if (count($data) == 0 || $data == false) {
                $sUrl = URL_JIREH_PERU_DNI . '/v1/ruc?numero=' . $n_documento . '&api_token=1b3ba3c4639a051e853e42a880af3c0888dd35b4ac49bc364d7ea5d7d7113e4d';

                $ch = curl_init();
                curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
                curl_setopt($ch, CURLOPT_URL, $sUrl);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                $respuesta = curl_exec($ch);
                $err     = curl_error($ch);
                curl_close($ch);

                if ($err) {
                    $data = curl_error($ch);
                } else {
                    $data = json_decode($respuesta, true);
                }

                if (isset($data["error"])) {
                    throw new Exception($data["error"]);
                }

                $bandera_ruc = 2;
            }
        } else if ($identificacion == 'DNI') {
            $sUrl = URL_JIREH_PERU_DNI . '/v1/dni?numero=' . $n_documento . '&api_token=1b3ba3c4639a051e853e42a880af3c0888dd35b4ac49bc364d7ea5d7d7113e4d';

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_URL, $sUrl);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            $respuesta = curl_exec($ch);
            $err     = curl_error($ch);
            curl_close($ch);

            if ($err) {
                $data = curl_error($ch);
            } else {
                $data = json_decode($respuesta, true);
            }

            if (isset($data["error"])) {
                throw new Exception('Error al consultar el documento');
            }

            //$data = $data["data"];

        } else {
            throw new Exception('Tipo de documento ' . $identificacion . ' no soportado para consultar');
        }



        $sHtml = '<div class="modal-dialog modal-lg" role="document" style="width:40%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title" id="myModalLabel" align="center">INFORMACIÓN DE USUARIOS<small></small></h5>
                        </div>
                        <div class="modal-body" style="margin-top:0xp;">
                        <div class="table" id="divFormularioCobros" style="height: 220px; overflow-y: scroll;">
                        <table id="tableConsulta" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%;" align="center">
                                    <thead>
                                        <tr>
                                        <td colspan="14" class="bg-primary"><h5>INFORMACIÓN ' . $identificacion . ' </small></h5></td>
                                        </tr>
                                        <tr>
                                            <td class="bg-primary" style="width: 10%;">Descripción</td>
                                            <td class="bg-primary" style="width: 90%;">Datos</td>
                                        </tr>
                                    </thead>
                                    <tbody>';
        if (count($data) > 0) {
            foreach ($data as $clave => $valor) {

                $valor_txt = '';

                if (is_array($valor)) {
                    foreach ($valor as $clave1 => $valor1) {
                        $valor_txt .= '<p><label style="font-weight: bold;">' . $clave1 . ': </label> ' . $valor1 . '<p>';
                    }
                } else {
                    $valor_txt = $valor;
                }

                $sHtml .= ' <tr>
                                <td>' . $clave . '</td>
                                <td>' . $valor_txt . '</td>
                            </tr>';

                if ($identificacion == 'RUC') {

                    if ($bandera_ruc == 1) {
                        if ($clave == 'razonSocial') {
                            $nombre = $valor_txt;
                        }

                        if ($clave == 'nombreComercial') {
                            $apellido = '';
                        }
                    } else if ($bandera_ruc == 2) {
                        if ($clave == 'nombre') {
                            $nombre = $valor_txt;
                        }

                        if ($clave == 'departamento') {
                            $apellido = '';
                        }
                    } else {
                        throw new Exception('Error al verificar datos.');
                    }
                } else if ($identificacion == 'DNI') {
                    if ($clave == 'nombres') {
                        $nombre = $valor_txt;
                    }

                    if ($clave == 'apellidoPaterno') {
                        $apellido = $valor_txt;
                    }

                    if ($clave == 'apellidoMaterno') {
                        $apellido .= ' ' . $valor_txt;
                    }
                }
            }
        }

        $btn = '';
        if (!empty($nombre)) {
            $btn = ' <button type="button" class="btn btn-success btn-block" onclick="bajaInformacionSunat(\'' . $nombre . '\', \'' . $apellido . '\')"> <i class="fa-solid fa-rotate"></i> Bajar información</button>';
        }
        $sHtml .= '</tbody>
                    </table></div>
                   ' . $btn . '
                    </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>';

        $oReturn->script("$('#miModalOk').modal('show')");
        $oReturn->assign("miModalOk", "innerHTML", $sHtml);
        $oReturn->script("jsRemoveWindowLoad()");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
        $oReturn->script("jsRemoveWindowLoad()");
    }

    return $oReturn;
}

function buscarContratosGlobal($aForm = '', $op = 0, $idHtml = 0)
{

    global $DSN_Ifx, $DSN;
    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $idempresa = $_SESSION['U_EMPRESA'];

    try {

        //array estado
        $sql = "select id, estado, color from isp.estado_contrato";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                unset($arrayEstado);
                unset($arrayEstadoColor);
                do {
                    $arrayEstado[$oCon->f('id')] = $oCon->f('estado');
                    $arrayEstadoColor[$oCon->f('id')] = $oCon->f('color');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml = '';
        $sHtml .= '<table class="table table-condensed table-bordered table-hover table-striped" style="width: 100%; margin: 0px;" align="center">';
        $sHtml .= '<tr>';
        $sHtml .= '<td class="warning fecha_letra">Abonado</th>';
        $sHtml .= '<td class="warning fecha_letra">Contrato</td>';
        $sHtml .= '<td class="warning fecha_letra">Nombres</td>';
        $sHtml .= '<td class="warning fecha_letra">Apodo</td>';
        $sHtml .= '<td class="warning fecha_letra">Sector</td>';
        $sHtml .= '<td class="warning fecha_letra">Direccion</td>';
        $sHtml .= '<td class="warning fecha_letra">Serial</td>';
        $sHtml .= '</tr>';

        if ($op == 1) {
            $filtro = trim($aForm['codigo_pago']);
            $filtro = substr($filtro, 1);

            $sql = "SELECT c.id, c.id_clpv, c.abonado, c.codigo, c.nom_clpv,
                c.sobrenombre, c.direccion, c.id_sector, c.id_barrio,
                c.referencia, c.telefono, c.estado
                from isp.contrato_clpv c
                where 
                c.id_empresa = $idempresa and
                c.codigo like '%$filtro%'
                limit 50";
        } else if ($op == 2) {
            $filtro = trim($aForm['codigo_cid']);

            $sql = "SELECT c.id, c.id_clpv, c.abonado, c.codigo, c.nom_clpv,
                c.sobrenombre, c.direccion, c.id_sector, c.id_barrio,
                c.referencia, c.telefono, c.estado
                from isp.contrato_clpv c, isp.int_contrato_caja_pack b
                where c.id_clpv = b.id_clpv and
                c.id = b.id_contrato and
                c.id_empresa = $idempresa and
                b.codigo_cid like '%$filtro%'
                limit 50";
        }
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id = $oCon->f('id');
                    $id_clpv = $oCon->f('id_clpv');
                    $abonado = $oCon->f('abonado');
                    $codigo = $oCon->f('codigo');
                    $nom_clpv = $oCon->f('nom_clpv');
                    $sobrenombre = $oCon->f('sobrenombre');
                    $id_sector = $oCon->f('id_sector');
                    $id_barrio = $oCon->f('id_barrio');
                    $referencia = $oCon->f('referencia');
                    $telefono = $oCon->f('telefono');
                    $direccion = $oCon->f('direccion');
                    $id_tarjeta = $oCon->f('id_tarjeta');
                    $estado = $oCon->f('estado');

                    $sHtml .= '<tr style="cursor: pointer;" onclick="seleccionaItemBuscarEquipo(' . $id_clpv . ', ' . $id . ', ' . $idHtml . ', \'' . $id_tarjeta . '\')">';
                    $sHtml .= '<td class="danger" style="width: 8%;"><h6>' . $codigo . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 25%;"><h6>' . $nom_clpv . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 15%;"><h6>' . $sobrenombre . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 8%; color: ' . $arrayEstadoColor[$estado] . '"><h6>' . $arrayEstado[$estado] . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 15%;"><h6>' . $arraySector[$id_sector] . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 20%;"><h6>' . $direccion . '</h6></td>';
                    $sHtml .= '<td class="danger" style="width: 9%;"><h6>' . $id_tarjeta . '</h6></td>';
                    $sHtml .= '</tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sHtml .= '</table>';

        $oReturn->assign('divResultados_5', 'innerHTML', $sHtml);
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function seleccionarTipoContrato($aForm = 0)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    //variables de sesion
    $idempresa = $_SESSION['U_EMPRESA'];

    $clpv = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $cod_pais = $_SESSION['U_PAIS_COD'];

    try {

        $sqlTipContr = "SELECT contr_des_contr, contr_cod_contr, contr_text1_contr FROM isp.int_txt_contrato WHERE contr_cod_empr = $idempresa AND contr_esta_contr = 'A' AND id_pais = $cod_pais ORDER BY contr_cod_contr";
        if ($oCon->Query($sqlTipContr)) {
            if ($oCon->NumFilas() > 0) {
                $contr_des_contr   = $oCon->f('contr_des_contr');
                $contr_cod_contr   = $oCon->f('contr_cod_contr');
            }
        }
        $oCon->Free();

        $sHtml = '<div class="modal-dialog modal-lg" role="document" style="width:40%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title" id="myModalLabel" align="center">FORMATOS DE CONTRATO<small></small></h5>
                        </div>
                        <div class="modal-body" style="margin-top:0xp;">
                        <div class="table" id="divFormularioCobros" style="height: 220px; overflow-y: scroll;">
                        <table id="tableConsulta" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%;" align="center">
                                    <thead>
                                        <tr>
                                        <td colspan="14" class="bg-primary"><h5>Seleccione un formato para continuar</small></h5></td>
                                        </tr>
                                        <tr>
                                            <td class="bg-primary" style="width: 10%;">Descripción</td>
                                            <td class="bg-primary" style="width: 90%;">Imprimir</td>
                                        </tr>
                                    </thead>
                                    <tbody>';
        if ($oCon->Query($sqlTipContr)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $contr_des_contr   = $oCon->f('contr_des_contr');
                    $contr_cod_contr   = $oCon->f('contr_cod_contr');
                    $contr_text1_contr   = $oCon->f('contr_text1_contr');

                    $button = '<div align="center"><button class="btn btn-primary" onclick="imprimirContrato(' . $contr_cod_contr . ', \'' . $contr_text1_contr . '\')"><i class="fa-solid fa-print"></i></button></div>';
                    $sHtml .= '<tr>
                                                            <td style="width: 80%;">' . $contr_des_contr . '</td>
                                                            <td style="width: 20%;">' . $button . '</td>
                                                        </tr>';
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();
        $sHtml .= '</tbody>
                    </table>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>';

        $oReturn->script("$('#miModalOk').modal('show')");
        $oReturn->assign("miModalOk", "innerHTML", $sHtml);
        $oReturn->script("jsRemoveWindowLoad()");
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function reinstalar_contrato($id_contrato)
{
    session_start();

    global $DSN;

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();


    $sql = "SELECT id, descripcion from isp.int_tipo_proceso WHERE visible_sn = 'S' AND op_reinstalacion_sn = 'S'";
    $lista_tipo_proceso = lista_boostrap_func($oCon, $sql, 0, 'id',  'descripcion');

    $sql = "SELECT id, paquete FROM isp.int_paquetes";
    unset($array_planes);
    $array_planes = array_dato($oCon, $sql, 'id', 'paquete');

    $sql = "SELECT id, estado FROM isp.int_estados_equipo";
    unset($array_estados);
    $array_estados = array_dato($oCon, $sql, 'id', 'estado');

    $sHtmlTable = '<table id="tablePlanes" class="table table-striped table-bordered table-hover table-condensed" style="align=center">
                <thead>
                    <tr>
                    <td colspan="24" class="bg-primary"><h5>LISTADO DE PLANES REGISTRADOS</small></h5></td>
                    </tr>
                    <tr>
                        <td class="bg-primary">No</td>
                        <td class="bg-primary">Código</td>
                        <td class="bg-primary">Plan</td>
                        <td class="bg-primary">Precio</td>
                        <td class="bg-primary">Registro</td>
                        <td class="bg-primary">Vence</td>
                        <td class="bg-primary">Estado</td>
                        <td class="bg-primary">
                            <input type="checkbox" onclick="marcar(this);"/>
                        </td>
                    </tr>
                </thead>
                <tbody>';
    $sql = "SELECT id, id_caja, id_prod, cod_prod, fecha, fecha_vence, precio, estado from isp.int_contrato_caja_pack where id_contrato = $id_contrato";
    if ($oCon->Query($sql)) {
        if ($oCon->NumFilas() > 0) {
            $i = 1;
            do {
                $id             = $oCon->f('id');
                $id_caja        = $oCon->f('id_caja');
                $id_prod        = $oCon->f('id_prod');
                $cod_prod       = $oCon->f('cod_prod');
                $fecha          = $oCon->f('fecha');
                $fecha_vence    = $oCon->f('fecha_vence');
                $precio         = $oCon->f('precio');
                $id_estado      = $oCon->f('estado');

                $plan           = $array_planes[$id_prod];
                $estado         = $array_estados[$id_estado];
                $check          = '<div align="center"> <input type="checkbox" name="planes_reinst" value="' . $id . '" id="planes_reinst" /></div>';

                $sHtmlTable .= '<tr>
                            <td>' . $i++ . '</td>
                            <td>' . $cod_prod . '</td>
                            <td>' . $plan . '</td>
                            <td>' . $precio . '</td>
                            <td>' . $fecha . '</td>
                            <td>' . $fecha_vence . '</td>
                            <td>' . $estado . '</td>
                            <td>' . $check . '</td>
                        </tr>';
            } while ($oCon->SiguienteRegistro());
        }
    }
    $oCon->Free();
    $sHtmlTable .= '</tbody>
    </table>
    <br> 
    <button type="button" class="btn btn-success btn-lg" onclick="mirarPlanes();" style="width: 100%;">
        <i class="fa fa-plus-circle"></i>
        Agregar Planes
    </button>
    ';

    $sHtml = '<div class="modal-dialog modal-lg" role="document" style="width:95%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" id="myModalLabel" align="center">REINSTALACION DE CONTRATO<small></small></h5>
                    </div>
                    <div class="modal-body" style="margin-top:0xp;">
                        <div class="row">
                            <div class="col-md-12">
                                <h5 class="text-primary" align="center">Selecciones los planes a reinstalar y los motivos para la orden de servicio</h5>
                            </div>
                        </div>
                        <br>
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-8">
                                    ' . $sHtmlTable . '
                                </div>
                                <div class="col-md-4">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="" for="id_tipo_reinstalacion">* Tipo orden de servicio</label>
                                            <select id="id_tipo_reinstalacion" name="id_tipo_reinstalacion" class="form-control select2" style="width:100%" onchange="carga_motivos_reinstalacion()">
                                                <option value="0">Seleccione una opcion..</option>
                                                ' . $lista_tipo_proceso . '
                                            </select>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="" for="id_motivo_reinstalacion">* Motivo orden de servicio</label>
                                            <select id="id_motivo_reinstalacion" name="id_motivo_reinstalacion" class="form-control select2" style="width:100%">
                                                <option value="0">Seleccione una opcion..</option>
                                            </select>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="" for="id_motivo_reinstalacion">* Fecha orden de servicio</label>
                                            <input type="date" class="form-control" value="' . date("Y-m-d") . '" id="fecha_reinstalacion">
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="" for="comentario_reinstalacion">* Comentario orden de servicio</label>
                                            <textarea rows="3" id="comentario_reinstalacion" name="comentario_reinstalacion" class="form-control"></textarea> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer" style="text-align:center">
                        <button type="button" class="btn btn-primary" onclick="generaReinst(' . $id_contrato . ')">Generar Reinstalación</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>';

    $sHtml_ok = $sHtml;

    $oReturn->script("$('#miModal').modal('show')");
    $oReturn->assign("miModal", "innerHTML", $sHtml_ok);
    $oReturn->script("$('.select2').select2();");
    $oReturn->script("jsRemoveWindowLoad()");
    return $oReturn;
}

function carga_motivos_reinstalacion($id)
{
    //Definiciones
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    try {

        if (!empty($id)) {
            $sql = "SELECT id, motivo from isp.int_motivos_canc WHERE id_proceso = $id AND estado = 'A'";
            $listaMotivos .= lista_boostrap_func($oCon, $sql, 0, 'id',  'motivo');

            $oReturn->assign("id_motivo_reinstalacion", "innerHTML", $listaMotivos);

            $oReturn->script("$('.select2').select2();");
        } else {
            $oReturn->assign("id_motivo_reinstalacion", "innerHTML", "");

            $oReturn->script("$('.select2').select2();");
        }
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function generaReinst($datos)
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon1 = new Dbo();
    $oCon1->DSN = $DSN;
    $oCon1->Conectar();

    $oCon2 = new Dbo();
    $oCon2->DSN = $DSN;
    $oCon2->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    //variables de session
    $idempresa  = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];
    $userWeb    = $_SESSION['U_ID'];

    $oReturn = new xajaxResponse();

    try {

        $id_contrato                = $datos["id_contrato"];
        $data_planes                = $datos["data_planes"];
        $id_tipo_orden              = $datos["id_tipo_orden"];
        $id_motivo_reinstalacion    = $datos["id_motivo_reinstalacion"];
        $fecha_reinstalacion        = $datos["fecha_reinstalacion"];
        $comentario_reinstalacion   = $datos["comentario_reinstalacion"];
        $comentario_reinstalacion   = strtoupper(trim($comentario_reinstalacion));

        $sql = "SELECT id_clpv from isp.contrato_clpv where id = $id_contrato";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id_clpv    = $oCon->f('id_clpv');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $oCon1->QueryT('BEGIN;');

        $sql1 = "INSERT INTO isp.estado_contrato (id,   estado,     class,              color,              aplica_factura,
                                                aplica_cartera,     aplica_cortesia,    aplica_servicios,   aplica_equipos) 
                                        VALUES ('RP', 'POR REINSTALAR', 'success',      'green',            'S',
                                                'N',                'N',                'S',                'N') 
                                        ON CONFLICT (id) DO NOTHING;";
        $oCon1->QueryT($sql1);

        $oCon1->QueryT('COMMIT;');


        $oCon->QueryT('BEGIN;');

        $sql = "UPDATE isp.contrato_clpv SET estado = 'RP', fecha_instalacion = '$fecha_reinstalacion' where id = $id_contrato";
        $oCon->QueryT($sql);

        $sql = "DELETE FROM isp.contrato_pago_pack WHERE id_contrato = $id_contrato AND id_clpv = $id_clpv AND valor_pago = 0";
        $oCon->QueryT($sql);

        $sql = "SELECT id FROM isp.contrato_pago WHERE id_contrato = $id_contrato AND id_clpv = $id_clpv AND valor_pago = 0";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id_delete    = $oCon->f('id');

                    $oCon2->QueryT('BEGIN;');

                    $sqlDelete = "DELETE FROM isp.contrato_factura WHERE id_pago = $id_delete AND id_contrato = $id_contrato";
                    $oCon2->QueryT($sqlDelete);

                    $oCon2->QueryT('COMMIT;');
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $sql = "DELETE FROM isp.contrato_pago WHERE id_contrato = $id_contrato AND id_clpv = $id_clpv AND valor_pago = 0";
        $oCon->QueryT($sql);

        $franja = 1;
        $Tareas = new Tareas($oCon, $oIfx, $idempresa, $idsucursal, $id_clpv, $id_contrato, null, null, null);
        $idTarea = $Tareas->ingresarTarea($id_tipo_orden, $fecha_reinstalacion, $comentario_reinstalacion, '', $franja, $id_motivo_reinstalacion, $userWeb);
        if (count($data_planes) > 0) {
            $id_caja = 0;
            $id_caja_pack = 0;

            for ($i = 0; $i < count($data_planes); $i++) {

                $id_caja_pack = $data_planes[$i];

                $sql = "UPDATE isp.int_contrato_caja_pack SET estado = 'P', activo = 'S' where id = $id_caja_pack";
                $oCon->QueryT($sql);

                $sql = "SELECT id_caja from isp.int_contrato_caja_pack where id = $id_caja_pack";
                if ($oCon->Query($sql)) {
                    if ($oCon->NumFilas() > 0) {
                        do {
                            $id_caja    = $oCon->f('id_caja');
                        } while ($oCon->SiguienteRegistro());
                    }
                }
                $oCon->Free();

                $sql = "UPDATE isp.int_contrato_caja SET estado = 'P' where id = $id_caja";
                $oCon->QueryT($sql);

                if (!empty($idTarea)) {
                    $Tareas->ingresarServiciosTarea('', $id_caja);
                }
            }
        }

        $oCon->QueryT('COMMIT;');

        $oReturn->script("Swal.fire(
            'Exito!',
            'Reinstalación generada de manera exitosa.',
            'success'
        )");

        $oReturn->script('seleccionarContrato(' . $id_clpv . ',' . $id_contrato . ');');
        $oReturn->script("$('#miModal').modal('hide')");
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }
    return $oReturn;
}

function guardarAdjuntosImg($aForm = '', $ruta)
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];
    $usuario_web = $_SESSION['U_ID'];

    //variables del formulario
    $cliente = $aForm['codigoCliente'];
    $idContrato = $aForm['idContrato'];
    $adjunto = substr($aForm['archivo'], 12);
    $titulo = $aForm['titulo'];
    $fechaServer = date("Y-m-d H:i:s");

    $ruta = substr($ruta, 18);
    if (!empty($titulo) && !empty($ruta)) {
        try {

            $oCon->QueryT('BEGIN;');

            $sql = "insert into comercial.adjuntos_clpv (id_empresa, id_sucursal, id_clpv, id_contrato, titulo, ruta, estado, fecha_server, user_web)
										values($idempresa, $idsucursal, $cliente, $idContrato, '$titulo', '$ruta', 'A', '$fechaServer', $usuario_web)";
            $oCon->QueryT($sql);

            $oCon->QueryT('COMMIT;');

            $oReturn->script("Swal.fire({
                                    type: 'success',
                                    title: 'Exito',
                                    text: 'Archivo subido de manera correcta'
                                })");

            //$oReturn->assign('titulo', 'value', '');
            $oReturn->assign('archivo', 'value', '');
            $oReturn->script('consultarAdjuntos();');
        } catch (Exception $e) {
            $oCon->QueryT('ROLLBACK;');
            $oReturn->alert($e->getMessage());
        }
    } else {
        $oReturn->alert('Ingrese Titulo y Archivo Adjunto..!');
    }

    return $oReturn;
}

function consultaNapsGeo($id_sector)
{
    global $DSN_Ifx, $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $filtro_sect = "";
    if ($id_sector != 0) {
        $filtro_sect = " AND id_sector = $id_sector ";
    }

    try {

        // commit
        $oCon->QueryT('BEGIN;');


        $sql = "SELECT id_nap, count(id_nap) as ocupadas FROM isp.int_contrato_caja WHERE id_nap is not null AND estado not in ('E') GROUP BY id_nap ";
        $array_ocupadas = array_dato($oCon, $sql, 'id_nap', 'ocupadas');

        $archivo_naps = '';
        $archivo_naps .= '<markers>' . PHP_EOL;
        $sql = "SELECT id, nombre, poste, latitud, longitud, capacidad, can_uso, can_libre, siglas
            from isp.int_nap
            where estado = 'A' 
            $filtro_dis 
            $filtro_sect 
            $filtro_nap
            $filtro_tar
            $filtro_pue";
        if ($oCon->Query($sql)) {
            if ($oCon->NumFilas() > 0) {
                do {
                    $id = $oCon->f('id');
                    $nombre = $oCon->f('nombre');
                    $poste = $oCon->f('poste');
                    $latitud = $oCon->f('latitud');
                    $longitud = $oCon->f('longitud');
                    $capacidad = $oCon->f('capacidad');
                    $can_uso = $array_ocupadas[$id];

                    if (empty($can_uso)) {
                        $can_uso = 0;
                    }

                    $can_libre = $capacidad - $can_uso;
                    $siglas = $oCon->f('siglas');

                    $nombre = $siglas . ' - ' . $nombre;

                    $archivo_naps .= '<marker id="' . $id . '" nombre="' . $nombre . '" poste="' . $poste . '" latitud="' . $latitud . '" longitud="' . $longitud . '" capacidad="' . $capacidad . '" can_uso="' . $can_uso . '" can_libre="' . $can_libre . '"/>' . PHP_EOL;
                } while ($oCon->SiguienteRegistro());
            }
        }
        $oCon->Free();

        $archivo_naps .= '</markers>';
        $ruta = "upload/naps";
        if (!file_exists($ruta)) {
            mkdir($ruta);
        }

        $nombre =  "naps_ubicacion.xml";

        if (unlink($ruta . '/' . $nombre)) {
            $archivo = fopen($ruta . '/' . $nombre, "w+");
            //fwrite($archivo, $xml);
            fwrite($archivo, utf8_encode($archivo_naps));
            fclose($archivo);

            $oReturn->script('initMap(\'' . $latitud . '\',\'' . $longitud . '\')');
        } else {
            $oReturn->alert("Error al generar mapa");
        }
    } catch (Exception $e) {
        // rollback
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function opciones_diferir($id_contrato)
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $UbicacionAdj = $aForm[$posicionId];

    $oReturn = new xajaxResponse();

    try {

        $oCon->QueryT('BEGIN;');

        $sql = "SELECT sum(total) as total_sus from isp.int_suscribir where id_contrato = $id_contrato AND estado = 'PE' AND precio > 0";
        $total_sus = consulta_string_func($sql, 'total_sus', $oCon, 0);

        $sql = "SELECT duracion, tarifa from isp.contrato_clpv where id = $id_contrato";
        $duracion = consulta_string_func($sql, 'duracion', $oCon, 0);
        $tarifa = consulta_string_func($sql, 'tarifa', $oCon, 0);

        //HTML PARA EL FORMULARIO DE DIFERIR CUOTAS
        $sHtml = '<div class="modal-dialog modal-lg" role="document" style="width:98%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title text-primary" id="myModalLabel" align="center">DIFERIR CUOTAS DE INSTALACION<small></small></h4>
                        </div>
                        <div class="modal-body" style="margin-top:0xp;">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-3">
                                        <label for="">
                                            Valor de instalación:
                                        </label>
                                        <input type="text" class="form-control input-sm" name="valor_instalacion" id="valor_instalacion" value="' . $total_sus . '" disabled>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="">
                                            Numero de cuotas individuales:
                                        </label>
                                        <input type="text" class="form-control input-sm" name="num_cuotas_indi" id="num_cuotas_indi" value="1">
                                    </div>
                                    <div class="col-md-3">
                                        <label for="">
                                            Valor en cuotas individuales:
                                        </label>
                                        <input type="text" class="form-control input-sm" name="valor_cuotas_indi" id="valor_cuotas_indi" value="0" onkeyup="divide_val_instalacion(' . $total_sus . ',' . $duracion . ',0,' . $tarifa . ')">
                                    </div>
                                    <div class="col-md-3">
                                        <label for="">
                                            Valor restante:
                                        </label>
                                        <input type="text" class="form-control input-sm" name="val_restante" id="val_restante" value="' . $total_sus . '" disabled>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="">
                                           Cuotas registradas en el contrato
                                        </label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="table-responsive" id="div_cuotas">
                                            <div style="margin-bottom: 10px;"></div>
                                            <table id="table_cuotas" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%;" align="center">
                                                <thead>
                                                    <tr>
                                                        <td class="bg-info">Número de cuota</td>
                                                        <td class="bg-info">Tarifa</td>
                                                        <td class="bg-info">Valor instalación</td>
                                                        <td class="bg-info">Valor a pagar</td>
                                                    </tr>
                                                </thead>
                                                <tbody>';

        for ($i = 0; $i < $duracion; $i++) {
            $num = $i + 1;
            $sHtml .= ' <tr>
                                                    <td>' . $num . '</td>
                                                    <td>' . $tarifa . '</td>
                                                    <td><input type="text" class="form-control input-sm" name="val_inst_' . $i . '" id="val_inst_' . $i . '" value="0" onkeyup="divide_val_instalacion(' . $total_sus . ',' . $duracion . ',' . $num . ',' . $tarifa . ')"></td>
                                                    <td><input type="text" class="form-control input-sm" name="val_fin_' . $i . '" id="val_fin_' . $i . '" value="' . $tarifa . '" disabled></td>
                                                </tr>';
        }

        $sHtml .= '                             <tbody> 
                                            </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" onclick="guarda_diferir_cuotas(' . $duracion . ',' . $id_contrato . ')">Guardar</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>';

        $oReturn->script("jsRemoveWindowLoad()");
        $oReturn->script("$('#miModalDiferir').modal('show')");
        $oReturn->assign("miModalDiferir", "innerHTML", $sHtml);
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }
    return $oReturn;
}

function guarda_diferir_cuotas($id_contrato, $array_cuotas_p, $array_cuotas_a)
{
    session_start();
    global $DSN, $DSN_Ifx;

    $oCon = new Dbo();
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oIfx = new Dbo;
    $oIfx->DSN = $DSN_Ifx;
    $oIfx->Conectar();

    $oReturn = new xajaxResponse();

    try {

        $oCon->QueryT('BEGIN;');

        $sql = "SELECT id_empresa, id_sucursal, id_clpv from isp.contrato_clpv where id = $id_contrato";
        $id_empresa     = consulta_string_func($sql, 'id_empresa', $oCon, 0);
        $id_sucursal    = consulta_string_func($sql, 'id_sucursal', $oCon, 0);
        $id_clpv        = consulta_string_func($sql, 'id_clpv', $oCon, 0);

        //COLOCA EN CERO LOS VALORES DE INSTALACION ANTIGUOS
        $sql = "UPDATE isp.int_suscribir SET cantidad = 0, precio = 0, total = 0, estado = 'AN' WHERE id_contrato = $id_contrato AND estado = 'PE'";
        $oCon->QueryT($sql);

        //COLOCA LA MANERA EN LA QUE SE DIFIEREN LAS CUOTAS
        $sql = "UPDATE isp.contrato_clpv SET instalador = '2' WHERE id = $id_contrato";
        $oCon->QueryT($sql);

        //INSERTA LOS VALORES INDIVIDUALES
        if (count($array_cuotas_p) > 0) {

            for ($i = 0; $i < count($array_cuotas_p); $i++) {
                $precio = $array_cuotas_p[$i];

                $sql = "INSERT INTO isp.int_suscribir(id_empresa, id_sucursal, id_clpv, id_contrato, equipo, tipo, cantidad, precio, total, pago, estado)
                                values($id_empresa, $id_sucursal, $id_clpv, $id_contrato, 2, 'P', 1, $precio, $precio, 0, 'PE')";
                $oCon->QueryT($sql);
            }
        }

        //INSERTA LOS VALORES ADICIONALES EN LA CUOTA
        if (count($array_cuotas_a) > 0) {

            for ($i = 0; $i < count($array_cuotas_a); $i++) {
                $id_pago = $array_cuotas_a[$i]["num_cuota"];
                $precio = $array_cuotas_a[$i]["valor"];

                $sql = "INSERT INTO isp.int_suscribir(id_empresa, id_sucursal, id_clpv, id_contrato, equipo, tipo, cantidad, precio, total, pago, estado, id_pago)
                                values($id_empresa, $id_sucursal, $id_clpv, $id_contrato, 2, 'A', 1, $precio, $precio, 0, 'PE', $id_pago)";
                $oCon->QueryT($sql);
            }
        }

        $oCon->QueryT('COMMIT;');

        $oReturn->script("Swal.fire({
                                type: 'success',
                                title: 'Exito',
                                text: 'Se a ingresado correctamente'
                            })");

        $oReturn->script('jsRemoveWindowLoad();');
        $oReturn->script("$('#miModalDiferir').modal('hide')");
        $oReturn->assign("miModalDiferir", "innerHTML", '');
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
        $oReturn->script('jsRemoveWindowLoad();');
    }



    return $oReturn;
}

function guarda_firma_scan($aForm = '', $base64)
{

    global $DSN_Ifx, $DSN;
    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oCon1 = new Dbo;
    $oCon1->DSN = $DSN;
    $oCon1->Conectar();

    $oReturn = new xajaxResponse();

    //variables de session
    $idempresa = $_SESSION['U_EMPRESA'];
    $idsucursal = $_SESSION['U_SUCURSAL'];

    //variables del formulario
    $codigoCliente  = $aForm['codigoCliente'];
    $idContrato     = $aForm['idContrato'];
    $fechaServer    = date("Y-m-d H:i:s");

    try {

        // commit
        $oCon->QueryT('BEGIN;');

        $imagen = preg_replace('#^data:image/\w+;base64,#i', '', $base64);

        $sql = "DELETE FROM contrato_firmas WHERE id_contrato = $idContrato";
        $oCon->QueryT($sql);

        $sql = "INSERT INTO contrato_firmas(id_contrato, imagen, created_at) VALUES($idContrato,'$imagen','$fechaServer')";

        $oCon->QueryT($sql);

        $oCon->QueryT('COMMIT;');
        $oReturn->script("Swal.fire({
                            type: 'success',
                            title: 'Exito',
                            text: 'Firma guardada de manera correcta'
                        })");
        $oReturn->script("seleccionarContrato($codigoCliente, $idContrato);");
    } catch (Exception $e) {
        $oCon->QueryT('ROLLBACK;');
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}

function valida_cargar_sector($aForm)
{
    //Definiciones
    global $DSN;

    session_start();

    $oCon = new Dbo;
    $oCon->DSN = $DSN;
    $oCon->Conectar();

    $oReturn = new xajaxResponse();

    $id_empresa = $_SESSION['U_EMPRESA'];
    $id_sucursal = $_SESSION['U_SUCURSAL'];

    $parrDire = $aForm['parrDire'];

    try {

        $sql = "SELECT esq_geografia from isp.int_parametros_general WHERE id_empresa = $id_empresa";
        $esq_geografia = consulta_string_func($sql, 'esq_geografia', $oCon, 0);

        if($esq_geografia == 2){
            if(!empty($id_sucursal) && !empty($parrDire)){
                $sql = "SELECT id, sector from comercial.sector_direccion WHERE id_empresa = $id_empresa AND id_sucursal = $id_sucursal and id_parroquia = $parrDire";
                $listaSector .= lista_boostrap_func($oCon, $sql, 0, 'id',  'sector' ); 
            
                $oReturn->assign("sectorDire", "innerHTML", $listaSector);
            
                $oReturn->script("$('.select2').select2();");
            }else{
                $oReturn->assign("sectorDire", "innerHTML", "");
            
                $oReturn->script("$('.select2').select2();");
            }
    
        }
        
    } catch (Exception $e) {
        $oReturn->alert($e->getMessage());
    }

    return $oReturn;
}
/* :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* PROCESO DE REQUEST DE LAS FUNCIONES MEDIANTE AJAX NO MODIFICAR */
$xajax->processRequest();
/* :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */