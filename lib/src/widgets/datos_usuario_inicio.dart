import 'package:provider/provider.dart';
import 'package:repartidorapp/src/models/infocliente_model.dart';
import 'package:flutter/material.dart';
import 'package:repartidorapp/src/providers/categorias_provider.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatosUsuarioInicio extends StatelessWidget {
  final List<InfoCliente> infocliente;

  const DatosUsuarioInicio({@required this.infocliente});

  @override
  Widget build(BuildContext context) {
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);
    return ListView.builder(
      itemCount: this.infocliente.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            /* Image.asset(
              'assets/icons/avatar.png',
              width: 70.0,
            ), */
            //Icon(FontAwesomeIcons.userAlt),
            SizedBox(width: 20, height: 10),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Este es tu # Id : ${categoryService.idrepartidor = this.infocliente[index].idrepartidor}',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    /* Text(
                      'Longitud ${this.infocliente[index].longitud}',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Longitud ${this.infocliente[index].latitud}',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ), */
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
