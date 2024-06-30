import '../pages/ranking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Jugador> deportesRef;
  late final CollectionReference<Jugador> paisesRef;
  late final CollectionReference<Jugador> frutasRef;
  late final CollectionReference<Jugador> generalRef;
  late final CollectionReference<Jugador> animalesRef;

  DataBaseService() {
    deportesRef = _firestore.collection("Deportes").withConverter<Jugador>(
        fromFirestore: (snapshots, _) => Jugador.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (jugador, _) => jugador.toJson());

    animalesRef = _firestore.collection("Animales").withConverter<Jugador>(
        fromFirestore: (snapshots, _) => Jugador.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (jugador, _) => jugador.toJson());

    frutasRef = _firestore.collection("Frutas").withConverter<Jugador>(
        fromFirestore: (snapshots, _) => Jugador.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (jugador, _) => jugador.toJson());

    paisesRef = _firestore.collection("Paises").withConverter<Jugador>(
        fromFirestore: (snapshots, _) => Jugador.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (jugador, _) => jugador.toJson());

    generalRef = _firestore.collection("General").withConverter<Jugador>(
        fromFirestore: (snapshots, _) => Jugador.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (jugador, _) => jugador.toJson());
  }

  Stream<QuerySnapshot<Jugador>> getDataBase(String? genero) {
    switch (genero) {
      case "Deportes":
        return deportesRef.orderBy('puntaje', descending: true).snapshots();
      case "General":
        return generalRef.orderBy('puntaje', descending: true).snapshots();
      case "Paises":
        return paisesRef.orderBy('puntaje', descending: true).snapshots();
      case "Frutas":
        return frutasRef.orderBy('puntaje', descending: true).snapshots();
      default:
        return animalesRef.orderBy('puntaje', descending: true).snapshots();
    }
  }

  void addJugador(Jugador jugador, String genero) async {
    switch (genero) {
      case "Deportes":
        deportesRef.add(jugador);
        break;
      case "General":
        generalRef.add(jugador);
        break;
      case "Paises":
        paisesRef.add(jugador);
        break;
      case "Frutas":
        frutasRef.add(jugador);
        break;
      case "Animales":
        animalesRef.add(jugador);
        break;
    }
  }
}

