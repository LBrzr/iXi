import '/models/quiz.dart';

import 'api.dart';
import 'user.dart';

class QuizBloc {
  const QuizBloc._();
  static const QuizBloc _instance = const QuizBloc._();
  static QuizBloc get instance => _instance;
  static final Api _api = Api.instance;
  static final UserBloc _userBloc = UserBloc.instance;

  Future<List<Quiz>> get suggestions {
    return _api.suggestions(_userBloc.user.level.id).then((quizList) => quizList.map((quiz) => Quiz.fromJson(quiz)).toList(growable: false));
  }

  Future<List<Quiz>> get fromUser {
    return _api.userQuiz(_userBloc.user.id).then((quizList) => quizList.map((quiz) => Quiz.fromJson(quiz)).toList(growable: false));
  }
}
