import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'calendario_model.dart';
export 'calendario_model.dart';

class CalendarioWidget extends StatefulWidget {
  const CalendarioWidget({Key? key}) : super(key: key);

  @override
  _CalendarioWidgetState createState() => _CalendarioWidgetState();
}

class _CalendarioWidgetState extends State<CalendarioWidget>
    with TickerProviderStateMixin {
  late CalendarioModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    primerVuelo();
    penultimoVuelo();
    _model = createModel(context, () => CalendarioModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  List prim= [];
  Future<void> primerVuelo() async {
    final url = Uri.parse("https://nzb6glvg-3000.brs.devtunnels.ms/api/v1/vuelos/correo/ultimo/$currentUserEmail");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      setState(() {
        prim = json;
      });
      print('todo bien en primer vuelo c:');
      print(json);
    }else {
      print('todo mal en primer vuelo :c');
    }
  }

  List penu= [];
  Future<void> penultimoVuelo() async {
    final url = Uri.parse("https://nzb6glvg-3000.brs.devtunnels.ms/api/v1/vuelos/correo/penultimo/$currentUserEmail");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      setState(() {
        penu = json;
      });
      print('todo bien en penultimo vuelo c:');
      print(json);
    }else{
      print("Error en la solicitud: ${response.statusCode}");
    }

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
          title: Text(
            'Calendario',
            style: FlutterFlowTheme.of(context).headlineMedium,
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 24, 0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed('homePage');
                },
                child: badges.Badge(
                  badgeContent: Text(
                    '1',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                    ),
                  ),
                  showBadge: true,
                  shape: badges.BadgeShape.circle,
                  badgeColor: FlutterFlowTheme.of(context).primary,
                  elevation: 4,
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  position: badges.BadgePosition.topEnd(),
                  animationType: badges.BadgeAnimationType.scale,
                  toAnimate: true,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: FaIcon(
                      FontAwesomeIcons.angleLeft,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment(0, 0),
                    child: FlutterFlowButtonTabBar(
                      useToggleButtonStyle: true,
                      isScrollable: true,
                      labelStyle: FlutterFlowTheme.of(context).titleMedium,
                      unselectedLabelStyle: TextStyle(),
                      labelColor: FlutterFlowTheme.of(context).primaryText,
                      unselectedLabelColor:
                      FlutterFlowTheme.of(context).secondaryText,
                      backgroundColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                      unselectedBackgroundColor:
                      FlutterFlowTheme.of(context).alternate,
                      borderColor: FlutterFlowTheme.of(context).alternate,
                      borderWidth: 2,
                      borderRadius: 12,
                      elevation: 0,
                      labelPadding:
                      EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      tabs: [
                        Tab(
                          text: 'Mes',
                        ),
                        Tab(
                          text: 'Semana',
                        ),
                      ],
                      controller: _model.tabBarController,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _model.tabBarController,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                  ),
                                  child: FlutterFlowCalendar(
                                    color: FlutterFlowTheme.of(context).primary,
                                    iconColor: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    weekFormat: false,
                                    weekStartsMonday: false,
                                    onChange: (DateTimeRange? newSelectedDate) {
                                      setState(() =>
                                      _model.calendarSelectedDay1 =
                                          newSelectedDate);
                                    },
                                    titleStyle:
                                    FlutterFlowTheme.of(context).titleLarge,
                                    dayOfWeekStyle: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                    dateStyle:
                                    FlutterFlowTheme.of(context).bodyMedium,
                                    selectedDateStyle:
                                    FlutterFlowTheme.of(context).titleSmall,
                                    inactiveDateStyle:
                                    FlutterFlowTheme.of(context)
                                        .labelMedium,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment:
                                      AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          currentUserEmail,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                            fontFamily: 'Outfit',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 0, 0),
                                      child: Text(
                                        'Proxima Reserva',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          for (int index = 0; index < prim.length; index++)
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16, 0, 16, 12),
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(4,
                                                              0, 0, 0),
                                                          child: Text(
                                                            prim[index]['nombre'],
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .headlineSmall,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0,
                                                              4, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    8,
                                                                    0),
                                                                child: Card(
                                                                  clipBehavior:
                                                                  Clip.antiAliasWithSaveLayer,
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .accent3,
                                                                  elevation: 0,
                                                                  shape:
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(8),
                                                                  ),
                                                                  child:
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        8,
                                                                        4,
                                                                        8,
                                                                        4),
                                                                    child: Text(
                                                                      prim[index]['hora'],
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .bodyMedium
                                                                          .override(
                                                                        fontFamily:
                                                                        'Outfit',
                                                                        color:
                                                                        FlutterFlowTheme.of(context).tertiary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                prim[index]['fecha'],
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                        shape:
                                                        BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .alternate,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      alignment:
                                                      AlignmentDirectional(
                                                          0.00, 0.00),
                                                      child: Icon(
                                                        Icons.access_time_sharp,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primaryText,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 0, 0),
                                      child: Text(
                                        'Ultima reserva',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 24),
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          for (int index = 0; index < penu.length; index++)
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16, 0, 16, 12),
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(4,
                                                              0, 0, 0),
                                                          child: Text(
                                                            penu[index]['nombre'],
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .headlineSmall,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  8,
                                                                  0),
                                                              child: Card(
                                                                clipBehavior: Clip
                                                                    .antiAliasWithSaveLayer,
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .accent1,
                                                                elevation: 0,
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      8,
                                                                      4,
                                                                      8,
                                                                      4),
                                                                  child: Text(
                                                                    penu[index]['hora'],
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Outfit',
                                                                      color:
                                                                      FlutterFlowTheme.of(context).primary,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  4,
                                                                  0,
                                                                  0,
                                                                  0),
                                                              child: Text(
                                                                penu[index]['fecha'],
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                        shape:
                                                        BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .alternate,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      alignment:
                                                      AlignmentDirectional(
                                                          0.00, 0.00),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .checkDouble,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primaryText,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                  ),
                                  child: FlutterFlowCalendar(
                                    color: FlutterFlowTheme.of(context).primary,
                                    iconColor: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    weekFormat: true,
                                    weekStartsMonday: false,
                                    onChange: (DateTimeRange? newSelectedDate) {
                                      setState(() =>
                                      _model.calendarSelectedDay2 =
                                          newSelectedDate);
                                    },
                                    titleStyle:
                                    FlutterFlowTheme.of(context).titleLarge,
                                    dayOfWeekStyle: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                    dateStyle:
                                    FlutterFlowTheme.of(context).bodyMedium,
                                    selectedDateStyle:
                                    FlutterFlowTheme.of(context).titleSmall,
                                    inactiveDateStyle:
                                    FlutterFlowTheme.of(context)
                                        .labelMedium,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment:
                                      AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          currentUserEmail,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                            fontFamily: 'Outfit',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 0, 0),
                                      child: Text(
                                        'Proximo vuelo',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          for (int index = 0; index < prim.length; index++)
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16, 0, 16, 12),
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(4,
                                                              0, 0, 0),
                                                          child: Text(
                                                            prim[index]['nombre'],
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .headlineSmall,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0,
                                                              4, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    8,
                                                                    0),
                                                                child: Card(
                                                                  clipBehavior:
                                                                  Clip.antiAliasWithSaveLayer,
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .accent3,
                                                                  elevation: 0,
                                                                  shape:
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(8),
                                                                  ),
                                                                  child:
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        8,
                                                                        4,
                                                                        8,
                                                                        4),
                                                                    child: Text(
                                                                      prim[index]['hora'],
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .bodyMedium
                                                                          .override(
                                                                        fontFamily:
                                                                        'Outfit',
                                                                        color:
                                                                        FlutterFlowTheme.of(context).tertiary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                prim[index]['fecha'],
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                        shape:
                                                        BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .alternate,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      alignment:
                                                      AlignmentDirectional(
                                                          0.00, 0.00),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .avianex,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primaryText,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 0, 0),
                                      child: Text(
                                        'Vuelo Anterior',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 24),
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          for (int index = 0; index < penu.length; index++)
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16, 0, 16, 12),
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(4,
                                                              0, 0, 0),
                                                          child: Text(
                                                            penu[index]['nombre'],
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .headlineSmall,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  8,
                                                                  0),
                                                              child: Card(
                                                                clipBehavior: Clip
                                                                    .antiAliasWithSaveLayer,
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .accent1,
                                                                elevation: 0,
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      8,
                                                                      4,
                                                                      8,
                                                                      4),
                                                                  child: Text(
                                                                    penu[index]['hora'],
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Outfit',
                                                                      color:
                                                                      FlutterFlowTheme.of(context).primary,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  4,
                                                                  0,
                                                                  0,
                                                                  0),
                                                              child: Text(
                                                                penu[index]['fecha'],
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                        shape:
                                                        BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .alternate,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      alignment:
                                                      AlignmentDirectional(
                                                          0.00, 0.00),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .ccAmazonPay,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primaryText,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
