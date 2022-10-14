import 'package:flutter/material.dart';
import 'package:app_game/models/models.dart';

class PartidaFormProvider extends ChangeNotifier {
  String mensajito = '';
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Ppt partida;

  PartidaFormProvider(this.partida);

  updateModojuego(dynamic value) {
    //print(value);
    partida.modojuego = value;
    /*if (partida.modojuego == true) {
      mensajito = 'automático';
    } else {
      mensajito = 'manual';
    }*/
    notifyListeners();
  }

  /*updateId(dynamic value) {
    print(value);
    partida.id = value;
    notifyListeners();
  }*/

  bool isValidForm() {
    /*print(partida.id);
    print(partida.montototal);
    print(partida.modojuego);*/

    return formKey.currentState?.validate() ?? false;
  }
}
