import 'dart:io';

import 'package:flutter/material.dart';

class UsuariosImage extends StatefulWidget {
  final String? url;

  const UsuariosImage({Key? key, this.url}) : super(key: key);

  @override
  State<UsuariosImage> createState() => _UsuariosImageState();
}

class _UsuariosImageState extends State<UsuariosImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
              child: getImage(widget.url)),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]);

  Widget getImage(String? picture) {
    if (picture == null) {
      return const Image(
        //Aquí se cambia la img grande al crear una partida
        //image: AssetImage('assets/images/no-image.png'),
        image: AssetImage('assets/images/ppt2.JPG'),
        fit: BoxFit.cover,
      );
    }

    if (picture.startsWith('http')) {
      return FadeInImage(
        image: NetworkImage(widget.url!),
        placeholder: const AssetImage('assets/images/jar-loading.gif'),
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
