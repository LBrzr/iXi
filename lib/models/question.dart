import 'propositionResponse.dart';
import 'enunciation.dart';

class Question {
  final int id;
  final Enunciation enunciation;
  final List<PropositionResponse> propositions;
  final PropositionResponse response;

  Question._(this.id, Map<String, dynamic> enunciation, this.propositions, this.response)
    : enunciation = Enunciation.fromJson(enunciation);
  factory Question.fromJson(Map<String, dynamic> data) => Question._(data['id'], data['enunciation'], data['propositions'], data['response']);
}