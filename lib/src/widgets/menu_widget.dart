import 'dart:async';

import 'package:repartidorapp/src/blocs/login_bloc.dart';
import 'package:repartidorapp/src/blocs/provider.dart';
//import 'package:negocioapp/src/providers/promos_provider.dart';
import 'package:repartidorapp/src/providers/usuario_provider.dart';
import 'package:repartidorapp/src/widgets/usuario_nombre_menu.dart';
//import 'package:clienteapp/src/widgets/promo_swiper.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flushbar/flushbar.dart';

class MenuWidget extends StatelessWidget {
  // final promosProvider = new PromosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = ProviderBloc.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              //color: Colors.lightGreen,
              child: Column(
                children: [
                  SizedBox(width: 20),
                  _usuarioId(bloc),
                ],
              ),
            ),
            /* decoration: BoxDecoration(
              color: Colors.lightGreen,
            ), */
          ),
          //_swiperPromos(),
          // _encabezado(),
          ListTile(
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Inicio'),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.receipt, color: Colors.black),
            title: Text('Mis pedidos'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'pedidosactivos'),
          ),
          ListTile(
              leading: Icon(FontAwesomeIcons.mapPin, color: Colors.black),
              title: Text('Mi ubicación'),
              onTap: () {
                showInfoFlushbar(context);
                Timer(Duration(seconds: 5), () {
                  Navigator.pushReplacementNamed(context, 'loading');
                });
                //Navigator.pushReplacementNamed(context, 'loading');
              }),
          /* ListTile(
            leading: Icon(Icons.pets, color: Colors.lightGreen),
            title: Text('Rastrea tu pedido'),
            onTap: () {},
          ), */
          ListTile(
            leading: Icon(FontAwesomeIcons.piggyBank, color: Colors.black),
            title: Text('Balance'),
            onTap: () => Navigator.pushReplacementNamed(context, 'balance'),
          ),
          ListTile(
            leading: IconButton(
              icon: FaIcon(FontAwesomeIcons.headset, color: Colors.black),
              //icon: SvgPicture.asset("assets/icons/support_agent-24px.svg"),
              onPressed: () {},
            ),
            //  Icon(Icons.pan_tool, color: Colors.lightGreen),
            title: Text('Sugerencias'),
            onTap: () => Navigator.pushReplacementNamed(context, 'reporte'),
          ),
          SizedBox(height: 40.0),
          ListTile(
              leading: IconButton(
                icon: FaIcon(FontAwesomeIcons.powerOff, color: Colors.red),
                //icon: SvgPicture.asset("assets/icons/support_agent-24px.svg"),
                onPressed: () {},
              ),
              //  Icon(Icons.pan_tool, color: Colors.lightGreen),
              title: Text('Salir'),
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  'login', (Route<dynamic> route) => false)),
        ],
      ),
    );
  }

/*   Widget _encabezado() {
    return SizedBox(
      height: 80,
    );
  } */
  /*  Widget _swiperPromos() {
    return FutureBuilder(
      future: promosProvider.getPromociones(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return PromoSwiper(promos: snapshot.data);
        } else {
          return Container(
              height: 200.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  } */

  Widget _usuarioId(LoginBloc bloc) {
    final usuarioProvider = new UsuarioProvider();

    //return Container();

    return SizedBox(
      height: 100.0,
      child: Container(
        margin: EdgeInsets.only(left: 1, right: 15, top: 1, bottom: 1),
        child: FutureBuilder(
          future: usuarioProvider.datosCliente(bloc.email.toString()),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return UsuarioNombreMenu(infocliente: snapshot.data);
            } else {
              return Container(
                  height: 10.0,
                  child: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ),
    );
  }

  void showInfoFlushbar(BuildContext context) {
    Flushbar(
      title: 'Divulgación Destacada',
      message:
          'Al hace uso de la app, apruebas que Pídelo yaa obtenga tu ubicación en segundo plano y siempre en uso de la misma.Esto lo hacemos para poder enviar tus pedidos a donde tú quieras',
      icon: Icon(
        Icons.warning_amber_outlined,
        size: 28,
        color: Colors.blue.shade300,
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 4),
    )..show(context);
  }
}
