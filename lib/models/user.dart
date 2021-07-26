import 'level.dart';

class User {
  final int id;
  final String username, email, pp;
  final Level level;
  User._(this.id, this.username, this.email, this.level, this.pp);
  factory User.fromJson(Map<String, dynamic> data) => User._(data['user']['id'], data['user']['username'], data['user']['email'], Level.fromJson(data['level']), data['pp']);

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, level: $level, pp: $pp}';
  }

  String get toDisplay => '{username: $username, email: $email}';
}