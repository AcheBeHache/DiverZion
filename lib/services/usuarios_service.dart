//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/services/services.dart';
//import 'package:date_format/date_format.dart';
import 'dart:convert';
import 'dart:io';
import 'package:app_game/models/models.dart';
import 'package:app_game/screens/home_screen.dart';
//PN1-import 'package:app_game/screens/partida_pptscreen.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int peticiones = 0;
int cuente = 0;

class UsuariosService extends ChangeNotifier {
  final String _baseUrl = 'pptgame-d06ee-default-rtdb.firebaseio.com';
  List<UsrGame> usuarios = [];
  List<UsrGame> xusuarios = [];
  //1 de 3: Para guadar id de la bolsa del usuario actual en el storage
  final storage = const FlutterSecureStorage();

  //Aquí se inicializa la valriable de selectedUsuarios, falta llamar la info en timeReal
  late UsrGame selectedUsuarios = UsrGame(
      id: 'xxx',
      usrId: 'xxxrrvalue', //validar
      apodo: 'APODO',
      avatar:
          'https://img2.freepng.es/20180623/iqh/kisspng-computer-icons-avatar-social-media-blog-font-aweso-avatar-icon-5b2e99c40ce333.6524068515297806760528.jpg', //validar
      bolsa: 0,
      cinvbolsa: 0,
      codigoinv: 'xxxDEFAULT',
      comisionbolsa: 0,
      email: 'xxxrrvalue',
      masbolsa: 0,
      menosbolsa: 0,
      bolsaRetenida: 0,
      ultActualizacion: '00/00/0000 00:00:PM',
      modo: 'xxxtrial',
      padrecodigo: 'xxxDEFAULT',
      status: true);
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;
  UsuariosService() {
    if (usuarios.isNotEmpty) {
      //usuarios.clear();
      print(
          "CREOBORRAR1: aplica el loadUsuarios en el if true. $contador, usuarios_service.dart.");
      loadUsuarios();
      //xloadUsuario();
    } else {
      //usuarios.clear();
      print(
          "CREOBORRAR2: aplica el loadUsuarios en el if false. $contador, usuarios_service.dart.");
      loadUsuarios();
      //xloadUsuario();
    }
  }
  Future<List<UsrGame>> loadUsuarios() async {
    try {
      cuente++;
      isLoading = true;
      notifyListeners();
      //usuarios = [];
      peticiones = peticiones++;
      print('se cargan usuarios desde usuarios_Services, 1 consulta get');
      final url = Uri.https(_baseUrl, 'usuarios/games.json');
      final resp = await http.get(url);

      final Map<String, dynamic> usuariosMap = json.decode(resp.body);
      //usuarios.clear();
      usuariosMap.forEach((key, value) {
        final tempUsuarios = UsrGame.fromMap(value);
        //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
        tempUsuarios.id = key;
        usuarios.add(tempUsuarios);
      });
      //print(usuarios[1].email);
      print('vuelta #:$cuente');
      isLoading = false;
      notifyListeners();
      return usuarios;
    } catch (e) {
      print('catch de loadUsuarios: $e');
      return usuarios;
    }
  }

  //actualizar partida
  /*Future<String> updatePartida(Ppt partida) async {
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
  }*/
  Future xloadUsuario(String usrId) async {
    try {
      isLoading = true;
      notifyListeners();
      print('se carga el usr desde usuarios_Services, 1 consulta get');
      final xurl = Uri.https(_baseUrl, 'usuarios/games/$usrId.json');
      final xresp = await http.get(xurl);
      final decodedData = json.decode(xresp.body);
      print(
          'Usuario desde usuarios_service.dart, aplico xloadUsuario: $decodedData');
      print(
          'se muestra 1 sólo usr desde usuarios_service:\nid: ${decodedData['id']},\n email: ${decodedData['email']}, poder: ${decodedData['bolsa']}');
      //escribo el poder en bolsa del usr:
      await storage.write(
          key: 'poderBolsa', value: decodedData['bolsa'].toString());
      await storage.write(key: 'idBolsa', value: decodedData['id'].toString());
      //String? bolsaValue = await storage.read(key: 'idBolsa');
      //String? poderValue = await storage.read(key: 'poderBolsa');
      isLoading = false;
      notifyListeners();
      return decodedData;
    } catch (e) {
      print('try del catch xloadUsuarios: $e');
    }
  }

  Future saveOrCreateUsuario(perfil) async {
    //2de3-Para poner contexto para navegar entre rutas al editar las cards
    //Future saveOrCreatePartida(context, Ppt partida) async {
    isSaving = true;
    notifyListeners();
    //checar los id y idPrueba, la actualización ya está, falta la creación. Ojo: estoy pidiendo el id desde el formulario, que en teoría no debe ser null o si?
    if (perfil.usrId == null || perfil.usrId == '') {
      // Es necesario crear
      //print("entro al creador");
      //await createPartida(partida);
      await updateUsuario(perfil);
      print('se updateUsuario, 1 consulta a Firebase desde usuarios_services');
      //3de3-Para poner contexto para navegar entre rutas al editar las cards
      //Navigator.pushNamed(context, 'partidas_ppt');
    } else {
      //TODO: posiblemente aqui aplique el loadUsuarios
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

  Future<String> updateUsuario(UsrGame perfil) async {
    //Prueba1: Poder modificar el email sin que afecte y no actualice el campo del id
    //Prueba2: Deshabilitar todo, y desde firebase cambiar el email, y que éste no afecte la funcionalidad general
    //Prueba3: Verificar y validar el id default de firebase y cómo me servirá al hacer los match con otros modelos
    //YAP4: Deshabilitar todo y que únicamente pueda cambiar el ávatar.
    //OJO: Indicar desde aquí qué campos le permitiré actualizar, osea que no afecte todo el objeto
    //Ojo2: Osea que sólo se actualice el ávatar y el apodo. INCLUIR CAMPO DE APODO
    isSaving = true;
    //notifyListeners();
    final url = Uri.https(_baseUrl, 'usuarios/games/${perfil.id}.json');
    final resp = await http.put(url, body: perfil.toJson());
    final decodedData = json.decode(resp.body);
    //TODO: Actualizar el listado de productos
    final index = usuarios.indexWhere((element) => element.id == perfil.id);
    print(
        'entra a actualizar usuario desde usuarios_services, ya considerada anteriormente desde que se invoca la funcion.');
    //únicamente permitimos cambiar dichos campos en la BD
    usuarios[index].avatar = perfil.avatar;
    usuarios[index].apodo = perfil.apodo;
    //TODO: checar si me guarda la hora correcta
    usuarios[index].ultActualizacion = formatDate(
        DateTime.now(), [d, '/', mm, '/', yyyy, ' ', H, ':', m, ':', am]);
    print(formatDate(
        DateTime.now(), [d, '/', mm, '/', yyyy, ' ', H, ':', m, ':', am]));

    isSaving = false;
    notifyListeners();
    return perfil.usrId!;
  }

  void updateSelectedPartidaImage(String path) {
    selectedUsuarios.avatar = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();
    print(
        'entra a actualizar img a cloudinary desde usuarios_services, 1 solicitud.');
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
      //print(resp.body);
      return null;
    }

    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    isSaving = false;
    notifyListeners();
    return decodedData['secure_url'];
  }

  //le integré el future, no tenía nada, estaba colo el void int;
  void int;
  obtenerUsuario(String rrvalor) async {
    /*isSaving = true;
    notifyListeners();*/
    try {
      //usuarios.clear();
      /*final url = Uri.https(_baseUrl, 'usuarios/games.json');
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);*/
      /*if (usuarios == []) {
        loadUsuarios();
      }*/

      print('entra a obtenerUsuario desde usuarios_services, 1 solicitud.');

      final index = usuarios.indexWhere((element) => element.email == rrvalor);
      //print('usrs Treal: $usuarios');
      if (index == -1 || index == null) {
        print('crearle tarjeta');
        //await storage.write(key: 'idBolsa', value: decodedData['name']);
        //print(decodedData['name']);
        //createUsuario();
        //TODO: implementar la técnica que realicé en el HomePage para consultar el perfil que completa y crea usr
        //return index;
      } else {
        //print('info usuarios[index]: ${usuarios[index].email}');
        //usuarios[index] = usuarios[index];
        //print('usuarios retornados: ${usuarios[index]}');
        if (usuarios[index].id != rrvalor || usuarios[index].id != '') {
          print(
              'Escribo en localstorage el idBolsa del usr y el poder en bolsa. Al obtener usr');

          //TODO: crearle la validación de que si es el email de firebase igual al del email del Storage se ejecuta la siguente línea sino no.
          //Para no sobreescribir en el dispositivo del usr
          await storage.write(key: 'idBolsa', value: usuarios[index].id);
          String? bolsaValue = await storage.read(key: 'idBolsa');
          await storage.write(
              key: 'poderBolsa', value: usuarios[index].bolsa.toString());
          String? poderValue = await storage.read(key: 'poderBolsa');
          //xloadUsuario(bolsaValue!);
          //escribo el poder en bolsa del usr:
          /*await storage.write(
            key: 'poderBolsa', value: usuarios[index].bolsa.toString());
        String? poderValue = await storage.read(key: 'poderBolsa');*/
          //Todo: Descomentar este print para optimizar la app
          print(
              'LOCALSTORAGE: idBolsa al obtener idBolsa: $bolsaValue, poderBolsa: $poderValue desde usuarios_service.');
        } else {
          print(
              'Falta que realices el cambio de tu ávatar. Desde obtenerUsr, usuarios:service.dart');
        }
        return index;
      }
      /*usuarios[index] = usuarios[index];

    usuario.usrId = decodedData['name'];
    usuarios.add(usuario);*/
      //print('index del rrvalue con correo: $rrvalor  -> $index');

      /*isSaving = false;
    notifyListeners();*/
      //return usuarios;
    } catch (e) {
      print("error en función obtener usuario: $e, usuarios_service.dart");
    }
  }
  //inicia obtención de status en tarjeta

  //finaliza obtención de status en tarjeta

  Future<String> createUsuario(UsrGame usr) async {
    isSaving = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'usuarios/games.json');
    final resp = await http.post(url, body: usr.toJson());
    final decodedData = json.decode(resp.body);
    print(
        '1 consulta a firebase desde usuarios_service al crearUsuario, también escribo el idbolsa y poder al crear usuario');

    usr.id = decodedData['name'];
    usuarios.add(usr);
    //2 de 3: guardado de la variable en storage
    //print(usr.id);
    await storage.write(key: 'idBolsa', value: usr.id);
    /*
    BORRAR
    await storage.write(key: 'idBolsa', value: decodedData['name]);*/
    //3 de 3: imprimimos valor de variable del storage
    String? idBolsa = await storage.read(key: 'idBolsa');
    await storage.write(key: 'poderBolsa', value: usr.bolsa.toString());
    String? poderValue = await storage.read(key: 'poderBolsa');
    print(
        'idBolsa al crear usr: $idBolsa, poder: $poderValue desde usuarios_service.dart');
    isSaving = false;
    notifyListeners();
    return usr.id!;
  }
}

/*class PartidasServices extends ChangeNotifier {
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

  Future<String> updateTarjeta(partida, tarjetas, enviousrcreador) async {
    //creamos una instancia para utilizar el localstorage, mostrar usr 1de4
    //BuildContext context;
    //final authService = Provider.of<AuthService>(context, listen: false);
    isSaving = true;
    notifyListeners();
    //print('4recibe updateTarjeta updateTarjeta: $enviousrcreador');
    final url = Uri.https(_baseUrl, 'partidas_ppt/${partida.id}.json');
    final resp = await http.put(url, body: partida.toJson());
    final decodedData = json.decode(resp.body);
    print(decodedData);
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
      /*final index =
          partidas.indexWhere((element) => (element.id == partida.id));*/

      //partidas[index] = partida;
      //partidas[index].respcreador = 'eleccioncreador';
      //print(partidas[index].respoponente);
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
      }
      if (partida.respcreador == 'piedra' && eleccioncreador == 'tijera') {
        partidas[index].usridwin = partida.usridcreador;
      }
      if (partida.respcreador == 'papel' && eleccioncreador == 'piedra') {
        partidas[index].usridwin = partida.usridcreador;
      }
      if (partida.respcreador == 'papel' && eleccioncreador == 'papel') {
        partidas[index].usridwin = 'empate';
      }
      if (partida.respcreador == 'papel' && eleccioncreador == 'tijera') {
        partidas[index].usridwin = partida.usridoponente;
      }
      if (partida.respcreador == 'tijera' && eleccioncreador == 'piedra') {
        partidas[index].usridwin = partida.usridoponente;
      }
      if (partida.respcreador == 'tijera' && eleccioncreador == 'papel') {
        partidas[index].usridwin = partida.usridcreador;
      }
      if (partida.respcreador == 'tijera' && eleccioncreador == 'tijera') {
        partidas[index].usridwin = 'empate';
      }
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
}*/
