import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(112, 90, 254, 1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromRGBO(192, 115, 237, 1), width: 2),
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.white) : null);
  }
}
