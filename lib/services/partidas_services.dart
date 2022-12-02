//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/services/services.dart';
//import 'package:app_game/services/services.dart';
//import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:app_game/models/models.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  late UsrGame selectUsr;
  bool isLoading = true;
  bool isSaving = false;
  String idBolsaS = '';
  String xidBolsaSOponente = '';
  //1 de 3: Para guadar id de la bolsa del usuario actual en el storage
  static const storage = FlutterSecureStorage();

  PartidasServices() {
    loadPartidas();
    loadUsuarios();
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
      if ((tempPartidas.status == 1 && tempPartidas.respcreador != '') ||
          (tempPartidas.status == 2 && tempPartidas.respcreador != '')) {
        tempPartidas.id = key;
        partidas.add(tempPartidas);
      }
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

  Future loadUsuarios() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'usuarios/games.json');
    final resp = await http.get(url);

    final Map<String, dynamic> usuariosMap = json.decode(resp.body);

    usuariosMap.forEach((key, value) {
      final tempUsuarios = UsrGame.fromMap(value);
      //hacer prueba con el id normal, en teoría, espero que con eso o hay necesidad de ponerle el null en los ifs
      tempUsuarios.id = key;
      usuarios.add(tempUsuarios);
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
        //Aqui me quedé, me di cuenta que al guardar el dato en bolsa, se copia el perfil del usr creador
        //en firebase, checar casteo de objetos.
        //Resuelto el punto anterior, resulta que el creador de la partida debe ser hugo0589 y el oponente es es x@gm.cm
        //Ya que se llama el obj con los corchetes [0]
        //Lo interesante que si realiza la resta a la bolsa copiada.
        //traerme el objeto seleccionado del card_swiper...
        //Para ESCRIBIR DATOS EN BOLSA ES AQUÍIII
        //Calculamos el/los valores en bolsa, en este caso se define desde la respuesta del usr que cierra la partida (oponente)
        //primero establecemos el ganador, que en este caso ya nos lo da el campo usrwin
        //imprimimos prueba del campo y bolsa del usrcreador y le asignamos valor
        //variabledelobjMontoBolsaCreador = variabledelobjMontoBolsaCreador +/- partidas[index].montototal;

        //obtenemos info del usrperdedor
        //descontamos lo correspondiente

        //OJO CON LA PARTIDA DE EMPATE. En este caso, sólo hay registro
        //Ver la forma de lanzar el desempate
        //Inicia modificación en bolsa 1
        //prueba1
        //idBolsaS = (await storage.read(key: 'idBolsa'))!;

        //print(idBolsaS);
        //Actualización1
        //selectUsr = UsuariosService().obtenerUsuario(enviousrcreador);

        //Termina prueba 1
        //print(xdecodedData);
        //print(usuarios.email);
        //Éstas dos líneas se integran dentro de los ifs para actualizar únicamene lo del usr correspondiente
        //Ya sea creador u oponente.

        //print("encuentro ID de bolsa");
        //DESCOMENTAR:
        /*print(xindex);
      print(usuariosLista[xindex].email);
      print('bolsa del usr actual: ${usuariosLista[index].bolsa}');*/
        //usuariosLista[index].bolsa = usuariosLista[index].bolsa - 10;
        /*BORRARfinal resp = await http.put(url, body: idBolsaS.toJson());
      final decodedData = json.decode(resp.body);*/
        //TODO: Actualizar el listado de productos
        //print('Usuarios: $usuariosLista');
        //print(usuarios);
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
        //print('idBolsa del usuarioActual: $idBolsaS');
        //tendría que realizar un if para saber si la idBolsaS es del usrcreador o del oponente para realizar la operación correspondiente en su bolsa.

        //Ejecución de la actualización de la Tarjeta
        partidas[index].respoponente = eleccioncreador;
        //print(partidas[index].respoponente);
        //programé para que el oponente cierre con fecha la partida, es el que la establece
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

      //if para manejo de bolsa SUMA
      if (partida.usridwin == enviousrcreador) {
        if (vuelta == 1) {
          final xurl = Uri.https(_baseUrl, 'usuarios/games/$idBolsaS.json');
          //calculo index del ganador
          final xindex =
              usuarios.indexWhere((xelement) => (xelement.id == idBolsaS));
          final xresp = await http.put(xurl, body: usuarios[xindex].toJson());
          final xdecodedData = json.decode(xresp.body);
          //Inicia variables para manejar Bolsa
          double? bganador = 0.0;
          double? bpartidacomision = 0.0;
          double? bolsapartida = 0.0;
          //Terminan variables para manejar bolsa

          //print('xdecodedData infoGanador: $xdecodedData');
          //calculo index del perdedor CHECAR HOJA BLANCA
          /**/

          bganador = (usuarios[xindex].bolsa);
          //TODO: en la siguiente aplico la comisión del 34%
          bpartidacomision = (partidas[index].montototal).toDouble() * 0.50;
          bolsapartida =
              (partidas[index].montototal).toDouble() - bpartidacomision;
          /*print('partidas valor: ${partidas[index].montototal}');
          print('partidas valor:  ${partida.montototal}');
          print('bganador, bolsa actual: $bganador');
          print('bolsa partida - comisión:  $bolsapartida');*/

          usuarios[xindex].bolsa =
              bganador! + bolsapartida; //(usuarios[xindex].bolsa! - 10)
          // pongo ganancia al límite máximo por día $300
          usuarios[xindex].masbolsa =
              ((usuarios[xindex].masbolsa! + bolsapartida));
          //TODO: Falta calculo comisión, convertir a double la variable
          usuarios[xindex].comisionbolsa =
              ((usuarios[xindex].comisionbolsa! + bpartidacomision));
        } else {
          double? bganador = 0.0;
          double? bpartidacomision = 0.0;
          double? bolsapartida = 0.0;
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
        if (vuelta == 1) {
          double? xbperdedor = 0.0;
          double? xbolsapartida = 0.0;
          final yindex = usuarios
              .indexWhere((yelement) => (yelement.email == xidBolsaSOponente));
          //obtengo idBolsa del adversario
          final yidBolsaindex = usuarios
              .indexWhere((yelement) => (yelement.id == usuarios[yindex].id));
          //print(
          //'index del perdedor: $yindex, idName: ${usuarios[yidBolsaindex].id}');
          final yurl = Uri.https(
              _baseUrl, 'usuarios/games/${usuarios[yidBolsaindex].id}.json');
          final yresp = await http.put(yurl, body: usuarios[yindex].toJson());
          final ydecodedData = json.decode(yresp.body);
          //print('ydecodedData infoPerdedor: $ydecodedData');
          xbperdedor = (usuarios[yindex].bolsa);
          //partidas[index].montototal = partida.montototal;
          xbolsapartida = (partida.montototal).toDouble();
          xbolsapartida = xbolsapartida;
          usuarios[yindex].bolsa = (xbperdedor! - xbolsapartida!);
        } else {
          double? xbperdedor = 0.0;
          double? xbolsapartida = 0.0;
          print("No se ejecuta vuelta 2");
        }
      } else {
        //TODO: quitar el else y poner un if para repetir el código, pero ésta vez es para aplicar cuando el creador pierda(partida.usridwin == enviousrcreador)
      }
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
      notifyListeners();
      return tarjetas.id!;
    } catch (e) {
      print('Error en updateTarjeta: $e');
      return tarjetas.id!;
    }
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
