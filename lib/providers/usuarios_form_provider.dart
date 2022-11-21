//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_game/models/models.dart';
//import 'package:http/http.dart' as http;

class UsuariosFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  /*UsrGame usuario;

  UsuariosProvider(this.usuario);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }*/
  UsrGame perfilusr;

  /*final String _baseUrl = 'pptgame-d06ee-default-rtdb.firebaseio.com';
  final List<UsrGame> usuarios = [];*/
  //UsrGame selectedUsuarios;
  UsuariosFormProvider(this.perfilusr);
  /*getOndisplayUsuarios() async {
    final url = Uri.https(_baseUrl, 'usuarios/games.json');
    final resp = await http.get(url);
    final Map<String, dynamic> usuariosMap = json.decode(resp.body);

    usuariosMap.forEach((key, value) {
      final tempUsuarios = UsrGame.fromMap(value);
      //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs

      tempUsuarios.usrId = key;
      usuarios.add(tempUsuarios);

      notifyListeners();
    });
  }*/
  updateStatus(dynamic value) {
    //print(value);
    perfilusr.status = value;
    /*if (partida.modojuego == true) {
      mensajito = 'automático';
      print(mensajito);
    } else {
      mensajito = 'manual';
      print(mensajito);
    }*/
    notifyListeners();
  }

  bool isValidForm() {
    /*print(partida.id);
    print(partida.montototal);
    print(partida.modojuego);*/

    return formKey.currentState?.validate() ?? false;
  }
}
