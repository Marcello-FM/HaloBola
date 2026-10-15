import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/quiz_result.dart';
import '../data/questions_data.dart';
import '../core/constants.dart';

enum QuizStatus { idle, active, answered, finished }

class QuizProvider extends ChangeNotifier {
  String _playerName = '';
  String _category = '';
  String _difficulty = '';
  List<Question> _questions = [];
  int _currentIndex = 0;
  String? _selectedAnswer;
  int _score = 0;
  int _timerSeconds = AppConstants.timerSeconds;
  Timer? _timer;
  QuizStatus _status = QuizStatus.idle;
  final List<AnswerRecord> _answerRecords = [];
  final List<LeaderboardEntry> _leaderboard = [];

  String get playerName => _playerName;
  String get category => _category;
  String get difficulty => _difficulty;
  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  String? get selectedAnswer => _selectedAnswer;
  int get score => _score;
  int get timerSeconds => _timerSeconds;
  QuizStatus get status => _status;
  List<AnswerRecord> get answerRecords => List.unmodifiable(_answerRecords);
  List<LeaderboardEntry> get leaderboard => List.unmodifiable(_leaderboard);
  Question? get currentQuestion => _questions.isNotEmpty && _currentIndex < _questions.length
      ? _questions[_currentIndex]
      : null;
  int get totalQuestions => _questions.length;
  bool get isLastQuestion => _currentIndex >= _questions.length - 1;

  void setPlayerName(String name) {
    _playerName = name;
    notifyListeners();
  }

  void startQuiz(String category, String difficulty) {
    _category = category;
    _difficulty = difficulty;
    _questions = _buildShuffledQuestions(category, difficulty);
    _currentIndex = 0;
    _selectedAnswer = null;
    _score = 0;
    _timerSeconds = AppConstants.timerSeconds;
    _status = QuizStatus.active;
    _answerRecords.clear();
    notifyListeners();
    _startTimer();
  }

  List<Question> _buildShuffledQuestions(String cat, String diff) {
    final raw = getQuestions(cat, diff);
    final list = [...raw]..shuffle();
    return list.map((q) {
      final shuffledOptions = [...q.options]..shuffle();
      return Question(
        id: q.id,
        category: q.category,
        difficulty: q.difficulty,
        questionText: q.questionText,
        options: shuffledOptions,
        correctAnswer: q.correctAnswer,
        explanation: q.explanation,
      );
    }).toList();
  }

  void _startTimer() {
    _timer?.cancel();
    _timerSeconds = AppConstants.timerSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timerSeconds > 0) {
        _timerSeconds--;
        notifyListeners();
      } else {
        _onTimerExpired();
      }
    });
  }

  void _onTimerExpired() {
    _timer?.cancel();
    final q = currentQuestion;
    if (q != null) {
      _answerRecords.add(AnswerRecord(
        questionText: q.questionText,
        correctAnswer: q.correctAnswer,
        chosenAnswer: null,
        isCorrect: false,
        isTimeout: true,
      ));
    }
    _status = QuizStatus.answered;
    notifyListeners();
  }

  void submitAnswer(String answer) {
    if (_status != QuizStatus.active) return;
    _timer?.cancel();
    _selectedAnswer = answer;
    final q = currentQuestion;
    final isCorrect = q != null && answer == q.correctAnswer;
    if (isCorrect) _score++;
    if (q != null) {
      _answerRecords.add(AnswerRecord(
        questionText: q.questionText,
        correctAnswer: q.correctAnswer,
        chosenAnswer: answer,
        isCorrect: isCorrect,
        isTimeout: false,
      ));
    }
    _status = QuizStatus.answered;
    notifyListeners();
  }

  void nextQuestion() {
    if (isLastQuestion) {
      _finishQuiz();
      return;
    }
    _currentIndex++;
    _selectedAnswer = null;
    _status = QuizStatus.active;
    notifyListeners();
    _startTimer();
  }

  void _finishQuiz() {
    _timer?.cancel();
    _status = QuizStatus.finished;
    _leaderboard.add(LeaderboardEntry(
      playerName: _playerName,
      score: _score,
      totalQuestions: _questions.length,
      category: _category,
      difficulty: _difficulty,
    ));
    notifyListeners();
  }

  void resetQuiz() {
    _timer?.cancel();
    _currentIndex = 0;
    _selectedAnswer = null;
    _score = 0;
    _timerSeconds = AppConstants.timerSeconds;
    _status = QuizStatus.idle;
    _answerRecords.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
