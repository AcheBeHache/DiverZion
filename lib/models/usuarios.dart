// To parse this JSON data, do
//
//     final usuarios = usuariosFromMap(jsonString);

import 'dart:convert';

class AdminusrGame1 {
  AdminusrGame1({
    this.avatar,
    this.apodo,
    this.bolsa,
    this.cinvbolsa,
    this.codigoinv,
    this.comisionbolsa,
    required this.email,
    this.masbolsa,
    this.menosbolsa,
    this.bolsaRetenida,
    this.ultActualizacion,
    required this.modo,
    required this.padrecodigo,
    required this.status,
    required this.usrId,
  });

  String? avatar;
  String? apodo;
  double? bolsa;
  int? cinvbolsa;
  String? codigoinv;
  double? comisionbolsa;
  String email;
  double? masbolsa;
  int? menosbolsa;
  int? bolsaRetenida;
  String? ultActualizacion;
  String modo;
  String padrecodigo;
  bool status;
  String usrId;

  factory AdminusrGame1.fromJson(String str) =>
      AdminusrGame1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminusrGame1.fromMap(Map<String, dynamic> json) => AdminusrGame1(
        avatar: json["avatar"],
        apodo: json["apodo"],
        bolsa: json["bolsa"],
        cinvbolsa: json["cinvbolsa"],
        codigoinv: json["codigoinv"],
        comisionbolsa: json["comisionbolsa"],
        email: json["email"],
        masbolsa: json["masbolsa"],
        menosbolsa: json["menosbolsa"],
        bolsaRetenida: json["bolsaRetenida"],
        ultActualizacion: json["ultActualizacion"],
        modo: json["modo"],
        padrecodigo: json["padrecodigo"],
        status: json["status"],
        usrId: json["usrId"],
      );

  Map<String, dynamic> toMap() => {
        "avatar": avatar,
        "apodo": apodo,
        "bolsa": bolsa,
        "cinvbolsa": cinvbolsa,
        "codigoinv": codigoinv,
        "comisionbolsa": comisionbolsa,
        "email": email,
        "masbolsa": masbolsa,
        "menosbolsa": menosbolsa,
        "bolsaRetenida": bolsaRetenida,
        "ultActualizacion": ultActualizacion,
        "modo": modo,
        "padrecodigo": padrecodigo,
        "status": status,
        "usrId": usrId,
      };
}

//aqui
class UsrGame {
  UsrGame({
    this.avatar,
    this.apodo,
    this.bolsa,
    this.cinvbolsa,
    this.codigoinv,
    this.comisionbolsa,
    required this.email,
    this.masbolsa,
    this.menosbolsa,
    this.bolsaRetenida,
    this.ultActualizacion,
    required this.modo,
    required this.padrecodigo,
    required this.status,
    this.usrId,
    this.id,
  });

  String? avatar;
  String? apodo;
  double? bolsa;
  int? cinvbolsa;
  String? codigoinv;
  double? comisionbolsa;
  String email;
  double? masbolsa;
  int? menosbolsa;
  int? bolsaRetenida;
  String? ultActualizacion;
  String modo;
  String padrecodigo;
  bool status;
  String? usrId;
  String? id;

  factory UsrGame.fromJson(String str) => UsrGame.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsrGame.fromMap(Map<String, dynamic> json) => UsrGame(
        avatar: json["avatar"],
        apodo: json["apodo"],
        bolsa: json["bolsa"],
        cinvbolsa: json["cinvbolsa"],
        codigoinv: json["codigoinv"],
        comisionbolsa: json["comisionbolsa"],
        email: json["email"],
        masbolsa: json["masbolsa"],
        menosbolsa: json["menosbolsa"],
        bolsaRetenida: json["bolsaRetenida"],
        ultActualizacion: json["ultActualizacion"],
        modo: json["modo"],
        padrecodigo: json["padrecodigo"],
        status: json["status"],
        usrId: json["usrId"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "avatar": avatar,
        "apodo": apodo,
        "bolsa": bolsa,
        "cinvbolsa": cinvbolsa,
        "codigoinv": codigoinv,
        "comisionbolsa": comisionbolsa,
        "email": email,
        "masbolsa": masbolsa,
        "menosbolsa": menosbolsa,
        "bolsaRetenida": bolsaRetenida,
        "ultActualizacion": ultActualizacion,
        "modo": modo,
        "padrecodigo": padrecodigo,
        "status": status,
        "usrId": usrId,
        "id": id,
      };
}
