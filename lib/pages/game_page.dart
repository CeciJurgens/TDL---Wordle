import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/keyboard_row.dart';
import '../components/grid.dart';
import '../constants/words.dart';
import '../controller.dart';
import '../login_controller.dart';
import 'ranking.dart';
import 'help_page.dart';

class HomePage extends StatefulWidget {
  final int selectedLevel;
  final String selectedCategory;

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
    int wordLength = _getWordLength(widget.selectedLevel);
    _maxAttempts = 5;
    _word = _getRandomWord(wordLength);

    _currentAttempts = 0;
    var controller = Provider.of<Controller>(context, listen: false);
    controller.setCorrectWord(word: _word);
    controller.resetAttempts();
  }

  int _getWordLength(int selectedLevel) {
    switch (selectedLevel) {
      case 0:
        return 5;
      case 1:
        return 6;
      case 2:
        return 7;
      case 3:
        return 8;
      default:
        return 5;
    }
  }

  String _getRandomWord(int length) {
    List<String> filteredWords;
    switch (widget.selectedCategory) {
      case "Animales":
        filteredWords = animal_category.where((word) => word.length == length).toList();
        break;
      case "Paises":
        filteredWords = countries_category.where((word) => word.length == length).toList();
        break;
      case "Deportes":
        filteredWords = sport_category.where((word) => word.length == length).toList();
        break;
      case "Frutas":
        filteredWords = fruits_category.where((word) => word.length == length).toList();
        break;
      case "General":
      default:
        filteredWords = general_category.where((word) => word.length == length).toList();
    }
    final randomIndex = Random().nextInt(filteredWords.length);
    return filteredWords[randomIndex];
  }

  void _refreshGame() {
    setState(() {
      _initializeGame();
      Provider.of<Controller>(context, listen: false).reset();
      _currentAttempts = 0;
    });
  }

  String _getFriendlyLevelName(int selectedLevel) {
    switch (selectedLevel) {
      case 0:
        return "Facil (5 letras)";
      case 1:
        return "Intermedio (6 letras)";
      case 2:
        return "Dificil (7 letters)";
      case 3:
        return "Experto (8 letras)";
      default:
        return "Facil (5 letras)";
    }
  }

  void _showHelpPage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HelpPage();
      },
    );
  }
/*
  void _showEndDialog(String message) {
    bool gameWon = Provider.of<Controller>(context, listen: false).isGameWon;
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            if (gameWon)
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
                if (gameWon) {
                  _showSubmitScoreDialog(_controller, Provider.of<Controller>(context, listen: false).pointsGame);
                } else {
                  _refreshGame();
                  Provider.of<Controller>(context, listen: false).reset();
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Salir"),
            ),
          ],
        );
      },
    );
  }

 */

  void _showEndDialog(String message) {
    bool gameWon = (Provider.of<Controller>(context, listen: false).isGameWon);
    final TextEditingController _controller = TextEditingController(); //casilla de texto
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Text(message),
            actions: [
              if (gameWon)
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
                  if (gameWon){
                    int puntaje = Provider.of<Controller>(context, listen: false).pointsGame;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Subir puntaje"),
                            content: Text("Si desea subir puntaje ingrese su nombre"),
                            actions: [
                              TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText: 'Ingrese su nombre',
                                  labelText: 'Nombre',
                                ),
                              ),
                              SizedBox(height: 20),
                              TextButton(
                                onPressed: () {

                                  String genero = widget.selectedCategory;
                                  String nombre = _controller.text;
                                  RankingPage().subirPuntaje(nombre, puntaje, genero);

                                  _refreshGame();
                                  Provider.of<Controller>(context, listen: false).reset();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text("Subir puntaje"),

                              ),
                              TextButton(
                                onPressed: () {

                                  _refreshGame();
                                  Provider.of<Controller>(context, listen: false).reset();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text("Salir"),
                              ),
                            ],
                          );
                        }
                    );
                    Provider.of<Controller>(context, listen: false).resetPoints();
                  }else{
                    _refreshGame();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
                child: Text("Salir"),
              ),
            ]);
      },
    );
  }

  void _showSubmitScoreDialog(TextEditingController _controller, int puntaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Subir puntaje"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Si desea subir puntaje ingrese su nombre"),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Ingrese su nombre',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String genero = widget.selectedCategory;
                String nombre = _controller.text;
                RankingPage().subirPuntaje(nombre, puntaje, genero);

                _refreshGame();
                Provider.of<Controller>(context, listen: false).reset();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("Subir puntaje"),
            ),
            TextButton(
              onPressed: () {
                _refreshGame();
                Provider.of<Controller>(context, listen: false).reset();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              _showHelpPage(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshGame,
          ),
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: () {
              if (!Provider.of<Controller>(context, listen: false).isHintUsed) {
                Provider.of<Controller>(context, listen: false).useHint();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Solo puedes usar la ayuda una sola vez")),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              Provider.of<Controller>(context).isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<Controller>(context, listen: false).toggleTheme();
            },
          ),
          Consumer<LoginController>(
            builder: (context, loginController, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    loginController.logout();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Text('Logout'),
                    ),
                  ];
                },
                child: Row(
                  children: [
                    if (loginController.imageUrl != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage(loginController.imageUrl!),
                      ),
                    const SizedBox(width: 8),
                    if (loginController.name != null)
                      Text(
                        loginController.name!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    const SizedBox(width: 16),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<Controller>(
        builder: (context, controller, child) {
          if (controller.isGameOver) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              String message = controller.isGameWon
                  ? "Felicitaciones! Has acertado la palabra! Tienes ${controller.pointsGame} puntos"
                  : "Has perdido! Game Over! La palabra correcta es ${controller.correctWord} y tienes ${controller.pointsGame} puntos.";
              _showEndDialog(message);
            });
          }
          double availableHeight = MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top;
          double gridHeight = availableHeight * 0.6;
          double keyboardHeight = availableHeight * 0.3;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Divider(
                height: 1,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Nivel: ${_getFriendlyLevelName(widget.selectedLevel)} | Categoria: ${widget.selectedCategory}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: gridHeight,
                height: gridHeight,
                child: Grid(
                  wordLength: _word.length,
                  maxAttempts: _maxAttempts,
                ),
              ),
              SizedBox(
                height: keyboardHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: KeyboardRow(min: 1, max: 10)),
                    Expanded(child: KeyboardRow(min: 11, max: 20)),
                    Expanded(child: KeyboardRow(min: 21, max: 30)),
                    Text('Attempts left: ${_maxAttempts - controller.currentAttempts}'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}