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
  int maxAttempts = 5;
  bool isHintUsed = false;
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void setCorrectWord({required String word}) {
    correctWord = word;
    wordLength = word.length;
    isGameWon = false;
    isGameOver = false;
    isHintUsed = false;
  }

  void incrementAttempts() {
    currentAttempts++;
    notifyListeners();
  }

  void resetAttempts() {
    currentAttempts = 0;
    notifyListeners();
  }

  void resetPoints() {
    pointsGame = 0;
  }

  void setKeyTapped({required String value}) {
    if (value == "ENTER" && currentTile == wordLength) {
      checkWord();
      currentTile = 0;
    } else if (value == "BACK" && currentTile > 0) {
      currentTile--;
      tilesEntered.removeLast();
    } else if (currentTile < wordLength) {
      tilesEntered.add(TileModel(letter: value, answerStage: AnswerStage.notAnswered));
      currentTile++;
    }
    notifyListeners();
  }

  void checkWord() {
    List<String> guessed = [];
    String guessedWord = "";
    List<String> remainingCorrect = correctWord.characters.toList();

    for (int i = currentRow * wordLength; i < (currentRow * wordLength) + wordLength; i++) {
      guessed.add(tilesEntered[i].letter);
    }
    guessedWord = guessed.join();

    if (guessedWord == correctWord) {
      isGameWon = true;
      isGameOver = true;
      _updateTilesAndKeys(AnswerStage.correct);
    } else {
      _updateTilesAndKeysForIncorrectGuess(remainingCorrect, guessedWord);
    }

    if (isGameWon) {
      //pointsGame += (maxAttempts - currentRow) * wordLength;
      pointsGame += (maxAttempts - currentRow);
    }

    currentRow++;
    if (currentRow == maxAttempts && !isGameWon) {
      isGameOver = true;
    }

    incrementAttempts();
  }

  void _updateTilesAndKeys(AnswerStage stage) {
    for (int i = currentRow * wordLength; i < (currentRow * wordLength) + wordLength; i++) {
      tilesEntered[i].answerStage = stage;
      keysMap.update(tilesEntered[i].letter, (value) => stage);
    }
    notifyListeners();
  }

  void _updateTilesAndKeysForIncorrectGuess(List<String> remainingCorrect, String guessedWord) {
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
          if (keysMap[tilesEntered[j + (currentRow * wordLength)].letter] == AnswerStage.notAnswered) {
            keysMap.update(tilesEntered[j + (currentRow * wordLength)].letter, (value) => AnswerStage.contains);
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
    notifyListeners();
  }

  void useHint() {
    if (!isHintUsed) {
      for (int i = 0; i < correctWord.length; i++) {
        if (!tilesEntered.any((tile) => tile.letter == correctWord[i] && tile.answerStage == AnswerStage.correct)) {
          tilesEntered.insert(currentRow * wordLength + i, TileModel(letter: correctWord[i], answerStage: AnswerStage.correct));
          keysMap.update(correctWord[i], (value) => AnswerStage.correct);
          currentTile++;
          break;
        }
      }
      isHintUsed = true;
      notifyListeners();
    }
  }

  void reset() {
    currentTile = 0;
    currentRow = 0;
    tilesEntered.clear();
    _resetKeysMap();
    isGameWon = false;
    isGameOver = false;
    isHintUsed = false;
    notifyListeners();
  }

  void _resetKeysMap() {
    keysMap.updateAll((key, value) => AnswerStage.notAnswered);
  }
}