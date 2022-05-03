import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repartidorapp/bloc/busqueda/busqueda_bloc.dart';
import 'package:repartidorapp/bloc/mapa/mapa_bloc.dart';
import 'package:repartidorapp/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:repartidorapp/src/blocs/provider.dart';
import 'package:repartidorapp/src/blocs2/provider2.dart';

import 'package:repartidorapp/src/pages/ayuda_page.dart';
import 'package:repartidorapp/src/pages/balance_page.dart';
import 'package:repartidorapp/src/pages/home_page.dart';
import 'package:repartidorapp/src/pages/infocliente_page.dart';
import 'package:repartidorapp/src/pages/infonegocio_page.dart';
import 'package:repartidorapp/src/pages/inicio_page.dart';
import 'package:repartidorapp/src/pages/iranegocio_page.dart';
import 'package:repartidorapp/src/pages/login/login_page.dart';
import 'package:repartidorapp/src/pages/page_ayuda/articulos_ped_page.dart';
import 'package:repartidorapp/src/pages/page_ayuda/cuenta_page.dart';
import 'package:repartidorapp/src/pages/page_ayuda/dudas_pages.dart';
import 'package:repartidorapp/src/pages/page_ayuda/ofrece_page.dart';
import 'package:repartidorapp/src/pages/page_ayuda/pedidos_page.dart';
import 'package:repartidorapp/src/pages/page_ayuda/pedidosactivos_page.dart';
import 'package:repartidorapp/src/pages/page_ayuda/reporte_page.dart';
import 'package:repartidorapp/src/pages/pedidos_en_proceso_page.dart';
import 'package:repartidorapp/src/pages/pedidos_nuevos_page.dart';
import 'package:repartidorapp/src/pages/ubicacion/acceso_gps_page.dart';
import 'package:repartidorapp/src/pages/ubicacion/loading_page.dart';
import 'package:repartidorapp/src/pages/ubicacion/mapa_page.dart';
import 'package:repartidorapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:repartidorapp/src/providers/categorias_provider.dart';
import 'package:repartidorapp/src/providers/pedidos_provider.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();

    print(prefs.token);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        Provider<ConsultaPedidos>(create: (_) => ConsultaPedidos()),
        ChangeNotifierProvider(create: (_) => new CategoryService()),
        BlocProvider(create: (_) => MiUbicacionBloc()),
        BlocProvider(create: (_) => MapaBloc()),
        BlocProvider(create: (_) => BusquedaBloc()),
      ],
      child: ProviderBloc2(
        child: ProviderBloc(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Negocio App',
            initialRoute: 'login',
            routes: <String, WidgetBuilder>{
              'login': (BuildContext context) => LoginPage(),
              'home': (BuildContext context) => HomePage(),
              'inicio': (BuildContext context) => InicioPage(),
              'ayuda': (BuildContext context) => AyudaPage(),
              'pedidos_nuevos': (BuildContext context) => PedidosNuevosPage(),
              'pedidos_en_proceso': (BuildContext context) =>
                  PedidosEnProcesoPage(),
              'cuenta': (BuildContext context) => CuentaPage(),
              'dudas': (BuildContext context) => DudasPage(),
              'ofrece': (BuildContext context) => OfrecePage(),
              'reporte': (BuildContext context) => ReportePage(),
              'pedidos': (BuildContext context) => PedidosPage(),
              'pedidosactivos': (BuildContext context) => PedidosActivosPage(),
              'articulosactivos': (BuildContext context) => ArticulosPedidos(),
              'infocliente': (BuildContext context) => InfoClientePage(),
              'infonegocio': (BuildContext context) => InfoNegocioPage(),
              'mapa': (BuildContext context) => MapaPage(),
              'loading': (BuildContext context) => LoadingPage(),
              'acceso_gps': (BuildContext contex) => AccesoGpsPage(),
              'iranegocio': (BuildContext context) => IrAnegocioPage(),
              'iracliente': (BuildContext context) => IrAnegocioPage(),
              'balance': (BuildContext context) => BalancePage(),
            },
            theme: ThemeData(primaryColor: Colors.lightGreen[300]),
          ),
        ),
      ),
    );
  }
}
