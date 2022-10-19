//import 'dart:html';

import 'dart:async';

import 'package:flutter/material.dart';

//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:app_game/bloc/peticionesppt_bloc.dart';

class PPT extends StatefulWidget {
  const PPT({Key? key}) : super(key: key);

  @override
  State<PPT> createState() => _PPTState();
}

class _PPTState extends State<PPT> {
  //Estilos textos
  /*var*/ TextStyle titulosTxt = const TextStyle(fontSize: 27);
  TextStyle subtitulosTxt = const TextStyle(fontSize: 22);
  TextStyle numerosTxt = const TextStyle(fontSize: 25);
  TextStyle parrafosTxt = const TextStyle(fontSize: 17);
  //variables PPT
  int j1ficha = 0, j2ficha = 0, montogame = 100;
  String enviomsj = '', juegosactivos = '';
  //variables para el stream
  //final juegosBloc = PeticionesPPTBloc();
  //Autenticación
  //final storage = new FlutterSecureStorage();

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

  void envio() {
    _startTimer();
    enviomsj = "Ficha enviada.";
    setState(() {});
  }

  void juegos() {
    enviomsj = "Ficha enviada.";
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
                Text(
                  '\nMuestra fichas de usuarios.',
                  style: titulosTxt,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '\nPor favor elije tu tarjeta:',
                  style: subtitulosTxt,
                ),
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
                    Text(
                      '$j1ficha ',
                      style: numerosTxt,
                    ),
                    Text(
                      "<->",
                      style: numerosTxt,
                    ),
                    Text(
                      //"$j2ficha",
                      " ?",
                      style: numerosTxt,
                    ),
                  ],
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    const FlutterLogo(),
                    Expanded(
                      child: Text(
                        "\nMonto en juego: $montogame.\n\n $enviomsj",
                        style: parrafosTxt,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Icon(Icons.sentiment_very_satisfied),
                  ],
                ) /*,
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
        FloatingActionButton(
          heroTag: "btnPiedra",
          child: const Icon(Icons.storm),
          onPressed: () => widget
              .piedraFn(), /*() {
            j1ficha = 1;
            setState(() {});
          }
          ,*/
        ),
        //const SizedBox(width: 20),
        FloatingActionButton(
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
        ),
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
