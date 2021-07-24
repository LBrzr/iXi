import 'question.dart';
import 'user.dart';

class Quiz {
  final int id;
  final Set<String> tags;
  final String theme;
  final bool visible;
  final User creator;
  final DateTime creationDate;
  final List<Question> questions;

  Quiz._(this.id,this.visible, Map<String, dynamic> creator, this.tags, String creationDate, List<Map<String, dynamic>> questions, this.theme)
    : creator = User.fromJson(creator),
      creationDate = DateTime.parse(creationDate),
      questions = questions.map((question) => Question.fromJson(question)).toList(growable: false);
  factory Quiz.fromJson(Map<String, dynamic> data) => Quiz._(data['id'], data['visible'] ?? false, data['creator'], data['tags'], data['creation_date'], data['questions'], data['theme']);

  num get note => 0;

  @override
  String toString() {
    return 'Quiz{id: $id, theme: $theme, visible: $visible, creator: $creator, tags: $tags, creationDate: $creationDate, questions: $questions}';
  }
}