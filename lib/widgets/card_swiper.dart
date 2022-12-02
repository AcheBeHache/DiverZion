//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/providers/opcionesppt_provider.dart';
import 'dart:async';

import 'package:app_game/providers/partida_form_provider.dart';
//import 'package:app_game/screens/partida_pptscreen.dart';
//import 'package:app_game/services/partidas_services.dart';
import 'package:app_game/services/services.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:app_game/models/models.dart';
import 'package:provider/provider.dart';
/*int _counter = 13;
  Timer? _timer;*/

/*import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;*/

class CardSwiper extends StatefulWidget {
  //List<String> tarjetas = ['Piedra', 'Papel', 'Tijera'];
  final List<Opcion> tarjetas;
  final PartidasServices partidaService;
  final UsuariosService usuariosLista;
  const CardSwiper(
      {Key? key,
      required this.tarjetas,
      required this.partidaService,
      required this.usuariosLista})
      : super(key: key);

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  //const CardSwiper({super.key, required this.tarjetas});
  String enviousrcreador = '';
  String idBolsaS = '';
  int usuario = 0;

  @override
  Widget build(BuildContext context) {
    //final partidaService = Provider.of<PartidasServices>(context);
    //creamos una instancia para utilizar el localstorage, mostrar usr 1de4
    final authService = Provider.of<AuthService>(context, listen: false);
    final usuariosService = Provider.of<UsuariosService>(context);

    //2 de 4
    mostrarusr() async {
      try {
        String? rrvalue = await authService.storage.read(key: 'usremail');
        enviousrcreador = rrvalue!;
        usuario = await usuariosService.obtenerUsuario(enviousrcreador);
        //print('usuario: $usuario');
        String? bolsaValue = await authService.storage.read(key: 'idBolsa');
        idBolsaS = bolsaValue!;
        //print('valor del idBolsa, enviado en el card: $idBolsaS');
      } catch (e) {
        print('Error en función mostrarusr: $e');
      }
      return enviousrcreador;
    }

    //3de4 para mostrar usr
    mostrarusr();
    //final tarjetasProvider = Provider.of<OpcionesPPTProvider>(context);
    /*return ChangeNotifierProvider(
      //create: (_) => PartidaFormProvider(partidaService.selectedPartidas, tarjetasProvider.selectedTarjetas),
      create: (_) => PartidaFormProvider(partidaService.selectedPartidas),
      child: _PartidaScreenBody(partidaService: partidaService),
    );*/

    final partidaForm = Provider.of<PartidaFormProvider>(context);
    final partida = partidaForm.partida;

    //print(usuariosService.);
    final usuariosLista = usuariosService.usuarios[usuario];
    //print('usuario: ${usuariosLista.email}');
    //print('usuarioLista enviado: $usuariosLista');
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

                    if (imageUrl != null || imageUrl != '') {
                      partida.img = imageUrl;
                    }

                    //print(imageUrl);
                    /*await widget.partidaService.saveOrCreatePartida(
                    partidaForm.partida, tarjetasProvider.selectedTarjetas);*/
                    //considera 2 móviles iniciando de 0 sin respuesta alguna, validar ésta parte

                    /*Future.delayed(const Duration(seconds: 2), () async {
                      /*await widget.partidaService
                          .saveOrCreatePartida(partidaForm.partida, tarjeta);*/

                      await widget.partidaService.updateTarjeta(
                          partidaForm.partida, tarjeta, enviousrcreador);

                      /*setState(() {});
                      Navigator.pushNamed(context, 'ppt', arguments: tarjeta);*/
                    });*/

                    //micodigo
                    //Antes de crear/apartar partida se valida que se tenga efectivo en la bolsa
                    //se le indica con un snackbar que tiene o no saldo
                    if (partida.id == null || partida.id == '') {
                      await widget.partidaService.saveOrCreatePartida(partida);
                    }
                    //do del creador
                    //Antes de crear partida se valida que se tenga efectivo en la bolsa
                    //se le indica con un snackbar que tiene o no saldo
                    if (partida.usridcreador == enviousrcreador) {
                      if (partida.respcreador == null ||
                          partida.respcreador == '') {
                        await widget.partidaService.updateTarjeta(
                            partida,
                            tarjeta,
                            enviousrcreador,
                            idBolsaS,
                            usuariosLista,
                            1);
                        Future.delayed(const Duration(seconds: 2), () async {
                          //print('usuario enviado: ${usuariosLista.email}');
                          await widget.partidaService.updateTarjeta(
                              partida,
                              tarjeta,
                              enviousrcreador,
                              idBolsaS,
                              usuariosLista,
                              2);
                        });
                        /*if (_counter >= 0) {
                          //print("Último número: $_counter");
                          _counter = 13;
                          _timer?.cancel();
                        } else {
                          //print("Último número: $_counter");
                          _timer?.cancel();
                        }*/
                      }
                    }
                    //apartar partida
                    //Antes de apartar partida se valida que se tenga efectivo en la bolsa
                    //se le indica con un snackbar que tiene o no saldo
                    //TODO: ApartaPartidaComenté
                    /*if ((partida.usridcreador != '' &&
                            partida.usridcreador != enviousrcreador) &&
                        partida.usridoponente == '') {
                      await widget.partidaService
                          .apartaPartida(partida, tarjeta, enviousrcreador);
                    }*/
                    //do del oponente
                    if (partida.usridoponente == enviousrcreador) {
                      do {
                        //Future.delayed(const Duration(seconds: 4), () async {
                        if ((partida.respoponente == null ||
                                partida.respoponente == '') &&
                            partida.respcreador != '') {
                          await widget.partidaService.updateTarjeta(
                              partida,
                              tarjeta,
                              enviousrcreador,
                              idBolsaS,
                              usuariosLista,
                              1);
                          //if(partida.respoponente == null || partida.respoponente == ''){
                          Future.delayed(const Duration(seconds: 2), () async {
                            await widget.partidaService.updateTarjeta(
                                partida,
                                tarjeta,
                                enviousrcreador,
                                idBolsaS,
                                usuariosLista,
                                2);
                          }); //}
                        } else {
                          //implementar un msj en gui de espere, deshabilitando el botón de enviar respuesta...
                          print("Espere...");
                        }
                        //});
                      } while ((partida.respoponente == '' &&
                          partida.respcreador != ''));
                    }
                    Future.delayed(const Duration(seconds: 6), () async {
                      //setState(() {});
                      //print("se tienen ambas respuestas, redirigiendo---");
                      /*Navigator.pushNamed(context, 'ppt',
                          arguments: [partida, tarjeta]);*/
                      Navigator.pushNamed(context, 'ppt', arguments: partida);
                    });
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
