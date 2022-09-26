import 'package:flutter/material.dart';

class QuestionInfo with ChangeNotifier {
  int current = 0;
  int score = 0;
  bool canSkip = true;
  bool stopped = false;

  updateStopped() {
    stopped = true;
    notifyListeners();
  }

  updateCurrent() {
    if (current != 29) {
      current += 1;
    }
    notifyListeners();
  }

  updateScore() {
    score += 1;
    notifyListeners();
  }

  updateSkip() {
    canSkip = false;
  }

  reset() {
    canSkip = true;
    score = 0;
    current = 0;
  }

}
