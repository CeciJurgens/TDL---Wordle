import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/constants/colors.dart';
import '../controller.dart';

class Tile extends StatelessWidget {
  const Tile({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        String text = "";
        Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
        Color borderColor = Theme.of(context).primaryColorLight;
        Color fontColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

        if (index < notifier.tilesEntered.length) {
          text = notifier.tilesEntered[index].letter;
          final answerStage = notifier.tilesEntered[index].answerStage;

          switch (answerStage) {
            case AnswerStage.correct:
              borderColor = Colors.transparent;
              backgroundColor = correctGreen;
              fontColor = Colors.white;
              break;
            case AnswerStage.contains:
              borderColor = Colors.transparent;
              backgroundColor = containsYellow;
              fontColor = Colors.white;
              break;
            case AnswerStage.incorrect:
              borderColor = Colors.transparent;
              backgroundColor = Theme.of(context).primaryColorDark;
              fontColor = Colors.white;
              break;
            default:
              fontColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
              break;
          }
        }

        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: fontColor, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}