import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Selecciona o crea una partida.'),
        title: const Text('Partidas encontradas: '),
        elevation: 8.0,
      ),
      body: const Center(
          child: CircularProgressIndicator(
        color: Colors.indigo,
      )),
      backgroundColor: Colors.amber.shade100,
    );
  }
}
