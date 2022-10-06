// To parse this JSON data, do
//
//     final partidasppt = partidaspptFromMap(jsonString);

import 'dart:convert';

/*class Partidasppt {
  Partidasppt({
    required this.ppt1,
    required this.ppt2,
  });

  Ppt ppt1;
  Ppt ppt2;

  factory Partidasppt.fromJson(String str) =>
      Partidasppt.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Partidasppt.fromMap(Map<String, dynamic> json) => Partidasppt(
        ppt1: Ppt.fromMap(json["ppt1"]),
        ppt2: Ppt.fromMap(json["ppt2"]),
      );

  Map<String, dynamic> toMap() => {
        "ppt1": ppt1.toMap(),
        "ppt2": ppt2.toMap(),
      };
}*/

class Ppt {
  Ppt({
    this.fechafin,
    required this.fechainicio,
    required this.id,
    required this.modojuego,
    required this.montototal,
    required this.oponentes,
    required this.status,
    required this.usridCreador,
    required this.usridnowin,
    required this.usridwin,
  });

  String? fechafin;
  String fechainicio;
  int id;
  String modojuego;
  int montototal;
  int oponentes;
  int status;
  int usridCreador;
  int usridnowin;
  int usridwin;
  String? idPrueba;

  factory Ppt.fromJson(String str) => Ppt.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ppt.fromMap(Map<String, dynamic> json) => Ppt(
        fechafin: json["fechafin"],
        fechainicio: json["fechainicio"],
        id: json["id"],
        modojuego: json["modojuego"],
        montototal: json["montototal"],
        oponentes: json["oponentes"],
        status: json["status"],
        usridCreador: json["usrid_creador"],
        usridnowin: json["usridnowin"],
        usridwin: json["usridwin"],
      );

  Map<String, dynamic> toMap() => {
        "fechafin": fechafin,
        "fechainicio": fechainicio,
        "id": id,
        "modojuego": modojuego,
        "montototal": montototal,
        "oponentes": oponentes,
        "status": status,
        "usrid_creador": usridCreador,
        "usridnowin": usridnowin,
        "usridwin": usridwin,
      };
}