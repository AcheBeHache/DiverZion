// ignore_for_file: unnecessary_this

import 'dart:async';

//import 'package:app_game/screens/partidas_ppt.dart';

const partidasGrales = [
  'partida1_id',
  'partida2_id',
  'partida3_id',
  'partida4_id',
  'partida5_id',
  'partida6_id'
];

class PeticionesPPTBloc {
  Stream<List<String>> get getPartidas async* {
    final List<String> partidas = [];
    for (String partida in partidasGrales) {
      await Future.delayed(const Duration(seconds: 1));
      partidas.add(partida);
      yield partidas;
    }
  }

  StreamController<int> _partidasContador = StreamController<int>();
  Stream<int> get partidasContador => _partidasContador.stream;

  PeticionesPPTBloc() {
    this.getPartidas.listen(
        (partidasList) => this._partidasContador.add(partidasList.length));
  }

  dispose() {
    _partidasContador.close();
  }
}
