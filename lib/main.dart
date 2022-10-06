//import 'package:app_game/services/notifications_service.dart';
import 'package:app_game/screens/pagina3.dart';
import 'package:app_game/screens/partidas_ppt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:app_game/screens/ppt.dart';
import 'package:app_game/screens/screens.dart';
import 'package:app_game/services/services.dart';

//import 'package:app_game/screens/home_screen.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PartidasServices()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App (usrs: xx)',
      initialRoute: 'login',
      routes: {
        'checking': (_) => CheckAuthScreen(),
        'home': (_) => const HomeScreen(),
        'ppt': (_) => const PPT(),
        'partidas_ppt': (_) => const PARTIDASPPT(),
        'login': (_) => const LoginScreen(),
        'register': (_) => RegisterScreen(),
        'pagina3': (_) => Pagina3(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
    );
  }
}
