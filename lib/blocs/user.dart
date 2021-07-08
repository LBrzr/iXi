import '/models/level.dart';
import '/models/user.dart';

import 'api.dart';

class UserBloc {
  UserBloc._();
  static final UserBloc _instance = UserBloc._();
  static UserBloc get instance => _instance;
  static final _api = Api.instance;

  Future<User?> login({required String email, required String password}) {
    return _connect(_api.login(email: email, password: password));
  }

  Future<User?> signup({required String email, required String password, required String pseudo, required Level level}) {
    return _connect(_api.signup(email: email, password: password, pseudo: pseudo, level: level.id));
  }

  Future<User?> _connect(Future<Map<String, dynamic>?> task) async {
    return task.then((value) {
      final user = value;
      if (user != null) {
        return User.fromJson(user);
      } else {
        return null;
      }
    });
  }

  Future<bool> logout() async {
    return true;
  }
}