class Level {
  final int id;
  final String level, classYear;

  Level._(this.id, this.level, this.classYear);
  factory Level.fromJson(Map<String, dynamic> data) => Level._(data['id'], data['level'], data['classYear']);
}