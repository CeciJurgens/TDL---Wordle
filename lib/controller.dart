import 'package:flutter/cupertino.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/keys_map.dart';
import 'models/tile_model.dart';

class Controller extends ChangeNotifier {
  int currentTile = 0;
  int currentRow = 0;
  List<TileModel> tilesEntered = [];
  String correctWord = "";

  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped({required String value}) {
    if(value == "ENTER") {
      if(currentTile == 5 * (currentRow + 1)) {
        checkWord();
      }

    } else if (value == "BACK") {
      if(0 < currentTile) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      if(currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }

  checkWord() {
    List<String> guessed = [];
    String guessedWord= "";
    List<String> remainingCorrect = [];

    for(int i = currentRow * 5; i < (currentRow * 5) + 5; i++){
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if(guessedWord == correctWord){
      for(int i = currentRow * 5; i < (currentRow * 5) + 5; i++){
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update((tilesEntered[i].letter), (value) => AnswerStage.correct);
      }
    }else{
      for(int i = 0; i < 5; i++){
        if(guessedWord[i] == correctWord[i]){
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }
      for(int i = 0; i < remainingCorrect.length; i++){
        for(int j = 0; j < 5; j++){
          if(remainingCorrect[i] == tilesEntered[j +  (currentRow * 5)].letter){
            if(tilesEntered[j + (currentRow * 5)].answerStage != AnswerStage.correct){
              tilesEntered[j + (currentRow * 5)].answerStage = AnswerStage.contains;
            }

            final resultKey = keysMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * 5)].letter);

            if(resultKey.single.value == AnswerStage.notAnswered){
              keysMap.update(resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }
    }
    for(int i = currentRow * 5; i < (currentRow * 5) + 5; i++){
      if(tilesEntered[i].answerStage == AnswerStage.notAnswered){
        tilesEntered[i].answerStage = AnswerStage.incorrect;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.incorrect);
      }
    }

    currentRow++;
    notifyListeners();
  }
}