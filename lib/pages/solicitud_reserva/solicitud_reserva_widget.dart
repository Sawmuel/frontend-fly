import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'solicitud_reserva_model.dart';
export 'solicitud_reserva_model.dart';

class SolicitudReservaWidget extends StatefulWidget {
  const SolicitudReservaWidget({Key? key}) : super(key: key);

  @override
  _SolicitudReservaWidgetState createState() => _SolicitudReservaWidgetState();
}

class _SolicitudReservaWidgetState extends State<SolicitudReservaWidget>
    with TickerProviderStateMixin {
  late SolicitudReservaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 110),
          end: Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 110),
          end: Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 110),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    listarPromo();
    _model = createModel(context, () => SolicitudReservaModel());

    _model.yourEmailController ??=
        TextEditingController(text: currentUserEmail);
    _model.yourEmailFocusNode ??= FocusNode();

    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  Future<void> guardasoli() async {
    final tipo_vuelo = _model.tipodevueloValueController?.value;
    final personas = _model.dropDownValueController1?.value;
    final promocion = _model.dropDownValueController2?.value;
    final fecha = _model.datePicked?.toString();

    // Extraer el valor del controlador del correo electrónico.
    final correo = _model.yourEmailController?.text ?? currentUserEmail;

    final body = {
      "tipo_vuelo": tipo_vuelo,
      "personas": personas,
      "promocion": promocion,
      "fecha": fecha,
      "correosa": correo,
    };

    final url = Uri.parse("https://nzb6glvg-3000.brs.devtunnels.ms/api/v1/solicitud/crear");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Manejar el caso de éxito si es necesario.
    }

    print(response.body);
  }

  List promo = [];

  Future<void> listarPromo() async {
    final url = Uri.parse("https://nzb6glvg-3000.brs.devtunnels.ms/api/v1/promociones/lista");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      setState(() {
        promo = json;
      });
    } else {}
    print(response.statusCode);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Solicitud de reserva',
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenido al area de solicitud',
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Recuerde que',
                      style: FlutterFlowTheme.of(context).headlineMedium,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Container(
                            width: 120,
                            constraints: BoxConstraints(
                              maxWidth: 500,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(8, 16, 8, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_phone,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 36,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: Text(
                                      'Contacto:',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: Text(
                                      '956569197',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation1']!),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Container(
                            width: 120,
                            constraints: BoxConstraints(
                              maxWidth: 500,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(8, 16, 8, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 36,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: Text(
                                      'Correo:\nflyuniversalperu@gmail',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation2']!),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Container(
                            width: 120,
                            constraints: BoxConstraints(
                              maxWidth: 500,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(8, 16, 8, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 36,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: Text(
                                      'Pagina Web:\nflyuniversal.pe',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation3']!),
                        ),
                      ),
                    ].divide(SizedBox(width: 12)),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: _model.yourEmailController,
                      focusNode: _model.yourEmailFocusNode,
                      readOnly: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: FlutterFlowTheme.of(context).bodySmall,
                        hintText: 'Your email',
                        hintStyle: FlutterFlowTheme.of(context).bodySmall,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium,
                      keyboardType: TextInputType.emailAddress,
                      validator: _model.yourEmailControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlutterFlowDropDown<String>(
                          controller: _model.tipodevueloValueController ??=
                              FormFieldController<String>(null),
                          options: [
                            'FlyBlue',
                            'FlyBlack',
                            'FlyPremium',
                            'FlyCumpleaños',
                            'FlyEspeciales'
                          ],
                          onChanged: (val) =>
                              setState(() => _model.tipodevueloValue = val),
                          width: 500,
                          height: 50,
                          textStyle: FlutterFlowTheme.of(context).bodyMedium,
                          hintText: 'Seleccione un tipo de vuelo',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                          hidesUnderline: true,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                        Divider(
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).accent4,
                        ),
                      ].divide(SizedBox(height: 12)),
                    ),
                  ),
                  FlutterFlowDropDown<String>(
                    controller: _model.dropDownValueController1 ??=
                        FormFieldController<String>(null),
                    options: ['1', '2', '3', '4', '+5'],
                    onChanged: (val) =>
                        setState(() => _model.dropDownValue1 = val),
                    width: 500,
                    height: 50,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium,
                    hintText: 'Selecciones las personas',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24,
                    ),
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    elevation: 2,
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    borderWidth: 2,
                    borderRadius: 8,
                    margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                    hidesUnderline: true,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                  Divider(
                    thickness: 1,
                    color: FlutterFlowTheme.of(context).accent4,
                  ),
                  Divider(
                    thickness: 1,
                    color: FlutterFlowTheme.of(context).accent4,
                  ),
                  FlutterFlowDropDown<String>(
                    controller: _model.dropDownValueController2 ??= FormFieldController<String>(null),
                    options: ['Promocion 1', 'Promocion 2', 'Promocion 3'],
                    onChanged: (val) =>
                        setState(() => _model.dropDownValue2 = val),
                    width: 500,
                    height: 50,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium,
                    hintText: 'Seleccione Promocion',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24,
                    ),
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    elevation: 2,
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    borderWidth: 2,
                    borderRadius: 8,
                    margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                    hidesUnderline: true,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                  Divider(
                    thickness: 1,
                    color: FlutterFlowTheme.of(context).accent4,
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: FFButtonWidget(
                      onPressed: () async {
                        final _datePickedDate = await showDatePicker(
                          context: context,
                          initialDate: getCurrentTimestamp,
                          firstDate: getCurrentTimestamp,
                          lastDate: DateTime(2050),
                          builder: (context, child) {
                            return wrapInMaterialDatePickerTheme(
                              context,
                              child!,
                              headerBackgroundColor:
                              FlutterFlowTheme.of(context).primary,
                              headerForegroundColor:
                              FlutterFlowTheme.of(context).info,
                              headerTextStyle: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .override(
                                fontFamily: 'Poppins',
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                              pickerBackgroundColor:
                              FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              pickerForegroundColor:
                              FlutterFlowTheme.of(context).primaryText,
                              selectedDateTimeBackgroundColor:
                              FlutterFlowTheme.of(context).primary,
                              selectedDateTimeForegroundColor:
                              FlutterFlowTheme.of(context).info,
                              actionButtonForegroundColor:
                              FlutterFlowTheme.of(context).primaryText,
                              iconSize: 24,
                            );
                          },
                        );

                        TimeOfDay? _datePickedTime;
                        if (_datePickedDate != null) {
                          _datePickedTime = await showTimePicker(
                            context: context,
                            initialTime:
                            TimeOfDay.fromDateTime(getCurrentTimestamp),
                            builder: (context, child) {
                              return wrapInMaterialTimePickerTheme(
                                context,
                                child!,
                                headerBackgroundColor:
                                FlutterFlowTheme.of(context).primary,
                                headerForegroundColor:
                                FlutterFlowTheme.of(context).info,
                                headerTextStyle: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                pickerBackgroundColor:
                                FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                pickerForegroundColor:
                                FlutterFlowTheme.of(context).primaryText,
                                selectedDateTimeBackgroundColor:
                                FlutterFlowTheme.of(context).primary,
                                selectedDateTimeForegroundColor:
                                FlutterFlowTheme.of(context).info,
                                actionButtonForegroundColor:
                                FlutterFlowTheme.of(context).primaryText,
                                iconSize: 24,
                              );
                            },
                          );
                        }

                        if (_datePickedDate != null &&
                            _datePickedTime != null) {
                          safeSetState(() {
                            _model.datePicked = DateTime(
                              _datePickedDate.year,
                              _datePickedDate.month,
                              _datePickedDate.day,
                              _datePickedTime!.hour,
                              _datePickedTime.minute,
                            );
                          });
                        }
                      },
                      text: 'Seleccione Fecha y Hora',
                      options: FFButtonOptions(
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                        FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                        ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: Text(
                        valueOrDefault<String>(
                          _model.datePicked?.toString(),
                          'time',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 12),
                    child: FFButtonWidget(
                      onPressed: () async {
                        guardasoli();
                        await launchURL(
                            'https://api.whatsapp.com/send?phone=956569197&text=Hola, soy el usuario  ${_model.yourEmailController.text},Y quiero solicitar un vuelo${_model.tipodevueloValue} Para ${_model.dropDownValue1} personas,con esta promocion ${_model.dropDownValue2}  y para esta fecha  ${_model.datePicked?.toString()}. Gracias');
                      },
                      text: 'Enviar Solicitud',
                      icon: Icon(
                        Icons.receipt_long,
                        size: 15,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                        FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                        ),
                        elevation: 4,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
