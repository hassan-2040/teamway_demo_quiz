class Question {
  final String question;
  final List<Map<String, dynamic>> options;

  const Question({
    required this.question,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: _getOptions(json['options']),
    );
  }
}

List<Map<String, dynamic>> _getOptions(List<dynamic> _options) {
  final List<Map<String, dynamic>> _optionsList = [];
  for (var option in _options) {
    _optionsList.add(option);
  }
  return _optionsList;
}
