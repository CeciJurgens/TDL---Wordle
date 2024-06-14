import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/keyboard_row.dart';
import '../components/grid.dart';
import '../constants/words.dart';
import '../controller.dart';

class HomePage extends StatefulWidget {
  final int selectedLevel;
  final int selectedCategory;

  const HomePage({
    Key? key,
    required this.selectedLevel,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _word;
  late int _maxAttempts;
  int _currentAttempts = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    int wordLength;
    switch (widget.selectedLevel) {
      case 0:
        wordLength = 5;
        _maxAttempts = 5;
        break;
      case 1:
        wordLength = 6;
        _maxAttempts = 5;
        break;
      case 2:
        wordLength = 7;
        _maxAttempts = 5;
        break;
      case 3:
        wordLength = 8;
        _maxAttempts = 5;
        break;
      default:
        wordLength = 5; // Default to 5 letters
        _maxAttempts = 5;
    }
    _word = _getRandomWord(wordLength);

    // Initialize game state
    _currentAttempts = 0;
    var controller = Provider.of<Controller>(context, listen: false);
    controller.setCorrectWord(word: _word);
    controller.resetAttempts();
  }

  String _getRandomWord(int length) {
    switch (widget.selectedCategory) {
      case 0:
        final filteredWords = animal_category.where((word) => word.length == length).toList();
        final randomIndex = Random().nextInt(filteredWords.length);
        return filteredWords[randomIndex];
      case 1:
        final filteredWords = countries_category.where((word) => word.length == length).toList();
        final randomIndex = Random().nextInt(filteredWords.length);
        return filteredWords[randomIndex];
      case 2:
        final filteredWords = sport_category.where((word) => word.length == length).toList();
        final randomIndex = Random().nextInt(filteredWords.length);
        return filteredWords[randomIndex];
      case 3:
        final filteredWords = fruits_category.where((word) => word.length == length).toList();
        final randomIndex = Random().nextInt(filteredWords.length);
        return filteredWords[randomIndex];
      case 4:
        final filteredWords = general_category.where((word) => word.length == length).toList();
        final randomIndex = Random().nextInt(filteredWords.length);
        return filteredWords[randomIndex];
      default:
        final filteredWords = animal_category.where((word) => word.length == length).toList();
        final randomIndex = Random().nextInt(filteredWords.length);
        return filteredWords[randomIndex];
    }

  }

  void _refreshGame() {
    setState(() {
      _initializeGame();
      Provider.of<Controller>(context, listen: false).reset();
      _currentAttempts = 0;
    });
  }

  void _showEndDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text("en construccion"),
          content: Text(message),
          actions: [
            if (Provider.of<Controller>(context, listen: false).isGameWon)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Provider.of<Controller>(context, listen: false).reset();
                  _initializeGame();
                },
                child: const Text("Juega Otra Vez"),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _refreshGame();
              },
              child: const Text("Salir"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wordle"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshGame,
          ),
        ],
      ),
      body: Consumer<Controller>(
          builder: (context, controller, child) {
            if (controller.isGameOver) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                String message = controller.isGameWon
                    ? "Felicitaciones!Has acertado la palabra! Tienes ${controller.pointsGame} puntos"
                    : "Has perdido! Game Over! La palabra correcta es ${controller.correctWord} y tienes ${controller.pointsGame} puntos.";
                _showEndDialog(message);
              });
            }
            return Column(
              children: [
                Divider(
                  height: 1,
                  thickness: 2,
                ),
                Expanded(
                  flex: 7,
                  child: Grid(
                    wordLength: _word.length,
                    maxAttempts: _maxAttempts,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      KeyboardRow(min: 1, max: 10),
                      KeyboardRow(min: 11, max: 20),
                      KeyboardRow(min: 21, max: 30),
                      Text('Attempts left: ${_maxAttempts - controller.currentAttempts}'),
                    ],
                  ),
                )
              ],
            );
          }
          )
    );
  }
}

