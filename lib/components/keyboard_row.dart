import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/constants/colors.dart';
import '../controller.dart';
import '../data/keys_map.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({
    required this.min,
    required this.max,
    super.key,
  });

  final int min, max;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        int index = 0;
        return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keysMap.entries.map((e) {
          index++;
          if(min <= index && index <= max) {
            Color color = Theme.of(context).focusColor;
            Color keyColor = Colors.white;
            if(e.value == AnswerStage.correct){
              color = correctGreen;
            }else if(e.value == AnswerStage.contains){
              color = containsYellow;
            }else if(e.value == AnswerStage.incorrect){
              color = Theme.of(context).primaryColorDark;
            }else{
              keyColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
            }
            return Padding(
              padding: EdgeInsets.all(size.width * 0.006),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width:e.key == "ENTER" || e.key == "BACK" ?
                  size.width * 0.13: size.width * 0.085,
                  height: size.height * 0.090,
                  child: Material(
                    color: color,
                    child: InkWell(
                      onTap: () {
                        Provider.of<Controller>(context, listen: false).setKeyTapped(value: e.key);
                      },
                      child: Center(
                          child: Text(e.key,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: keyColor)
                      ),
                    ),
                  )
                ),
              ),
              )
            );
          } else {
            return const SizedBox();
          }
      }).toList()
      );
      },
    );
  }
}