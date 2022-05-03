import 'dart:convert';

import 'package:repartidorapp/src/models/datoscliente_model.dart';
import 'package:repartidorapp/src/models/datosnegocio_model.dart';
import 'package:repartidorapp/src/models/favoritos_model.dart';
import 'package:repartidorapp/src/models/historial_model.dart';
import 'package:repartidorapp/src/models/importe_model.dart';
import 'package:repartidorapp/src/models/infocliente_model.dart';
import 'package:repartidorapp/src/models/productos_model.dart';
//import 'package:negocioapp/src/models/tarjetas_cobro_model.dart';
//import 'package:negocioapp/src/models/tarjetas_guardadas_model.dart';
//import 'package:clienteapp/src/pages/page_ayuda/articulos_ped_page.dart';
import 'package:repartidorapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  String _url = 'apirestful.pideloyaa.com';

  //final String _apiKey = '12345678';

  //final String _firebaseToken = 'AIzaSyCQo8MHe7aamo8qqi7_vUN9wafuVBRo0KQ';

  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'correo': email,
      'password': password,
      'returnSecureToken': true
    };
    print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/piderepartidor/repartidor',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      print(decodedResp);
      return {'ok': false, 'mensaje': decodedResp['error']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password, String nombre) async {
    final authData = {
      'correo': email,
      'password': password,
      'nombre': nombre,
      'status': 'Alta'

      //,
      //'returnSecureToken': true
    };
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/pidalocliente/newcliente',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      print(decodedResp);
      return {'ok': false, 'mensaje': decodedResp['error']};
    }
  }

  Future<List<InfoCliente>> datosCliente(String email) async {
    final authData = {'correo': email};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/piderepartidor/inforepartidor',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final datoscliente =
        new InfoClientes.fromJsonList(decodedData['infocliente']);

    return datoscliente.items;
  }

  Future<List<DatoCliente>> datosPedidoCliente(String email) async {
    final authData = {'correo': email};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/piderepartidor/infocliente',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final datoscliente =
        new DatosClientes.fromJsonList(decodedData['infocliente']);

    return datoscliente.items;
  }

  Future<List<DatoNegocio>> datosPedidoNegocio(String email) async {
    final authData = {'correo': email};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/piderepartidor/infonegocio',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final datoscliente =
        new DatoNegocios.fromJsonList(decodedData['infonegocio']);

    return datoscliente.items;
  }

  Future<List<Historial>> datosHistorialCliente(String email) async {
    final authData = {'correo': email};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/pidalocliente/historialpedidos',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final historial = new Historiales.fromJsonList(decodedData['historial']);

    return historial.historiales;
  }

  Future<List<Historial>> pedidosEnCurso(String email) async {
    final authData = {'correo': email};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/pidalocliente/pedidosencurso',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final historial = new Historiales.fromJsonList(decodedData['historial']);

    return historial.historiales;
  }

  Future<List<Historial>> pedidosNuevos(String idrepartidor) async {
    final authData = {'idrepartidor': idrepartidor};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/piderepartidor/pedidosnuevos',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final historial = new Historiales.fromJsonList(decodedData['historial']);

    return historial.historiales;
  }

  Future<List<Historial>> pedidosEnProceso(String email) async {
    final authData = {'correo': email};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/detalleproveedor/pedidosenproceso',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final historial = new Historiales.fromJsonList(decodedData['historial']);

    return historial.historiales;
  }

  Future<List<Historial>> pedidosEnEnvio(String email) async {
    final authData = {'correo': email};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/detalleproveedor/pedidosenenvio',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final historial = new Historiales.fromJsonList(decodedData['historial']);

    return historial.historiales;
  }

  Future<List<Articulo>> artPedidoNuevo(
      String idproveedor, String pedido) async {
    final authData = {'idproveedor': idproveedor, 'pedido': pedido};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/detalleproveedor/artpedidonuevo',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final articulo = new ArticulosPedido.fromJsonList(decodedData['articulos']);

    return articulo.articulos;
  }

  Future<List<Favorito>> favoritosCliente(String email) async {
    final authData = {'correo': email};
    //print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/pidalocliente/favoritos',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final favorito = new Favoritos.fromJsonList(decodedData['favoritos']);

    return favorito.favoritos;
  }

  Future<bool> ubicacionNegocio(
      String email, String ubicacion, String latitud, String longitud) async {
    final authData = {
      'email': email,
      'ubicacion': ubicacion,
      'latitud': latitud,
      'longitud': longitud
    };
    //print(authData);
    final url = Uri.https(_url, 'detalleproveedor/ubicacionnegocio');

    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> detalleUbicacionNegocio(
      String email, String numero, String entrecalles) async {
    final authData = {
      'email': email,
      'numero': numero,
      'entrecalles': entrecalles
    };
    //print(authData);
    final url = Uri.https(_url, 'detalleproveedor/detalleubicacionnegocio');

    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> guardarTarjetaCliente(String email, String hidden, String numero,
      String brand, String cvv, String fechaExp, String nombre) async {
    final authData = {
      'email': email,
      'hidden': hidden,
      'numero': numero,
      'brand': brand,
      'cvv': cvv,
      'fechaexp': fechaExp,
      'nombre': nombre
    };
    print(authData);
    final url = Uri.https(_url, 'pidalocliente/guardadotarjeta');

    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

/*   Future<List<TarjetaGuardada>> tarjetasCliente(String email) async {
    final authData = {'correo': email};
    print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/pidalocliente/tarjetascliente',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final tarjeta = new TarjetasGuardadas.fromJsonList(decodedData['tarjetas']);

    return tarjeta.tarjetas;
  } */

  Future<bool> deleteTarjetaCliente(String idtarjeta) async {
    final url = Uri.https(_url, 'pidalocliente/eliminartarjeta/$idtarjeta');

    final resp = await http.post(url, headers: {"X-API-KEY": "12345678"});

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

/*   Future<List<TarjetaCredito>> tarjetasCliConsulta(String email) async {
    final authData = {'correo': email};
    print(authData);
    final resp = await http.post(
        'https://apirestful.pideloyaa.com/pidalocliente/tarjetascliente',
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    final tarjeta = new TarjetasCreditos.fromJsonList(decodedData['tarjetas']);

    return tarjeta.tarjetas;
  } */

  Future<bool> pedidoPreparacion(String idpedido) async {
    final authData = {'idpedido': idpedido};
    //print(authData);
    final url = Uri.https(_url, 'detalleproveedor/pedidoapreparacion');

    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> pedidoParaEnviar(String idpedido) async {
    final authData = {'idpedido': idpedido};
    //print(authData);
    final url = Uri.https(_url, 'detalleproveedor/pedidoparaenviar');

    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> entregarPedido(String idpedido) async {
    final authData = {'idpedido': idpedido};
    //print(authData);
    final url = Uri.https(_url, 'piderepartidor/entregarpedido');

    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<Importe>> getVentDelDia(String mail) async {
    final authData = {'correoprov': mail};
    //print(authData);
    final url = Uri.http(_url, 'detalleproveedor/ventadeldia');

    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});
    final decodedData = json.decode(resp.body);

    final importes =
        new ImportePedido.fromJsonList(decodedData['venta_del_dia']);

    return importes.importes;
  }

  Future<List<Importe>> getVentUltimos7Dias(String mail) async {
    final authData = {'correoprov': mail};
    //print(authData);
    final url = Uri.http(_url, 'detalleproveedor/venta7diasatras');

    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {"X-API-KEY": "12345678", "Content-type": "application/json"});
    final decodedData = json.decode(resp.body);

    final importes =
        new ImportePedido.fromJsonList(decodedData['venta_del_dia']);

    return importes.importes;
  }
}
