import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/database.dart';
import 'package:intl/intl.dart';

class Jugador {
  String nombre;
  int puntaje;
  Timestamp fechaHora;

  Jugador({
    required this.nombre,
    required this.puntaje,
    required this.fechaHora,
  });

  Jugador.fromJson(Map<String, Object?> json)
      : this(
    nombre: json["nombre"]! as String,
    puntaje: json["puntaje"]! as int,
    fechaHora: json["fecha"]! as Timestamp,
  );

  Map<String, Object?> toJson() {
    return {
      "nombre": nombre,
      "puntaje": puntaje,
      "fecha": fechaHora,
    };
  }
}

class RankingPage extends StatefulWidget {
  _RankingPageState createState() => _RankingPageState();
  final DataBaseService dataBase = DataBaseService();

  void subirPuntaje(String nombre, int puntaje, String genero) async {
    Jugador jugador = Jugador(nombre: nombre, puntaje: puntaje, fechaHora: Timestamp.now());
    dataBase.addJugador(jugador, genero);
  }
}

class _RankingPageState extends State<RankingPage> {
  final DataBaseService dataBase = DataBaseService();
  String? generoSelected = "Deportes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CupertinoSlidingSegmentedControl(
              children: {
                "Deportes": Text("Deportes", style: TextStyle(fontSize: 15.0)),
                "Paises": Text("Paises", style: TextStyle(fontSize: 15.0)),
                "Frutas": Text("Frutas", style: TextStyle(fontSize: 15.0)),
                "General": Text("General", style: TextStyle(fontSize: 15.0)),
                "Animales": Text("Animales", style: TextStyle(fontSize: 15.0)),
              },
              onValueChanged: (value) {
                setState(() {
                  generoSelected = value; // Actualizar el género seleccionado
                });
              },
              groupValue: generoSelected,
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Jugador>>(
                stream: dataBase.getDataBase(generoSelected),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No hay jugadores disponibles'));
                  }

                  List<QueryDocumentSnapshot<Jugador>> documentos = snapshot.data!.docs;

                  int nroPuesto = 0;
                  return ListView.builder(
                    itemCount: documentos.length,
                    itemBuilder: (context, index) {
                      Jugador jugador = documentos[index].data();
                      nroPuesto++;
                      String nombreJugador = jugador.nombre;
                      int puntajeJugador = jugador.puntaje;
                      Timestamp fecha = jugador.fechaHora;
                      return ListTile(
                        leading: CircleAvatar(child: Text(nroPuesto.toString())),
                        title: Text(
                          'Jugador: $nombreJugador   Puntaje obtenido : $puntajeJugador',
                          style: TextStyle(
                            color: Color(0xFF006400), // Color verde oscuro personalizado
                            fontSize: 16.0,
                          ),
                        ),
                        subtitle: Text('Fecha : ${DateFormat('dd-MM-yyyy h:mm a').format(fecha.toDate())}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


