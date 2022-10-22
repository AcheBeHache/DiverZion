// To parse this JSON data, do
//
//     final opcionesPpt = opcionesPptFromMap(jsonString);

import 'dart:convert';

/*class OpcionesPpt {
    OpcionesPpt({
        this.opcion1,
        this.opcion2,
        this.opcion3,
    });

    Opcion opcion1;
    Opcion opcion2;
    Opcion opcion3;

    factory OpcionesPpt.fromJson(String str) => OpcionesPpt.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OpcionesPpt.fromMap(Map<String, dynamic> json) => OpcionesPpt(
        opcion1: Opcion.fromMap(json["opcion1"]),
        opcion2: Opcion.fromMap(json["opcion2"]),
        opcion3: Opcion.fromMap(json["opcion3"]),
    );

    Map<String, dynamic> toMap() => {
        "opcion1": opcion1.toMap(),
        "opcion2": opcion2.toMap(),
        "opcion3": opcion3.toMap(),
    };
}*/

class Opcion {
  Opcion({
    this.id,
    required this.img,
    this.nombre,
  });

  String? id;
  String img;
  String? nombre;

  String? heroId;
  get fullPosterImg {
    if (img != null || img != '') {
      return img;
    }

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  get tarjetaId {
    if (id != null || id != '') {
      return id;
    }

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory Opcion.fromJson(String str) => Opcion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Opcion.fromMap(Map<String, dynamic> json) => Opcion(
        id: json["id"],
        img: json["img"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "img": img,
        "nombre": nombre,
      };
}
