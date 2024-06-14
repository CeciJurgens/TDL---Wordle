import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'game_page.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedLevel = 0;
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Elegir un Nivel:',
              style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 20),
            CupertinoSlidingSegmentedControl(
              children: {
                0: Text('Facil', style: TextStyle(fontSize: 16.0)),
                1: Text('Medio', style: TextStyle(fontSize: 16.0)),
                2: Text('Dificil', style: TextStyle(fontSize: 16.0)),
                3: Text('Experto', style: TextStyle(fontSize: 16.0)),
              },
              onValueChanged: (value) {
                setState(() {
                  selectedLevel = value!;
                });
              },
              groupValue: selectedLevel,
            ),
            SizedBox(height: 20),
            Text(
              'Elegir una categoria:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            CupertinoSlidingSegmentedControl(
              children: {
                0: Text('Animales', style: TextStyle(fontSize: 15.0)),
                1: Text('Paises', style: TextStyle(fontSize: 15.0)),
                2: Text('Deportes', style: TextStyle(fontSize: 15.0)),
                3: Text('Frutas', style: TextStyle(fontSize: 15.0)),
                4: Text('Gerenal', style: TextStyle(fontSize: 15.0)),
              },
              onValueChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              groupValue: selectedCategory,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      selectedLevel: selectedLevel,
                      selectedCategory: selectedCategory,
                    ),
                  ),
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