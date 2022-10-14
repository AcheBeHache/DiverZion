//import 'package:app_game/bloc/peticionesppt_bloc.dart';
import 'package:app_game/models/models.dart';
//import 'package:app_game/services/services.dart';
import 'package:flutter/material.dart';
//import 'package:app_game/models/models.dart';

class PartidasCard extends StatefulWidget {
  final Ppt partida;

  const PartidasCard({super.key, required this.partida});

  @override
  State<PartidasCard> createState() => _PartidasCardState();
}

class _PartidasCardState extends State<PartidasCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(widget.partida.img),

            _ProductDetails(
              finicio: widget.partida.fechainicio,
              ffin: widget.partida.fechafin,
              creador: widget.partida.usridCreador,
            ),

            Positioned(
                top: 0,
                right: 0,
                child: _PriceTag(widget.partida.montototal.toDouble())),
            //para no disponible, en partida actualmente.
            if (widget.partida.status == 2)
              Positioned(top: 0, left: 0, child: _NotAvailable()),
            //para disponible, listo para el juego.
            if (widget.partida.status == 1)
              Positioned(top: 0, left: 0, child: _Available()),
            //para marcar partidas finalizadas, en juego, no disponibles.
            if (widget.partida.status == 3)
              Positioned(top: 0, left: 0, child: _Termino()),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _NotAvailable extends StatefulWidget {
  @override
  State<_NotAvailable> createState() => _NotAvailableState();
}

class _NotAvailableState extends State<_NotAvailable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'En partida',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _Available extends StatefulWidget {
  @override
  State<_Available> createState() => _AvailableState();
}

class _AvailableState extends State<_Available> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _Termino extends StatefulWidget {
  @override
  State<_Termino> createState() => _TerminoState();
}

class _TerminoState extends State<_Termino> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Finalizó',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _PriceTag extends StatefulWidget {
  final double price;

  const _PriceTag(this.price);

  @override
  State<_PriceTag> createState() => _PriceTagState();
}

class _PriceTagState extends State<_PriceTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('\$${widget.price}',
                style: const TextStyle(color: Colors.white, fontSize: 20))),
      ),
    );
  }
}

class _ProductDetails extends StatefulWidget {
  final String finicio;
  final String? ffin;
  final String creador;

  const _ProductDetails(
      {required this.finicio, this.ffin, required this.creador});

  @override
  State<_ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<_ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lanzamiento: ${widget.finicio}',
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Cierre: ${widget.ffin}',
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
            Text(
              'vs granja de: ${widget.creador}',
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackgroundImage extends StatefulWidget {
  final String? url;

  const _BackgroundImage(this.url);

  @override
  State<_BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<_BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: widget.url == null
            ? const Image(
                image: AssetImage('assets/images/no-image.png'),
                fit: BoxFit.cover)
            : FadeInImage(
                placeholder: const AssetImage('assets/images/jar-loading.gif'),
                image: NetworkImage(widget.url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
