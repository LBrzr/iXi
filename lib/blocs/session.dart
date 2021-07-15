import 'package:shared_preferences/shared_preferences.dart';

import '/models/user.dart';

class Session {
  Session._();
  static Session _instance = Session._();
  static Session get instance => _instance;

  static const String _IS_USER_REGISTERED = 'isUserRegistered',
    _TOKEN_EXPIRE_DATE = 'expire', // todo handle token expiration
    _USER_ID = 'userID',
    _USERNAME = 'username',
    _USER_EMAIL = 'userEmail',
    _USER_PP = 'userPp',
    _LEVEL_ID = 'levelId',
    _LEVEL_LEVEL = 'levelLevel',
    _LEVEL_CLASS_YEAR = 'levelClassYear';

  late SharedPreferences prefs;
  User? user;

  Future<bool> initialize() async {
    prefs = await SharedPreferences.getInstance();
    if (isUserRegistered) {
      _userData = {
        'id': _userId,
        'email': _userEmail,
        'username': _username,
        'pp': _userPp,
        'level': {
          'id': _levelId,
          'level': _levelLevel,
          'class_year': _levelClassYear,
        }
      };
      user = User.fromJson(_userData);
      return true;
    }
    return false;
  }

  bool get isUserRegistered => prefs.getBool(_IS_USER_REGISTERED) ?? false;

  int? get _userId => prefs.getInt(_USER_ID);
  String? get _userEmail => prefs.getString(_USER_EMAIL);
  String? get _username => prefs.getString(_USERNAME);
  String? get _userPp => prefs.getString(_USER_PP);
  int? get _levelId => prefs.getInt(_LEVEL_ID);
  String? get _levelLevel => prefs.getString(_LEVEL_LEVEL);
  String? get _levelClassYear => prefs.getString(_LEVEL_CLASS_YEAR);

  set _userId(int? id) => prefs.setInt(_USER_ID, id!);
  set _userEmail(String? email) => prefs.setString(_USER_EMAIL, email!);
  set _username(String? username) => prefs.setString(_USERNAME, username!);
  set _userPp(String? pp) => prefs.setString(_USER_PP, pp!);
  set _levelId(int? id) => prefs.setInt(_LEVEL_ID, id!);
  set _levelLevel(String? level) => prefs.setString(_LEVEL_LEVEL, level!);
  set _levelClassYear(String? classYear) => prefs.setString(_LEVEL_CLASS_YEAR, classYear!);

  late Map<String, dynamic> _userData;

  Map<String, dynamic> get userData => _userData;

  void _registerUserInfo(Map<String, dynamic> userData) {
    _userData = userData;
    _userId = userData['id'];
    _username = userData['username'];
    _userEmail = userData['email'];
    _userPp = userData['pp'];
    _levelId = userData['level']['id'];
    _levelLevel = userData['level']['level'];
    _levelClassYear = userData['level']['class_year'];
  }

  Future<User> createSession(Map<String, dynamic> userData) async {
    _registerUserInfo(userData);
    return User.fromJson(userData);
  }
}