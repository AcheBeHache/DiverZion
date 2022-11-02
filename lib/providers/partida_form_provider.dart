import 'package:flutter/material.dart';
import 'package:app_game/models/models.dart';

class PartidaFormProvider extends ChangeNotifier {
  String mensajito = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Ppt partida;
  //UsrGame usuario;
  //Opcion tarj;

  // PartidaFormProvider(this.partida, this.tarj);
  PartidaFormProvider(this.partida);
  updateModojuego(dynamic value) {
    //print(value);
    partida.modojuego = value;
    /*if (partida.modojuego == true) {
      mensajito = 'automático';
      print(mensajito);
    } else {
      mensajito = 'manual';
      print(mensajito);
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
