class Historiales {
  List<Historial> historiales = new List();

  Historiales();

  Historiales.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final historial = new Historial.fromJsonMap(item);
      historiales.add(historial);
    }
  }
}

class Historial {
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
  String idpedidos;
  DateTime fechaped;
  String idcliente;
  String correcliente;
  String idproveedor;
  String correoprov;
  String cantidad;
  String entrega;
  String importe;
  String idarticulos;
  String estado;
  String vigente;
  String girodenegocio;

  Historial({
    this.idrepartidor,
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
    this.entrecalles,
    this.idpedidos,
    this.fechaped,
    this.idcliente,
    this.correcliente,
    this.idproveedor,
    this.correoprov,
    this.cantidad,
    this.entrega,
    this.importe,
    this.idarticulos,
    this.estado,
    this.vigente,
    this.girodenegocio,
  });

  Historial.fromJsonMap(Map<String, dynamic> json) {
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
    idpedidos = json["idpedidos"];
    fechaped = DateTime.parse(json["fechaped"]);
    idcliente = json["idcliente"];
    correcliente = json["correcliente"];
    idproveedor = json["idproveedor"];
    correoprov = json["correoprov"];
    cantidad = json["cantidad"];
    entrega = json["entrega"];
    importe = json["importe"];
    idarticulos = json["idarticulos"];
    estado = json["estado"];
    vigente = json["vigente"];
    girodenegocio = json["girodenegocio"];
  }
}
