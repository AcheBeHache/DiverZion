//import 'dart:html';

//import 'dart:async';

import 'package:app_game/bloc/peticionesppt_bloc.dart';
import 'package:app_game/screens/ppt.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:app_game/bloc/peticionesppt_bloc.dart';

class PARTIDASPPT extends StatefulWidget {
  const PARTIDASPPT({Key? key}) : super(key: key);

  @override
  State<PARTIDASPPT> createState() => _PARTIDASPPTState();
}

class _PARTIDASPPTState extends State<PARTIDASPPT> {
  //Estilos textos
  /*var*/ TextStyle titulosTxt = const TextStyle(fontSize: 27);
  TextStyle subtitulosTxt = const TextStyle(fontSize: 22);
  TextStyle numerosTxt = const TextStyle(fontSize: 25);
  TextStyle parrafosTxt = const TextStyle(fontSize: 17);
  //Para iniciar la instancia del StreamBuilder, usando nuestro archivo bloc
  final peticionesBloc = PeticionesPPTBloc();

  @override
  Widget build(BuildContext context) {
    //estilosTextos
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 194, 125, 108),
        Color.fromARGB(255, 67, 141, 202)
      ],
    ).createShader(const Rect.fromLTWH(0, 0, 200, 70));
    final Shader xlinearGradient = const LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 194, 125, 108),
        Color.fromARGB(255, 8, 133, 190)
      ],
    ).createShader(const Rect.fromLTWH(0, 0, 200, 70));

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          //title: const Text('Selecciona o crea una partida.'),
          title: StreamBuilder(
            stream: peticionesBloc.partidasContador,
            builder: ((context, snapshot) {
              return Text('Partidas encontradas: ${snapshot.data ?? 0}');
            }),
          ),
          elevation: 8.0,
        ),
        backgroundColor: Colors.amber.shade100,
        body: StreamBuilder(
          stream: peticionesBloc.getPartidas,
          builder: (context, AsyncSnapshot<List<String>> snapshot) {
            final partidas = snapshot.data ?? [];
            final monto = 10;
            return ListView.builder(
              itemCount: partidas.length,
              itemBuilder: (context, i) {
                return ListTile(
                    title: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
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
                  //child: Text('${partidas[i]} monto: \$$monto vs usrN.')),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '\n${partidas[i]}. ',
                      //style: const TextStyle(fontSize: 27, color: Colors.black45),
                      style: TextStyle(
                        fontSize: 13,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = Colors.blue[300]!,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            //establecemos variable para mostrar el msj del usr, mostrar usr 4de4
                            text: 'vs "usrN" -> ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient)),
                        TextSpan(
                            text: ' poder: \$$monto ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = xlinearGradient)),
                      ],
                    ),
                  ),
                ));
              },
            );
          },
        ),
      ),
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
}
