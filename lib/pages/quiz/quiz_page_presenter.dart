import 'package:loco_test/models/Question.dart';
import 'package:loco_test/services/quiz_service.dart';

abstract class QuizPageContract {
  void onNewQuestionLive(Question quiz);
  void onQuestionEnded(); // called when time is over a live question
  void onQuizEnded(); // called when the quiz is over
}

class QuizPagePresenter {
  QuizPageContract _view;
  QuizService _service;
  QuizPagePresenter(this._view) {
    _service = new QuizService();
  }
}