import 'propositionResponse.dart';

class Question {
  final int id;
  final String enunciation;
  final List<PropositionResponse> propositions;

  Question._(this.id, this.enunciation, List<dynamic> propositions)
    : propositions = propositions.map((data) => PropositionResponse.fromJson(data)).toList(growable: false);
  factory Question.fromJson(Map<String, dynamic> data) => Question._(data['id'], data['enunciation'], data['propositions']);

  @override
  String toString() {
    return 'Question{id: $id, enunciation: $enunciation, propositions: $propositions}';
  }
}