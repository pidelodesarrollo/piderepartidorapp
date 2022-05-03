import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:repartidorapp/src/blocs/provider.dart';
import 'package:repartidorapp/src/providers/categorias_provider.dart';
import 'package:repartidorapp/src/providers/usuario_provider.dart';
import 'package:repartidorapp/src/widgets/lista_pedidos.dart';

class PedidosNuevosPage extends StatelessWidget {
  static final String routeName = 'pedidos_en_ruta';

  @override
  Widget build(BuildContext context) {
    // final bloc = ProviderBloc.of(context);
    // final width = ;

    return Scaffold(
      body: Column(
        children: <Widget>[
          _encabezado(context),
          SizedBox(height: 5),
          Expanded(child: _listaPedidos(context))
        ],
      ),
    );
  }

  Widget _listaPedidos(BuildContext context) {
    final usuarioProvider = new UsuarioProvider();
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);

    //return Container();

    return FutureBuilder(
      future: usuarioProvider
          .pedidosNuevos(categoryService.idrepartidor.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ListaPedidos(historiales: snapshot.data);
        } else {
          return Container(
              height: 10.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _encabezado(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        width: _width,
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              'Este es tus pedido asignado',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
