//import 'dart:html';
//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/widgets/card_swiper.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:app_game/models/models.dart';
//import 'package:app_game/services/services.dart';
//import 'package:app_game/providers/partida_form_provider.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
//import 'package:provider/provider.dart';

class PPT extends StatefulWidget {
  const PPT({Key? key}) : super(key: key);

  @override
  State<PPT> createState() => _PPTState();
}

class _PPTState extends State<PPT> {
  //Estilos textos
  /*var*/ TextStyle titulosTxt = const TextStyle(fontSize: 20);
  TextStyle subtitulosTxt = const TextStyle(fontSize: 15);
  TextStyle numerosTxt = const TextStyle(fontSize: 18);
  TextStyle parrafosTxt = const TextStyle(fontSize: 10);
  //variables para imprimir variables de BD
  String creadorimg = '';
  String oponenteimg = '';
  //variables PPT
  int j1ficha = 0, j2ficha = 0, montogame = 100;
  String enviomsj = '', juegosactivos = '', ganador = '';
  //variables para el stream
  //final juegosBloc = PeticionesPPTBloc();
  //Autenticación
  //final storage = new FlutterSecureStorage();
  //variables para leer BD
  final String _baseUrl = 'pptgame-d06ee-default-rtdb.firebaseio.com';
  //final List<Ppt> xpartidas = [];

  //Funciones PPT
  void piedra() {
    j1ficha = 1;
    setState(() {});
  }

  void papel() {
    j1ficha = 2;
    setState(() {});
  }

  void tijera() {
    j1ficha = 3;
    setState(() {});
  }

  void envio() async {
    //_startTimer();
    //enviomsj = "Ficha enviada.";
    //
    setState(() {});

    await Future.delayed(const Duration(seconds: 3), () async {
      Navigator.pushNamed(context, 'partidas_ppt');
    });
  }

  void juegos() {
    enviomsj = "Ficha enviada.";
    setState(() {});
  }

  void actualizar() {
    setState(() {});
  }

  //Funciones del cronómetro
  int _counter = 10;
  Timer? _timer;

  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      /*if (mounted) {
        //String _noDataText;
        setState(() => _timer?.cancel());
      }*/
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  //Termina funciones del cronómetro

  @override
  Widget build(BuildContext context) {
    final Ppt resultado = ModalRoute.of(context)!.settings.arguments as Ppt;

    //StreamBuilder
    int i = 0;
    bool bandera = false;
    final Stream _resultados = (() {
      late final StreamController controller;
      //final partidaService = Provider.of<PartidasServices>(context);

      controller = StreamController(
        onListen: () async {
          //await Future<void>.delayed(const Duration(seconds: 1));
          if (resultado.respoponente == '') {
            while (
                resultado.respcreador != '' && resultado.respoponente == '') {
              //await Future<void>.delayed(const Duration(seconds: 7));
              await Future.delayed(const Duration(seconds: 7), () async {
                final List<Ppt> xpartidas = [];
                //comienza lectura a BD
                /*isSaving = true;
              notifyListeners();*/
                final url = Uri.https(_baseUrl, 'partidas_ppt.json');
                final resp = await http.get(url);
                final Map<String, dynamic> partidasMap = json.decode(resp.body);

                partidasMap.forEach((key, value) {
                  final tempPartidas = Ppt.fromMap(value);
                  //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
                  tempPartidas.id = key;
                  xpartidas.add(tempPartidas);
                });
                final index = xpartidas
                    .indexWhere((element) => element.id == resultado.id);
                resultado.respoponente = xpartidas[index].respoponente;
                /*print(xpartidas.length);*/
                //resultado.respoponente = xpartidas[0].respoponente;
                print('$i : ${resultado.respoponente}');
                //Comienza bolsa del oponente

                /*if (xpartidas[index].usridwin != '' &&
                    xpartidas[index].usridwin != usuariosLista.email) {
                  final xurl =
                      Uri.https(_baseUrl, 'usuarios/games/${usuariosLista.id}.json');
                  final xresp = await http.put(xurl, body: usuariosLista.toJson());
                  final xdecodedData = json.decode(xresp.body);
                  final xindex =
                      usuarios.indexWhere((xelement) => (xelement.id == idBolsaS));
                  print('xindexGanador: $xdecodedData');
                  usuariosLista.bolsa = (usuariosLista.bolsa -
                      xpartidas[index].montototal); //(usuarios[xindex].bolsa! - 10)
                  print("Modifica bolsa del ganador de la partida");
                }*/

                //Finaliza bolsa del oponente
                /*isSaving = false;
              notifyListeners();*/
                //termina lectura a BD
                //if(partidaService.obtenerPartida.respoponente)
                //bandera = partidaService.obtenerPartida(partida);
                controller.add(i++);
                //setState(() {});
              });
            }
            bandera = true;
            print("2Ya respondió, canijo");
          } else {
            print("Ya respondió, canijo");
          }

          //controller.add("HUgoooo");
          /*await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(2);
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(3);
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(4);
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(5);
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(6);*/
          //micodigo
          /*await widget.partidaService.saveOrCreatePartida(
            partida, tarjeta, enviousrcreador);*/
          /*await widget.partidaService
            .updateTarjeta(partida, tarjeta, enviousrcreador);*/
          await controller.close();
        },
      );
      return controller.stream;
    })();
    //termina función del streamcontroller

    /*final partidaForm = Provider.of<PartidaFormProvider>(context);
    final partida = partidaForm.partida;*/
    final size = MediaQuery.of(context).size;
    //print(resultado.nombre);
    return WillPopScope(
      onWillPop: () async {
        //este if no permite salir al jugador cuando está en juego (recomendado)
        /*if (_counter > 0) {
          return false;
        } else {
          return true;
        }*/
        //Este if detiene el cronómetro, evita desbordamiento y deja salir al usuario.
        if (_counter >= 0) {
          //print("Último número: $_counter");
          _timer?.cancel();
          return true;
        } else {
          //print("Último número: $_counter");
          _timer?.cancel();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Piedra, papel o tijera.'),
          elevation: 8.0,
        ),
        backgroundColor: Colors.amber.shade100,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                (_counter > 0)
                    ? const Text("")
                    : const Text(
                        "Listo!",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                        ),
                      ),
                Text(
                  '$_counter',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),

                //aqui
                /*Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    const FlutterLogo(),
                    Expanded(
                      child: Text(
                        "\nMsj. Final: \n\n $enviomsj",
                        style: parrafosTxt,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Icon(Icons.sentiment_very_satisfied),
                  ],
                ),*/
                Row(
                  children: [
                    StreamBuilder(
                      stream: _resultados,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        List<Widget> children;
                        if (snapshot.hasError) {
                          children = <Widget>[
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child:
                                  Text('Stack trace: ${snapshot.stackTrace}'),
                            ),
                          ];
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              print("entró al estado none");
                              children = const <Widget>[
                                Icon(
                                  Icons.info,
                                  color: Colors.blue,
                                  size: 60,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Text(
                                      'Sin estado, vuelve a iniciar partida. ¡Gracias!'),
                                ),
                              ];
                              break;
                            case ConnectionState.waiting:
                              print("entró al estado esperando waiting");
                              children = <Widget>[
                                const SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text(
                                      'Esperando respuestas de ambos jugadores... $bandera'),
                                ),
                              ];
                              break;
                            case ConnectionState.active:
                              //inicia el active para el while
                              print("entró al estado activo");
                              children = <Widget>[
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                  size: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  //mostrar segundos para leer respuesta de ambos contrincantes.
                                  //En teoría debería ser el mismo tiempo.
                                  child: Text('\$${snapshot.data} $bandera'),
                                ),
                                Text(
                                  '\nMuestra fichas de usuarios. \n',
                                  style: titulosTxt,
                                  textAlign: TextAlign.center,
                                ),
                                const Text('\n\n'),
                                /*Text(
                                  '\nPor favor elije tu tarjeta:',
                                  style: subtitulosTxt,
                                ),*/
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    FlutterLogo(),
                                    SizedBox(width: 26),
                                    /*Text(
                                        "Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android."),*/
                                    Icon(Icons.sentiment_very_satisfied),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //cambiarlo por un gidget img y llamar la propiedad img
                                    //if (resultado.nombre == null || resultado.nombre == '')
                                    if (resultado.respcreador == null ||
                                        resultado.respcreador == '')
                                      const SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    else
                                      SizedBox(
                                          //width: double.infinity,
                                          height: size.height * 0.1,
                                          child: const FadeInImage(
                                            /*width: size.width * 0.6,
                                          height: size.height * 0.4,*/
                                            placeholder: AssetImage(
                                                'assets/images/no-image.png'),
                                            image: AssetImage(
                                                'assets/images/interrogacion.png'),
                                            //image: AssetImage('assets/images/no-image.png'),
                                            fit: BoxFit.cover,
                                          )),
                                    /*Text(
                                      //'$j1ficha ',
                                      resultado.nombre!,
                                      style: numerosTxt,
                                    ),*/
                                    Text(
                                      "<->",
                                      style: numerosTxt,
                                    ),
                                    if (resultado.respoponente == null ||
                                        resultado.respoponente == '')
                                      const SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    else
                                      SizedBox(
                                          //width: double.infinity,
                                          height: size.height * 0.1,
                                          child: const FadeInImage(
                                            /*width: size.width * 0.6,
                                          height: size.height * 0.4,*/
                                            placeholder: AssetImage(
                                                'assets/images/no-image.png'),
                                            //TODO: ponerle resultado del oponente, aquí si consultamos a BD
                                            image: AssetImage(
                                                'assets/images/interrogacion.png'),
                                            //image: AssetImage('assets/images/no-image.png'),
                                            fit: BoxFit.cover,
                                          )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //cambiarlo por un gidget img y llamar la propiedad img
                                    //if (resultado.nombre == null || resultado.nombre == '')
                                    Text(
                                      //'$j1ficha ,
                                      'Creador: ?',
                                      style: numerosTxt,
                                    ),
                                    Text(
                                      " /-/ ",
                                      style: numerosTxt,
                                    ),
                                    Text(
                                      //"$j2ficha",
                                      "Oponente: ??",
                                      style: numerosTxt,
                                    ),
                                  ],
                                ),
                                //aquí

                                Text(
                                  "\nGanador (???): ??? \n Poder en juego: \$???.\n\n $enviomsj",
                                  style: parrafosTxt,
                                  textAlign: TextAlign.center,
                                ),
                              ];
                              //setState(() {});
                              break;
                            //termina el active cierra el while
                            case ConnectionState.done:
                              print("entró al estado done");
                              /*setState(() {
                                resultado.respcreador = 'prueba Stream';
                              });*/
                              montogame = 200;
                              if (resultado.usridcreador != '' ||
                                  resultado.usridoponente != '') {
                                ganador = '??cambio';
                              }
                              if (resultado.usridcreador ==
                                  resultado.usridwin) {
                                ganador = 'Creadorxxx';
                              }
                              if (resultado.usridoponente ==
                                  resultado.usridwin) {
                                ganador = 'Oponentexxx';
                              }

                              if (resultado.respcreador == 'piedra') {
                                creadorimg =
                                    "https://images.vexels.com/media/users/3/145641/isolated/preview/30bc99162bca69bdbd27451ceeef8848-ilustracion-de-piedra-de-la-tierra.png";
                              }
                              if (resultado.respoponente == 'piedra') {
                                oponenteimg =
                                    "https://images.vexels.com/media/users/3/145641/isolated/preview/30bc99162bca69bdbd27451ceeef8848-ilustracion-de-piedra-de-la-tierra.png";
                              }
                              if (resultado.respcreador == 'papel') {
                                creadorimg =
                                    "https://i.pinimg.com/originals/f2/9a/99/f29a995653ff0658cfcef654708a02fd.png";
                              }
                              if (resultado.respoponente == 'papel') {
                                oponenteimg =
                                    "https://i.pinimg.com/originals/f2/9a/99/f29a995653ff0658cfcef654708a02fd.png";
                              }
                              if (resultado.respcreador == 'tijera') {
                                creadorimg =
                                    "https://static.vecteezy.com/system/resources/thumbnails/009/664/151/small/scissor-icon-transparent-free-png.png";
                              }
                              if (resultado.respoponente == 'tijera') {
                                oponenteimg =
                                    "https://static.vecteezy.com/system/resources/thumbnails/009/664/151/small/scissor-icon-transparent-free-png.png";
                              }
                              children = <Widget>[
                                const Icon(
                                  Icons.info,
                                  color: Colors.blue,
                                  size: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text('\$${snapshot.data} (closed)'),
                                ),
                                Text(
                                  '\nMuestra fichas de usuarios. \n',
                                  style: titulosTxt,
                                  textAlign: TextAlign.center,
                                ),
                                const Text('\n\n'),
                                /*Text(
                                  '\nPor favor elije tu tarjeta:',
                                  style: subtitulosTxt,
                                ),*/
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    FlutterLogo(),
                                    SizedBox(width: 26),
                                    /*Text(
                                        "Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android."),*/
                                    Icon(Icons.sentiment_very_satisfied),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //cambiarlo por un gidget img y llamar la propiedad img
                                    //if (resultado.nombre == null || resultado.nombre == '')
                                    if (resultado.respcreador == null ||
                                        resultado.respcreador == '')
                                      const SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    else
                                      SizedBox(
                                          //width: double.infinity,
                                          height: size.height * 0.1,
                                          child: FadeInImage(
                                            /*width: size.width * 0.6,
                                          height: size.height * 0.4,*/
                                            placeholder: const AssetImage(
                                                'assets/images/no-image.png'),
                                            image: NetworkImage(creadorimg),
                                            //image: AssetImage('assets/images/no-image.png'),
                                            fit: BoxFit.cover,
                                          )),
                                    /*Text(
                                      //'$j1ficha ',
                                      resultado.nombre!,
                                      style: numerosTxt,
                                    ),*/
                                    Text(
                                      "<->",
                                      style: numerosTxt,
                                    ),
                                    if (resultado.respoponente == null ||
                                        resultado.respoponente == '')
                                      const SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    else
                                      SizedBox(
                                          //width: double.infinity,
                                          height: size.height * 0.1,
                                          child: FadeInImage(
                                            /*width: size.width * 0.6,
                                          height: size.height * 0.4,*/
                                            placeholder: const AssetImage(
                                                'assets/images/no-image.png'),
                                            image: NetworkImage(oponenteimg),
                                            //image: AssetImage('assets/images/no-image.png'),
                                            fit: BoxFit.cover,
                                          )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //cambiarlo por un gidget img y llamar la propiedad img
                                    //if (resultado.nombre == null || resultado.nombre == '')
                                    Text(
                                      //'$j1ficha ,
                                      'Creador: ${resultado.respcreador}',
                                      style: numerosTxt,
                                    ),
                                    Text(
                                      " /-/ ",
                                      style: numerosTxt,
                                    ),
                                    Text(
                                      //"$j2ficha",
                                      "Oponente: ${resultado.respoponente}",
                                      style: numerosTxt,
                                    ),
                                  ],
                                ),
                                Text(
                                  "\nGanador ($ganador): \n${resultado.usridwin} \n Poder en juego: ${resultado.montototal}.\n\n $enviomsj",
                                  style: parrafosTxt,
                                  textAlign: TextAlign.center,
                                ),
                              ];
                              break;
                          }
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        );
                      },
                    ),
                  ],
                  //Termina el streamBuilder
                  //lógica fin.
                )
                /*,
                StreamBuilder(
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return ListView.builder(
                      itemBuilder: (_, i) {
                        return const ListTile(
                          title: Text('ABC'),
                        );
                      },
                    );
                  },
                ),*/
                /*Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain, // otherwise the logo will be tiny
                    child: FlutterLogo(),
                  ),
                ),*/
              ],
            ),
          ),
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BotoneraInferior(
            piedraFn: piedra,
            papelFn: papel,
            tijeraFn: tijera,
            enviomsjFn: envio),
      ),
    );
  }
}

class BotoneraInferior extends StatefulWidget {
  final Function piedraFn;
  final Function papelFn;
  final Function tijeraFn;
  final Function enviomsjFn;

  const BotoneraInferior({
    Key? key,
    required this.piedraFn,
    required this.papelFn,
    required this.tijeraFn,
    required this.enviomsjFn,
  }) : super(key: key);

  @override
  State<BotoneraInferior> createState() => _BotoneraInferiorState();
}

class _BotoneraInferiorState extends State<BotoneraInferior> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /*FloatingActionButton(
          heroTag: "btnPiedra",
          child: const Icon(Icons.storm),
          onPressed: () => widget
              .piedraFn(), /*() {
            j1ficha = 1;
            setState(() {});
          }
          ,*/
        ),*/
        //const SizedBox(width: 20),
        /*FloatingActionButton(
          heroTag: "btnPapel",
          child: const Icon(Icons.filter_frames),
          onPressed: () => widget
              .papelFn(), /*() {
            j1ficha = 2;
            setState(() {});
          }
          ,*/
        ),
        //const SizedBox(width: 20),
        FloatingActionButton(
          heroTag: "btnTijera",
          child: const Icon(Icons.switch_access_shortcut_sharp),
          onPressed: () => widget
              .tijeraFn(), /*() {
            j1ficha = 3;
            setState(() {});
          }
          ,*/
        ),*/
        //const SizedBox(width: 20),
        FloatingActionButton(
          heroTag: "btnEnvioMsj",
          child: const Icon(Icons.play_arrow),
          onPressed: () {
            widget.enviomsjFn(); //otra forma de definir la función
          }, /*() {
            j1ficha++;
            setState(() {});
          }
          ,*/
        ),
      ],
    );
  }
}
