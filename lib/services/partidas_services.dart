//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/screens/partida_pptscreen.dart';
//import 'package:app_game/screens/partidas_ppt.dart';
//import 'package:app_game/services/services.dart';
import 'package:app_game/navigator_key.dart';
//import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:app_game/models/models.dart';
import 'package:app_game/services/notifications_service.dart';
import 'package:app_game/services/services.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int pncontador = 0;

class PartidasServices extends ChangeNotifier {
  /*@override
  Widget build(BuildContext context) {
    return const Text('PN');
  }
  late BuildContext context;*/

  final String _baseUrl = 'pptgame-d06ee-default-rtdb.firebaseio.com';
  List<Ppt> partidas = [];
  final List<Ppt> xpartida = [];
  Map<String, dynamic> pnpartidasMap = {};
  late Ppt selectedPartidas;
  File? newPictureFile;
  String enviousrcreador = '';
  //para tarjetas ppt
  final List<Opcion> tarjetas = [];
  late Opcion selectedTarjetas;
  //objeto para info de usuarios generales
  List<UsrGame> usuarios = [];
  List<UsrGame> usuariosPartida = [];
  List<UsrGame> usuarioCreador = [];
  List<UsrGame> usuarioOponente = [];
  var pnusuarios = {};
  //guarda info del creador
  var xusuario = {};
  //guarda info del oponente
  var yusuario = {};
  late UsrGame selectedUsuarios;
  late UsrGame selectUsr;
  bool isLoading = true;
  bool isSaving = false;
  String idBolsaS = '';
  String xidBolsaSOponente = '';
  String? xusr1Id = '';
  String? yusr2Id = '';
  //1 de 3: Para guadar id de la bolsa del usuario actual en el storage
  static const storage = FlutterSecureStorage();

  PartidasServices() {
    loadPartidas();
    loadUsuarios();
  }
  void refrescaTarjetas() {
    //dispose();
    partidas.clear();
    //usuarios.clear();
    loadPartidas();
    //loadUsuarios();
    notifyListeners();
  }

  void refrescaUsuarios() {
    //dispose();
    usuarios.clear();
    //usuarios.clear();
    loadUsuarios();
    //loadUsuarios();
    notifyListeners();
  }

  //TODO: <List<Partidasppt>>
  Future loadPartidas() async {
    try {
      print(
          'se cargan partidas desde partidas_services, consulta a Firebase desde partidas_services');
      isLoading = true;
      notifyListeners();

      final url = Uri.https(_baseUrl, 'partidas_ppt.json');
      final resp = await http.get(url);

      final Map<String, dynamic> partidasMap = json.decode(resp.body);

      partidasMap.forEach((key, value) {
        final tempPartidas = Ppt.fromMap(value);
        //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
        if ((tempPartidas.status == 1 && tempPartidas.respcreador != '') ||
            (tempPartidas.status == 2 && tempPartidas.respcreador != '')) {
          tempPartidas.id = key;
          partidas.add(tempPartidas);
        }
      });

      isLoading = false;
      notifyListeners();
      return partidas;
    } catch (e) {
      print('catch del loadpartidas: $e');
    }
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

  Future<List<UsrGame>> loadUsuarios() async {
    isLoading = true;
    notifyListeners();
    print(
        'se cargan Usuarios desde partidas_services, consulta a Firebase desde partidas_services');

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

    isLoading = false;
    notifyListeners();
    return usuarios;
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

  Future<List<UsrGame>> loadUsuariosPartida(
      String xusr1Id, String xusr2Id) async {
    isLoading = true;
    notifyListeners();
    print(
        'se cargan Usuarios desde partidas_services, consulta a Firebase desde partidas_services');

    final url = Uri.https(_baseUrl, 'usuarios/games.json');
    final resp = await http.get(url);

    final Map<String, dynamic> xusuariosMap = json.decode(resp.body);
    usuariosPartida.clear();
    xusuariosMap.forEach((key, value) {
      final xtempUsuarios = UsrGame.fromMap(value);
      //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
      if (xtempUsuarios.id == xusr1Id || xtempUsuarios.id == xusr2Id) {
        xtempUsuarios.id = key;
        usuariosPartida.add(xtempUsuarios);
      }
    });

    isLoading = false;
    notifyListeners();
    print('UsuariosEnJuego: $usuariosPartida');
    return usuariosPartida;
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

  Future x1loadUsuario(String xusr1Id) async {
    try {
      isLoading = true;
      notifyListeners();
      usuarioCreador.clear();
      print(
          'se carga únicamente el usr1, creador. Desde partidas_Services, 1 consulta get');
      final xurl = Uri.https(_baseUrl, 'usuarios/games.json');
      final xresp = await http.get(xurl);
      final Map<String, dynamic> xdecodedData = json.decode(xresp.body);
      xdecodedData.forEach((key, value) {
        final creadortempUsuario = UsrGame.fromMap(value);
        //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
        if (creadortempUsuario.id == xusr1Id) {
          creadortempUsuario.id = key;
          usuarioCreador.add(creadortempUsuario);
        }
      });

      print(
          'Usuario creador desde partidas_service.dart, aplico para usr: ${usuarioCreador[0].email}, tiene en bolsa: ${usuarioCreador[0].bolsa}');
      //escribo el poder en bolsa del usr:
      await storage.write(
          key: 'poderBolsa', value: usuarioCreador[0].bolsa.toString());
      await storage.write(
          key: 'idBolsa', value: usuarioCreador[0].id.toString());
      //String? bolsaValue = await storage.read(key: 'idBolsa');
      //String? poderValue = await storage.read(key: 'poderBolsa');
      isLoading = false;
      notifyListeners();
      return usuarioCreador;
    } catch (e) {
      print('try del catch xloadUsuarios: $e');
    }
  }

  Future y2loadUsuario(String yusr2Id) async {
    try {
      isLoading = true;
      notifyListeners();
      print(
          'se carga únicamente el usr2, oponente. Desde partidas_Services, 1 consulta get');
      print(
          'se carga el usr oponente, desde partidas_Services, 1 consulta get');
      usuarioOponente.clear();
      final yurl = Uri.https(_baseUrl, 'usuarios/games.json');
      final yresp = await http.get(yurl);
      final Map<String, dynamic> ydecodedData = json.decode(yresp.body);
      ydecodedData.forEach((key, value) {
        final oponentetempUsuario = UsrGame.fromMap(value);
        //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
        if (oponentetempUsuario.id == yusr2Id) {
          oponentetempUsuario.id = key;
          usuarioOponente.add(oponentetempUsuario);
        }
      });

      //escribo el poder en bolsa del usr:
      await storage.write(
          key: 'poderBolsa', value: usuarioOponente[0].bolsa.toString());
      await storage.write(
          key: 'idBolsa', value: usuarioOponente[0].id.toString());
      //String? bolsaValue = await storage.read(key: 'idBolsa');
      //String? poderValue = await storage.read(key: 'poderBolsa');
      isLoading = false;
      notifyListeners();
      return usuarioOponente;
    } catch (e) {
      print('try del catch yloadUsuarios: $e');
    }
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
      print(
          'se ejecutan 2 consultas a Firebase al crear y actualizar la partida creada desde partidas_services.');
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
    print('entra a crear partida desde partidas_services');
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
    print(
        'Consulta a Firebase cuando se obtiene la partida desde partidas_services');

    partida.id = decodedData['name'];
    partidas.add(partida);
    //print(partidas);
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

  Future<String> updateTarjeta(partida, tarjetas, enviousrcreador, idBolsaS,
      usuariosLista, vuelta) async {
    //creamos una instancia para utilizar el localstorage, mostrar usr 1de4
    //BuildContext context;
    //final authService = Provider.of<AuthService>(context, listen: false);
    try {
      isSaving = true;
      notifyListeners();
      print(
          'se actualiza tarjeta desde updateTarjeta, 3 consultas a Firebase desde partidas_services');
      /*await Future.delayed(const Duration(seconds: 3), () async {
        refrescaTarjetas();
      });*/
      //await Future.delayed(const Duration(seconds: 2), () async {
      //print('4recibe updateTarjeta updateTarjeta: $enviousrcreador');
      print('valor vuelta: $vuelta');
      final url = Uri.https(_baseUrl, 'partidas_ppt/${partida.id}.json');
      final resp = await http.put(url, body: partida.toJson());
      final decodedData = json.decode(resp.body);
      //print(decodedData);
      final index =
          partidas.indexWhere((element) => (element.id == partida.id));
      final eleccioncreador = tarjetas.nombre;
      String fechaFin = formatDate(
          DateTime.now(), [d, '/', mm, '/', yyyy, ' ', H, ':', m, ':', am]);
      //selectedTarjetas = tarj;
      //-----------
      //obtengo objeto del usuario oponente al que se le resta
      /*usuarioCreador = await x1loadUsuario(idBolsaS);
      print('usuarioCreadorJAJAJA: ${usuarioCreador[0].id}');*/
      //TODO: aplicarle un DelayFuture, porque a veces al ejecutar las siguientes líneas marca error de espera en transacción. obtengo obj del oponente
      //usuarioOponente = await y2loadUsuario(idBolsaS);
      //----------

      //1
      /*print('1-Pasa obtención de url con idusr: $xurl');
      //calculo index del ganador
      //final xusuario = json.encode(usuarios[xindex]);
      //2
      print('2-obtiene usr de función: $xresp');
      //final xresp = await http.put(xurl, body: xusuario);
      //2.1
      print('2.1-aplica al obj usr el decode: $xdecodedData');*/

      //print('Tarj: $tarj');
      //TODO: Actualizar el listado de productos
      if (partida.usridcreador == enviousrcreador) {
        partidas[index].respcreador = eleccioncreador;
      } else {
        partidas[index].respoponente = eleccioncreador;
        partidas[index].fechafin = fechaFin;
        partidas[index].status = 3;

        //TODO: Faltanreglas del gane PPT, para guardar el usridGanador en usridwin
        if (partida.respcreador == 'piedra' && eleccioncreador == 'piedra') {
          partidas[index].usridwin = 'empate';
          print("No se actualiza la bolsa");
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
      }
      //print('UsrCreador: ${partida.usridcreador}');
      //print('UsrOponente: ${partida.usridoponente}');
      //print('UsrWin-Ganador: ${partida.usridwin}');
      //inicia respaldo

      //if para manejo de bolsa SUMA, si el oponente es el ganador
      if (partida.usridwin == enviousrcreador) {
        if (vuelta == 1 || vuelta == 2) {
          //loPuse para refrescar obj de usuario
          //usuarios = await UsuariosService().loadUsuarios();
          // -------------
          Future.delayed(const Duration(seconds: 3), () async {
            //Inicia variables para manejar Bolsa
            int? bganador = 0;
            int? bpartidacomision = 0;
            int? bolsapartida = 0;
            //Terminan variables para manejar bolsa
            final xindex =
                usuarios.indexWhere((xelement) => (xelement.id == idBolsaS));
            final xurl = Uri.https(_baseUrl, 'usuarios/games/$idBolsaS.json');
            final xresp =
                await http.put(xurl, body: (usuarios[xindex].toJson()));
            final xdecodedData = json.decode(xresp.body);

            //3
            //print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiint.1');
            //No funcionó: xdecodedData['bolsa'] = 666.5;
            //No funciona: xdecodedData.bolsa = 666.7;
            //xdecodedData["bolsa"] = 667.8;
            /*print(
              '3-aplica al obj usr el decode: $xdecodedData, ${xdecodedData['bolsa']}');*/

            //print('xdecodedData infoGanador: $xdecodedData');
            //calculo index del perdedor CHECAR HOJA BLANCA
            /**/
            /*print(
              'ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑobj usr1 solo: $xdecodedData, ${xdecodedData['bolsa']}');*/
            /*bganador = xdecodedData[
                'bolsa'];*/ //double.parse(xusuario['bolsa'].toString());
            //print('vvvvvvvvvvvvvvvvaaalorrrr: $bganador');
            //TODO: en la siguiente aplico la comisión del 34%
            //bpartidacomision = (partidas[index].montototal).toDouble() * 0.50;
            bpartidacomision = ((partidas[index].montototal) * 60) ~/ 100;
            bolsapartida = (partidas[index].montototal) - bpartidacomision;
            /*print('partidas valor: ${partidas[index].montototal}');
          print('partidas valor:  ${partida.montototal}');
          print('bganador, bolsa actual: $bganador');
          print('bolsa partida - comisión:  $bolsapartida');*/
            //paso0Bolsa
            usuarios[xindex].bolsaRetenida = (partidas[index].montototal);
            //paso1Bolsa
            usuarios[xindex].bolsa = usuarios[xindex].bolsa! +
                bpartidacomision; //(usuarios[xindex].bolsa! - 10)
            // pongo ganancia al límite máximo por día $300
            usuarios[xindex].masbolsa =
                (usuarios[xindex].masbolsa! + bpartidacomision);
            //TODO: Falta calculo comisión, convertir a double la variable
            usuarios[xindex].comisionbolsa =
                (usuarios[xindex].comisionbolsa! + bolsapartida);
            //refrescaUsuarios();

            notifyListeners();
          });
        } else {
          int? bganador = 0;
          int? bpartidacomision = 0;
          int? bolsapartida = 0;
          print("No se ejecuta vuelta 2");
        }
        //el conteo de la pérdida del día, la manejamos aparte
        //pongo pérdida permitida al día $80
        /*usuarios[xindex].menosbolsa = (usuarios[xindex].menosbolsa! +
            partidas[index].montototal);*/
        //validar la instrucción anterior
        //print('usuarios[xindex] infoBolsa-Ganador: ${usuarios[xindex].bolsa}');
        //print("-----Modifica bolsa del ganador de la partida-----");
        //-------------Para restar valor de la bolsa del oponente perdedor. 'Falta implementar el empate como condición', <- creo no por el if general de esta sección, no aplica.
        if (partida.usridcreador == enviousrcreador &&
            partida.usridwin == enviousrcreador) {
          xidBolsaSOponente = partida.usridoponente;
          //print('perdedor el oponente: $xidBolsaSOponente');
        }
        if (partida.usridcreador != enviousrcreador &&
            partida.usridwin == enviousrcreador) {
          xidBolsaSOponente = partida.usridcreador;
          //print('perdedor el creador: $xidBolsaSOponente');
        }

        //TODO: RESTA DEL CREADOR
        if (vuelta == 1 || vuelta == 2) {
          //loPuse para refrescar obj de usuario
          //usuarios =
          /*Future.delayed(const Duration(seconds: 1), () async {
            await loadUsuarios();
          });*/
          //pnusuarios.clear();
          //pnusuarios = await loadUsuarios();

          //TODO:Subir aqui el Delayed
          final yindex = usuarios
              .indexWhere((yelement) => (yelement.email == xidBolsaSOponente));
          //obtengo idBolsa del adversario
          final yidBolsaindex = usuarios
              .indexWhere((yelement) => (yelement.id == usuarios[yindex].id));
          yusr2Id = usuarios[yidBolsaindex].id;
          //loadUsuariosPartida(usuariosLista.id, yusr2Id!);
          //TODO: borrar el llamado de éste método ya que escribo en el storage el monto del creador en el dispositivo del usr oponente
          //pnusuarios = await y2loadUsuario(yusr2Id!);
          usuarioCreador = await x1loadUsuario(yusr2Id!);
          print('usuarioCreadorJAJAJA: ${usuarioCreador[0].id}');
          Future.delayed(const Duration(seconds: 5), () async {
            //Future.delayed(const Duration(seconds: 10), () async {
            final yurl = Uri.https(
                _baseUrl, 'usuarios/games/${usuarioCreador[0].id}.json');
            //calculo index del ganador
            /*final xindex =
              usuarios.indexWhere((xelement) => (xelement.id == idBolsaS));*/
            //final yusuario = json.encode(usuarios[yidBolsaindex]);
            final yresp =
                await http.put(yurl, body: usuarioCreador[0].toJson());

            final ydecodedData = json.decode(yresp.body);
            int? xbperdedor = 0;
            int? xbolsapartida = 0;
            /*print(
                'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMobj usr2 solo: $ydecodedData, objt2: ${ydecodedData['bolsa']}');*/
            //print(
            //'index del perdedor: $yindex, idName: ${usuarios[yidBolsaindex].id}');
            /*final yurl = Uri.https(
              _baseUrl, 'usuarios/games/$yusuario.json');
          final yresp = await http.put(yurl, body: usuarios[yindex].toJson());
          final ydecodedData = json.decode(yresp.body);*/
            //print('ydecodedData infoPerdedor: $ydecodedData');
            //xbperdedor = (ydecodedData['bolsa']);
            //partidas[index].montototal = partida.montototal;
            xbolsapartida = (partida.montototal);
            //PN-xbolsapartida = xbolsapartida;
            //ydecodedData['bolsa'] = (xbperdedor! - xbolsapartida!);
            usuarioCreador[0].bolsa =
                (usuarioCreador[0].bolsa! - xbolsapartida!);
            /*print(
                'IRIIIIIII_ pnusuarios: $pnusuarios,\n valor2_pnusuarios[0].bolsa: ${pnusuarios['bolsa']}\n valor3_ydecodedData[bolsa]: ${ydecodedData['bolsa']} \n valor4_usuarios[yidBolsaindex].bolsa: ${usuarios[yidBolsaindex].bolsa}');*/
            usuarioCreador[0].menosbolsa =
                (usuarioCreador[0].menosbolsa! + xbolsapartida);
            //});
            notifyListeners();
          });
        } else {
          int? xbperdedor = 0;
          int? xbolsapartida = 0;
          print("No se ejecuta vuelta 2");
        }
      }
      /*if (partida.usridwin == enviousrcreador) {
      
      } else {
        //TODO: quitar el else y poner un if para repetir el código, pero ésta vez es para aplicar cuando el creador pierda(partida.usridwin == enviousrcreador)
        //del creador->usuarios[xindex].menosbolsa = ((xdecodedData['menosbolsa'] + bolsapartida));
      }*/
      //Falta validar: partida.usridwin != '' dentro de un if
      //if (partida.usridwin != enviousrcreador && partida.usridwin != 'empate' && partida.usridwin != '')
      /*if (partida.usridwin != enviousrcreador && partida.usridwin != '') {
        final yurl = Uri.https(_baseUrl, 'usuarios/games/$idBolsaS.json');
        //calculo index del ganador
        final yindex =
            usuarios.indexWhere((yelement) => (yelement.id == idBolsaS));
        final yresp = await http.put(yurl, body: usuarios[yindex].toJson());
        final ydecodedData = json.decode(yresp.body);

        print('xdecodedData infoPerdedor: $ydecodedData');
        //calculo index del perdedor CHECAR HOJA BLANCA
        /*final yindex =
            usuarios.indexWhere((yelement) => (yelement.email == idBolsaS));*/
        usuarios[yindex].bolsa = (usuarios[yindex].bolsa! -
            partidas[index].montototal); //(usuarios[xindex].bolsa! - 10)
        print('usuarios[xindex] infoBolsa-Perdedor: ${usuarios[yindex].bolsa}');
        print("-----Modifica bolsa del perdedor de la partida-----");
      }*/
      /*else {
        print('Entro a modificar ficha perdedorrrrr else');
      }*/
      //checar éste if, ya que se activa únicamente cuando se crea la tarjeta
      //En este caso le implementé != '' para limitar el entre
      //Manejo de bolsa: RESTA
      /*if (partida.usridwin != '' &&
          partida.usridwin != usuariosLista.email) {
        final yurl =
            Uri.https(_baseUrl, 'usuarios/games/${usuariosLista.id}.json');
        final yresp = await http.put(yurl, body: usuariosLista.toJson());
        final ydecodedData = json.decode(yresp.body);
        //calculo index del perdedor
        final yindex =
            usuarios.indexWhere((yelement) => (yelement.id == idBolsaS));
        print('ydecodedData infoGanador: $ydecodedData');
        //calculo index del perdedor CHECAR HOJA BLANCA
        usuariosLista.bolsa = (usuariosLista.bolsa -
            partida.montototal); //(usuarios[xindex].bolsa! - 10)
        print('usuarios[yindex] infoBolsa-Ganador: ${usuarios[yindex].bolsa}');
        print('------ Entro a modificar ficha perdedorrrrr -----');
      }*/
      /*if (partidas[index]. != usuariosLista.email) {
        final xurl =
            Uri.https(_baseUrl, 'usuarios/games/${usuariosLista.id}.json');
        final xresp = await http.put(xurl, body: usuariosLista.toJson());
        final xdecodedData = json.decode(xresp.body);
        final xindex =
            usuarios.indexWhere((xelement) => (xelement.id == idBolsaS));
        print('xindexGanador: $xdecodedData');
        usuariosLista.bolsa = (usuariosLista.bolsa -
            partidas[index].montototal); //(usuarios[xindex].bolsa! - 10)
        print("Modifica bolsa del ganador de la partida");
      }*/

      /*else {
            //en teoría aqui deberia restarle al otro usrId el perdedor, pero está actualizando el mismo obj, checar mi limitante desde que traigo la url para aplicarle el put
            final yurl =
                Uri.https(_baseUrl, 'usuarios/games/${usuariosLista.id}.json');
            final yresp = await http.put(yurl, body: usuariosLista.toJson());
            final ydecodedData = json.decode(yresp.body);
            final yindex =
                usuarios.indexWhere((yelement) => (yelement.id == idBolsaS));
            print('xindexGanador: $ydecodedData');
            usuariosLista.bolsa =
                (usuariosLista.bolsa - partidas[index].montototal);
            print("Modifica bolsa del perdedor de la partida");
          }*/ /*else {
            print("Modifica bolsa del oponente de la partida");
            final xurl =
                Uri.https(_baseUrl, 'usuarios/games/${usuariosLista.id}.json');
            final xresp = await http.put(xurl, body: usuariosLista.toJson());
            final xdecodedData = json.decode(xresp.body);
            final xindex =
                usuarios.indexWhere((xelement) => (xelement.id == idBolsaS));
            print('xindexPerdedor: $xdecodedData');
            usuariosLista.bolsa = (usuariosLista.bolsa +
                partidas[index].montototal); //(usuarios[xindex].bolsa! + 10)
          }*/
      //Termina if para manejo de bolsa
      //notifyListeners();
      isSaving = false;
      //refrescaTarjetas();PartidasServices().PartidasServices().
      notifyListeners();
      /*Future.delayed(const Duration(seconds: 1), () async {
        refrescaTarjetas();
        refrescaUsuarios();
      });*/
      //});
      return tarjetas.id!;
    } catch (e) {
      print('Error en updateTarjeta: $e');
      return tarjetas.id!;
    }
  }
  //finaliza respaldo

  //inicio apartar partida
  Future<String> apartaPartida(partida, tarjetas, enviousrcreador) async {
    isSaving = true;
    notifyListeners();
    print('se aparta partida, 1 consulta a Firebase desde partidas_services');
    //TODO: Aqui es necesario cargar info de partida actual info, para verificar estatus.
    //print('4recibe updateTarjeta updateTarjeta: $enviousrcreador');
    final url = Uri.https(_baseUrl, 'partidas_ppt/${partida.id}.json');
    final resp = await http.put(url, body: partida.toJson());
    final decodedData = json.decode(resp.body);
    final index = partidas.indexWhere((element) => (element.id == partida.id));
    //Future.delayed(const Duration(seconds: 3), () async {
    //final eleccioncreador = tarjetas.nombre;
    /*String fechaFin = formatDate(
        DateTime.now(), [d, '/', mm, '/', yyyy, ' ', H, ':', m, ':', am]);*/
    //selectedTarjetas = tarj;

    //print('Tarj: $tarj');
    //TODO: Actualizar el listado de productos
    if (partida.usridoponente == '' && partida.status == 1) {
      //Inicia verificación de status en partida
      pncontador = 0;
      partidas[index].usridoponente = enviousrcreador;
      partidas[index].status = 2;
      while (pncontador <= 1) {
        pncontador++;
        await Future.delayed(const Duration(seconds: 3), () async {
          final pnurl = Uri.https(_baseUrl, 'partidas_ppt.json');
          final pnresp = await http.get(pnurl);
          pnpartidasMap = json.decode(pnresp.body);
          //});
          //}

          pnpartidasMap.forEach((key, value) {
            final pntempPartidas = Ppt.fromMap(value);
            //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
            if (pntempPartidas.id == partida.id && pntempPartidas.status == 2) {
              NotificationsService.showSnackbar(
                  "1Creador finalizó partida! Refresca y busca o crea una nueva.");
            }
            //if (pntempPartidas.id == partida.id && pntempPartidas.status == 1) {
            pntempPartidas.id = key;
            xpartida.add(pntempPartidas);
            //}
          });
          //Termina verificación de status en partida
          //ejecuta de volada
          //partidas[index].usridoponente = enviousrcreador;
          if (xpartida[index].usridoponente == '' &&
              partida.usridoponente == '') {
            partidas[index].usridoponente = enviousrcreador;
            partidas[index].status = 2;
            notifyListeners();
          }
          if (xpartida[0].usridoponente != '' && partida.usridoponente == '') {
            NotificationsService.showSnackbar(
                "2Creador finalizó partida! Refresca y busca o crea una nueva.");
          }
          if (xpartida[0].usridoponente != '' && partida.usridoponente != '') {
            if (pncontador == 1) {
              NotificationsService.showSnackbar(
                  "3Creador finalizó partida! Refresca y busca o crea una nueva.");
              print('PPPPPNNNNNcontador: $pncontador, vez.');
              //refrescaTarjetas();

              await Future.delayed(const Duration(seconds: 3), () async {
                //BuildContext context;
                //Navigator.pushNamed(context, 'partidas_ppt');
                //TODO: en lugar del BuildContext context, usamos navigatorKey.currentContext
                //Es importante importar la librería.
                Navigator.of(navigatorKey.currentContext!)
                    .pushNamed('partidas_ppt');
                partidas.clear();
                partidas = await loadPartidas();
              });
            }
          }
        });
      }
      //pncontador = 0;
      notifyListeners();
    }
    if (partida.status == 2 && partida.usridoponente == enviousrcreador) {
      var partidas = await PartidasServices().loadPartidas();
      Future.delayed(const Duration(seconds: 4), () async {
        if (partida.usridoponente == enviousrcreador) {
          partidas[index].usridoponente = enviousrcreador;
        } else {
          NotificationsService.showSnackbar(
              "ZZzzzzzYa finalizó! Refresca y busca nueva partida. O crea una.");
        }
      });
    } else {
      print('ya se encuentra apartada, lanzar excepción a GUI.');
      NotificationsService.showSnackbar(
          "xxxxxYa finalizó! Refresca y busca nueva partida. O crea una.");
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
    pncontador = 0;
    //});
    //notifyListeners();
    isSaving = false;
    notifyListeners();
    return partidas[index].id!;
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
      //print(resp.body);
      return null;
    }

    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    isSaving = false;
    notifyListeners();
    return decodedData['secure_url'];
  }

  //actualizar usuario
  Future<String> updateUsuario(UsrGame usuario) async {
    isSaving = true;
    notifyListeners();
    print(
        'se actualiza info de usr, 1 consulta a Firebase desde partidas_services');
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
