import '/blocs/session.dart';
import '/models/level.dart';
import '/models/user.dart';
import 'api.dart';

class UserBloc {
  UserBloc._() : _user = _session.user;
  static final UserBloc _instance = UserBloc._();
  static UserBloc get instance => _instance;
  static final _api = Api.instance;
  static final _session = Session.instance;

  User? _user;

  bool get isLogged => _user != null;

  Future<User?> login({required String username, required String password}) {
    return _connect(_api.login(email: username, password: password));
  }

  Future<User?> signup({required String email, required String password, required String username, required Level level}) {
    return _connect(_api.signup(email: email, password: password, pseudo: username, level: level.id));
  }

  Future<User?> _connect(Future<Map<String, dynamic>?> task) async {
    return task.then((userData) {
      if (userData != null) {
        return _session.createSession(userData);
      } else {
        return null;
      }
    });
  }

  Future<bool?> update(Map<String, dynamic>? data) async {

  }

  Future<bool> logout() async {
    return _api.logout();
  }
}