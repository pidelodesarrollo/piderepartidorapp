import 'package:repartidorapp/src/blocs/login_bloc.dart';
import 'package:repartidorapp/src/models/historial_model.dart';
//import 'package:clienteapp/src/models/productos_model.dart';
import 'package:repartidorapp/src/providers/usuario_provider.dart';
//import 'package:clienteapp/src/widgets/lista_articulos.dart';
import 'package:repartidorapp/src/widgets/lista_artpedido.dart';
import 'package:flutter/material.dart';

import 'package:repartidorapp/src/blocs/provider.dart';

class ArticulosPedidos extends StatelessWidget {
  static final String routeName = 'articulosactivos';

  @override
  Widget build(BuildContext context) {
    final Historial historial = ModalRoute.of(context).settings.arguments;

    final bloc = ProviderBloc.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Articulos del pedido')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _articulosActivos(bloc, historial),
      ),
      /*  floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          backgroundColor: Colors.lightGreen,
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
          }), */
    );
  }

  Widget _articulosActivos(LoginBloc bloc, Historial historial) {
    /*   return Container(
      child: Text('Pedidos ejemplo'),
    ); */

    final usuarioProvider = new UsuarioProvider();

    //return Container();

    return FutureBuilder(
      future: usuarioProvider.artPedidoNuevo(
          historial.idproveedor, historial.idpedidos),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ListaArtPedido(articulos: snapshot.data);
        } else {
          return Container(
              height: 10.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
