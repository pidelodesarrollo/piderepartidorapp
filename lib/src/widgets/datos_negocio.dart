import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repartidorapp/src/models/datosnegocio_model.dart';
import 'package:repartidorapp/src/providers/categorias_provider.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatosNegocio extends StatelessWidget {
  final List<DatoNegocio> infonegocio;

  const DatosNegocio({@required this.infonegocio});

  @override
  Widget build(BuildContext context) {
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);

    return ListView.builder(
      itemCount: this.infonegocio.length,
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
                      'Nombre: ${categoryService.nombreNegocio = this.infonegocio[index].razonsocial} ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ubicación: ${this.infonegocio[index].ubicacion}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Número Interior : ${this.infonegocio[index].numero}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Entre las calles de ${this.infonegocio[index].entrecalles} ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Longitud ${categoryService.negocioLongitud = this.infonegocio[index].longitud} ',
                      style: TextStyle(
                          color: Colors.transparent,
                          fontSize: 1.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Latitud ${categoryService.negocioLatitud = this.infonegocio[index].latitud} ',
                      style: TextStyle(
                          color: Colors.transparent,
                          fontSize: 1.0,
                          fontWeight: FontWeight.bold),
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
