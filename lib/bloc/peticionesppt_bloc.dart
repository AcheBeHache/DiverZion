const juegosGrales = ['ppt', 'carreras', 'rayuela', 'disparejo', 'volado'];

class PeticionesPPTBloc {
  Stream get getJuegos async* {
    final List<String> juegos = [];
    for (String juego in juegosGrales) {
      await Future.delayed(const Duration(seconds: 2));
      juegos.add(juego);
      yield juegos;
    }
  }
}
