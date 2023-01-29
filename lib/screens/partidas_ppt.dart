//import 'dart:async';
//import 'dart:html';
//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/screens/ppt.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_game/models/models.dart';
import 'package:app_game/screens/partida_pptscreen.dart';
import 'package:app_game/screens/screens.dart';
import 'package:app_game/services/services.dart';
import 'package:app_game/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

final List<Opcion> tarjetas = [];
String usrcreador = '';
int num_cont = 0;

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
  //final peticionesBloc = PeticionesPPTBloc();
  //prueba usr
  void navegar() async {
    Navigator.of(context).pushNamed('/partidas_ppt');
  }

  @override
  Widget build(BuildContext context) {
    //llamamos las partidasServicio
    //Obtenemos el usr - idToken
    final authService = Provider.of<AuthService>(context, listen: false);
    //final PartidasServices partidas;

    mostrarusr() async {
      //String? rrvalue = await AuthService().readEmail();
      //String? valor = await authService.storage.read(key: 'usremail');
      try {
        //bandera = 1;

        String? rrvalue = await authService.storage.read(key: 'usremail');
        /*obtenemos el nombre del usuario tomando como referencia su email, lo que va antes del @ con split:
      ${rrvalue!.split('@')[0]}*/
        /* Obtenemos la primera letra y la convertimos en mayúscula:
        ${rrvalue![0].toUpperCase()}${rrvalue.substring(1)}
      */
        usrcreador = rrvalue!.toLowerCase();
        print(
            'Entró a mostrar info de usr en screen de partidas_ppt.dart: $rrvalue y $usrcreador');
        //print(enviomsj);
        if (mounted) {
          // check whether the state object is in tree
          setState(() {
            // make changes here
          });
        }
        return usrcreador;
      } catch (e) {
        print(e);
      }
    }

    //ejecutamos la función para mostrar usrname
    if ((usrcreador == '' || usrcreador != '') && num_cont == 0) {
      num_cont++;
      //TODO: ESTAif (usrcreador != (rrvalue.toLowerCase())) {
      mostrarusr();
      print('NNNUM_CONT: $num_cont');
      //}
    }
    final partidasService = Provider.of<PartidasServices>(context);
    final usuariosService = Provider.of<UsuariosService>(context);
    if (partidasService.isLoading) {
      return LoadingScreen();
    } /* else {
      final partidasService = Provider.of<PartidasServices>(context);
    }*/

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
        //Navigator.pushNamed(_, 'momentos');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Selecciona o crea una partida.'),
          /*title: StreamBuilder(
            stream: peticionesBloc.partidasContador,
            builder: (context, snapshot) {
              return Text('Partidas encontradas: ${snapshot.data ?? 0}');
            },
          ),*/
          elevation: 8.0,
        ),
        backgroundColor: const Color.fromRGBO(239, 184, 16, 0.9),
        //body: RefreshIndicator(
        body: LiquidPullToRefresh(
          height: 300,
          showChildOpacityTransition: true,
          //color: const Color.fromRGBO(212, 207, 41, 0.7),
          color: Colors.deepPurpleAccent.shade200,
          borderWidth: 4.0,
          springAnimationDurationInMilliseconds: 1000,
          //color: const Color.fromRGBO(151, 195, 240, 1),
          //backgroundColor: const Color.fromRGBO(200, 201, 230, 0.7),
          backgroundColor: const Color.fromRGBO(212, 207, 41, 0.8),
          animSpeedFactor: 10,
          child: ListView.builder(
              //separatorBuilder: ((_, __) => const Divider()),
              //return ListView.builder(
              //NoJalascrollDirection: Axis.horizontal,
              itemCount: partidasService.partidas.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () async {
                    //Aquí tenemos que cambiar la funcionalidad "total", pero dirigir con los datos a la ventana (PPT) para comenzar el juego
                    //Me quedé aqui para hacer pruebas de visualizar y copiar únicamente las cards con status 1y2
                    /*partidasService.selectedPartidas =
                        partidasService.partidas[index].copy();*/
                    //TODO: Checar el copy
                    partidasService.selectedPartidas =
                        partidasService.partidas[index];

                    //incluir evalúo de que tenga poder en su granja el usr, así como el monto al día permitido,
                    //checar el tema de juego entre usrversionapp para poder mayor
                    if (partidasService.partidas[index].usridcreador ==
                            usrcreador &&
                        partidasService.partidas[index].status == 1 &&
                        (partidasService.partidas[index].usridoponente == '' ||
                            partidasService.partidas[index].usridoponente ==
                                null)) {
                      NotificationsService.showSnackbar(
                          "tú mismo la hicistesss, aún no hay oponente, recibirás una notificación!");
                    }
                    if (partidasService.partidas[index].usridcreador !=
                            usrcreador &&
                        partidasService.partidas[index].status == 1 &&
                        (partidasService.partidas[index].usridoponente == '' ||
                            partidasService.partidas[index].usridoponente ==
                                null)) {
                      //TODO: Antes de apartar, checar su bolsa del usr
                      rrvalue =
                          (await authService.storage.read(key: 'usremail'))!;
                      var daUsr = await UsuariosService().loadUsuarios();
                      infoUsr = await usuariosService.obtenerUsuario(rrvalue);
                      //2)verifico que tenga poder mayor a 1o pesos en bolsa
                      //Future.delayed(const Duration(seconds: 2), () {
                      final decodedData = await usuariosService
                          .xloadUsuario(daUsr[infoUsr!].id!);
                      diverzcoin = decodedData['bolsa'].toString();
                      var partidas = await PartidasServices().loadPartidas();
                      if (partidas.isNotEmpty) {
                        if ((int.parse(diverzcoin!) >=
                            partidas[index].montototal)) {
                          if (partidas[index].status == 1) {
                            partidasService.apartaPartida(
                                partidasService.partidas[index],
                                tarjetas,
                                usrcreador);
                            //se crea el segundo apartaPartida para apartar en firebase. QS
                            //TODO: FirebaseEjecución
                            Future.delayed(const Duration(seconds: 1),
                                () async {
                              //TODO: BORRAR ES PRUEBA ESTA CARGA DE refrescaTarjetas
                              PartidasServices().refrescaTarjetas();
                              if (partidas[index].status == 2) {
                                NotificationsService.showSnackbar(
                                    "Creador terminó partida. Refresca y busca una nueva. O crea una.");
                              }
                              if (partidas[index].status == 1) {
                                partidasService.apartaPartida(
                                    partidasService.partidas[index],
                                    tarjetas,
                                    usrcreador);
                              }
                            });
                            Navigator.pushNamed(context, 'partida');
                            //inicia validación de bolsa y status en T.real
                          }
                          //TODO: DarSeguimiento, inicia validación de bolsa y status en T.real
                          if (partidas[index].status == 2) {
                            print("Ya la apartaron, no redirijo");
                            NotificationsService.showSnackbar(
                                "Ya te la ganaron! Refresca y busca nueva partida. O crea una.");
                          }
                          if (partidas[index].status == 3) {
                            print("Ya finalizó");
                            NotificationsService.showSnackbar(
                                "Ya finalizó! Refresca y busca nueva partida. O crea una.");
                          }
                        } else {
                          NotificationsService.showSnackbar(
                              "No tienes poder suficiente, realiza una recarga de poder e intenta de nuevo.");
                        }
                      } else {
                        NotificationsService.showSnackbar(
                            "Sin partida disponible, refresca y elige, o crea una nueva partida.");
                      }
                      /*NotificationsService.showSnackbar(
                          "Otro la hizo, deseas ser el oponente?, envía la notificación al creador!");*/
                      //antes de activar la opción, es importante validar su monto en bolsa, modo basico o golden, etc...
                      //si se le permite entrar inmediatamente hacer un update en usridoponente, para reservar su lugar
                    }
                    if (partidasService.partidas[index].usridcreador ==
                            usrcreador &&
                        partidasService.partidas[index].status == 2 &&
                        (partidasService.partidas[index].usridoponente != '' ||
                            partidasService.partidas[index].usridoponente !=
                                null)) {
                      Navigator.pushNamed(context, 'partida');
                      //TODO: Cuando soy creador y di mi respuesta y me salgo, ésto me deja entrar y aunque no se guarde otra vez mi respuesta, el usr pensará que hizo un cambio
                      /*NotificationsService.showSnackbar(
                          "Vientos! puedes entrar a retar, ya se tiene oponente!");*/
                    }

                    if (partidasService.partidas[index].usridcreador !=
                            usrcreador &&
                        partidasService.partidas[index].status == 2 &&
                        partidasService.partidas[index].usridoponente !=
                            usrcreador) {
                      NotificationsService.showSnackbar(
                          "Ya te la ganaron! no la creastess ni eres oponente. refresca y busca nueva partida. O crea una.");
                    }

                    if (partidasService.partidas[index].usridcreador !=
                            usrcreador &&
                        partidasService.partidas[index].status == 2 &&
                        partidasService.partidas[index].usridoponente ==
                            usrcreador) {
                      Navigator.pushNamed(context, 'partida');
                      /*NotificationsService.showSnackbar(
                          "¡Eres oponente, qué esperas! Envía tu respuesta.");*/
                    }

                    if (partidasService.partidas[index].usridcreador ==
                            usrcreador &&
                        partidasService.partidas[index].status == 3 &&
                        (partidasService.partidas[index].usridoponente != '' ||
                            partidasService.partidas[index].usridoponente !=
                                null)) {
                      NotificationsService.showSnackbar(
                          "Ya la llevaste a cabo, fuiste el creador! Realiza una nueva partida.");
                    }

                    if (partidasService.partidas[index].usridcreador !=
                            usrcreador &&
                        partidasService.partidas[index].status == 3 &&
                        partidasService.partidas[index].usridoponente !=
                            usrcreador) {
                      NotificationsService.showSnackbar(
                          "Chav@, Ya se llevó a cabo! No estás dentro de la partida. Intenta creando nueva partida.");
                    }

                    if (partidasService.partidas[index].usridcreador !=
                            usrcreador &&
                        partidasService.partidas[index].status == 3 &&
                        partidasService.partidas[index].usridoponente ==
                            usrcreador) {
                      NotificationsService.showSnackbar(
                          "Chav@, Ya se llevó a cabo! Fuiste el oponente en la partida. Intenta creando nueva partida.");
                    }
                  },
                  //Logra mostrar al usr únicamente cards disponibles y en status 'En partida'
                  //Falta aplicar una limpieza de la lista para que únicamente guarde las partidas con dichos estatus
                  //lo que para que cuando la app muestra las mismas, se crean espacios en blanco con las de estatus finalizó
                  child: /*partidasService.partidas[index].status == 1 ||
                            partidasService.partidas[index].status == 2
                        ? PartidasCard(
                            partida: partidasService.partidas[index],
                          )
                        : const Text(""),*/
                      //Muestra todas las tarjetas
                      PartidasCard(
                    partida: partidasService.partidas[index],
                  ))),
          onRefresh: () {
            //partidasService.dispose;
            //setState(() {
            //final PartidasServices partidasService =
            //Provider.of<PartidasServices>(context, listen: false);

            /*final PartidasServices partidasService =
                  Provider.of<PartidasServices>(context, listen: false);*/
            //partidasService.partidas.length = partidasService.partidas.length;

            //partidasService.selectedPartidas = partidasService.partidas[0];
            /*PartidasCard(
                partida: partidasService.selectedPartidas,
              );*/
            //});
            //setState(() {});
            /*print(formatDate(DateTime.now(), [H, ':', m, am]));
            print('----');
            print(formatDate(DateTime.now(), [d, '-', M, '-', yyyy]));
            print('----');
            print(formatDate(
                DateTime.now(), [z, '->', M, '/', DD, '/', yy, '-', am]));
            print('----');
            print(formatDate(DateTime.now(),
                [d, '/', mm, '/', yyyy, '->', H, ':', m, ':', am]));*/
            //bandera = 0;
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                partidasService.refrescaTarjetas();
                partidasService.refrescaUsuarios();
              });
              //Navigator.pushNamed(context, 'pptpartida');
            });
          },
        ),
        //botonera
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: "btnHome",
              onPressed: () {
                //bandera = 0;
                //Navigator.push(context, _crearRuta1()),
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    Navigator.pushNamed(context, 'momentos');
                  });
                });
              },
              tooltip: 'Home',
              //child: const Icon(Icons.add_reaction_rounded),
              //child: const Icon(Icons.agriculture_rounded),
              //child: const Icon(Icons.app_shortcut_sharp),
              //child: const Icon(Icons.assured_workload_rounded),
              //child: const Icon(Icons.auto_awesome),
              child: const Icon(Icons.widgets_rounded),
              //child: const Icon(Icons.pest_control_sharp),
            ),
            FloatingActionButton(
              //heroTag: "btnRecargar",
              heroTag: "btnCrearPartida",
              onPressed: () async {
                //bandera = 0;
                //1)traigo la info en tiempo real del usr
                try {
                  //TODO: INICIA LA CONSULTA A RESUMIR CON LOCAL STORAGE
                  rrvalue = (await authService.storage.read(key: 'usremail'))!;
                  var daUsr = await UsuariosService().loadUsuarios();
                  infoUsr = await usuariosService.obtenerUsuario(rrvalue);
                  //2)verifico que tenga poder mayor a 1o pesos en bolsa
                  //Future.delayed(const Duration(seconds: 2), () {
                  final decodedData =
                      await usuariosService.xloadUsuario(daUsr[infoUsr!].id!);
                  diverzcoin = decodedData['bolsa'].toString();
                  //TERMINA LA CONSULTA A RESUMIR

                  //await authService.storage.read(key: 'poderBolsa');
                  if (int.parse(diverzcoin!) >= 10) {
                    partidasService.selectedPartidas = Ppt(
                        fechainicio: formatDate(DateTime.now(),
                            [d, '/', mm, '/', yyyy, ' ', H, ':', m, ':', am]),
                        id: '', //validar
                        idPrueba: '', //validar
                        modojuego: false,
                        montototal: 10,
                        oponentes: 1,
                        status: 1,
                        usridcreador: usrcreador,
                        usridoponente: '',
                        usridwin: '',
                        fechafin: '',
                        usrversionapp: 'basica',
                        respcreador: '',
                        respoponente: '',
                        notificar: false);
                    Navigator.pushNamed(context, 'pptpartida');
                  } else {
                    //TODO: popup
                    print(
                        "aplicar el popup para indicarle que no tiene poder en bolsa");
                    NotificationsService.showSnackbar(
                        "Chav@, No tienes suficiente poder para crear una partida, recuerda que el mínimo de poder es de 10.");
                  }
                  //});
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
                } catch (e) {
                  print('error en btnCrearPartida. $e');
                }
              },
              tooltip: 'Agregar',
              child: const Icon(Icons.add_outlined),
            ),
            FloatingActionButton(
              heroTag: "btnRefrescar",
              onPressed: () async {
                //Navigator.push(context, _crearRuta1()),
                //bandera = 0;
                //var daUsr = await UsuariosService().loadUsuarios();
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    partidasService.refrescaTarjetas();
                    //daUsr = daUsr;
                    partidasService.refrescaUsuarios();
                  });
                });
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

  //borrarRuta - se omite por la función.
  Route _crearRuta1() {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            //const PPT(),
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
}
