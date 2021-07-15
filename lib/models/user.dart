import 'level.dart';

class User {
  final int id;
  final String username, email;
  final Level level;
  User._(this.id, this.username, this.email, this.level, );
  factory User.fromJson(Map<String, dynamic> data) => User._(data['id'], data['email'], data['username'], Level.fromJson(data['level']));
}