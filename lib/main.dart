//import 'package:app_game/services/notifications_service.dart';
import 'package:app_game/providers/opcionesppt_provider.dart';
import 'package:app_game/screens/pagina1.dart';
//import 'package:app_game/providers/usuarios_form_provider.dart';
import 'package:app_game/screens/pagina3.dart';
import 'package:app_game/screens/partida_pptscreen.dart';
import 'package:app_game/screens/partida_screen.dart';
import 'package:app_game/screens/partidas_ppt.dart';
//import 'package:app_game/screens/usuarios_screen.dart';
//import 'package:app_game/screens/perfilusr_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:app_game/screens/ppt.dart';
import 'package:app_game/screens/screens.dart';
import 'package:app_game/services/services.dart';
import 'package:app_game/navigator_key.dart';

//import 'package:app_game/screens/home_screen.dart';

void main() {
  //Tengo que agregar la licencia de mi tipografía Montserrat
  /*LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });*/
  runApp(AppState());
}

class AppState extends StatefulWidget {
  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PartidasServices()),
        ChangeNotifierProvider(create: (_) => OpcionesPPTProvider()),
        ChangeNotifierProvider(create: (_) => UsuariosService()),
        //ChangeNotifierProvider(create: (_) => UsuariosFormProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App (usrs: xx)',
      navigatorKey: navigatorKey,
      initialRoute: 'login',
      routes: {
        'checking': (_) => CheckAuthScreen(),
        'home': (_) => const HomeScreen(),
        'ppt': (_) => const PPT(),
        'partidas_ppt': (_) => const PARTIDASPPT(),
        'login': (_) => const LoginScreen(),
        'register': (_) => RegisterScreen(),
        'pagina3': (_) => Pagina3(),
        'partida': (_) => PartidaScreen(),
        'pptpartida': (_) => PartidaPPTScreen(),
        'perfil': (_) => const UsuariosScreen(),
        'momentos': (_) => Pagina1(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          //brightness: Brightness.dark,
          //primaryColor: Colors.red,
          /*inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.greenAccent),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.amberAccent),
            ),
          ),*/
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: const Color.fromRGBO(251, 160, 254, 0.9),
          appBarTheme: const AppBarTheme(
              elevation: 0, color: Color.fromRGBO(112, 90, 254, 1)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromRGBO(112, 90, 254, 1), elevation: 0),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan[600])),
    );
  }
}
