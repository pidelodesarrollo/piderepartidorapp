import 'package:provider/provider.dart';
import 'package:repartidorapp/src/models/datoscliente_model.dart';
import 'package:flutter/material.dart';
import 'package:repartidorapp/src/providers/categorias_provider.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatosUsuario extends StatelessWidget {
  final List<DatoCliente> infocliente;

  const DatosUsuario({@required this.infocliente});

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
              height: 120,
            ),
            /* Image.asset(
              'assets/icons/avatar.png',
              width: 70.0,
            ), */
            //Icon(FontAwesomeIcons.userAlt),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      'Nombre: ${this.infocliente[index].nombre} ${this.infocliente[index].apePat} ${this.infocliente[index].apeMat}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ubicación: ${this.infocliente[index].ubicacion}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Número Interior : ${this.infocliente[index].numero}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Entre las calles de ${this.infocliente[index].entrecalles} ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Longitud ${categoryService.clienteLongitud = this.infocliente[index].longitud} ',
                      style: TextStyle(
                          color: Colors.transparent,
                          fontSize: 1.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Latitud ${categoryService.clienteLatitud = this.infocliente[index].latitud} ',
                      style: TextStyle(
                          color: Colors.transparent,
                          fontSize: 1.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton.icon(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 15.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            color: Colors.lightGreen,
                            textColor: Colors.white,
                            icon: Icon(Icons.phone_enabled),
                            label: Text('Telefono de contacto'),
                            onPressed: () {
                              String url =
                                  'tel:+${this.infocliente[index].telefono}';

                              launch(url);
                            },
                          ),
                        ],
                      ),
                    ),
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
/* 
_launchURL() async {
  const url = 'tel:+{}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
 */
