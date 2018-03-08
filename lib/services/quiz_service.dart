class QuizService {
  static final QuizService _instance = new QuizService.internal();
  QuizService.internal();
  factory QuizService() => _instance;
}