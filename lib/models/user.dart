import 'level.dart';

class User {
  final int id;
  final String pseudo, email;
  final Level level;
  User._(this.id, this.pseudo, this.email, this.level);
  factory User.fromJson(Map<String, dynamic> data) => User._(data['id'], data['email'], data['pseudo'], Level.fromJson(data['level']));
}