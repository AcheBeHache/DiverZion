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
    //TODO: Descomentar las siguientes 3 líneas para activar el consultar por url las imgs,
    //también será necesario cambiar AssetImage por NetworkImage desde el archivo card_swiper línea 249 aprox

    /*final url = Uri.https(_baseUrl, 'fichas_ppt.json');
    final resp = await http.get(url);
    final Map<String, dynamic> partidasMap = json.decode(resp.body);*/
    //También tendremos que comentar el llamado a las imgs locales, que es el mapa siguiente, lo comentamos para descomentar las lineasa anteriores, y que las imgs de las opciones del ppt se consulten de internet
    final Map<String, dynamic> partidasMap = {
      "opcion1": {
        "id": "1",
        "img": "assets/images/piedra.png",
        "nombre": "piedra"
      },
      "opcion2": {
        "id": "2",
        "img": "assets/images/papelm.png",
        "nombre": "papel"
      },
      "opcion3": {
        "id": "3",
        "img": "assets/images/tijeram.png",
        "nombre": "tijera"
      }
    };

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
