import 'package:app_game/services/partidas_services.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:app_game/models/models.dart';

/*import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;*/

class CardSwiper extends StatelessWidget {
  //List<String> tarjetas = ['Piedra', 'Papel', 'Tijera'];
  final List<Opcion> tarjetas;

  const CardSwiper({Key? key, required this.tarjetas}) : super(key: key);

  //const CardSwiper({super.key, required this.tarjetas});

  //CardSwiper({Key? key, required this.tarjetas}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (tarjetas == null || tarjetas == '') {
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
        itemCount: tarjetas.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (context, int index) {
          final tarjeta = tarjetas[index];
          /*final tarjeta = tarjetas[index];
          //tarjeta.id = tarjeta.id;
          print('variable1: $tarjeta');
          print("---");
          print(tarjeta.id);
          return const Text('data');*/
          return FadeInImage(
            placeholder: const AssetImage('assets/images/no-image.png'),
            image: NetworkImage(tarjeta.img),
            //image: AssetImage('assets/images/no-image.png'),
            fit: BoxFit.cover,
          );
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
