import '../pages/ranking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{
   final _firestore = FirebaseFirestore.instance;
   late final CollectionReference deportesRef;
   late final CollectionReference paisesRef;
   late final CollectionReference frutasRef;
   late final CollectionReference generalRef;
   late final CollectionReference animalesRef;
   
   DataBaseService(){
     deportesRef = _firestore.collection("Deportes").withConverter<Jugador>(
         fromFirestore: (snapshots, _) => Jugador.fromJson(
           snapshots.data()!,
         ),
         toFirestore: (Jugador, _) => Jugador.toJson());

     animalesRef = _firestore.collection("Animales").withConverter<Jugador>(
         fromFirestore: (snapshots, _) => Jugador.fromJson(
           snapshots.data()!,
         ),
         toFirestore: (Jugador, _) => Jugador.toJson());

     frutasRef = _firestore.collection("Frutas").withConverter<Jugador>(
         fromFirestore: (snapshots, _) => Jugador.fromJson(
           snapshots.data()!,
         ),
         toFirestore: (Jugador, _) => Jugador.toJson());
     paisesRef = _firestore.collection("Paises").withConverter<Jugador>(
         fromFirestore: (snapshots, _) => Jugador.fromJson(
           snapshots.data()!,
         ),
         toFirestore: (Jugador, _) => Jugador.toJson());

     generalRef = _firestore.collection("General").withConverter<Jugador>(
         fromFirestore: (snapshots, _) => Jugador.fromJson(
           snapshots.data()!,
         ),
         toFirestore: (Jugador, _) => Jugador.toJson());
   }


   Stream<QuerySnapshot> getDataBase(String? genero){

     switch (genero){
       case "Deportes": return deportesRef.orderBy('puntaje', descending: true).snapshots();
       case "General" : return generalRef.orderBy('puntaje', descending: true).snapshots();
       case "Paises" : return paisesRef.orderBy('puntaje', descending: true).snapshots();
       case "Frutas" : return frutasRef.orderBy('puntaje', descending: true).snapshots();
       default : return animalesRef.orderBy('puntaje', descending: true).snapshots();
     }
   }

   void addJugador(Jugador jugador, String genero) async{

     switch (genero){
       case "Deportes": deportesRef.add(jugador);
       break;
       case "General" : generalRef.add(Jugador);
       break;
       case "Paises" : paisesRef.add(Jugador);
       break;
       case "Frutas" : frutasRef.add(Jugador);
       break;
       case "Animales" : animalesRef.add(Jugador);
       break;
     }
   }
}