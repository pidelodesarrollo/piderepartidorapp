class InfoClientes {
  List<InfoCliente> items = new List();

  InfoClientes();

  InfoClientes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final infocliente = new InfoCliente.fromJsonMap(item);
      items.add(infocliente);
    }
  }
}

class InfoCliente {
  String idrepartidor;
  String nombre;
  String apePat;
  String apeMat;
  String correo;
  String password;
  String telefono;
  DateTime fechaCreacion;
  String calle;
  String numero;
  String colonia;
  String cp;
  String alcaldiamunicipio;
  String entidad;
  String ciudad;
  String status;
  String metodopago;
  String ubicacion;
  String latitud;
  String longitud;
  String entrecalles;

  InfoCliente(
      {this.idrepartidor,
      this.nombre,
      this.apePat,
      this.apeMat,
      this.correo,
      this.password,
      this.telefono,
      this.fechaCreacion,
      this.calle,
      this.numero,
      this.colonia,
      this.cp,
      this.alcaldiamunicipio,
      this.entidad,
      this.ciudad,
      this.status,
      this.metodopago,
      this.ubicacion,
      this.latitud,
      this.longitud,
      this.entrecalles});

  InfoCliente.fromJsonMap(Map<String, dynamic> json) {
    idrepartidor = json["idrepartidor"];
    nombre = json["nombre"];
    apePat = json["ape_pat"];
    apeMat = json["ape_mat"];
    correo = json["correo"];
    password = json["password"];
    telefono = json["telefono"];
    fechaCreacion = DateTime.parse(json["fecha_creacion"]);
    calle = json["calle"];
    numero = json["numero"];
    colonia = json["colonia"];
    cp = json["cp"];
    alcaldiamunicipio = json["alcaldiamunicipio"];
    entidad = json["entidad"];
    ciudad = json["ciudad"];
    status = json["status"];
    metodopago = json['metodopago'];
    ubicacion = json['ubicacion'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    entrecalles = json['entrecalles'];
  }
}
