// ignore_for_file: unnecessary_this

import 'dart:async';

//import 'package:app_game/models/models.dart';

//import 'package:app_game/screens/partidas_ppt.dart';
//late final Ppt xpartida;

const partidasGrales = [
  'partida1_id',
  'partida2_id',
  'partida3_id',
  'partida4_id',
  'partida5_id'
];

class PeticionesPPTBloc {
  StreamController<int> _partidasContador = StreamController<int>();
  Stream<int> get partidasContador => _partidasContador.stream;
  //List<String> partidasList = [];

  //constructor
  PeticionesPPTBloc() {
    //setState(() {});
    this.getPartidas.listen(
        (partidasList) => this._partidasContador.add(partidasList.length));
  }

  Stream<List<String>> get getPartidas async* {
    final List<String> partidas = [];
    for (String partida in partidasGrales) {
      await Future.delayed(const Duration(seconds: 1));
      partidas.add(partida);
      yield partidas;
    }
    //print(partidas);
    partidas.add('Fin de la búsqueda.');
    //print(xpartida);
    //print(partidas);
  }

  dispose() {
    _partidasContador.close();
  }
}
