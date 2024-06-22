import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login_controller.dart';
import 'menu_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Wordle'),
        //centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Wordle Logo
              Image.asset(
                'assets/Wordle-01.png', // Make sure you have the Wordle logo in assets folder
                height: 350,
                width: 350,
              ),
              SizedBox(height: 40),
              // Google Login Button
              ElevatedButton.icon(
                icon: Image.asset(
                  "assets/logo_google.png", // Google logo
                  height: 24,
                  width: 24,
                ),
                label: Text("Ingresar con Google"),
                /*
                onPressed: () {
                  LoginController().signInWithGoogle();
                },

                 */
                onPressed: () async {
                  final loginController = Provider.of<LoginController>(context, listen: false);
                  final user = await loginController.signInWithGoogle();
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage(
                        name: loginController.name,
                        imageUrl: loginController.imageUrl,
                      )),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  //primary: Colors.white, // Background color
                  //onPrimary: Colors.black, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              SizedBox(height: 20),
              // Play Without Google Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage()),
                  );
                },
                child: Text('Jugar Sin Google'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
