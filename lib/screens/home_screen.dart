//ESTAimport 'package:paginas/pages/pagina1.dart';
//import 'dart:async';
//import 'dart:math';
//import 'package:app_game/providers/usuarios_form_provider.dart';
//import 'package:app_game/screens/screens.dart';
//import 'package:app_game/widgets/widgets.dart';
//import 'package:date_format/date_format.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:paginas/pages/pagina3.dart';
import 'dart:math';
import 'package:app_game/models/models.dart';
import 'package:app_game/screens/pagina1.dart';
import 'package:app_game/services/services.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

int bandera = 0;
int contador = 0;
var decodedData = [];

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
  String? usrId = '';
  int? infoUsr;
  String? diverzcoin = '0';
  String? poderValue = '0';
  List<UsrGame> daUsr = [];
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random.secure();
  //1 de 4: controllerText
  //var controller = TextEditingController();
  @override
  //TODO: PUSE EL DISPOSE
  /*void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    // Esto también elimina el listener _printLatestValue
    controller.dispose();
    super.dispose();
  }*/

  Widget build(BuildContext context) {
    //final partidasService = Provider.of<PartidasServices>(context);
    var usuariosService = Provider.of<UsuariosService>(context);
    daUsr = usuariosService.usuarios;
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
        ..color = const Color.fromRGBO(0, 38, 76, 1),
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
    //1 de 3: Para guadar id de la bolsa del usuario actual en el storage
    const storage = FlutterSecureStorage();

    /*if (mounted) {
      //String _noDataText;
        setState(() => _timer?.cancel()));
    }*/
    //BorrarString? mm = AuthService().storage.read(key: 'usremail').toString();
    //generamos la función, mostrar usr 2de4
    //1-Inicia análisis de bolsa y usr inicial

    mostrarusr() async {
      try {
        //1-asigno valor a bandera
        //bandera = 1;
        //await usuariosService.loadUsuarios();
        //daUsr = usuariosService.usuarios;
        //2-obtengo el email
        rrvalue = (await authService.storage.read(key: 'usremail'))!;
        //3-depuro la cadena email para obtener el usr son el arroba
        enviomsj =
            '\n${rrvalue[0].toUpperCase()}${rrvalue.substring(1).split('@')[0]}';
        //4-obtengo el id de la lista del usuario con base al email
        //await usuariosService.loadUsuarios();
        infoUsr = await usuariosService.obtenerUsuario(rrvalue);
        //con base al obj daUsr que tiene los la info de usuarios, obtengo la bolsa y el id
        //posiblemente aplicarle un delay
        //5-obtengo idy bolsa del usuario con su valor actual.
        //se calculan o se tienen de referencia para verificar el loadUsuarios, subí un nivel el usrId para asignarlo a variable.
        usrId = daUsr[infoUsr!].id;
        final decodedData =
            await usuariosService.xloadUsuario(daUsr[infoUsr!].id!);

        await authService.storage
            .write(key: 'poderBolsa', value: '${decodedData['bolsa']}');
        diverzcoin = (await authService.storage.read(key: 'poderBolsa'))!;
        //6-se evalúa que no contenga el email a continuación.
        if (usrId != rrvalue && usrId != '') {
          print(
              'diverzcoin del loadUsuarios en home_screen: $diverzcoin,usrId: $usrId. Se muestra info del USRs en un primer momento.');
          //7-escribo el poder en bolsa del usr:
          /*PN-4await authService.storage
              .write(key: 'poderBolsa', value: '${daUsr[infoUsr!].bolsa}');*/
          //lo asigno a una variable de referencia
          //PN5-poderValue = await authService.storage.read(key: 'poderBolsa');
          //testing de variables de bolsas
          print(
              'Bolsa al salir de mostrarUsr en home_screen, diverzcoin firebase: $diverzcoin, poderValue local: $poderValue.');
          //8 evalúo que tenga poder en la bolsa.
          if (double.parse(diverzcoin!) < 1) {
            //le aplico el cierre, pero en realidad hay que enviarlo a otra página que únicamente sea informativa. sin consultas a firebase.
            print("cerrar sesión por falta de poder.");
            usrId = '';
            bandera = 0;
            rrvalue = '';
            enviomsj = '';
            infoUsr = null;
            diverzcoin = '0';
            poderValue = '0';
            contador = 0;
            decodedData.clear();
            usuariosService.xusuarios.clear();
            //controller.dispose();
            usuariosService.usuarios.clear();
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          }
        } else {
          print(
              'Cambia tu ávatar, para mejorar tu experiencia. Desde mostrarUsr.');
          //mostrar popup
        }
        contador++;
        //cargo info únicamente el usr actual, nó de toooda la lista de usrs, con base a su id
        /*
          final decodedData = await usuariosService.xloadUsuario(usrId!);
          print('bolsa usr actual, únicamente: ${decodedData['bolsa']}.');
          */
        //ponemos el if mounted para detener el error en el widget en tiempo de ejecución.
        if (mounted) {
          // check whether the state object is in tree
          setState(() {
            // make changes here
          });
        }
        return enviomsj;
      } catch (error) {
        print("Catch en mostrarUsuario: HomeScreen. $error");
      }
    }

    xvisualizaBolsa() async {
      //lo asigno a una variable de referencia
      diverzcoin = await authService.storage.read(key: 'poderBolsa');
      if (mounted) {
        // check whether the state object is in tree
        setState(() {
          // make changes here
        });
      }
    }

    visualizaBolsa() async {
      try {
        print('Contador de visualizaBolsa, tester: $contador.');
        /*if (infoUsr.toString() != '' || infoUsr != null) {
          
          throw Exception(
              'No se tiene infoUsr del usr desde el obj principal, llega a visualizaBolsa.');
        }*/
        //1-cargo obj únicamente del usr que inicia sesión
        final decodedData = await usuariosService.xloadUsuario(usrId!);
        //aqui if(decodedData['bolsa'] != poderValue)
        poderValue = await authService.storage.read(key: 'poderBolsa');
        //print(poderValue);
        if (decodedData['bolsa'].toString() != poderValue) {
          //ésta línea ya no la ejecuta, a partir de aqui ya no ejecuta el código, arreglar ifs y quitar else.
          print(
              'IIIXXXXnfo únicamente del usr: $decodedData, desde visualizaBolsa');
          throw Exception(
              'No ha cambiado en nada los valores, no ejecuto nada. ;)');
        }
        //2-verifico que se tenga cadena de id del usr para su Bolsa
        if (decodedData['id'] != usrId) {
          throw Exception(
              "No se obtiene el id del usr. Ocupa un guardado en su perfil. Desde visualizaBolsa");
        }
        //3-verifico que tenga poder en bolsa
        if (double.parse(decodedData['bolsa'].toString()) < 1) {
          //le aplico el cierre, pero en realidad hay que enviarlo a otra página que únicamente sea informativa. sin consultas a firebase.
          print("CCCCCCCcerrar sesión por falta de poder.");
          usrId = '';
          bandera = 0;
          rrvalue = '';
          enviomsj = '';
          infoUsr = null;
          diverzcoin = '0';
          poderValue = '0';
          contador = 0;
          await authService.logout();
          await decodedData.clear();
          usuariosService.xusuarios.clear();
          //controller.dispose();
          usuariosService.usuarios.clear();
          await Navigator.pushReplacementNamed(context, 'login');
        } else {
          //4-escribo en el localStorage la info obtenida desde firebase
          //7-escribo el poder en bolsa del usr:
          await authService.storage
              .write(key: 'poderBolsa', value: '${decodedData['bolsa']}');
          //lo asigno a una variable local para referencia
          poderValue = await authService.storage.read(key: 'poderBolsa');
          //actualizo variable diverzcoin con valor real de firebase, para testing
          diverzcoin = decodedData['bolsa'];
          /*throw Exception(
              'Bolsa al salir de visualizaBolsa, diverzcoin firebase: $diverzcoin, poderValue local: $poderValue.');*/
        }
        //aqui
        //aqui pongo el código
        //poderValue = await storage.read(key: 'poderBolsa');
        //}
        /*poderValue = await storage.read(key: 'poderBolsa');
          diverzcoin = daUsr[infoUsr!].bolsa;*/
        //});
        contador++;
      } catch (e) {
        print('catch en visualizaBolsa: en HomeScreen: $e');
      }
    }

    /*visualizaBolsa() async {
      try {
        /*await Future.delayed(const Duration(seconds: 13), () async {
          usuariosService.loadUsuarios();
        });*/
        await Future.delayed(const Duration(seconds: 15), () async {
          //Las siguientes 2 líneas me sirven para obtener info del objeto USRGame para la bolsa
          infoUsr = await usuariosService.obtenerUsuario(rrvalue);
          diverzcoin = daUsr[infoUsr!].bolsa;
          if (mounted) {
            // check whether the state object is in tree
            setState(() {
              // make changes here
              if (diverzcoin!.toString() == '' ||
                  (diverzcoin!.toString() != poderValue!)) {
                usuariosService.loadUsuarios();
              }
              diverzcoin = double.parse(poderValue!);
            });
            //TODO: en teoría esta visualización de la bolsa se borra
            poderValue = await storage.read(key: 'poderBolsa');
          }
        });
        return poderValue!;
      } catch (e) {
        print(e);
      }
    }
*/
    //ejecutamos la función para mostrar usrname, mostrar usr 3de4
    //&& (diverzcoin != double.tryParse(poderValue!))
    //&& controller.text == '' || (controller.text != diverzcoin.toString())
    // || (diverzcoin != double.tryParse(poderValue!))
    /*if (rrvalue == '' ||
        enviomsj == '' ||
        diverzcoin == 0.1 ||
        infoUsr == null ||
        (diverzcoin != double.tryParse(poderValue!))) {
      mostrarusr();
    }*/
    if (infoUsr == null || bandera == 0) {
      print('entro a mostrarUSR(): bandera: $bandera');
      bandera = 1;
      Future.delayed(const Duration(seconds: 1), () async {
        await usuariosService.loadUsuarios();
        await mostrarusr();
      });
    }

    Future.delayed(const Duration(seconds: 10), () async {
      //await mostrarusr();
      //&& (diverzcoin != double.tryParse(poderValue!))
      //iniciaPrueba
      await xvisualizaBolsa();
      //termina prueba
      /*if (bandera >= 1 && (usrId != rrvalue && usrId != '')) {
        await xvisualizaBolsa();
      } else {
        print(
            'Es necesario que cambies tu ávatar, para mejorar tu experiencia. Desde visualizaBolsa.');
      }*/
    });

    //2-Temina análisis de bolsa y usr inicial
    /*if (poderValue != '') {
      print('entró al else de diverzcoin');

      if (mounted) {
        // check whether the state object is in tree
        setState(() {
          // make changes here*/

    /*  });
      }
    }*/

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
              //Imprimimos para revisar los valores del storage
              //print(await authService.storage.read(key: 'usremail'));
              //print(await authService.storage.read(key: 'idBolsa'));
              //bandera = 0;
              try {
                //aquí el código para obtener el index del usr y pintar lo correspondiente a su sesión
                bandera = 0;
                await usuariosService.loadUsuarios();

                if (infoUsr == null || infoUsr == -1) {
                  usuariosService.createUsuario(UsrGame(
                      id: rrvalue,
                      usrId: rrvalue, //validar
                      apodo: 'AVATAR',
                      avatar: 'assets/images/no-image.png', //validar
                      bolsa: 0,
                      cinvbolsa: 0,
                      //Genera un código con función random y algo que extraiga de su email
                      codigoinv:
                          '${rrvalue[0]}${getRandomString(5)}${rrvalue[1]}',
                      comisionbolsa: 0,
                      email: rrvalue,
                      masbolsa: 0,
                      menosbolsa: 0,
                      bolsaRetenida: 0,
                      ultActualizacion: formatDate(DateTime.now(),
                          [d, '/', mm, '/', yyyy, ' ', H, ':', m, ':', am]),
                      modo: 'trial',
                      padrecodigo: 'DEFAULT',
                      status: true));
                  //Aquí al final puedo lanzar un msj al usr nuevo de construyendo su perfil, intente ingresar en 1 minuto.
                } else {
                  //var usuarios = [];
                  //UsuariosService().loadUsuarios();
                  /*usuariosService =
                      Provider.of<UsuariosService>(context, listen: false);*/
                  daUsr = await UsuariosService().loadUsuarios();
                  if (mounted) {
                    setState(() {});
                  }
                  print('daUsr: ${daUsr[infoUsr!].bolsa}');
                  //usuariosService.obtenerUsuario(rrvalue);
                  //print('histogramas');
                  //infoUsr = await usuariosService.obtenerUsuario(rrvalue);
                  /*diverzcoin =
                      await authService.storage.read(key: 'poderBolsa');*/
                  /*var decodedData =
                      await usuariosService.xloadUsuario(daUsr[infoUsr!].id!);*/
                  usuariosService.selectedUsuarios = UsrGame(
                      id: daUsr[infoUsr!].id,
                      usrId: daUsr[infoUsr!].usrId, //validar
                      apodo: daUsr[infoUsr!].apodo, //validar
                      avatar: daUsr[infoUsr!].avatar, //validar
                      //bolsa: decodedData['bolsa'],
                      bolsa: daUsr[infoUsr!].bolsa,
                      cinvbolsa: daUsr[infoUsr!].cinvbolsa,
                      codigoinv: daUsr[infoUsr!].codigoinv,
                      comisionbolsa: daUsr[infoUsr!].comisionbolsa,
                      email: daUsr[infoUsr!].email,
                      masbolsa: daUsr[infoUsr!].masbolsa,
                      menosbolsa: daUsr[infoUsr!].menosbolsa,
                      bolsaRetenida: daUsr[infoUsr!].bolsaRetenida,
                      //ultActualizacion: daUsr[infoUsr!].ultActualizacion,
                      ultActualizacion: daUsr[infoUsr!].ultActualizacion,
                      modo: daUsr[infoUsr!].modo,
                      padrecodigo: daUsr[infoUsr!].padrecodigo,
                      status: daUsr[infoUsr!].status);
                  /*if (mounted) {
                    setState(() {});
                  }*/
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
              */
              print('------------------\n oprimo log out.');
              usrId = '';
              bandera = 0;
              rrvalue = '';
              enviomsj = '';
              infoUsr = null;
              diverzcoin = '0';
              poderValue = '0';
              contador = 0;
              decodedData.clear();
              usuariosService.xusuarios.clear();
              //controller.dispose();
              usuariosService.usuarios.clear();
              authService.logout();
              //bandera = 0;
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
      //backgroundColor: Colors.lightBlue.shade100,
      body: SingleChildScrollView(
        //TODO incluir en el registro el ávatar del usr
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.4, 0.9],
              colors: [
                Color.fromRGBO(192, 115, 237, 1),
                Color.fromRGBO(56, 177, 234, 1)
              ],
            )),
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
                          image: AssetImage('assets/images/no-image.png'),
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
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.blue, letterSpacing: .5),
                        color: const Color.fromRGBO(0, 38, 76, 1),
                        fontSize: 27.5),
                    children: <TextSpan>[
                      TextSpan(
                          //establecemos variable para mostrar el msj del usr, mostrar usr 4de4
                          text: enviomsj,
                          style: TextStyle(
                              fontSize: 27,
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
                const Text(
                  '\nPoder en juego',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontFamily: ,
                      fontSize: 12,
                      color: Color.fromRGBO(239, 184, 16, 0.9)),
                ),
                (diverzcoin != null)
                    ? Text(
                        'DiverZcoin: $diverzcoin \n\n\n\n\n\n',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.double,
                            color: Color.fromRGBO(239, 184, 16, 0.9)),
                      )
                    : const Text('DiverZcoin: 0 \n\n\n\n\n\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.double,
                            color: Color.fromRGBO(239, 184, 16, 0.9))),
                /*
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
                ),*/
              ],
            ),
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
                  backgroundColor: const Color.fromRGBO(200, 201, 230, 0.9),
                  title: Text(
                    "Adquiere más elementos.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(0, 38, 76, 1),
                      fontSize: 17.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const SingleChildScrollView(
                    child: Text(
                      "¡Es muy fácil! Sólo acude al oxxo de tu preferencia y realiza el aporte (a partir de 10mxn) a la siguiente cuenta: xxxx-xxxx-xxxx-xxxx, es a banco Banregio. Guarda tu comprobante (ticket), compártelo vía whatsapp al número oficial de DiverZión: \n(+52) 473-139-95-77.\n \n¡Y listo! Dentro de las próximas 2 horas, podrás adquirir víveres dentro de DiverZión para divertirte al máximo.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17, color: Color.fromRGBO(0, 38, 76, 1)),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(112, 90, 254, 0.1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Entendido",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(112, 90, 254, 1),
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                  ],
                ),
                barrierDismissible: false,
              )
            },
            tooltip: 'Recargar',
            child: const Icon(Icons.account_balance_rounded),
          ),
          FloatingActionButton(
            heroTag: "btnGames",
            onPressed: () {
              //bandera = 0;
              Navigator.push(context, _crearRuta());
            },
            tooltip: 'Games',
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
