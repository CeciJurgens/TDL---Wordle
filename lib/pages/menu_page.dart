import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller.dart';
import '../login_controller.dart';
import 'game_page.dart';
import 'help_page.dart';
import 'ranking.dart';

class MenuPage extends StatefulWidget {
  final String? name;
  final String? imageUrl;

  MenuPage({this.name, this.imageUrl});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedLevel = 0;
  String selectedCategory = "Animales";

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (loginController.name != null && loginController.imageUrl != null) ...[
            CircleAvatar(
              backgroundImage: NetworkImage(loginController.imageUrl ?? ''),
            ),
            SizedBox(width: 8),
            Center(
              child: Text(
                loginController.name ?? '',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await loginController.logout();
              },
            ),
          ],
          IconButton(
            icon: Icon(
              Provider.of<Controller>(context).isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<Controller>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                'assets/Wordle-01.png',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
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
                "Animales": Text('Animales', style: TextStyle(fontSize: 15.0)),
                "Paises": Text('Paises', style: TextStyle(fontSize: 15.0)),
                "Deportes": Text('Deportes', style: TextStyle(fontSize: 15.0)),
                "Frutas": Text('Frutas', style: TextStyle(fontSize: 15.0)),
                "General": Text('General', style: TextStyle(fontSize: 15.0)),
              },
              onValueChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              groupValue: selectedCategory,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpPage(),
                      ),
                    );
                  },
                  child: Text('Como Jugar?'),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RankingPage(),
                      ),
                    );
                  },
                  child: Text('Mejores Puntajes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}