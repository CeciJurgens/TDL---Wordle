import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class RankingPage extends StatefulWidget {
  _RankingPageState createState() => _RankingPageState();

  void subirPuntaje(String nombre, int puntaje, String genero) async {
    String rutaArchivo = 'lib/data/ranking.json';
    // Lee el contenido del archivo
    String jsonString = await File(rutaArchivo).readAsString();
    Map Rankings = json.decode(jsonString);

    List rankingSeleccionado = Rankings[genero]; //lista especifica
    rankingSeleccionado.add({"nombre": nombre, "puntaje": puntaje});

    String rankingActualizado = jsonEncode(Rankings);

    // Escribir en el archivo JSON
    File file = File(rutaArchivo);
    file.writeAsString(rankingActualizado).then((_) {

    }).catchError((error) {
      //atrapar error
    });
  }
}

class _RankingPageState extends State<RankingPage>{
  List<Widget> _listaItems = [];
  String? generoSelected = "Animales";
  @override
  void initState() {
    super.initState();
    _cargarItemsDesdeJson(generoSelected);
  }

  void _cargarItemsDesdeJson(genero) async {
    String rutaArchivo = 'lib/data/ranking.json';
    // Lee el contenido del archivo
    String jsonString = await File(rutaArchivo).readAsString();
    Map Rankings = json.decode(jsonString);
    List rankingSeleccionado = Rankings[genero]; //lista especifica

    List<Widget> listaRankAux = [];
    int nroPuesto = 1;

    rankingSeleccionado.sort((a, b) => b['puntaje'].compareTo(a['puntaje'])); //ordeno la lista

    for (var item in rankingSeleccionado) {
      String nombre = item['nombre'];
      double puntaje = item['puntaje'].toDouble();
      listaRankAux.add(ListTile(
        leading: CircleAvatar(child: Text(nroPuesto.toString())),
        title: Text('Jugador : $nombre '),
        subtitle: Text('Puntaje: $puntaje'),
      ));
      nroPuesto++;
    }
    setState(() {
      _listaItems =  listaRankAux;

    });
  }

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
              "Animales": Text("Animales", style: TextStyle(fontSize: 15.0)),
              "Paises": Text("Paises", style: TextStyle(fontSize: 15.0)),
              "Deportes": Text("Deportes", style: TextStyle(fontSize: 15.0)),
              "Frutas": Text("Frutas", style: TextStyle(fontSize: 15.0)),
              "General": Text("General", style: TextStyle(fontSize: 15.0)),
            },
            onValueChanged: (value) {
              setState(() {
                generoSelected = value;
                _cargarItemsDesdeJson(generoSelected);
              });
            },
            groupValue: generoSelected,
          ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _listaItems,
              ),
            ),
          ]
      ),
      )
    );
  }
}
