import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/quiz_models.dart';
import '../services/quiz_data_service.dart';

class QuizProvider extends ChangeNotifier {
  List<Quiz> _quizzes = [];
  Quiz? _currentQuiz;
  int _currentQuestionIndex = 0;
  List<int> _selectedAnswers = [];
  int _timeElapsed = 0;
  List<QuizResult> _results = [];
  bool _isQuizStarted = false;

  // Getters
  List<Quiz> get quizzes => _quizzes;
  Quiz? get currentQuiz => _currentQuiz;
  int get currentQuestionIndex => _currentQuestionIndex;
  List<int> get selectedAnswers => _selectedAnswers;
  int get timeElapsed => _timeElapsed;
  List<QuizResult> get results => _results;
  bool get isQuizStarted => _isQuizStarted;

  Question? get currentQuestion {
    if (_currentQuiz != null && _currentQuestionIndex < _currentQuiz!.questions.length) {
      return _currentQuiz!.questions[_currentQuestionIndex];
    }
    return null;
  }

  bool get isLastQuestion {
    return _currentQuiz != null && _currentQuestionIndex == _currentQuiz!.questions.length - 1;
  }

  int get progress {
    if (_currentQuiz == null) return 0;
    return ((_currentQuestionIndex + 1) / _currentQuiz!.questions.length * 100).toInt();
  }

  QuizProvider() {
    _initializeQuizzes();
    _loadResults();
  }

  void _initializeQuizzes() {
    _quizzes = QuizDataService.getAllQuizzes();
    notifyListeners();
  }

  void startQuiz(String quizId) {
    _currentQuiz = QuizDataService.getQuizById(quizId);
    _currentQuestionIndex = 0;
    _selectedAnswers = List.filled(_currentQuiz!.questions.length, -1);
    _timeElapsed = 0;
    _isQuizStarted = true;
    notifyListeners();
  }

  void selectAnswer(int answerIndex) {
    if (_currentQuestionIndex < _selectedAnswers.length) {
      _selectedAnswers[_currentQuestionIndex] = answerIndex;
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (_currentQuiz != null && _currentQuestionIndex < _currentQuiz!.questions.length - 1) {
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

  void goToQuestion(int index) {
    if (_currentQuiz != null && index >= 0 && index < _currentQuiz!.questions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }

  void updateTimeElapsed(int seconds) {
    _timeElapsed = seconds;
    notifyListeners();
  }

  QuizResult submitQuiz() {
    if (_currentQuiz == null) {
      throw Exception('No quiz is currently active');
    }

    int correctCount = 0;
    for (int i = 0; i < _selectedAnswers.length; i++) {
      if (_selectedAnswers[i] == _currentQuiz!.questions[i].correctAnswerIndex) {
        correctCount++;
      }
    }

    final result = QuizResult(
      quizId: _currentQuiz!.id,
      quizTitle: _currentQuiz!.title,
      totalQuestions: _currentQuiz!.questions.length,
      correctAnswers: correctCount,
      wrongAnswers: _currentQuiz!.questions.length - correctCount,
      completedAt: DateTime.now(),
      selectedAnswers: List.from(_selectedAnswers),
      timeTaken: _timeElapsed,
    );

    _results.add(result);
    _saveResults();
    resetQuiz();
    return result;
  }

  void resetQuiz() {
    _currentQuiz = null;
    _currentQuestionIndex = 0;
    _selectedAnswers = [];
    _timeElapsed = 0;
    _isQuizStarted = false;
    notifyListeners();
  }

  Future<void> _saveResults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final resultsJson = _results
          .map((r) => jsonEncode(r.toJson()))
          .toList();
      await prefs.setStringList('quiz_results', resultsJson);
    } catch (e) {
      print('Error saving results: $e');
    }
  }

  Future<void> _loadResults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final resultsJson = prefs.getStringList('quiz_results') ?? [];
      _results = resultsJson
          .map((r) => QuizResult.fromJson(jsonDecode(r)))
          .toList();
      notifyListeners();
    } catch (e) {
      print('Error loading results: $e');
    }
  }

  void clearAllResults() async {
    _results.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('quiz_results');
    notifyListeners();
  }

  int getTotalQuizzesTaken() => _results.length;

  double getAverageScore() {
    if (_results.isEmpty) return 0;
    final totalPercentage = _results.fold<double>(
      0,
      (sum, result) => sum + result.percentage,
    );
    return totalPercentage / _results.length;
  }
}
