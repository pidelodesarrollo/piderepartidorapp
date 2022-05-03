import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repartidorapp/src/blocs/provider.dart';
import 'package:repartidorapp/src/providers/usuario_provider.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:repartidorapp/src/utils/utils.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = 'login';

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(107, 175, 46, 1.0),
        Color.fromRGBO(107, 175, 46, 1.0)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              FadeInImage(
                image: AssetImage('assets/icon/pideloyaa-icon.png'),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 90.0,
              ),
              // Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text(
                'Repartidor',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = ProviderBloc.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 0.5),
                    spreadRadius: 3.0,
                  )
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 40.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc),
              ],
            ),
          ),
          /* FlatButton(
            child: Text('Crear una nueva cuenta'),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'registro'),
          ), */
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.lightGreen),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.lightGreen),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: Text('Ingresar'),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 0.0,
              color: Colors.lightGreen,
              textColor: Colors.white,
              onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
        });
  }

  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if (info['ok']) {
      if (!Platform.isAndroid) {
        aviso(context);
      }

      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: Text('Términos de Servicio y Política de Privacidad'),
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Bienvenido a Pídelo Yaa!',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      child: Center(
                        child: Text(
                            'Los Términos de Servicio y la Política de Privacidad de Pídelo Yaa proporcionan más detalles sobre cómo recopilamos y utilizamos la información.',
                            textAlign: TextAlign.justify),
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Container(
                      child: Center(
                        child: Text(
                            'Al hacer clic en “Aceptar”, indicas que estás de acuerdo con los Términos de Servicio de Pídelo Yaa!, y que has leído y comprendes la Política de Privacidad.',
                            textAlign: TextAlign.justify),
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          _launchURL();
                        },
                        child: Text(
                          'Consulta la versión completa de los Términos de Servicio y la Política de Privacidad.',
                          style: TextStyle(
                              color: Colors.lightGreen, fontSize: 15.0),
                        ),
                      ),
                      /* Center(
                        child: Text(
                            'Consulta la versión completa de los Términos de Servicio y la Política de Privacidad.'),
                      ), */
                    ),
                  ],
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Aceptar'),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'home');
                    },
                  )
                ],
              ));

      // Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarAlerta(context, info['mensaje']);
    }

    // Navigator.pushReplacementNamed(context, 'home');
  }

  void aviso(BuildContext context) {
    AlertDialog(
      title: Text('Términos de Servicio y Politica de Privacidad'),
      content: Column(
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Container(
            child: Center(
              child: Text(
                'Bienvenido a Pídelo Yaa!',
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Container(
            child: Center(
              child: Text(
                  'Los Términos de Servicio y la Política de Privacidad de Pídelo Yaa proporcionan más detalles sobre cómo recopilamos y utilizamos la información.',
                  textAlign: TextAlign.justify),
            ),
          ),
          SizedBox(height: 3.0),
          Container(
            child: Center(
              child: Text(
                  'Al hacer clic en “Aceptar”, indicas que estás de acuerdo con los Términos de Servicio de Pídelo Yaa!, y que has leído y comprendes la Política de Privacidad.',
                  textAlign: TextAlign.justify),
            ),
          ),
          SizedBox(height: 3.0),
          Container(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _launchURL();
                },
                child: Text(
                  'Consulta la versión completa de los Términos de Servicio y la Política de Privacidad.',
                  style: TextStyle(color: Colors.lightGreen, fontSize: 15.0),
                ),
              ),
              /* Text(
                  'Consulta la versión completa de los Términos de Servicio y la Política de Privacidad.'),
             */
            ),
          ),
        ],
      ),
      actions: <Widget>[
        RaisedButton(
            color: Colors.lightGreen,
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
            child: Text('Aceptar'))
      ],
    );
  }

  _launchURL() async {
    const url = 'http://www.pideloyaa.com/?page_id=1659';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
