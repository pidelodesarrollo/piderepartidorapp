import 'package:flutter/material.dart';
import 'package:repartidorapp/src/blocs/provider.dart';
import 'package:repartidorapp/src/models/historial_model.dart';
import 'package:repartidorapp/src/providers/usuario_provider.dart';
import 'package:repartidorapp/src/widgets/datos_usuario.dart';

class InfoClientePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Historial historial = ModalRoute.of(context).settings.arguments;

    final bloc = ProviderBloc.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Información del cliente'),
        actions: [],
      ),
      body: Column(
        children: <Widget>[
          _usuarioDatos(bloc, historial),
        ],
      ),
    );
  }

  Widget _usuarioDatos(LoginBloc bloc, Historial historial) {
    final usuarioProvider = new UsuarioProvider();

    //return Container();

    return SizedBox(
      height: 400.0,
      child: Container(
        margin: EdgeInsets.only(left: 1, right: 15, top: 1, bottom: 1),
        child: FutureBuilder(
          future: usuarioProvider.datosPedidoCliente(historial.correcliente),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return DatosUsuario(infocliente: snapshot.data);
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
}
