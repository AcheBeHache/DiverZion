import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_game/models/models.dart';
import 'package:http/http.dart' as http;

class PartidasServices extends ChangeNotifier {
  final String _baseUrl = 'pptgame-d06ee-default-rtdb.firebaseio.com';
  final List<Ppt> partidas = [];
  late Ppt selectedPartidas;
  bool isLoading = true;
  bool isSaving = false;
  File? newPictureFile;
  //para tarjetas ppt
  final List<Opcion> tarjetas = [];
  late Opcion selectedTarjetas;

  PartidasServices() {
    loadPartidas();
    //loadTarjetas();
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
      //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
      tempPartidas.id = key;
      partidas.add(tempPartidas);
    });

    isLoading = false;
    notifyListeners();
    /*print(partidasMap);
    print(partidasMap.length);*/
    /*print(partidas[1].toMap());
    print('------');
    print(partidas[1].id);
    return partidas;*/

/*    print(partidasMap);
    print("---");
    print('${partidas[0].id} ${partidas[0].fechainicio}');
    print("---");
    print('${partidas[1].id} ${partidas[1].fechainicio}');*/
  }

  //para cargar tarjetas
  /*Future loadTarjetas() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'fichas_ppt.json');
    final resp = await http.get(url);

    final Map<String, dynamic> partidasMap = json.decode(resp.body);

    partidasMap.forEach((key, value) {
      final tempTarjetas = Opcion.fromMap(value);
      //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs

      tempTarjetas.id = key;
      tarjetas.add(tempTarjetas);
      print(tarjetas[0].toMap());
    });

    isLoading = false;
    notifyListeners();
    return tarjetas;
    /*print(partidasMap);
    print(partidasMap.length);*/
    /*print(partidas[1].toMap());
    print('------');
    print(partidas[1].id);
    return partidas;*/

/*    print(partidasMap);
    print("---");
    print('${partidas[0].id} ${partidas[0].fechainicio}');
    print("---");
    print('${partidas[1].id} ${partidas[1].fechainicio}');*/
  }*/

  //Future saveOrCreatePartida(Ppt partida, Opcion tarj) async {
  Future saveOrCreatePartida(Ppt partida, Opcion tarjetas) async {
    //2de3-Para poner contexto para navegar entre rutas al editar las cards
    //Future saveOrCreatePartida(context, Ppt partida) async {
    isSaving = true;
    notifyListeners();
    //checar los id y idPrueba, la actualización ya está, falta la creación. Ojo: estoy pidiendo el id desde el formulario, que en teoría no debe ser null o si?
    if (partida.id == null || partida.id == '') {
      // Es necesario crear
      print("entro al creador");
      await createPartida(partida);
      await updatePartida(partida);
      //3de3-Para poner contexto para navegar entre rutas al editar las cards
      //Navigator.pushNamed(context, 'partidas_ppt');
    } else {
      // Actualizar
      //await updatePartida(partida);
      await updateTarjeta(partida, tarjetas);

      //Navigator.pushNamed(context, 'partidas_ppt');
      //Sprint('actualizará_Partida');
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> createPartida(Ppt partida) async {
    final url = Uri.https(_baseUrl, 'partidas_ppt.json');
    final resp = await http.post(url, body: partida.toJson());
    final decodedData = json.decode(resp.body);

    partida.id = decodedData['name'];
    partidas.add(partida);

    return partida.id!;
  }

  //actualizar tarjeta
  //Future<String> updateTarjeta(Ppt partida, Opcion tarj) async {

  //actualizar partida
  Future<String> updatePartida(Ppt partida) async {
    final url = Uri.https(_baseUrl, 'partidas_ppt/${partida.id}.json');
    final resp = await http.put(url, body: partida.toJson());
    final decodedData = json.decode(resp.body);

    //TODO: Actualizar el listado de productos
    final index = partidas.indexWhere((element) => element.id == partida.id);
    partidas[index] = partida;

    return partida.id!;
  }

  Future<String> updateTarjeta(Ppt partida, Opcion tarjetas) async {
    final url = Uri.https(_baseUrl, 'partidas_ppt/${partida.id}.json');
    final resp = await http.put(url, body: partida.toJson());
    final decodedData = json.decode(resp.body);
    final eleccioncreador = tarjetas.nombre;
    //selectedTarjetas = tarj;

    //print('Tarj: $tarj');
    //TODO: Actualizar el listado de productos
    final index = partidas.indexWhere((element) => (element.id == partida.id));

    partidas[index] = partida;
    partidas[index].respcreador = eleccioncreador;
    partidas[index].respoponente = 'eleccionoponente';
    //notifyListeners();
    return tarjetas.id!;
  }

  void updateSelectedPartidaImage(String path) {
    selectedPartidas.img = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dqtjgerwt/image/upload?upload_preset=wjh87pn9');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
