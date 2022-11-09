//import 'package:app_game/services/services.dart';
//import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:app_game/models/models.dart';
import 'package:app_game/services/services.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_game/bloc/peticionesppt_bloc.dart';
import 'package:provider/provider.dart';

class PartidasServices extends ChangeNotifier {
  final String _baseUrl = 'pptgame-d06ee-default-rtdb.firebaseio.com';
  final List<Ppt> partidas = [];
  late Ppt selectedPartidas;
  File? newPictureFile;
  String enviousrcreador = '';
  //para tarjetas ppt
  final List<Opcion> tarjetas = [];
  late Opcion selectedTarjetas;
  //para usuarios
  final List<UsrGame> usuarios = [];
  late UsrGame selectedUsuarios;
  bool isLoading = true;
  bool isSaving = false;
  String idBolsaS = '';

  PartidasServices() {
    loadPartidas();
    //loadTarjetas();
  }
  void refrescaTarjetas() {
    //dispose();
    partidas.clear();
    loadPartidas();
    notifyListeners();
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
    //return partidas;
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
  Future saveOrCreatePartida(partida) async {
    //2de3-Para poner contexto para navegar entre rutas al editar las cards
    //Future saveOrCreatePartida(context, Ppt partida) async {
    isSaving = true;
    notifyListeners();
    //checar los id y idPrueba, la actualización ya está, falta la creación. Ojo: estoy pidiendo el id desde el formulario, que en teoría no debe ser null o si?
    if (partida.id == null || partida.id == '') {
      // Es necesario crear
      //print("entro al creador");
      await createPartida(partida);
      await updatePartida(partida);
      //3de3-Para poner contexto para navegar entre rutas al editar las cards
      //Navigator.pushNamed(context, 'partidas_ppt');
    } else {
      // Actualizar
      //await updatePartida(partida);
      //print('3Recibe el await de saveorcreatepartida: $enviousrcreador');
      //await updateTarjeta(partida, tarjetas, enviousrcreador);

      //Navigator.pushNamed(context, 'partidas_ppt');
      //Sprint('actualizará_Partida');
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> createPartida(Ppt partida) async {
    isSaving = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'partidas_ppt.json');
    final resp = await http.post(url, body: partida.toJson());
    final decodedData = json.decode(resp.body);

    partida.id = decodedData['name'];
    partidas.add(partida);
    isSaving = false;
    notifyListeners();
    return partida.id!;
  }

  //borrar
  Future obtenerPartida(Ppt partida) async {
    /*isSaving = true;
    notifyListeners();*/
    final url = Uri.https(_baseUrl, 'partidas_ppt.json');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    partida.id = decodedData['name'];
    partidas.add(partida);
    print(partidas);
    /*isSaving = false;
    notifyListeners();*/
    return partidas;
  }

  //actualizar tarjeta
  //Future<String> updateTarjeta(Ppt partida, Opcion tarj) async {

  //actualizar partida
  Future<String> updatePartida(Ppt partida) async {
    isSaving = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'partidas_ppt/${partida.id}.json');
    final resp = await http.put(url, body: partida.toJson());
    final decodedData = json.decode(resp.body);
    //TODO: Actualizar el listado de productos
    final index = partidas.indexWhere((element) => element.id == partida.id);
    partidas[index] = partida;
    isSaving = false;
    notifyListeners();
    return partida.id!;
  }

  /*Future<String> updateBolsa(partida, tarjetas, enviousrcreador) async {

  }*/

  Future<String> updateTarjeta(
      partida, tarjetas, enviousrcreador, idBolsaS) async {
    //creamos una instancia para utilizar el localstorage, mostrar usr 1de4
    //BuildContext context;
    //final authService = Provider.of<AuthService>(context, listen: false);
    isSaving = true;
    notifyListeners();
    //print('4recibe updateTarjeta updateTarjeta: $enviousrcreador');
    final url = Uri.https(_baseUrl, 'partidas_ppt/${partida.id}.json');
    final resp = await http.put(url, body: partida.toJson());
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    final index = partidas.indexWhere((element) => (element.id == partida.id));
    final eleccioncreador = tarjetas.nombre;
    String fechaFin = formatDate(
        DateTime.now(), [d, '/', mm, '/', yyyy, ' ', H, ':', m, ':', am]);
    //selectedTarjetas = tarj;

    //print('Tarj: $tarj');
    //TODO: Actualizar el listado de productos
    if (partida.usridcreador == enviousrcreador) {
      //partidas[index] = partida;
      //print(partidas[index].respcreador);
      partidas[index].respcreador = eleccioncreador;
      //print(partidas[index].respcreador);
      //partidas[index].fechafin = fechaFin;
      //partidas[index].respoponente = 'eleccionoponente';
    } else {
      //Inicia modificación en bolsa 1
      //idBolsaS = (await storage.read(key: 'idBolsa'))!;
      /*
      Descomentar, me di cuenta que tengo que recibir también el objeto del modelo UsrGame para obtener los valores del mismo
      Tanto el objeto del modelo como por otra parte la referencia del localStorage
      final url = Uri.https(_baseUrl, 'usuarios/games/$idBolsaS.json');
      final perfil = await http.get(url);
      final Map<String, dynamic> usuariosMap = json.decode(perfil.body);
      usuariosMap.forEach((key, value) {
        final tempUsuarios = UsrGame.fromMap(value);
        //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
        tempUsuarios.id = key;
        usuarios.add(tempUsuarios);
      });
      /*final resp = await http.put(url, body: idBolsaS.toJson());
      final decodedData = json.decode(resp.body);*/
      //TODO: Actualizar el listado de productos
      print('Usuarios: $usuarios');*/
      /*1final index =
          usuarios.indexWhere((element) => element.id == decodedData['name']);*/
      //únicamente permitimos cambiar dichos campos en la BD
      //2usuarios[index].cinvbolsa = 1111;
      //usuarios[index].apodo = perfil.apodo;

      /*BuildContext context;
        int? infoUsr = 0;
        int? diverzcoin = 0;
        final usuariosService = Provider.of<UsuariosService>(context);
        final daUsr = usuariosService.usuarios;
        infoUsr = await usuariosService.obtenerUsuario(enviousrcreador);
        diverzcoin = daUsr[infoUsr!].bolsa;
    */
      //Finaliza edición bolsa 2
      /*final index =
          partidas.indexWhere((element) => (element.id == partida.id));*/

      //partidas[index] = partida;
      //partidas[index].respcreador = 'eleccioncreador';
      //print(partidas[index].respoponente);
      print('idBolsa del usuarioActual: $idBolsaS');
      //tendría que realizar un if para saber si la idBolsaS es del usrcreador o del oponente para realizar la operación correspondiente en su bolsa.

      partidas[index].respoponente = eleccioncreador;
      //print(partidas[index].respoponente);
      //programé para que el oponente cierre con fecha la partida, es el que la establece
      partidas[index].fechafin = fechaFin;
      partidas[index].status = 3;

      //TODO: Faltanreglas del gane PPT, para guardar el usridGanador en usridwin
      if (partida.respcreador == 'piedra' && eleccioncreador == 'piedra') {
        partidas[index].usridwin = 'empate';
        //programar la revancha.
      }
      if (partida.respcreador == 'piedra' && eleccioncreador == 'papel') {
        partidas[index].usridwin = partida.usridoponente;
        //gana oponente
      }
      if (partida.respcreador == 'piedra' && eleccioncreador == 'tijera') {
        partidas[index].usridwin = partida.usridcreador;
        //gana creador
      }
      if (partida.respcreador == 'papel' && eleccioncreador == 'piedra') {
        partidas[index].usridwin = partida.usridcreador;
        //gana creador
      }
      if (partida.respcreador == 'papel' && eleccioncreador == 'papel') {
        partidas[index].usridwin = 'empate';
        //programar la revancha.
      }
      if (partida.respcreador == 'papel' && eleccioncreador == 'tijera') {
        partidas[index].usridwin = partida.usridoponente;
        //gana oponente
      }
      if (partida.respcreador == 'tijera' && eleccioncreador == 'piedra') {
        partidas[index].usridwin = partida.usridoponente;
        //gana oponente
      }
      if (partida.respcreador == 'tijera' && eleccioncreador == 'papel') {
        partidas[index].usridwin = partida.usridcreador;
        //gana creador
      }
      if (partida.respcreador == 'tijera' && eleccioncreador == 'tijera') {
        partidas[index].usridwin = 'empate';
        //programar la revancha.
      }
      //Para ESCRIBIR DATOS EN BOLSA ES AQUÍIII
      //Calculamos el/los valores en bolsa, en este caso se define desde la respuesta del usr que cierra la partida (oponente)
      //primero establecemos el ganador, que en este caso ya nos lo da el campo usrwin
      //imprimimos prueba del campo y bolsa del usrcreador y le asignamos valor
      //variabledelobjMontoBolsaCreador = variabledelobjMontoBolsaCreador +/- partidas[index].montototal;

      //obtenemos info del usrperdedor
      //descontamos lo correspondiente

      //OJO CON LA PARTIDA DE EMPATE. En este caso, sólo hay registro
      //Ver la forma de lanzar el desempate
    }
    //notifyListeners();
    isSaving = false;
    notifyListeners();
    return tarjetas.id!;
  }

  //inicio apartar partida
  Future<String> apartaPartida(partida, tarjetas, enviousrcreador) async {
    //creamos una instancia para utilizar el localstorage, mostrar usr 1de4
    //BuildContext context;
    //final authService = Provider.of<AuthService>(context, listen: false);
    isSaving = true;
    notifyListeners();
    //print('4recibe updateTarjeta updateTarjeta: $enviousrcreador');
    final url = Uri.https(_baseUrl, 'partidas_ppt/${partida.id}.json');
    final resp = await http.put(url, body: partida.toJson());
    final decodedData = json.decode(resp.body);
    final index = partidas.indexWhere((element) => (element.id == partida.id));
    //final eleccioncreador = tarjetas.nombre;
    /*String fechaFin = formatDate(
        DateTime.now(), [d, '/', mm, '/', yyyy, ' ', H, ':', m, ':', am]);*/
    //selectedTarjetas = tarj;

    //print('Tarj: $tarj');
    //TODO: Actualizar el listado de productos
    if (partida.usridoponente == '') {
      //partidas[index] = partida;
      //print(partidas[index].respcreador);
      /*partidas[index].respcreador = eleccioncreador;*/
      //print(partidas[index].respcreador);
      //partidas[index].fechafin = fechaFin;
      //partidas[index].respoponente = 'eleccionoponente';
      partidas[index].usridoponente = enviousrcreador;
      partidas[index].status = 2;
    } else {
      /*final index =
          partidas.indexWhere((element) => (element.id == partida.id));*/

      //partidas[index] = partida;
      //partidas[index].respcreador = 'eleccioncreador';
      //print(partidas[index].respoponente);
      /*partidas[index].respoponente = eleccioncreador;*/
      //print(partidas[index].respoponente);
      //programé para que el oponente cierre con fecha la partida, es el que la establece

      //TODO: enviar msj de que ya se la ganaron a la GUI

    }
    //notifyListeners();
    isSaving = false;
    notifyListeners();
    return tarjetas.id!;
  }
  //Fin apartar partida

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
    isSaving = false;
    notifyListeners();
    return decodedData['secure_url'];
  }

  //actualizar partida
  Future<String> updateUsuario(UsrGame usuario) async {
    isSaving = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'usuarios/games/${usuario.usrId}.json');
    final resp = await http.put(url, body: usuario.toJson());
    final decodedData = json.decode(resp.body);
    //TODO: Actualizar el listado de productos
    final index =
        usuarios.indexWhere((element) => element.usrId == usuario.usrId);
    usuarios[index] = usuario;
    isSaving = false;
    notifyListeners();
    return usuario.usrId!;
  }
}
