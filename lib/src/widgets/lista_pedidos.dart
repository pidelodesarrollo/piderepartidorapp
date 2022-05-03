import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repartidorapp/src/models/historial_model.dart';
import 'package:flutter/material.dart';
import 'package:repartidorapp/src/providers/usuario_provider.dart';
//import 'package:repartidorapp/src/providers/usuario_provider.dart';

class ListaPedidos extends StatelessWidget {
  final List<Historial> historiales;

  const ListaPedidos({this.historiales});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.historiales.length,
        itemBuilder: (BuildContext context, int index) {
          return _Pedido(historial: this.historiales[index], index: index);
        });
  }
}

class _Pedido extends StatelessWidget {
  final Historial historial;
  final int index;

  const _Pedido({@required this.historial, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          _TarjetaTopBar(historial, index),
          _TarjetaTitulo(historial),
          SizedBox(
            height: 10,
          ),
          _TarjetaImporte(historial),
          SizedBox(height: 10.0),
          _TarjetaBotones(historial),
          SizedBox(height: 20.0),
          _TarjetaBotonOk(historial),
          SizedBox(height: 15)
          //Divider(),
        ],
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Historial historial;
  final int index;

  const _TarjetaTopBar(this.historial, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text('${index + 1}.',
              style: TextStyle(color: Colors.lightGreen, fontSize: 18)),
          Text(
            'Fecha : ${historial.fechaped.day}/${historial.fechaped.month}/${historial.fechaped.year}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
              '  Generado a las  ${historial.fechaped.hour}:${historial.fechaped.minute} hrs',
              style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Historial historial;

  const _TarjetaTitulo(this.historial);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text('Pedido # : ${historial.idpedidos} ',
              style: TextStyle(fontSize: 16)),
          Text('  Status:  '),
          Text(historial.estado,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _TarjetaImporte extends StatelessWidget {
  final Historial historial;

  const _TarjetaImporte(this.historial);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text('Importe: \$${historial.importe}   ',
              style: TextStyle(fontSize: 16)),
          // Text('  Status:  '),
          // Text(historial.estado,
          //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  final Historial historial;

  const _TarjetaBotones(this.historial);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: Text('Ver articulos'),
                  color: Colors.lightGreen,
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Navigator.pushNamed(context, 'articulosactivos',
                        arguments: historial);
                  }),
              SizedBox(width: 30),
              RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: Text('Datos Negocio'),
                  color: Colors.orange[300],
                  icon: Icon(
                    FontAwesomeIcons.shoppingBasket,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'infonegocio',
                        arguments: historial);
                  })
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*  RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: Text('Ver articulos'),
                  color: Colors.lightGreen,
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                   /*  Navigator.pushNamed(context, 'articulosactivos',
                        arguments: historial); */
                  }), */
              SizedBox(width: 180),
              RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: Text('Datos Cliente'),
                  color: Colors.lightBlue,
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.pushNamed(context, 'infocliente',
                        arguments: historial);
                  })
            ],
          ),
        ],
      ),
    );
  }
}

class _TarjetaBotonOk extends StatelessWidget {
  final Historial historial;

  const _TarjetaBotonOk(this.historial);

  @override
  Widget build(BuildContext context) {
    if (this.historial.estado.toString() == 'Para envio') {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                label: Text(
                  'Recoger',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightGreen,
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {
                  /* final usuario = new UsuarioProvider();

                usuario.pedidoPreparacion(historial.idpedidos); */
                }),
          ],
        ),
      );
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              label: Text(
                'Entregado',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightGreen,
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                final usuario = new UsuarioProvider();

                usuario.entregarPedido(historial.idpedidos);
                Navigator.pushNamed(context, 'home');
              }),
        ],
      ),
    );
  }
}
