//import 'dart:math';

import 'package:app_game/screens/pagina1.dart';
import 'package:app_game/services/services.dart';
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
  @override
  Widget build(BuildContext context) {
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
      String? rrvalue = await authService.storage.read(key: 'usremail');
      /*obtenemos el nombre del usuario tomando como referencia su email, lo que va antes del @ con split:
      ${rrvalue!.split('@')[0]}*/
      /* Obtenemos la primera letra y la convertimos en mayúscula:
        ${rrvalue![0].toUpperCase()}${rrvalue.substring(1)}
      */
      enviomsj =
          '\n${rrvalue![0].toUpperCase()}${rrvalue.substring(1).split('@')[0]}';
      //print(enviomsj);
      setState(() {});
      return enviomsj;
    }

    //ejecutamos la función para mostrar usrname, mostrar usr 3de4
    mostrarusr();
    //const storage = FlutterSecureStorage();
    return Scaffold(
      //backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('DiverZión - Almacén'),
        elevation: 8.0,
        //Para poner el icono de logout en la parte derecha, class254min1:19
        /*actions: [IconButton(
          onPressed: (){}), 
          icon: const Icon(Icons.logout_rounded)),
          ),]*/
        leading: IconButton(
            onPressed: () async {
              /*String? value = await authService.storage.read(key: 'usremail');
              print(value);
              String? xvalue = await AuthService().readEmail();
              print('xvalue: ' + xvalue);
              print(mostrarusr().toString());
              authService.logout();*/
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: const Icon(Icons.logout_rounded)),
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
