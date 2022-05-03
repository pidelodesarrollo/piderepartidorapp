import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repartidorapp/src/blocs/provider.dart';
import 'package:repartidorapp/src/models/ubicacion_model.dart';
import 'package:repartidorapp/src/providers/categorias_provider.dart';
import 'package:repartidorapp/src/providers/usuario_provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:repartidorapp/src/models/search_result.dart';

//import 'package:repartidorapp/src/search/search_destination.dart';

import 'package:repartidorapp/bloc/mapa/mapa_bloc.dart';
import 'package:repartidorapp/bloc/busqueda/busqueda_bloc.dart';
import 'package:repartidorapp/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline/polyline.dart' as Poly;

import 'package:repartidorapp/helpers/helpers.dart';

import 'package:repartidorapp/services/traffic_service.dart';
import 'package:provider/provider.dart';

part 'btn_ubicacion.dart';
part 'btn_mi_ruta.dart';
part 'btn_seguir_ubicacion.dart';
part 'searchbar.dart';
part 'searchbar2.dart';
part 'marcador_manual.dart';
part 'btn_home.dart';
part 'direccion_cliente.dart';
