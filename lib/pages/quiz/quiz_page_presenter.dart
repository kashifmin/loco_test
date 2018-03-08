import 'package:loco_test/services/quiz_service.dart';

abstract class QuizPageContract {
  void onNewQuiz();
}

class QuizPagePresenter {
  QuizPageContract _view;
  QuizService _service;
  QuizPagePresenter(this._view) {
    _service = new QuizService();
  }
}