import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_game/models/models.dart';
import 'package:http/http.dart' as http;

class OpcionesPPTProvider extends ChangeNotifier {
  final String _baseUrl = 'pptgame-d06ee-default-rtdb.firebaseio.com';
  final List<Opcion> tarjetas = [];
  //late Opcion selectedTarjetas;
  OpcionesPPTProvider() {
    //print("getondisplayTarjetas inicializado");
    getOndisplayTarjetas();
  }
  getOndisplayTarjetas() async {
    //para tarjetas ppt
    final url = Uri.https(_baseUrl, 'fichas_ppt.json');
    final resp = await http.get(url);
    final Map<String, dynamic> partidasMap = json.decode(resp.body);

    partidasMap.forEach((key, value) {
      final tempTarjetas = Opcion.fromMap(value);
      //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs

      tempTarjetas.id = key;
      tarjetas.add(tempTarjetas);
      //print(tarjetas[0].toMap());

      notifyListeners();
    });
  }
}
