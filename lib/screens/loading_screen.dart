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
        //title: const Text('Selecciona o crea una partida.'),
        title: const Text('pnPartidas encontradas: '),
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
