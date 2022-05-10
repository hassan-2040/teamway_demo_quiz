import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:teamway_demo_quiz/models/question.dart';

class QuizRepo {
  final List<Question> questions = [];

  Future<void> fetchQuestions() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final String _response =
          await rootBundle.loadString('assets/questions.json');
      final Map<String, dynamic> _json = json.decode(_response);
      final List<dynamic> _questions = _json['questions'];
      for (var question in _questions) {
        questions.add(Question.fromJson(question));
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
