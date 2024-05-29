import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/keyboard_row.dart';
import '../components/grid.dart';
import '../constants/words.dart';
import '../controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String  _word;

  @override
  void initState() {
    final r = Random().nextInt(words.length);
    _word = words[r];
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wally wordle"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.yellow,
              child: const Grid(),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.green,
              child: const Column(
                children: [
                  KeyboardRow(min: 1, max: 10),
                  KeyboardRow(min: 11, max: 20),
                  KeyboardRow(min: 21, max: 30)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

