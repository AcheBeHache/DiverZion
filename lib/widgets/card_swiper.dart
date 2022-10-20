import 'package:app_game/bloc/peticionesppt_bloc.dart';
import 'package:app_game/providers/opcionesppt_provider.dart';
import 'package:app_game/providers/partida_form_provider.dart';
import 'package:app_game/services/partidas_services.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:app_game/models/models.dart';
import 'package:provider/provider.dart';

/*import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;*/

class CardSwiper extends StatefulWidget {
  //List<String> tarjetas = ['Piedra', 'Papel', 'Tijera'];
  final List<Opcion> tarjetas;
  final PartidasServices partidaService;
  const CardSwiper(
      {Key? key, required this.tarjetas, required this.partidaService})
      : super(key: key);

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  //const CardSwiper({super.key, required this.tarjetas});
  @override
  Widget build(BuildContext context) {
    final partidaService = Provider.of<PartidasServices>(context);
    //final tarjetasProvider = Provider.of<OpcionesPPTProvider>(context);
    /*return ChangeNotifierProvider(
      //create: (_) => PartidaFormProvider(partidaService.selectedPartidas, tarjetasProvider.selectedTarjetas),
      create: (_) => PartidaFormProvider(partidaService.selectedPartidas),
      child: _PartidaScreenBody(partidaService: partidaService),
    );*/

    final partidaForm = Provider.of<PartidaFormProvider>(context);
    final partida = partidaForm.partida;

    final size = MediaQuery.of(context).size;

    if (widget.tarjetas == null || widget.tarjetas == '') {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.3,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,
      child: Swiper(
        itemCount: widget.tarjetas.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (context, int index) {
          final tarjeta = widget.tarjetas[index];
          //print('Mi length tarjeta: ${tarjeta.nombre}');
          /*final tarjeta = tarjetas[index];
          //tarjeta.id = tarjeta.id;
          print('variable1: $tarjeta');
          print("---");
          print(tarjeta.id);
          return const Text('data');*/
          return GestureDetector(
            onTap: widget.partidaService.isSaving
                ? null
                : () async {
                    if (!partidaForm.isValidForm()) return;

                    final String? imageUrl =
                        await widget.partidaService.uploadImage();

                    if (imageUrl != null) partidaForm.partida.img = imageUrl;

                    //print(imageUrl);
                    /*await widget.partidaService.saveOrCreatePartida(
                    partidaForm.partida, tarjetasProvider.selectedTarjetas);*/
                    await widget.partidaService
                        .saveOrCreatePartida(partidaForm.partida, tarjeta);
                    Navigator.pushNamed(context, 'ppt', arguments: tarjeta);
                  }
            /*widget.partidaService.isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.save_outlined);*/
            //Navigator.pushNamed(context, 'ppt', arguments: tarjeta);
            ,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/no-image.png'),
                image: NetworkImage(tarjeta.img),
                //image: AssetImage('assets/images/no-image.png'),
                fit: BoxFit.cover,
              ),
            ),
          );
          //return tarjeta.id;
          /*return Hero(
            tag: tarjeta.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/no-image.png'),
                image: NetworkImage(tarjeta.img),
                //image: AssetImage('assets/images/no-image.png'),
                fit: BoxFit.cover,
              ),
            ),
          );*/
          /*final movie = tarjetas[index];

          movie.heroId = 'swiper-${ movie.id }';

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/no-image.jpg'),
                  image: NetworkImage( movie.fullPosterImg ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );*/
        },
      ),
    );
  }
}
