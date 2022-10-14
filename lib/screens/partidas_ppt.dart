//import 'dart:async';
//import 'dart:html';
//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/screens/ppt.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:date_format/date_format.dart';
import 'package:app_game/bloc/peticionesppt_bloc.dart';
import 'package:app_game/models/models.dart';
import 'package:app_game/screens/screens.dart';
import 'package:app_game/services/services.dart';
import 'package:app_game/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  //prueba usr
  String usrcreador = '';

  @override
  Widget build(BuildContext context) {
    //llamamos las partidasServicio
    final partidasService = Provider.of<PartidasServices>(context);
    if (partidasService.isLoading) {
      return LoadingScreen();
    }
    //Obtenemos el usr - idToken
    final authService = Provider.of<AuthService>(context, listen: false);
    mostrarusr() async {
      //String? rrvalue = await AuthService().readEmail();
      //String? valor = await authService.storage.read(key: 'usremail');
      String? rrvalue = await authService.storage.read(key: 'usremail');
      /*obtenemos el nombre del usuario tomando como referencia su email, lo que va antes del @ con split:
      ${rrvalue!.split('@')[0]}*/
      /* Obtenemos la primera letra y la convertimos en mayúscula:
        ${rrvalue![0].toUpperCase()}${rrvalue.substring(1)}
      */
      usrcreador = rrvalue!.toLowerCase();
      //print(enviomsj);
      setState(() {});
      return usrcreador;
    }

    //ejecutamos la función para mostrar usrname
    mostrarusr();
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
            builder: (context, snapshot) {
              return Text('Partidas encontradas: ${snapshot.data ?? 0}');
            },
          ),
          elevation: 8.0,
        ),
        backgroundColor: Colors.amber.shade100,
        body: RefreshIndicator(
          color: Colors.yellow.shade600,
          child: ListView.builder(
              //separatorBuilder: ((_, __) => const Divider()),
              //return ListView.builder(
              itemCount: partidasService.partidas.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () {
                      //Aquí tenemos que cambiar la funcionalidad "total", pero dirigir con los datos a la ventana (PPT) para comenzar el juego
                      partidasService.selectedPartidas =
                          partidasService.partidas[index].copy();
                      Navigator.pushNamed(context, 'partida');
                    },
                    child: PartidasCard(
                      partida: partidasService.partidas[index],
                    ),
                  )),
          onRefresh: () {
            /*print(formatDate(DateTime.now(), [H, ':', m, am]));
            print('----');
            print(formatDate(DateTime.now(), [d, '-', M, '-', yyyy]));
            print('----');
            print(formatDate(
                DateTime.now(), [z, '->', M, '/', DD, '/', yy, '-', am]));
            print('----');
            print(formatDate(DateTime.now(),
                [d, '/', mm, '/', yyyy, '->', H, ':', m, ':', am]));*/
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {});
            });
          },
        ),
        //botonera
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: "btnRecargar",
              onPressed: () {
                partidasService.selectedPartidas = Ppt(
                    fechainicio: formatDate(DateTime.now(),
                        [d, '/', mm, '/', yyyy, ' ', H, ':', m, ':', am]),
                    id: '', //validar
                    idPrueba: '', //validar
                    modojuego: false,
                    montototal: 1,
                    oponentes: 1,
                    status: 1,
                    //TODO: establecerle el dato del localstorage
                    usridCreador: usrcreador,
                    usridnowin: '',
                    usridwin: '',
                    fechafin: '');
                Navigator.pushNamed(context, 'partida');
                /*showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: Colors.lightBlue.shade100,
                          title: const Text("¡A tu medida!"),
                          content: const SingleChildScrollView(
                            child: Text(
                                "Crea una partida e invita a la comunidad. \n Antes de establecer los siguientes datos es importante tener poder en tu granja, tu poder actual es de: \$\$\$ DiverZCoin"),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Crear e invitar..."))
                          ],
                        ))*/
              },
              tooltip: 'Refrescar',
              child: const Icon(Icons.add_outlined),
            ),
            FloatingActionButton(
              heroTag: "btnRefrescar",
              onPressed: () => {
                //Navigator.push(context, _crearRuta1())
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {});
                })
              },
              tooltip: 'Refrescar',
              //child: const Icon(Icons.add_reaction_rounded),
              //child: const Icon(Icons.agriculture_rounded),
              //child: const Icon(Icons.app_shortcut_sharp),
              //child: const Icon(Icons.assured_workload_rounded),
              //child: const Icon(Icons.auto_awesome),
              child: const Icon(Icons.refresh),
              //child: const Icon(Icons.pest_control_sharp),
            ),
            /*MaterialButton(
            minWidth: 200.0,
            height: 40.0,
            onPressed: () {},
            color: Colors.lightBlue,
            child: const Text('Material Button',
                style: TextStyle(color: Colors.white)),
          ),*/
          ],
        ),
        //termina botonera
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
