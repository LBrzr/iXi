import 'propositionResponse.dart';

class Question {
  final int id;
  final String enunciation;
  final List<PropositionResponse> propositions;
  final PropositionResponse response;

  Question._(this.id, this.enunciation, List<Map<String, dynamic>> propositions, Map<String, dynamic> response)
    : propositions = propositions.map((data) => PropositionResponse.fromJson(data)).toList(growable: false),
      response = PropositionResponse.fromJson(response);
  factory Question.fromJson(Map<String, dynamic> data) => Question._(data['id'], data['enunciation'], data['propositions'], data['response']);

  @override
  String toString() {
    return 'Question{id: $id, enunciation: $enunciation, propositions: $propositions, response: $response}';
  }
}