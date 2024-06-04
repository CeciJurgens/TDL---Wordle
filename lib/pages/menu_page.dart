import 'package:flutter/material.dart';
import 'game_page.dart';
import 'package:flutter/cupertino.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Set<String> dificultad1 = {};
    Set<String> dificultad2 = {};

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
                'facil': Text('Facil', style: TextStyle(fontSize: 16.0)),
                'medio': Text('Medio', style: TextStyle(fontSize: 16.0)),
                'dificil': Text('Dificil', style: TextStyle(fontSize: 16.0)),
                'experto': Text('Experto', style: TextStyle(fontSize: 16.0)),
              },
              onValueChanged: (value) { },
              groupValue: dificultad1.isNotEmpty ? dificultad1.first : null,
            ),
            SizedBox(height: 30),
            CupertinoSlidingSegmentedControl(
              children: {
                'Animales': Text('Animales', style: TextStyle(fontSize: 15.0)),
                'Paises': Text('Paises', style: TextStyle(fontSize: 15.0)),
                'Objetos': Text('Objetos', style: TextStyle(fontSize: 15.0)),
                'Futbol': Text('Futbol', style: TextStyle(fontSize: 15.0)),
                'Gerenal': Text('Gerenal', style: TextStyle(fontSize: 15.0)),
              },
              onValueChanged: (value) { },
              groupValue: dificultad2.isNotEmpty ? dificultad2.first : null,
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