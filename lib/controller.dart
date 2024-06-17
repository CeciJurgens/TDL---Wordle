import 'package:flutter/cupertino.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/keys_map.dart';
import 'models/tile_model.dart';

class Controller extends ChangeNotifier {
  int currentTile = 0;
  int currentRow = 0;
  List<TileModel> tilesEntered = [];
  String correctWord = "";
  int wordLength = 5;
  int currentAttempts = 0;
  bool isGameWon = false;
  bool isGameOver = false;
  int pointsGame = 0;
  int maxAttemp = 5;

  setCorrectWord({required String word}) {
    correctWord = word;
    wordLength = word.length;
    isGameWon = false;
    isGameOver = false;
  }

  incrementAttempts() {
    currentAttempts++;
    notifyListeners();
  }

  resetAttempts() {
    currentAttempts = 0;
    notifyListeners();
  }

  setKeyTapped({required String value}) {
    if (value == "ENTER") {
      if (currentTile == wordLength) {
        currentTile = 0;
        checkWord();
      }
    } else if (value == "BACK") {
      if (0 < currentTile) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      if (currentTile < wordLength) {
        tilesEntered.add(TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }

  void checkWord() {
    List<String> guessed = [];
    String guessedWord = "";
    List<String> remainingCorrect = [];

    for (int i = currentRow * wordLength; i < (currentRow * wordLength) + wordLength; i++) {
      guessed.add(tilesEntered[i].letter);
    }
    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (guessedWord == correctWord) {
      isGameWon = true;
      isGameOver = true;
      for (int i = currentRow * wordLength; i < (currentRow * wordLength) + wordLength; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
      }
    } else {
      for (int i = 0; i < wordLength; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * wordLength)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }
      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < wordLength; j++) {
          if (remainingCorrect[i] == tilesEntered[j + (currentRow * wordLength)].letter) {
            if (tilesEntered[j + (currentRow * wordLength)].answerStage != AnswerStage.correct) {
              tilesEntered[j + (currentRow * wordLength)].answerStage = AnswerStage.contains;
            }
            final resultKey = keysMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * wordLength)].letter);
            if (resultKey.single.value == AnswerStage.notAnswered) {
              keysMap.update(resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }
    }
    for (int i = currentRow * wordLength; i < (currentRow * wordLength) + wordLength; i++) {
      if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
        tilesEntered[i].answerStage = AnswerStage.incorrect;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.incorrect);
      }
    }
    if (isGameWon){
      pointsGame += (maxAttemp - currentRow)*wordLength;
    }
    currentRow++;
    if (currentRow == 5 && !isGameWon) {
      isGameOver = true;
    }
    currentAttempts++;
    notifyListeners();
  }

  void reset() {
    currentTile = 0;
    currentRow = 0;
    tilesEntered.clear();
    _resetKeysMap();
    isGameWon = false;
    isGameOver = false;
    notifyListeners();
  }

  void _resetKeysMap() {
    keysMap.updateAll((key, value) => AnswerStage.notAnswered);
  }

}

