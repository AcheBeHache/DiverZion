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
  Ppt(
      {this.fechafin,
      required this.fechainicio,
      this.id,
      required this.modojuego,
      required this.montototal,
      this.oponentes,
      required this.status,
      required this.usridCreador,
      this.usridoponente,
      this.usridwin,
      this.img,
      this.idPrueba,
      this.usrversionapp,
      this.respcreador,
      this.respoponente,
      this.notificar

      /*Para usr poder 
      this.usrrol,
      this.usrbolsagral,
      this.usrbolsahoy,
      this.usrversionapp
      */

      /*Para granja
      
      this.modogranja,
      this.elemento1,
      this.elemento2,
      this.elemento3,
      this.elemento4,
      this.elemento5,
      this.elemento6,
      this.elemento7,
      this.elemento8,
      this.servicio1,
      this.servicio2,
      this.servicio3,
      this.servicio4,
      this.servicio5,
      this.servicio6,
      this.servicio7,
      this.servicio8,*/

      });

  String? fechafin;
  String fechainicio;
  String? img;
  String? id;
  bool modojuego;
  int montototal;
  int? oponentes;
  int status;
  String usridCreador;
  String? usridoponente;
  String? usridwin;
  String? idPrueba;
  String? usrversionapp;
  String? respcreador;
  String? respoponente;
  bool? notificar;

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
      usridoponente: json["usridoponente"],
      usridwin: json["usridwin"],
      img: json["img"],
      usrversionapp: json["usrversionapp"],
      respcreador: json["respcreador"],
      respoponente: json["respoponente"],
      notificar: json["notificar"]);

  Map<String, dynamic> toMap() => {
        "fechafin": fechafin,
        "fechainicio": fechainicio,
        "id": id,
        "modojuego": modojuego,
        "montototal": montototal,
        "oponentes": oponentes,
        "status": status,
        "usrid_creador": usridCreador,
        "usridoponente": usridoponente,
        "usridwin": usridwin,
        "img": img,
        "usrversionapp": usrversionapp,
        "respcreador": respcreador,
        "respoponente": respoponente,
        "notificar": notificar
      };

  Ppt copy() => Ppt(
      fechainicio: fechainicio,
      id: id,
      idPrueba: idPrueba,
      modojuego: modojuego,
      montototal: montototal,
      oponentes: oponentes,
      status: status,
      usridCreador: usridCreador,
      usridoponente: usridoponente,
      usridwin: usridwin,
      img: img,
      fechafin: fechafin,
      usrversionapp: usrversionapp,
      respcreador: respcreador,
      respoponente: respoponente,
      notificar: notificar);
}
