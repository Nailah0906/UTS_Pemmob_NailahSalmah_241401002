import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  int? _selectedOptionIndex;

  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isAnswered => _isAnswered;
  int? get selectedOptionIndex => _selectedOptionIndex;
  int get totalQuestions => dummyQuestions.length;
  bool get isLastQuestion => _currentQuestionIndex == totalQuestions - 1;

  Question get currentQuestion => dummyQuestions[_currentQuestionIndex];

  void answerQuestion(int index) {
    _selectedOptionIndex = index;
    _isAnswered = true; 

    _score = 0;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
      _isAnswered = false; 
      _selectedOptionIndex = null; 
      notifyListeners();
    }
  }

    void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _isAnswered = false;
      _selectedOptionIndex = null;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _isAnswered = false;
    _selectedOptionIndex = null;
    notifyListeners();
  }
}