import 'package:flutter/material.dart';
//import 'package:transicion_app/pages/pagina2_page.dart';
import 'package:app_game/screens/ppt.dart';
import 'package:app_game/screens/pagina3.dart';

class Pagina1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle titulosTxt = const TextStyle(fontSize: 27);
    //TextStyle subtitulosTxt = const TextStyle(fontSize: 22);
    //TextStyle numerosTxt = const TextStyle(fontSize: 25);
    TextStyle parrafosTxt = const TextStyle(fontSize: 17);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regresa a tu almacén'),
      ),
      backgroundColor: Colors.red.shade100,
      body: SingleChildScrollView(
        child: Center(
          //TODO incluir en el registro el ávatar del usr
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '\n¡(nombre), elige un momento!',
                style: titulosTxt,
                textAlign: TextAlign.center,
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
                    (states) => Colors.red.shade200),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.deepOrange.shade50),
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
                      label: Text("Elije tu \nfortaleza",
                          textAlign: TextAlign.center)),
                  DataColumn(
                      label: Text("y adquiere \npoder.",
                          textAlign: TextAlign.center)),
                ],
                rows: [
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.teal.shade700,
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/ppt1.JPG"),
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.0),
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.teal.shade700,
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://echaloasuerte.com/_next/static/media/coin_og_image.c103683a.png"),
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.0),
                    )),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, _crearRuta1());
                        },
                        child: const Text('PPT'))),
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, _crearRuta2());
                        },
                        child: const Text('Voladito'))),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.pink[200],
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/abc.png"),
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.0),
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.brown[200],
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/flecha.png"),
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.0),
                    )),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, _crearRuta1());
                        },
                        child: const Text('LETRAS'))),
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, _crearRuta2());
                        },
                        child: const Text('Dirección'))),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.teal.shade700,
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/lista.png"),
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.0),
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.teal.shade700,
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-BFwOsrVwxQo73FuiwQy-u92JYeId2DA97Kw19_2Z_hHFyEEZtR29UzPHz3UpDqTKL4k&usqp=CAU"),
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.0),
                    )),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, _crearRuta1());
                        },
                        child: const Text('LISTA'))),
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, _crearRuta2());
                        },
                        child: const Text('Elementos'))),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.teal.shade700,
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2RsfDypuUVYzZs5OTWjvR8MkJmRKwj7wOTFbVCDwgxTIe54lbPtenbPKKLGdKZ40F-Bk&usqp=CAU"),
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.0),
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.teal.shade700,
                      alignment: Alignment.center,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://png.pngtree.com/png-clipart/20210128/ourlarge/pngtree-racecourse-horse-color-silhouette-png-image_2822715.jpg"),
                          centerSlice:
                              Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                      ),
                      transform: Matrix4.rotationZ(0.0),
                    )),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, _crearRuta1());
                        },
                        child: const Text('RAYUELA'))),
                    DataCell(TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, _crearRuta2());
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
    );
  }

  Route _crearRuta1() {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            const PPT(),
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
