import 'package:flutter/material.dart';
import 'game_page.dart';
import 'package:flutter/cupertino.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dificultad1 ;
    var dificultad2 ;

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CupertinoSlidingSegmentedControl(
              children: {
                0: Text('Facil', style: TextStyle(fontSize: 16.0)),
                1: Text('Medio', style: TextStyle(fontSize: 16.0)),
                2: Text('Dificil', style: TextStyle(fontSize: 16.0)),
                3: Text('Experto', style: TextStyle(fontSize: 16.0)),
              },
              onValueChanged: (value) {dificultad1 = value;},
              groupValue: dificultad1 = 0,
            ),
            SizedBox(height: 30),
            CupertinoSlidingSegmentedControl(
              children: {
                0: Text('Animales', style: TextStyle(fontSize: 15.0)),
                1: Text('Paises', style: TextStyle(fontSize: 15.0)),
                2: Text('Objetos', style: TextStyle(fontSize: 15.0)),
                3: Text('Futbol', style: TextStyle(fontSize: 15.0)),
                4: Text('Gerenal', style: TextStyle(fontSize: 15.0)),
              },
              onValueChanged: (value) {dificultad2 = value;},
              groupValue: dificultad2 = 0,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Jugar'),
            ),
          ],
        ),
      ),
    );
  }
}