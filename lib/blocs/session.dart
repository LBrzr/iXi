import 'package:shared_preferences/shared_preferences.dart';

import '/models/user.dart';

class Session {
  Session._();
  static Session _instance = Session._();
  static Session get instance => _instance;

  static const String _IS_USER_REGISTERED = 'isUserRegistered',
  // todo handle token expiration _TOKEN_EXPIRE_DATE = 'expire',
    _TOKEN = 'token',
    _USER_ID = 'userID',
    _USERNAME = 'username',
    _USER_EMAIL = 'userEmail',
    _USER_PP = 'userPp',
    _LEVEL_ID = 'levelId',
    _LEVEL_LEVEL = 'levelLevel',
    _LEVEL_CLASS_YEAR = 'levelClassYear';

  SharedPreferences prefs;
  User _user;

  Map<String, dynamic> _profileData;

  Map<String, dynamic> get userData => _profileData;

  User get user => _user;

  Future<bool> initialize() async {
    prefs = await SharedPreferences.getInstance();
    if (isUserRegistered) {
      _profileData = {
        'user': {
          'id': _userId,
          'email': _userEmail,
          'username': _username,
        },
        'pp': _userPp,
        'level': {
          'id': _levelId,
          'level': _levelLevel,
          'class_year': _levelClassYear,
        }
      };
      _user = User.fromJson(_profileData);
      return true;
    }
    return false;
  }

  bool get isUserRegistered => prefs.getBool(_IS_USER_REGISTERED) ?? false;
  String get token => prefs.getString(_TOKEN);
  String get _userEmail => prefs.getString(_USER_EMAIL);
  String get _username => prefs.getString(_USERNAME);
  String get _userPp => prefs.getString(_USER_PP);
  String get _levelLevel => prefs.getString(_LEVEL_LEVEL);
  String get _levelClassYear => prefs.getString(_LEVEL_CLASS_YEAR);
  int get _userId => prefs.getInt(_USER_ID);
  int get _levelId => prefs.getInt(_LEVEL_ID);

  set _isUserRegistered(bool _is) => prefs.setBool(_IS_USER_REGISTERED, _is);
  set _token(String token) => prefs.setString(_TOKEN, token);
  set _userId(int id) => prefs.setInt(_USER_ID, id);
  set _userEmail(String email) => prefs.setString(_USER_EMAIL, email);
  set _username(String username) => prefs.setString(_USERNAME, username);
  set _userPp(String pp) => prefs.setString(_USER_PP, pp);
  set _levelId(int id) => prefs.setInt(_LEVEL_ID, id);
  set _levelLevel(String level) => prefs.setString(_LEVEL_LEVEL, level);
  set _levelClassYear(String classYear) => prefs.setString(_LEVEL_CLASS_YEAR, classYear);

  User _registerSession(Map<String, dynamic> sessionData) {
    _token = sessionData['token'];
    _isUserRegistered = true;
    return updateUserData(sessionData['profile']);
  }

  User createSession(Map<String, dynamic> sessionData) {
    return _registerSession(sessionData);
  }

  void deleteSession() {
    _profileData = null;
    _eraseUserData();
  }

  void _eraseUserData() {
    prefs.clear();
  }

  User updateUserData(Map<String, dynamic> profileData) {
    final userData = profileData['user'];
    _profileData = userData;
    _userId = userData['id'];
    _username = userData['username'];
    _userEmail = userData['email'];
    if (profileData['pp'] != null) _userPp = profileData['pp'];
    final levelData = profileData['level'];
    _levelId = levelData['id'];
    _levelLevel = levelData['level'];
    _levelClassYear = levelData['class_year'];
    return _user = User.fromJson(profileData);
  }
}