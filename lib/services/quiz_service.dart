import 'dart:async';

import 'package:loco_test/models/Question.dart';

class QuizService {
  static final QuizService _instance = new QuizService.internal();
  QuizService.internal();
  factory QuizService() => _instance;


}