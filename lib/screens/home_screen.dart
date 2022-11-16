//import 'dart:math';

import 'dart:math';

import 'package:app_game/models/models.dart';
import 'package:app_game/providers/usuarios_form_provider.dart';
import 'package:app_game/screens/pagina1.dart';
import 'package:app_game/screens/screens.dart';
import 'package:app_game/services/services.dart';
import 'package:app_game/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
//ESTAimport 'package:paginas/pages/pagina1.dart';
//import 'dart:async';

//import 'package:paginas/pages/pagina3.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  //definimos la variable global para mostrar el msj del usuario, mostrar usr 0de4
  String enviomsj = '';
  //Para poner la primera letra en mayúscula de una palabra
  String get inCaps => '$this[0].toUpperCase()$this.substring(1)';
  String rrvalue = '';
  int? infoUsr = 0;
  int? diverzcoin = 0;
  List<UsrGame> daUsr = [];
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random.secure();
  @override
  Widget build(BuildContext context) {
    final partidasService = Provider.of<PartidasServices>(context);
    final usuariosService = Provider.of<UsuariosService>(context);
    final daUsr = usuariosService.usuarios;
    //creamos código de inv de 5 dígitos, le pondremos aún parte de su email, más abajo
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    //activar el loading con una misma screen copia
    /*if (partidasService.isLoading) {
      return LoadingScreen();
    }*/
    //TextStyle titulosTxt = const TextStyle(fontSize: 27);
    TextStyle subtitulosTxt = TextStyle(
      fontSize: 22,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = Colors.deepPurple,
    );
    //TextStyle numerosTxt = const TextStyle(fontSize: 25);
    TextStyle parrafosTxt = const TextStyle(fontSize: 17);

    //aplicamos estilos al nombre de usr
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
    ).createShader(const Rect.fromLTWH(0, 0, 200, 70));
    //creamos instancia del provider del usr
    //final perfil = Provider.of<UsuariosService>(context);
    //print('perfil-usuarios: ${perfil.usuarios[0]}');
    //print('Perfil-getOnDisplayUsusarios: ${perfil.getOndisplayUsuarios}');

    //print(perfil.getOndisplayUsuarios);
    //creamos una instancia para utilizar el localstorage, mostrar usr 1de4
    final authService = Provider.of<AuthService>(context, listen: false);

    /*if (mounted) {
      //String _noDataText;
        setState(() => _timer?.cancel()));
    }*/
    //BorrarString? mm = AuthService().storage.read(key: 'usremail').toString();
    //generamos la función, mostrar usr 2de4
    mostrarusr() async {
      //String? rrvalue = await AuthService().readEmail();
      //String? valor = await authService.storage.read(key: 'usremail');
      try {
        rrvalue = (await authService.storage.read(key: 'usremail'))!;
        /*obtenemos el nombre del usuario tomando como referencia su email, lo que va antes del @ con split:
      ${rrvalue!.split('@')[0]}*/
        /* Obtenemos la primera letra y la convertimos en mayúscula:
        ${rrvalue![0].toUpperCase()}${rrvalue.substring(1)}
      */
        enviomsj =
            '\n${rrvalue[0].toUpperCase()}${rrvalue.substring(1).split('@')[0]}';
        //Las siguientes 2 líneas me sirven para obtener info del objeto USRGame para la bolsa
        infoUsr = await usuariosService.obtenerUsuario(rrvalue);
        diverzcoin = daUsr[infoUsr!].bolsa;

        //ponemos el if mounted para detener el error en el widget en tiempo de ejecución.
        if (mounted) {
          // check whether the state object is in tree
          setState(() {
            // make changes here
          });
        }
        return enviomsj;
      } catch (error) {
        print("???Try-Finally:Function Mostrar usr. $error");
      }
    }

    //ejecutamos la función para mostrar usrname, mostrar usr 3de4
    mostrarusr();
    /*bolsa() async {
      //Las siguientes 2 líneas me sirven para obtener info del objeto USRGame para la bolsa
      infoUsr = await usuariosService.obtenerUsuario(rrvalue);
      //diverzcoin = daUsr[infoUsr!].bolsa;
      /*obtenemos el nombre del usuario tomando como referencia su email, lo que va antes del @ con split:
      ${rrvalue!.split('@')[0]}*/
      /* Obtenemos la primera letra y la convertimos en mayúscula:
        ${rrvalue![0].toUpperCase()}${rrvalue.substring(1)}
      */
      //print(enviomsj);
      setState(() {});
      return infoUsr;
    }

    //ejecutamos la función para mostrar usrname, mostrar usr 3de4
    bolsa();*/
    //const storage = FlutterSecureStorage();
    //La siguiente línea probamos el código generado único
    //print('${rrvalue[0]}${getRandomString(5)}${rrvalue[1]}');
    return Scaffold(
      //backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('DiverZión - Almacén'),
        elevation: 8.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.perm_identity_rounded),
            tooltip: 'Mi perfil',
            onPressed: () async {
              //TODO: Imprimimos para revisar los valores del storage
              print(await authService.storage.read(key: 'usremail'));
              print(await authService.storage.read(key: 'idBolsa'));
              try {
                //aquí el código para obtener el index del usr y pintar lo correspondiente a su sesión
                infoUsr = await usuariosService.obtenerUsuario(rrvalue);
                if (infoUsr == null || infoUsr == -1) {
                  usuariosService.createUsuario(UsrGame(
                      id: rrvalue,
                      usrId: rrvalue, //validar
                      apodo: 'AVATAR',
                      avatar:
                          'https://res.cloudinary.com/dqtjgerwt/image/upload/v1665216453/cld-sample-2.jpg', //validar
                      bolsa: 0,
                      cinvbolsa: 0,
                      //Genera un código con función random y algo que extraiga de su email
                      codigoinv:
                          '${rrvalue[0]}${getRandomString(5)}${rrvalue[1]}',
                      comisionbolsa: 0,
                      email: rrvalue,
                      masbolsa: 0,
                      menosbolsa: 0,
                      modo: 'trial',
                      padrecodigo: 'DEFAULT',
                      status: true));
                  //Aquí al final puedo lanzar un msj al usr nuevo de construyendo su perfil, intente ingresar en 1 minuto.
                } else {
                  print('infousr: $infoUsr');
                  //usuariosService.obtenerUsuario(rrvalue);

                  usuariosService.selectedUsuarios = UsrGame(
                      id: daUsr[infoUsr!].id,
                      usrId: daUsr[infoUsr!].usrId, //validar
                      apodo: daUsr[infoUsr!].apodo, //validar
                      avatar: daUsr[infoUsr!].avatar, //validar
                      bolsa: daUsr[infoUsr!].bolsa,
                      cinvbolsa: daUsr[infoUsr!].cinvbolsa,
                      codigoinv: daUsr[infoUsr!].codigoinv,
                      comisionbolsa: daUsr[infoUsr!].comisionbolsa,
                      email: daUsr[infoUsr!].email,
                      masbolsa: daUsr[infoUsr!].masbolsa,
                      menosbolsa: daUsr[infoUsr!].menosbolsa,
                      modo: daUsr[infoUsr!].modo,
                      padrecodigo: daUsr[infoUsr!].padrecodigo,
                      status: daUsr[infoUsr!].status);
                }
                Navigator.pushNamed(context, 'perfil');
                /*ListView.builder(
                  //separatorBuilder: ((_, __) => const Divider()),
                  //return ListView.builder(
                  //NoJalascrollDirection: Axis.horizontal,
                  itemCount: usuariosService.usuarios.length,
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                      onTap: () {
                        //Aquí tenemos que cambiar la funcionalidad "total", pero dirigir con los datos a la ventana (PPT) para comenzar el juego
                        //Me quedé aqui para hacer pruebas de visualizar y copiar únicamente las cards con status 1y2
                        /*partidasService.selectedPartidas =
                        partidasService.partidas[index].copy();*/
                        //TODO: Checar el copy
                        usuariosService.selectedUsuarios =
                            usuariosService.usuarios[index];
                        Navigator.pushNamed(context, 'perfil');
                        //incluir evalúo de que tenga poder en su granja el usr, así como el monto al día permitido,
                        //checar el tema de juego entre usrversionapp para poder mayor
                        /*if (usuariosService.usuarios[index].email == rrvalue) {
                          NotificationsService.showSnackbar(
                              "tú mismo la hicistesss, aún no hay oponente, recibirás una notificación!");
                          //Navigator.pushNamed(context, 'partida');
                        }*/
                      },
                      child: UsuariosCard(
                        usuario: usuariosService.usuarios[index],
                      )
                      /*Logra mostrar al usr únicamente cards disponibles y en status 'En partida' 
                    partidasService.partidas[index].status == 1 ||
                            partidasService.partidas[index].status == 2
                        /? PartidasCard(
                            partida: partidasService.partidas[index],
                          )
                        : const Text(""),*/
                      ));*/
                /*showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: Colors.lightBlue.shade100,
                          title: const Text("¡A tu medida!"),
                          content: const SingleChildScrollView(
                            child: Text(
                                "Crea una partida e invita a la comunidad. \n Antes de establecer los siguientes datos es importante tener poder en tu granja, tu poder actual es de: \$\$\$ DiverZCoin"),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Crear e invitar..."))
                          ],
                        ))*/
              } catch (e) {
                print(e);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Notificaciones',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preparar popup.')));
            },
          ),
          IconButton(
            tooltip: 'Salir',
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              /*String? value = await authService.storage.read(key: 'usremail');
              print(value);
              String? xvalue = await AuthService().readEmail();
              print('xvalue: ' + xvalue);
              print(mostrarusr().toString());
              authService.logout();*/
              //TODO: authService.storage.deleteAll();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
        //Para poner el icono de logout en la parte derecha, class254min1:19
        /*actions: [IconButton(
          onPressed: (){}), 
          icon: const Icon(Icons.logout_rounded)),
          ),]*/
        /*leading: IconButton(
            onPressed: () async {
              /*String? value = await authService.storage.read(key: 'usremail');
              print(value);
              String? xvalue = await AuthService().readEmail();
              print('xvalue: ' + xvalue);
              print(mostrarusr().toString());
              authService.logout();*/
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: const Icon(Icons.logout_rounded)
            ),*/
      ),
      backgroundColor: Colors.lightBlue.shade100,
      body: SingleChildScrollView(
        //TODO incluir en el registro el ávatar del usr
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    Expanded(
                      child: Image(
                        image: NetworkImage(
                            'https://xtremeretro.com/wp-content/uploads/2021/05/Theme-Park-Electronic-Arts-Bullfrog-Productions-Strategy-Tactics-1994-3DO-Amiga-DOS-FM-Towns-Jaguar-PlayStation-SEGA-Saturn-PC-Xtreme-Retro-5.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              /*Me marcó error - checarlo, sólo es una referencia del widget
              GridView.count(
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const <Widget>[
                  Expanded(
                    child: Image(
                      image: NetworkImage(
                          'https://xtremeretro.com/wp-content/uploads/2021/05/Theme-Park-Electronic-Arts-Bullfrog-Productions-Strategy-Tactics-1994-3DO-Amiga-DOS-FM-Towns-Jaguar-PlayStation-SEGA-Saturn-PC-Xtreme-Retro-5.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),*/
              /*ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Text("test");
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),*/
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '\n¡Te damos la bienvenida, ',
                  //style: const TextStyle(fontSize: 27, color: Colors.black45),
                  style: TextStyle(
                    fontSize: 25,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.blue[700]!,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        //establecemos variable para mostrar el msj del usr, mostrar usr 4de4
                        text: enviomsj,
                        style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient)),
                    const TextSpan(text: ' !'),
                  ],
                ),
              ),
              /*FutureBuilder<String?>(
                  future: authService.storage.read(key: 'usremail'),
                  builder: (context, snapshot) {
                    // Logica...
                    Future<String> xvalue = AuthService().readEmail();
                    print(xvalue);
                    return Text(xvalue.toString());
                    print(mm);
                  }),*/
              /*FutureBuilder(
                  future: authService.readEmail(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (!snapshot.hasData) return const Text('msj1');
                    if (snapshot.data == '') {
                      print(AuthService().storage.read(key: 'usremail'));
                      return const Text('msj2');
                    } else {
                      Future<String> xvalue = AuthService().readEmail();
                      print('msj3: $xvalue');
                      return Text(xvalue.toString());
                      print(mm);
                    }
                  }),*/
              /*Text(
                //authService.readEmail().toString(),
                //authService.storage.read(key: 'usremail').toString(),
                //authService.readEmail().then((value) => 'usremail').toString(),
                //storage.read(key: 'usremail').toString(),
                mostrarusr().toString(),
                style: subtitulosTxt,
              ),*/
              /*Text(
                '¡Te damos la bienvenida, $enviomsj!',
                style: titulosTxt,
                textAlign: TextAlign.center,
              ),*/
              Text(
                '\nEste espacio muestra el contenido de tu almacén, aquí se verán reflejados, todos los víveres que tienes hasta el momento, con estos elementos puedes divertirte dentro de la comunidad en DiverZión para ponerlos en juego a través de momentos divertidísimos. Posteriormente, puedes solicitar tu despensa a domicilio, a partir de tu primer desafío.\n',
                style: parrafosTxt,
                textAlign: TextAlign.center,
              ),
              Text(
                'Almacén actual:',
                style: subtitulosTxt,
              ),
              Text(
                'DiverZcoin: $diverzcoin',
                style: subtitulosTxt,
              ),
              DataTable(
                sortColumnIndex: 2,
                sortAscending: false,
                columns: const [
                  DataColumn(label: Text("Cant.")),
                  DataColumn(label: Text("Elemento")),
                  DataColumn(label: Text("Poder"), numeric: true),
                ],
                rows: const [
                  DataRow(selected: true, cells: [
                    DataCell(Text("1"), showEditIcon: true),
                    DataCell(Text("Pez")),
                    DataCell(Text("1"))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("1")),
                    DataCell(Text("Dátil")),
                    DataCell(Text("2"))
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Text("1"), showEditIcon: true),
                    DataCell(Text("Tina")),
                    DataCell(Text("3"))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("1")),
                    DataCell(Text("Cachorro")),
                    DataCell(Text("4"))
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Text("1"), showEditIcon: true),
                    DataCell(Text("Cuchara")),
                    DataCell(Text("5"))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("1")),
                    DataCell(Text("Serpiente")),
                    DataCell(Text("6"))
                  ]),
                  /*DataRow(selected: true, cells: [
                    DataCell(Text("1"), showEditIcon: true),
                    DataCell(Text("Trinche")),
                    DataCell(Text("3"))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("1")),
                    DataCell(Text("Rábano")),
                    DataCell(Text("4"))
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Text("1"), showEditIcon: true),
                    DataCell(Text("Abeja")),
                    DataCell(Text("5"))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("1")),
                    DataCell(Text("Borrego")),
                    DataCell(Text("6"))
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(Text("1"), showEditIcon: true),
                    DataCell(Text("Perro")),
                    DataCell(Text("7"))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("1")),
                    DataCell(Text("Chivo")),
                    DataCell(Text("8"))
                  ]),*/
                ],
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: "btnRecargar",
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        backgroundColor: Colors.lightBlue.shade100,
                        title: const Text("Adquiere más elementos."),
                        content: const SingleChildScrollView(
                          child: Text(
                              "¡Es muy fácil! Sólo acude al oxxo de tu preferencia y realiza el aporte (a partir de 10mxn) a la siguiente cuenta: xxxx-xxxx-xxxx-xxxx, es a banco Banregio. Guarda tu comprobante (ticket), compártelo vía whatsapp al número oficial de DiverZión: \n(+52) 473-139-95-77.\n \n¡Y listo! Dentro de las próximas 2 horas, podrás adquirir víveres dentro de DiverZión para divertirte al máximo."),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Entendido"))
                        ],
                      ))
            },
            tooltip: 'Recargar',
            child: const Icon(Icons.account_balance_rounded),
          ),
          FloatingActionButton(
            heroTag: "btnColiseo",
            onPressed: () => {Navigator.push(context, _crearRuta())},
            tooltip: 'Coliseo',
            //child: const Icon(Icons.add_reaction_rounded),
            //child: const Icon(Icons.agriculture_rounded),
            //child: const Icon(Icons.app_shortcut_sharp),
            //child: const Icon(Icons.assured_workload_rounded),
            //child: const Icon(Icons.auto_awesome),
            child: const Icon(Icons.widgets_rounded),
            //child: const Icon(Icons.pest_control_sharp),
          ),
          /*MaterialButton(
            minWidth: 200.0,
            height: 40.0,
            onPressed: () {},
            color: Colors.lightBlue,
            child: const Text('Material Button',
                style: TextStyle(color: Colors.white)),
          ),*/
        ],
      ),
    );
  }

  Route _crearRuta() {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            Pagina1(),
        transitionDuration: const Duration(seconds: 2),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          // return SlideTransition(
          //   position: Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero ).animate(curvedAnimation),
          //   child: child,
          // );
          return ScaleTransition(
              scale:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);

          //RotationTransition
          /*return RotationTransition(
              turns:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);*/

          /*return FadeTransition(
              opacity:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);*/

          /*return RotationTransition(
              child: FadeTransition(
                  child: child,
                  opacity: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(curvedAnimation)),
              turns:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation));*/
        });
  }
}
