class AnswerRecord {
  final String questionText;
  final String correctAnswer;
  final String? chosenAnswer;
  final bool isCorrect;
  final bool isTimeout;

  const AnswerRecord({
    required this.questionText,
    required this.correctAnswer,
    required this.chosenAnswer,
    required this.isCorrect,
    required this.isTimeout,
  });
}

class QuizResult {
  final String playerName;
  final String category;
  final String difficulty;
  final int score;
  final int totalQuestions;
  final List<AnswerRecord> answers;
  final DateTime finishedAt;

  const QuizResult({
    required this.playerName,
    required this.category,
    required this.difficulty,
    required this.score,
    required this.totalQuestions,
    required this.answers,
    required this.finishedAt,
  });

  double get percentage => totalQuestions == 0 ? 0 : score / totalQuestions;
}

class LeaderboardEntry {
  final String playerName;
  final int score;
  final int totalQuestions;
  final String category;
  final String difficulty;

  const LeaderboardEntry({
    required this.playerName,
    required this.score,
    required this.totalQuestions,
    required this.category,
    required this.difficulty,
  });
}
