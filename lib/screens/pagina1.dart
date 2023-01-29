import 'package:app_game/screens/partidas_ppt.dart';
import 'package:app_game/services/auth_service.dart';
import 'package:app_game/services/services.dart';
import 'package:flutter/material.dart';
//import 'package:transicion_app/pages/pagina2_page.dart';
//import 'package:app_game/screens/ppt.dart';
import 'package:app_game/screens/pagina3.dart';
import 'package:provider/provider.dart';

class Pagina1 extends StatefulWidget {
  @override
  State<Pagina1> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
  String enviomsj = '';
  String rrvalue = '';

  //Para poner la primera letra en mayúscula de una palabra
  //String get inCaps => '$this[0].toUpperCase()$this.substring(1)';

  @override
  Widget build(BuildContext context) {
    //int bandera = 0;
    //TextStyle titulosTxt = const TextStyle(fontSize: 27);
    //TextStyle subtitulosTxt = const TextStyle(fontSize: 22);
    //TextStyle numerosTxt = const TextStyle(fontSize: 25);
    TextStyle parrafosTxt =
        const TextStyle(fontSize: 17, color: Color.fromRGBO(0, 38, 76, 1));
    //estilos para aplicar al nombre de usr
    //aplicamos estilos al nombre de usr
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
    ).createShader(const Rect.fromLTWH(0, 0, 200, 70));
    //creamos una instancia para utilizar el localstorage
    final authService = Provider.of<AuthService>(context, listen: false);
    mostrarusr() async {
      //String? rrvalue = await AuthService().readEmail();
      //String? valor = await authService.storage.read(key: 'usremail');
      try {
        //bandera = 1;
        //do {
        rrvalue = (await authService.storage.read(key: 'usremail'))!;
        /*obtenemos el nombre del usuario tomando como referencia su email, lo que va antes del @ con split:
      ${rrvalue!.split('@')[0]}*/
        /* Obtenemos la primera letra y la convertimos en mayúscula:
        ${rrvalue![0].toUpperCase()}${rrvalue.substring(1)}
      */
        enviomsj =
            '\n${rrvalue[0].toUpperCase()}${rrvalue.substring(1).split('@')[0]}';
        //Las siguientes 2 líneas me sirven para obtener info del objeto USRGame para la bolsa
        /*infoUsr = await usuariosService.obtenerUsuario(rrvalue);
          diverzcoin = daUsr[infoUsr!].bolsa;
          print('Valor de DiverZcoin: $diverzcoin');*/
        print('entró a mostrar usr');
        //ponemos el if mounted para detener el error en el widget en tiempo de ejecución.
        if (mounted) {
          // check whether the state object is in tree
          setState(() {
            // make changes here
          });
        }
        //} while (rrvalue.isEmpty || enviomsj.isEmpty);
        return enviomsj;
      } catch (error) {
        print("Excepción en función Mostrar usr, desde Pagina1.dart. $error");
      }
    }

    //ejecutamos la función para mostrar usrname
    if (rrvalue == '' || enviomsj == '') {
      mostrarusr();
    }

    return /*WillPopScope(
      onWillPop: () async {
        //return true; principalmente estaba con éste código comentado
        Navigator.pushNamed(context, 'home');
        return true;
      },
      child:*/
        Scaffold(
      appBar: AppBar(
        title: const Text('Regresa a tu almacén'),
      ),
      backgroundColor: const Color.fromRGBO(251, 160, 254, 1),
      body: SingleChildScrollView(
        child: Center(
          //TODO incluir en el registro el ávatar del usr
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '\n',
                  style: GoogleFonts.montserrat(
                      /*textStyle: const TextStyle(
                          color: Colors.blue, letterSpacing: .5),*/
                      color: const Color.fromRGBO(0, 38, 76, 1),
                      fontSize: 14.5),
                  children: <TextSpan>[
                    TextSpan(
                        text: enviomsj,
                        //style: const TextStyle(fontSize: 27, color: Colors.black45),
                        style: TextStyle(
                            fontSize: 27.0,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient)),
                    TextSpan(
                        //establecemos variable para mostrar el msj del usr, mostrar usr 4de4
                        text: ', \nelige un momento:',
                        style: GoogleFonts.montserrat(
                            /*textStyle: const TextStyle(
                                color: Colors.blue, letterSpacing: .5),*/
                            color: const Color.fromRGBO(0, 38, 76, 1),
                            fontSize: 27.5)),
                  ],
                ),
              ),
              /*Image.asset("assets/images/piedra.png"),*/
              /*const Padding(
                  padding: EdgeInsets.all(20),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.vexels.com/media/users/3/145874/isolated/preview/b55eccb8fb67c9fd017e5df9f47cab3e-roca-de-piedra.png'),
                    radius: 70,
                  ),
                ),*/
              Text(
                '\nSelecciona alguna de las tarjetas, dando clic en el título que hay debajo, para comenzar...\n',
                style: parrafosTxt,
                textAlign: TextAlign.center,
              ),
              DataTable(
                sortColumnIndex: 1,
                sortAscending: false,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromRGBO(137, 25, 161, 0.5)),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromRGBO(137, 25, 161, 0.2)),
                /*border: TableBorder.all(width: 5.0, color: Colors.red.shade200),*/
                //border: TableBorder.all(borderRadius: BorderRadius.zero),
                //showBottomBorder: true,
                //dividerThickness: 5,
                /*decoration: BoxDecoration(
                    border: Border(
                        right: Divider.createBorderSide(context, width: 5.0),
                        left: Divider.createBorderSide(context, width: 5.0)),
                    color: Colors.red.shade200,
                    
                  ),*/
                columns: const [
                  DataColumn(
                    label: Text(
                      "Elije tu \nfortaleza",
                      style: TextStyle(
                          fontSize: 15, color: Color.fromRGBO(0, 38, 76, 1)),
                    ),
                  ),
                  DataColumn(
                      label: Text(
                    "y adquiere \npoder.",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(0, 38, 76, 1)),
                  )),
                ],
                rows: [
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      /*width: 75.0,
                      height: 150.0,*/
                      padding: const EdgeInsets.all(8.0),
                      //color: Colors.indigo.shade400,
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          //scale: 2.5,
                          image: AssetImage("assets/images/pptcomida.png"),
                          centerSlice:
                              Rect.fromLTRB(270.0, 80.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.0),
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color.fromRGBO(0, 38, 76, 1),
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/conejovolado.png"),
                          opacity: 0.2,
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.30),
                    )),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.amber.shade300),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.amber.shade400.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.amber.shade400.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          //bandera = 0;
                          Navigator.push(context, _crearRuta1());
                        },
                        child: const Text(
                          'PPT',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(137, 25, 161, 0.5)),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.amber.shade400.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.amber.shade400.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          //bandera = 0;
                          //Navigator.push(context, _crearRuta2());
                          NotificationsService.showSnackbar('Próximanente...');
                        },
                        child: const Text('Voladito'))),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color.fromRGBO(0, 38, 76, 1),
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/abc.png"),
                          opacity: 0.2,
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.30),
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color.fromRGBO(0, 38, 76, 1),
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/flecha.png"),
                          opacity: 0.2,
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.30),
                    )),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(137, 25, 161, 0.5)),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.amber.shade400.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.amber.shade400.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          //bandera = 0;
                          //Navigator.push(context, _crearRuta1());
                          NotificationsService.showSnackbar(
                              'Módulo en desarrollo, inténtalo más tarde...');
                        },
                        child: const Text('Letras'))),
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(137, 25, 161, 0.5)),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.amber.shade400.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.amber.shade400.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          //bandera = 0;
                          //Navigator.push(context, _crearRuta2());
                          NotificationsService.showSnackbar(
                              'No disponible, por el momento...');
                        },
                        child: const Text('Dirección'))),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color.fromRGBO(0, 38, 76, 1),
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/listaelementos.png"),
                          opacity: 0.2,
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.30),
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color.fromRGBO(0, 38, 76, 1),
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/xlista.png"),
                          opacity: 0.3,
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.30),
                    )),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(137, 25, 161, 0.5)),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.amber.shade400.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.amber.shade400.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          //bandera = 0;
                          //Navigator.push(context, _crearRuta1());
                          NotificationsService.showSnackbar(
                              'Intenta más tarde...');
                        },
                        child: const Text('Lista'))),
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(137, 25, 161, 0.5)),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.amber.shade400.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.amber.shade400.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          //bandera = 0;
                          //Navigator.push(context, _crearRuta2());
                          NotificationsService.showSnackbar(
                              'Opción no activa...');
                        },
                        child: const Text('Elementos'))),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color.fromRGBO(0, 38, 76, 1),
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/rayuela.png"),
                          opacity: 0.2,
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.30),
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color.fromRGBO(0, 38, 76, 1),
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/caballitos.png"),
                          opacity: 0.4,
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.30),
                    )),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(137, 25, 161, 0.5)),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.amber.shade400.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.amber.shade400.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          //bandera = 0;
                          //Navigator.push(context, _crearRuta1());
                          NotificationsService.showSnackbar(
                              'En construcción...');
                        },
                        child: const Text('Rayuela'))),
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(137, 25, 161, 0.5)),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.amber.shade400.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.amber.shade400.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          //bandera = 0;
                          //Navigator.push(context, _crearRuta2());
                          NotificationsService.showSnackbar('Próximanente...');
                        },
                        child: const Text('Carreras'))),
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.access_time),
            onPressed: () {
              Navigator.push(context, _crearRuta());
            }),*/
      //willscope),
    );
  }

  Route _crearRuta1() {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            const PARTIDASPPT(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          // return SlideTransition(
          //   position: Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero ).animate(curvedAnimation),
          //   child: child,
          // );

          return ScaleTransition(
              scale:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);

          //RotationTransition
          /*return RotationTransition(
              turns:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);*/

          /*return FadeTransition(
              opacity:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);*/

          /*return RotationTransition(
              child: FadeTransition(
                  child: child,
                  opacity: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(curvedAnimation)),
              turns:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation));*/
        });
  }

  Route _crearRuta2() {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            Pagina3(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          //baja la pantalla
          return SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero)
                    .animate(curvedAnimation),
            child: child,
          );

          //sale la pantalla de enmedio, comienza pequeñita y se hace grande
          /*return ScaleTransition(
              scale:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);*/

          //RotationTransition - gira la pantalla acia la izquierda, da una vuelta completa
          /*return RotationTransition(
              turns:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);*/
          //se desvanece la pantalla, va desapareciendo
          /*return FadeTransition(
              opacity:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);*/
          //Rota la pantalla hacia la derecha, duele la cabeza no lo sugiero
          /*return RotationTransition(
              turns:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(curvedAnimation),
                  child: child));*/
        });
  }
}
