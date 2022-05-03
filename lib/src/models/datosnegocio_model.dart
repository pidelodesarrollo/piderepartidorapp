class DatoNegocios {
  List<DatoNegocio> items = new List();

  DatoNegocios();

  DatoNegocios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final infonegocio = new DatoNegocio.fromJsonMap(item);
      items.add(infonegocio);
    }
  }
}

class DatoNegocio {
  String idproveedores;
  String razonsocial;
  String gironegocio;
  String nombre;
  String apePat;
  String apeMat;
  String telefono;
  String correo;
  String passwordo;
  DateTime profechacre;
  String calle;
  String numero;
  String colonia;
  String cp;
  String alcaldiamunicipio;
  String entidad;
  String ciudad;
  String icononegocio;
  String activo;
  String descripcion;
  String ubicacion;
  String latitud;
  String longitud;
  String entrecalles;

  DatoNegocio({
    this.idproveedores,
    this.gironegocio,
    this.nombre,
    this.apePat,
    this.apeMat,
    this.telefono,
    this.correo,
    this.passwordo,
    this.profechacre,
    this.calle,
    this.numero,
    this.colonia,
    this.cp,
    this.alcaldiamunicipio,
    this.entidad,
    this.ciudad,
    this.icononegocio,
    this.activo,
    this.descripcion,
    this.ubicacion,
    this.latitud,
    this.longitud,
    this.entrecalles,
  });

  DatoNegocio.fromJsonMap(Map<String, dynamic> json) {
    idproveedores = json["idproveedores"];
    razonsocial = json["razonsocial"];
    gironegocio = json["gironegocio"];
    nombre = json["nombre"];
    apePat = json["ape_pat"];
    apeMat = json["ape_mat"];
    telefono = json["telefono"];
    correo = json["correo"];
    passwordo = json["passwordo"];
    profechacre = DateTime.parse(json["profechacre"]);
    calle = json["calle"];
    numero = json["numero"];
    colonia = json["colonia"];
    cp = json["cp"];
    alcaldiamunicipio = json["alcaldiamunicipio"];
    entidad = json["entidad"];
    ciudad = json["ciudad"];
    icononegocio = json["icononegocio"];
    activo = json["activo"];
    descripcion = json["descripcion"];
    ubicacion = json['ubicacion'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    entrecalles = json['entrecalles'];
  }
}
