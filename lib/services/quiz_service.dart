import 'dart:async';
import 'dart:math';
import 'package:rxdart/rxdart.dart';
import 'package:loco_test/models/Question.dart';

var questions = [
  new Question("Question 1", ["Choice 1", "Choice 2", "Choice 3"], 2),
  new Question(
      "Question 2: This question will span multiple and probably "
      " occupy more space than any other questions"
      ,
      ["Choice 1", "Choice 2", "Choice 3", "Choice 4", "Choice 5"],
      1
  ),
  new Question("Question 3: This question will span multiple and probably "
      " occupy more space than any other questions", ["Choice 1", "Choice 2", "Choice 3"], 2),
  new Question("Question 2: This question will span multiple and probably "
      " occupy more space than any other questions", ["Choice 1", "Choice 2", "Choice 3"], 2),
  new Question("Question 5", ["Choice 1", "Choice 2", "Choice 3"], 2),
];

class QuizService {
  static final QuizService _instance = new QuizService.internal();
  QuizService.internal();
  factory QuizService() => _instance;



  Observable<Question> getQuestions() {
    var rand = new Random(43);
    // send a new question every 15 seconds
    var quizes = new Observable.periodic(
        new Duration(seconds: 15),
    ([int i]) {
      return questions[rand.nextInt(questions.length - 1)];
    }
    );

    return quizes;
  }

}