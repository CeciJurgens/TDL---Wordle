import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/tile.dart';
import '../controller.dart';

class Grid extends StatelessWidget {
  final int wordLength;
  final int maxAttempts;

  const Grid({
    Key? key,
    required this.wordLength,
    required this.maxAttempts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (context, controller, child) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
          itemCount: wordLength * maxAttempts,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            crossAxisCount: wordLength,
          ),
          itemBuilder: (context, index) {
            return Tile(index: index);
          },
        );
      },
    );
  }
}