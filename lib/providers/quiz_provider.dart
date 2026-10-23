import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _score = 0;
  // save jawaban biar ga ilang
  final Map<int, int> _userAnswers = {}; 

  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get totalQuestions => dummyQuestions.length;
  bool get isLastQuestion => _currentQuestionIndex == totalQuestions - 1;
  
  Question get currentQuestion => dummyQuestions[_currentQuestionIndex];
  
  // Cek udah dijawab blum
  bool get isAnswered => _userAnswers.containsKey(_currentQuestionIndex);
  int? get selectedOptionIndex => _userAnswers[_currentQuestionIndex];

  void answerQuestion(int index) {
    // Simpan jawaban user
    _userAnswers[_currentQuestionIndex] = index;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Hitung skor akhir
  int calculateScore() {
    int finalScore = 0;
    _userAnswers.forEach((questionIndex, answerIndex) {
      if (dummyQuestions[questionIndex].correctAnswerIndex == answerIndex) {
        finalScore += 10; //skor
      }
    });
    return finalScore;
  }

  // Simpan skor
  void finishQuiz() {
    _score = calculateScore();
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _userAnswers.clear();
    notifyListeners();
  }
}