import 'package:flutter/material.dart';

class CardContainer extends StatefulWidget {
  const CardContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: _createCardShape(),
        child: widget.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
          color: const Color.fromRGBO(249, 249, 249, 0.6),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}
