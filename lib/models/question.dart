class Question {
  final String id;
  final String category;
  final String difficulty;
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  const Question({
    required this.id,
    required this.category,
    required this.difficulty,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}
