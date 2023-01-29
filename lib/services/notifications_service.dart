import 'package:flutter/material.dart';
import 'package:app_game/navigator_key.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      //dismissDirection: DismissDirection.up,
      backgroundColor: const Color.fromRGBO(0, 38, 76, 0.6),
      content: Text(message,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle: GoogleFonts.montserrat(fontSize: 18.5),
            color: const Color.fromRGBO(239, 184, 16, 0.7),
          )),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
