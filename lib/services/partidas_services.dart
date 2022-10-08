import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:app_game/models/models.dart';
import 'package:http/http.dart' as http;

class PartidasServices extends ChangeNotifier {
  final String _baseUrl = 'pptgame-d06ee-default-rtdb.firebaseio.com';
  final List<Ppt> partidas = [];
  late Ppt selectedPartidas;
  bool isLoading = true;

  PartidasServices() {
    loadPartidas();
  }

  //TODO: <List<Partidasppt>>
  Future loadPartidas() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'partidas_ppt.json');
    final resp = await http.get(url);

    final Map<String, dynamic> partidasMap = json.decode(resp.body);

    partidasMap.forEach((key, value) {
      final tempPartidas = Ppt.fromMap(value);
      tempPartidas.idPrueba = key;
      partidas.add(tempPartidas);
    });

    isLoading = false;
    notifyListeners();
    /*print(partidasMap);
    print(partidasMap.length);*/
    print(partidas[1].toMap());
    print('------');
    print(partidas[1].id);
    return partidas;

/*    print(partidasMap);
    print("---");
    print('${partidas[0].id} ${partidas[0].fechainicio}');
    print("---");
    print('${partidas[1].id} ${partidas[1].fechainicio}');*/
  }
}
