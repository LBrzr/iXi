import 'package:flutter/cupertino.dart';

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

  User _user;

  User get user => _user;

  bool get isLogged => _user != null;

  Future<User> login({@required String username, @required String password}) {
    return _connect(_api.login(email: username, password: password));
  }

  Future<User> signup({@required String email, @required String password, @required String username, @required Level level}) {
    return _connect(_api.signup(email: email, password: password, username: username, levelId: level.id));
  }

  Future<User> _connect(Future<Map<String, dynamic>> task) async {
    return task.then((sessionData) {
      if (sessionData != null) {
        return _user = _session.createSession(sessionData);
      } else {
        return null;
      }
    });
  }

  Future<bool> update({String email, String password, String username, Level level}) async {
    return _api.updateUser({
      'id': user.id,
      'username': username ?? user.username,
      'email': email ?? user.email,
      'level': level?.id ?? user.level.id
    }).then((userData) {
      final user = _session.updateUserData(userData);
      if (user != null) {
        _user = user;
        return true;
      } else return false;
    });
  }

  Future<bool> logout() async {
    return _api.logout().then((_is) {
      if (_is)
        _session.deleteSession();
      return _is;
    });
  }
}