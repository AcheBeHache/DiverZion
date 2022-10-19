import 'package:flutter/material.dart';

class AuthBackground extends StatefulWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  State<AuthBackground> createState() => _AuthBackgroundState();
}

class _AuthBackgroundState extends State<AuthBackground> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.amber,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _AmberBox(),
          _HeaderIconLogin(),
          widget.child,
        ],
      ),
    );
  }
}

class _HeaderIconLogin extends StatefulWidget {
  @override
  State<_HeaderIconLogin> createState() => _HeaderIconLoginState();
}

class _HeaderIconLoginState extends State<_HeaderIconLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}

class _AmberBox extends StatefulWidget {
  @override
  State<_AmberBox> createState() => _AmberBoxState();
}

class _AmberBoxState extends State<_AmberBox> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: amberDecoration(),
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: _Bubble()),
          Positioned(top: -40, left: 30, child: _Bubble()),
          Positioned(top: -50, right: -20, child: _Bubble()),
          Positioned(bottom: -50, left: 10, child: _Bubble()),
          Positioned(bottom: 120, right: 20, child: _Bubble())
        ],
      ),
    );
  }

  BoxDecoration amberDecoration() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]));
}

class _Bubble extends StatefulWidget {
  @override
  State<_Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<_Bubble> {
  //const _Bubble({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
