import 'category.dart';
import 'question.dart';
import 'user.dart';

class Quiz {
  final id;
  final String? theme;
  final bool visible;
  final User creator;
  final Category category;
  final DateTime creationDate;
  final List<Question> questions;

  Quiz._(this.id,this.visible, Map<String, dynamic> creator, Map<String, dynamic> category, int creationDate, List<Map<String, dynamic>> questions, this.theme)
    : creator = User.fromJson(creator),
      category = Category.fromJson(category),
      creationDate = DateTime.fromMicrosecondsSinceEpoch(creationDate),
      questions = questions.map((question) => Question.fromJson(question)).toList(growable: false);
  factory Quiz.fromJson(Map<String, dynamic> data) => Quiz._(data['id'], data['visible'] ?? false, data['creator'], data['category'], data['creationDate'], data['questions'], data['theme']);

  num get note => 0;
}