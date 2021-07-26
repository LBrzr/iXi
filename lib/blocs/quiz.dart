import 'package:rxdart/subjects.dart';

import '/models/quiz.dart';

import 'api.dart';
import 'user.dart';

class QuizBloc {
  QuizBloc._();
  static QuizBloc _instance = QuizBloc._();
  static QuizBloc get instance => _instance;
  static final Api _api = Api.instance;
  static final UserBloc _userBloc = UserBloc.instance;
  final _suggestionSubject = BehaviorSubject<List<Quiz>>(),
    _fromUserSubject = BehaviorSubject<List<Quiz>>(),
    _userStatsSubject = BehaviorSubject<Map<String, dynamic>>();

  Quiz _quizBuilder(quiz) {
    print(quiz['id']); // todo
    return Quiz.fromJson(quiz);
  }

  Future get _refreshSuggestions => _api.suggestions(_userBloc.user.level.id).then((quizList) {
    if (quizList != null)
      _suggestionSubject.add(quizList.map(_quizBuilder).toList(growable: false));
  });

  Stream<List<Quiz>> get suggestions {
    _refreshSuggestions;
    return _suggestionSubject;
  }

  Future get _refreshFromUser => _api.userQuiz.then((quizList) {
    if (quizList != null)
      _fromUserSubject.add(quizList.map(_quizBuilder).toList(growable: false));
  });

  Stream<List<Quiz>> get fromUser {
    _refreshFromUser;
    return _fromUserSubject;
  }

  Future get _refreshUserStats => _api.userStats.then((stats) {
    if (stats != null)
      _userStatsSubject.add(stats);
  });

  Stream<Map<String, dynamic>> get userStats {
    _refreshUserStats;
    return _userStatsSubject;
  }
}
