part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return Container();
        } else {
          return FadeInDown(
              duration: Duration(milliseconds: 300),
              child: buildSerchBar(context));
        }
      },
    );
  }

  Widget buildSerchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);

    if (categoryService.negocioLatitud == '') {
      return SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: RaisedButton.icon(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.lightGreen,
          textColor: Colors.white,
          icon: Icon(FontAwesomeIcons.businessTime),
          label: Text('Revisa Info negocio'),
          onPressed: () {
            showInfoFlushbar(context);
          },
        ),
      ));
    }

    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: width,
      child: RaisedButton.icon(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.lightGreen,
        textColor: Colors.white,
        icon: Icon(Icons.business_outlined),
        label: Text('Mostrar a ruta Negocio'),
        onPressed: () async {
          final trafficService = new TrafficService();
          // ignore: deprecated_member_use
          final mapaBloc = context.bloc<MapaBloc>();

          // ignore: deprecated_member_use
          final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
          //final destino = result.position;

          /*   final drivingResponse =
        await trafficService.getCoordsInicioYFin(inicio, destino); */
          final categoryService =
              Provider.of<CategoryService>(context, listen: false);

          final drivingResponse = await trafficService.getCoordsDestino(
              inicio.longitude.toString(),
              inicio.latitude.toString(),
              categoryService.negocioLongitud,
              categoryService.negocioLatitud);

          final geometry = drivingResponse.routes[0].geometry;
          final duracion = drivingResponse.routes[0].duration;
          final distancia = drivingResponse.routes[0].distance;
          final nombreDestino = 'Ubicacion Negocio';

          final points =
              Poly.Polyline.Decode(encodedString: geometry, precision: 6);
          final List<LatLng> rutaCoordenadas = points.decodedCoords
              .map((point) => LatLng(point[0], point[1]))
              .toList();

          mapaBloc.add(OnCrearRutainicioDestino(
              rutaCoordenadas, distancia, duracion, nombreDestino));
        },
      ),
    ));
    /* return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
            // ignore: deprecated_member_use
            final proximidad = context.bloc<MiUbicacionBloc>().state.ubicacion;
            // ignore: deprecated_member_use
            final historial = context.bloc<BusquedaBloc>().state.historial;
            final SearchResult resultado = await showSearch(
                context: context,
                delegate: SearchDestination(proximidad, historial));
            this.retornoBusqueda(context, resultado);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            height: 50,
            child: Text('Presiona y ve donde recoges',
                style: TextStyle(color: Colors.black87)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
          ),
        ),
      ),
    ); */
  }

  Future retornoBusqueda(BuildContext context, SearchResult result) async {
    if (result.cancelo) return;

    if (result.manual) {
      // ignore: deprecated_member_use
      context.bloc<BusquedaBloc>().add(OnActivarMarcadorManual());
      return;
    }

    calculandoAlerta(context);

    // Calcular la ruta en base al valor : Result

    final trafficService = new TrafficService();
    // ignore: deprecated_member_use
    final mapaBloc = context.bloc<MapaBloc>();

    // ignore: deprecated_member_use
    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    //final destino = result.position;

    /*   final drivingResponse =
        await trafficService.getCoordsInicioYFin(inicio, destino); */
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);

    final drivingResponse = await trafficService.getCoordsDestino(
        inicio.longitude.toString(),
        inicio.latitude.toString(),
        categoryService.negocioLongitud,
        categoryService.negocioLatitud);

    final geometry = drivingResponse.routes[0].geometry;
    final duracion = drivingResponse.routes[0].duration;
    final distancia = drivingResponse.routes[0].distance;
    final nombreDestino = result.nombreDestino;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> rutaCoordenadas = points.decodedCoords
        .map((point) => LatLng(point[0], point[1]))
        .toList();

    mapaBloc.add(OnCrearRutainicioDestino(
        rutaCoordenadas, distancia, duracion, nombreDestino));

    Navigator.of(context).pop();

    // agregar al historial

    // ignore: deprecated_member_use
    final busquedaBloc = context.bloc<BusquedaBloc>();

    busquedaBloc.add(OnAgregarHistorial(result));
  }

  void showInfoFlushbar(BuildContext context) {
    Flushbar(
      title: 'Falta la ubicacion del negocio',
      message:
          'Por favor revisa la informacion del negocio en la ficha del pedido(Datos Negocio)',
      icon: Icon(
        Icons.check,
        size: 28,
        color: Colors.blue.shade300,
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
