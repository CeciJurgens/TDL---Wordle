import 'package:flutter/material.dart';
import 'package:wordle/constants/colors.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cómo se juega el Wordle?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RulesHeader(title: "Objetivo del Juego"),
              DecoratedPlainText(
                text: "El objetivo del juego WORDLE es adivinar una palabra en cinco intentos.",
              ),
              DecoratedPlainText(
                text: "Cada intento debe ser una palabra válida que coincida con la longitud de la palabra oculta, que por defecto es de cinco caracteres.",
              ),
              DecoratedPlainText(
                text: "Después de cada intento, el color de las fichas cambiará para indicar qué tan cerca está tu respuesta de la palabra. El significado de los colores se muestra a continuación.",
              ),
              RulesHeader(title: "Leer los Colores"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    DecoratedTextBox(letter: "T", state: 1),
                    DecoratedTextBox(letter: "R", state: 0),
                    DecoratedTextBox(letter: "U", state: 0),
                    DecoratedTextBox(letter: "C", state: 0),
                    DecoratedTextBox(letter: "O", state: 0),
                  ],
                ),
              ),
              DecoratedPlainText(
                text: "La ficha verde muestra que la letra T está en la palabra y en el lugar correcto.",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  DecoratedTextBox(letter: "R", state: 1),
                  DecoratedTextBox(letter: "A", state: 2),
                  DecoratedTextBox(letter: "R", state: -1),
                  DecoratedTextBox(letter: "O", state: 0),
                ],
              ),
              DecoratedPlainText(
                text: "La ficha amarilla muestra que la letra A está en la palabra pero no en el lugar correcto.",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  DecoratedTextBox(letter: "M", state: -1),
                  DecoratedTextBox(letter: "A", state: -1),
                  DecoratedTextBox(letter: "N", state: -1),
                  DecoratedTextBox(letter: "O", state: -1),
                ],
              ),
              DecoratedPlainText(
                text: "Una ficha gris muestra que la letra no está en la palabra. Por ejemplo, M, A, N, O no están en la palabra.",
              ),
              RulesHeader(title: "Ayuda"),
              DecoratedPlainText(
                text: "Puedes obtener una ayuda al presionar la tecla de la lampara y se develara una letra de la palabra a adivinar. Solo puedes pedir una sola ayuda por juego.",
              ),
              RulesHeader(title: "Puntos"),
              DecoratedPlainText(
                text: "La puntuación se basa en el número de intentos necesarios para adivinar la palabra:",
              ),
              DecoratedPlainText(
                text: "1. Si adivinas la palabra en el primer intento, obtienes 5 puntos.",
              ),
              DecoratedPlainText(
                text: "2. Si adivinas la palabra en el segundo intento, obtienes 4 puntos.",
              ),
              DecoratedPlainText(
                text: "3. Si adivinas la palabra en el tercer intento, obtienes 3 puntos.",
              ),
              DecoratedPlainText(
                text: "4. Si adivinas la palabra en el cuarto intento, obtienes 2 puntos.",
              ),
              DecoratedPlainText(
                text: "5. Si adivinas la palabra en el quinto intento, obtienes 1 punto.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RulesHeader extends StatelessWidget {
  const RulesHeader({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Stack(
        children: [
          Positioned.directional(
            textDirection: TextDirection.ltr,
            bottom: 0,
            child: Container(
              width: 30.0,
              height: 10.0,
            ),
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            bottom: 0,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DecoratedPlainText extends StatelessWidget {
  const DecoratedPlainText({required this.text, Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    //var mainTextColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey[850];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: TextStyle(
          //color: mainTextColor,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DecoratedTextBox extends StatelessWidget {
  const DecoratedTextBox({required this.letter, required this.state, Key? key}) : super(key: key);

  final String letter;
  final int state;

  @override
  Widget build(BuildContext context) {
    Color backGroundColor;
    Color borderColor;
    Color fontColor;

    if (state == 1) {
      backGroundColor = correctGreen;
      borderColor = Colors.transparent;
      fontColor = Colors.white;
    } else if (state == 2) {
      backGroundColor = containsYellow;
      borderColor = Colors.transparent;
      fontColor = Colors.white;
    } else if (state == -1) {
      backGroundColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey[700]! : Colors.grey[400]!;
      borderColor = backGroundColor;
      fontColor = Colors.white;
    } else {
      backGroundColor = Theme.of(context).scaffoldBackgroundColor;
      borderColor = Theme.of(context).primaryColorLight;
      fontColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Container(
        width: 40.0,
        height: 40.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
          color: backGroundColor,
        ),
        child: Text(
          letter,
          style: TextStyle(
            //color: mainTextColor,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

