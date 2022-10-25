//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/models/models.dart';
//import 'package:app_game/screens/screens.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:app_game/providers/partida_form_provider.dart';
import 'package:app_game/services/services.dart';
import 'package:app_game/ui/input_decorations.dart';
import 'package:app_game/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//color textos deshabilitados
TextStyle deshabilitarTxts =
    const TextStyle(fontSize: 13, color: Color.fromARGB(255, 228, 226, 226));
//msjito del modo manual/automático
//String mensajito = 'manual';

class PartidaScreen extends StatefulWidget {
  @override
  State<PartidaScreen> createState() => _PartidaScreenState();
}

class _PartidaScreenState extends State<PartidaScreen> {
  @override
  Widget build(BuildContext context) {
    final partidaService = Provider.of<PartidasServices>(context);

    return ChangeNotifierProvider(
      create: (_) => PartidaFormProvider(partidaService.selectedPartidas),
      child: _PartidaScreenBody(partidaService: partidaService),
    );
  }
}

class _PartidaScreenBody extends StatefulWidget {
  const _PartidaScreenBody({
    Key? key,
    required this.partidaService,
  }) : super(key: key);

  final PartidasServices partidaService;

  @override
  State<_PartidaScreenBody> createState() => _PartidaScreenBodyState();
}

class _PartidaScreenBodyState extends State<_PartidaScreenBody> {
  @override
  Widget build(BuildContext context) {
    final partidaForm = Provider.of<PartidaFormProvider>(context);
    //final partida = partidaForm.partida;
    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                PartidaImage(url: widget.partidaService.selectedPartidas.img),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white),
                    )),
                /*Descomentar para permitir al usr cargar una fotografía
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final PickedFile? pickedFile = await picker.getImage(
                            //source: ImageSource.gallery,
                            source: ImageSource.camera,
                            imageQuality: 100);

                        if (pickedFile == null || pickedFile == '') {
                          print('Archivo null o vacío.');
                          return;
                        }

                        widget.partidaService
                            .updateSelectedPartidaImage(pickedFile.path);
                      },
                      icon: const Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.white),
                    ))*/
              ],
            ),
            _PartidaForm(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        //ejemplo para comenzar a emparejar partida con otro oponente: select, update, etc...
        onPressed: widget.partidaService.isSaving
            ? null
            : () async {
                if (!partidaForm.isValidForm()) return;

                final String? imageUrl =
                    await widget.partidaService.uploadImage();

                if (imageUrl != null) partidaForm.partida.img = imageUrl;

                //print(imageUrl);
                //TODO: Descomentar Necesario
                /*await widget.partidaService
                    .saveOrCreatePartida(partidaForm.partida);*/

                //1de3-Para poner contexto para navegar entre rutas al editar las cards
                /*await partidaService.saveOrCreatePartida(
                    context, partidaForm.partida);*/
              },
        child: widget.partidaService.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _PartidaForm extends StatefulWidget {
  @override
  State<_PartidaForm> createState() => _PartidaFormState();
}

class _PartidaFormState extends State<_PartidaForm> {
  @override
  Widget build(BuildContext context) {
    final partidaForm = Provider.of<PartidaFormProvider>(context);
    final partida = partidaForm.partida;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: partidaForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: partida.fechainicio,
                onChanged: (value) => partida.fechainicio = value,
                validator: (value) {
                  //if (value == null || value.length < 1) {
                  if (value == null || value.isEmpty) {
                    return 'La fecha de inicio es obligatoria.';
                  }
                  //añadí el return null
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'YYYY/MM/DD', labelText: 'Creación:'),
              ),
              /*const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: partida.fechafin,
                onChanged: (value) => partida.fechafin = value,
                validator: (value) {
                  //if (value == null || value.length < 1) {
                  if (value == null || value.isEmpty) {
                    return 'La fecha de fin es obligatoria.';
                  }
                  //añadí el return null
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'YYYY/MM/DD', labelText: 'Fecha Fin:'),
              ),*/
              /*const SizedBox(height: 10),
              TextFormField(
                initialValue: partida.id,
                onChanged: (value) => partida.id = value,
                //validator: (value) {
                //if (value == null || value.length < 1) {
                /*if (value == null || value.isEmpty) {
                    return 'El id es obligatorio.';
                  }*/
                //añadí el return null
                //return null;
                //},
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'idDeFirebase', labelText: 'Id: '),
              ),*/
              /*const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: '${partida.oponentes}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      //RegExp(r'^(\d+)?\.?\d{0,2}'))
                      RegExp(r'^([1-5])$'))
                ],
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    partida.oponentes = 1;
                  } else {
                    partida.oponentes = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '#', labelText: 'Oponentes: '),
              ),*/
              /*MUESTRA const SizedBox(height: 10),
              TextFormField(
                initialValue: partida.modojuego,
                onChanged: (value) => partida.modojuego = value,
                validator: (value) {
                  //if (value == null || value.length < 1) {
                  if (value == null || value.isEmpty) {
                    return 'El modo juego es obligatorio';
                  }
                  //añadí el return null
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Manual/Automático', labelText: 'Modo Juego:'),
              ),*/
              const SizedBox(height: 30),
              TextFormField(
                initialValue: '${partida.montototal}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      //RegExp(r'^(\d+)?\.?\d{0,2}'))
                      RegExp(r'^[1-9]|[0-9]?$'))
                ],
                onChanged: (value) {
                  if (int.tryParse(value) == null || int.tryParse(value) == 0) {
                    //TODO: verificar que el usr tenga poder en su granja
                    partida.montototal = 1;
                  } else {
                    partida.montototal = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Rango del 1 al 99',
                    labelText: 'Poder en juego:'),
              ),
              /*const SizedBox(height: 30),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: '${partida.status}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      //RegExp(r'^(\d+)?\.?\d{0,2}'))
                      RegExp(r'^([1-3])$'))
                ],
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    partida.status = 1;
                  } else {
                    partida.status = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '1', labelText: 'Status:'),
              ),*/
              const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: partida.usridcreador,
                onChanged: (value) => partida.usridcreador = value,
                validator: (value) {
                  //if (value == null || value.length < 1) {
                  if (value == null || value.length < 1) {
                    return 'El usrid es obligatorio.';
                  }
                  //añadí el return null
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'usridDeFirebase', labelText: 'Creadora/or: '),
              ),
              const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: partida.usridoponente,
                onChanged: (value) => partida.usridoponente = value,
                /*validator: (value) {
                  //if (value == null || value.length < 1) {
                  if (value == null || value.length < 1) {
                    return 'El usridnowin es obligatorio.';
                  }
                  //añadí el return null
                  return null;
                },*/
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'usridOponenteLocalStorage',
                    labelText: 'Oponente: '),
              ),
              const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: partida.usridwin,
                onChanged: (value) => partida.usridwin = value,
                /*validator: (value) {
                  //if (value == null || value.length < 1) {
                  if (value == null || value.length < 1) {
                    return 'El usridwin es obligatorio.';
                  }
                  //añadí el return null
                  return null;
                },*/
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'usridwinDeFirebase',
                    labelText: 'Recibe poder: '),
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                  //NO APLICA - enabled: false,
                  //TODO: falta habilitar el timeReal del modo
                  value: partida.modojuego,
                  //title: Text('Modo: ${partida.modojuego}'),
                  title: const Text('Activar modo automático:'),
                  subtitle: Text('${partida.modojuego}.'),
                  activeColor: Colors.indigo,
                  onChanged: partidaForm.updateModojuego),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
