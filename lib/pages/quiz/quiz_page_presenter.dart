import 'package:loco_test/models/Question.dart';
import 'package:loco_test/services/quiz_service.dart';
import 'package:rxdart/rxdart.dart';

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
    _service.getQuestions().forEach((Question q) => _onNewQuestion(q));
  }

  _onNewQuestion(Question q) {
    _view.onNewQuestionLive(q);
    new Observable.timer(null, new Duration(seconds: 5))
    ..listen((i) { _view.onQuestionEnded(); });
  }
}