import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cargando partidas...'),
          /*title: StreamBuilder(
            stream: peticionesBloc.partidasContador,
            builder: (context, snapshot) {
              return Text('Partidas encontradas: ${snapshot.data ?? 0}');
            },
          ),*/
          elevation: 8.0,
        ),
        backgroundColor: const Color.fromRGBO(251, 160, 254, 1),
        body: const Text('')
        //termina botonera
        );
  }
}
