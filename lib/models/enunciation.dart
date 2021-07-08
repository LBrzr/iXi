class Enunciation {
  final int id;
  final String content;

  Enunciation._(this.id, this.content);
  factory Enunciation.fromJson(Map<String, dynamic> data) => Enunciation._(data['id'], data['content']);
}