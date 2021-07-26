import 'question.dart';
import 'user.dart';

class Quiz {
  final int id;
  final Set<String> tags;
  final num note;
  final bool visible;
  final User creator;
  final DateTime creationDate;
  final List<Question> questions;

  Quiz._(this.id,this.visible, Map<String, dynamic> creator, List tags, String creationDate, List<dynamic> questions, this.note)
    : tags = Set.from(tags),
      creator = User.fromJson(creator),
      creationDate = DateTime.parse(creationDate),
      questions = questions.map((question) => Question.fromJson(question)).toList(growable: false);
  factory Quiz.fromJson(Map<String, dynamic> data) => Quiz._(
    data['id'], data['visible'] ?? false, data['creator'], data['tags'],
    data['creation_date'], data['questions'], data['note']
  );

  @override
  String toString() {
    return 'Quiz{id: $id, note: $note, visible: $visible, creator: $creator, tags: $tags, creationDate: $creationDate, questions: $questions}';
  }
}