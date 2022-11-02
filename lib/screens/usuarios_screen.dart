//import 'package:app_game/bloc/peticionesppt_bloc.dart';
//import 'package:app_game/models/models.dart';
//import 'package:app_game/screens/screens.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:app_game/models/models.dart';
//import 'package:app_game/providers/opcionesppt_provider.dart';
//import 'package:app_game/providers/partida_form_provider.dart';
import 'package:app_game/providers/usuarios_form_provider.dart';
import 'package:app_game/services/services.dart';
import 'package:app_game/ui/input_decorations.dart';
//import 'package:app_game/widgets/card_swiper.dart';
import 'package:app_game/widgets/widgets.dart';
//import 'package:app_game/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

//color textos deshabilitados
TextStyle deshabilitarTxts =
    const TextStyle(fontSize: 13, color: Color.fromARGB(255, 228, 226, 226));
//msjito del modo manual/automático
//String mensajito = 'manual';
late UsrGame selectedUsuarios;

class UsuariosScreen extends StatefulWidget {
  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuariosService>(context);

    return ChangeNotifierProvider(
      //create: (_) => PartidaFormProvider(
      //partidaService.selectedPartidas, partidaService.selectedUsuarios),
      create: (_) => UsuariosFormProvider(usuarioService.selectedUsuarios),
      child: _UsuarioScreenBody(usuarioService: usuarioService),
    );
  }
}

class _UsuarioScreenBody extends StatefulWidget {
  const _UsuarioScreenBody({
    Key? key,
    required this.usuarioService,
  }) : super(key: key);

  final UsuariosService usuarioService;

  @override
  State<_UsuarioScreenBody> createState() => _UsuarioScreenBodyState();
}

class _UsuarioScreenBodyState extends State<_UsuarioScreenBody> {
  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuariosService>(context);
    final usuarioForm = Provider.of<UsuariosFormProvider>(context);
    final perfil = usuarioForm.perfilusr;
    /*final partidaForm = Provider.of<PartidaFormProvider>(context);
    final partida = partidaForm.partida;*/
    return Scaffold(
      appBar: AppBar(
        title: const Text('usrPersonaliza tu partida...'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 90.0, horizontal: 10.20),
          child: Column(
            children: [
              Stack(
                children: [
                  UsuariosImage(url: usuarioService.selectedUsuarios.avatar),
                  Positioned(
                      top: 60,
                      left: 20,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios_new,
                            size: 40, color: Colors.white),
                      )),
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

                          usuarioService
                              .updateSelectedPartidaImage(pickedFile.path);
                        },
                        icon: const Icon(Icons.camera_alt_outlined,
                            size: 40, color: Colors.white),
                      ))
                ],
              ),
              _UsuarioForm(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        //ejemplo para comenzar a emparejar partida con otro oponente: select, update, etc...
        onPressed: usuarioService.isSaving
            ? null
            : () async {
                if (!usuarioForm.isValidForm()) return;

                final String? imageUrl = await usuarioService.uploadImage();

                if (imageUrl != null) usuarioForm.perfilusr.avatar = imageUrl;

                //print(imageUrl);
                //TODO: Descomentar Necesario
                await usuarioService.saveOrCreateUsuario(perfil);

                //1de3-Para poner contexto para navegar entre rutas al editar las cards
                /*await partidaService.saveOrCreatePartida(
                    context, partidaForm.partida);*/
              },
        child: usuarioService.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _UsuarioForm extends StatefulWidget {
  @override
  State<_UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<_UsuarioForm> {
  @override
  Widget build(BuildContext context) {
    final usuarioForm = Provider.of<UsuariosFormProvider>(context);
    final usuario = usuarioForm.perfilusr;
    //para info usr
    final perfil = Provider.of<UsuariosService>(context);
    //final usuario = perfil.selectedUsuarios;
    print('usuariodatos: $perfil');
    //Obtengo info del usuario del provider Usuario
    //print(usuario[0].usrId);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: usuarioForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              /*Agregar campo de última modificación
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
              ),*/
              const SizedBox(height: 30),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: usuario.padrecodigo,
                onChanged: (value) => usuario.padrecodigo,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'códigoPadre', labelText: 'Padre Código: '),
              ),
              const SizedBox(height: 30),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: usuario.codigoinv,
                onChanged: (value) => usuario.codigoinv,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'código', labelText: 'Código Invitación: '),
              ),
              const SizedBox(height: 30),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: usuario.modo,
                onChanged: (value) => usuario.modo,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'modo', labelText: 'Modo: '),
              ),
              //TODO: mostrar el monto en bolsa actual, y que el usr visualice el monto en tiempo real cada que cree partida.
              const SizedBox(height: 10),
              TextFormField(
                initialValue: usuario.email,
                onChanged: (value) => usuario.email = value,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'email', labelText: 'Email: '),
              ),
              const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: usuario.usrId,
                onChanged: (value) => usuario.usrId = value,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'usridFirebase', labelText: 'Usuario: '),
              ),
              const SizedBox(height: 30),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: '${perfil.selectedUsuarios.bolsa}',
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    //TODO: verificar que el usr tenga poder en su granja
                    perfil.selectedUsuarios.bolsa = 0;
                  } else {
                    perfil.selectedUsuarios.bolsa = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Rango del 1 al 99',
                    labelText: 'Poder en juego:'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: '${usuario.cinvbolsa}',
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    //TODO: verificar que el usr tenga poder en su granja
                    perfil.selectedUsuarios.cinvbolsa = 0;
                  } else {
                    perfil.selectedUsuarios.cinvbolsa = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Rango del 1 al 99',
                    labelText: 'Poder ganado por invitaciones:'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: '${usuario.comisionbolsa}',
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    //TODO: verificar que el usr tenga poder en su granja
                    perfil.selectedUsuarios.comisionbolsa = 0;
                  } else {
                    perfil.selectedUsuarios.comisionbolsa = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Rango del 1 al 99',
                    labelText: 'Comisión retenida por ganes:'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: '${usuario.masbolsa}',
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    //TODO: verificar que el usr tenga poder en su granja
                    perfil.selectedUsuarios.masbolsa = 0;
                  } else {
                    perfil.selectedUsuarios.masbolsa = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Máximo 300 al día',
                    labelText: 'Ganado del día en bolsa:'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                enabled: false,
                style: deshabilitarTxts,
                initialValue: '${usuario.menosbolsa}',
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    //TODO: verificar que el usr tenga poder en su granja
                    perfil.selectedUsuarios.menosbolsa = 0;
                  } else {
                    perfil.selectedUsuarios.menosbolsa = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Máximo 80 al día',
                    labelText: 'Pérdida al día en bolsa:'),
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                  //NO APLICA - enabled: false,
                  //TODO: falta habilitar en automatico, que muestre las tarjetasw para seleccionar o bien, un random que lo asigne dicho sistema.
                  value: usuario.status,
                  //title: Text('Modo: ${partida.modojuego}'),
                  title: const Text('Status del usr:'),
                  subtitle: Text('${usuario.status}.'),
                  activeColor: Colors.indigo,
                  onChanged: usuarioForm.updateStatus),
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
