class Level {
  final int id;
  final String level, classYear;

  Level._(this.id, this.level, this.classYear);
  factory Level.fromJson(Map<String, dynamic> data) => Level._(data['id'], data['level'], data['class_year']);

  @override
  String toString() {
    return 'Level{id: $id, level: $level, classYear: $classYear}';
  }

  String get toDisplay => '$level/$classYear';
}