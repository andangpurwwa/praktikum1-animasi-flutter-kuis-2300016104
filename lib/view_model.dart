import 'package:flutter/foundation.dart';

import 'model.dart';

class QuizViewModel extends ChangeNotifier {
  final QuestionBank _questionBank = QuestionBank();

  late final int totalQuestions;
  Question? currentQuestion;
  int answeredQuestionCount = 0;
  int score = 0;
  bool didAnswerQuestion = false;

  bool get hasNextQuestion => answeredQuestionCount < totalQuestions;

  bool get isGameOver => didAnswerQuestion && !hasNextQuestion;

  QuizViewModel() {
    totalQuestions = _questionBank.remainingQuestions;
    currentQuestion = _questionBank.getRandomQuestion();
    if (currentQuestion != null) {
      answeredQuestionCount = 1;
    }
  }

  void getNextQuestion() {
    // Pergantian soal hanya boleh dilakukan setelah soal aktif dijawab.
    if (!didAnswerQuestion || !hasNextQuestion) {
      return;
    }

    final Question? nextQuestion = _questionBank.getRandomQuestion();
    if (nextQuestion == null) {
      return;
    }

    currentQuestion = nextQuestion;
    answeredQuestionCount++;
    didAnswerQuestion = false;
    notifyListeners();
  }

  void checkAnswer(int selectedIndex) {
    // Mencegah skor bertambah atau status Game Over diproses berulang kali.
    if (didAnswerQuestion || currentQuestion == null) {
      return;
    }

    if (currentQuestion!.correctAnswer == selectedIndex) {
      score++;
    }

    didAnswerQuestion = true;
    notifyListeners();
  }
}
