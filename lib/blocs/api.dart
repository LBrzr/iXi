import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart';

import 'session.dart';

List<Map<String, dynamic>> _levels = [
  {
    'id': 1, 'level': 'Lycée', 'class_year': 'Tle',
  },
  {
    'id': 2, 'level': 'Lycée', 'class_year': '1ere',
  },
  {
    'id': 3, 'level': 'Lycée', 'class_year': '2nd',
  }
];

final _token = 'ldqhlkdhqlmdkhqmlkhq54dwhlwfh5qd4h',
  _profile = {
      'user': {
        'id': 0,
        'username': 'LBrzr',
        'email': 'akakpoleandre0@gmail.com',
      },
      'level': _levels[1]
    },
  _pro = [
    {
      'id': 0,
      'content': '0'
    },
    {
      'id': 1,
      'content': '1'
    },
    {
      'id': 2,
      'content': '2'
    },
    {
      'id': 3,
      'content': '3'
    },
    {
      'id': 4,
      'content': '4'
    },
    {
      'id': 5,
      'content': '5'
    },
    {
      'id': 6,
      'content': '6'
    },
    {
      'id': 7,
      'content': '7'
    },
    {
      'id': 8,
      'content': '8'
    },
    {
      'id': 9,
      'content': '9'
    },
  ],
  _res = [
    {
      'id': 0,
      'content': '0'
    },
    {
      'id': 1,
      'content': '2'
    },
    {
      'id': 2,
      'content': '4'
    },
    {
      'id': 3,
      'content': '6'
    },
    {
      'id': 4,
      'content': '8'
    },
  ],
  _enun = [
    '0+0',
    '1+1',
    '2+2',
    '3+3',
    '4+4',
  ],
  _ques = [
    {
      'id': 0,
      'enunciation': _enun[0],
      'response': _res[0],
      'propositions': [
        _pro[0],
        _pro[1]
      ]
    },
    {
      'id': 1,
      'enunciation': _enun[1],
      'response': _res[1],
      'propositions': [
        _pro[2],
        _pro[3]
      ]
    },
    {
      'id': 2,
      'enunciation': _enun[2],
      'response': _res[2],
      'propositions': [
        _pro[4],
        _pro[5]
      ]
    },
    {
      'id': 3,
      'enunciation': _enun[3],
      'response': _res[3],
      'propositions': [
        _pro[6],
        _pro[7]
      ]
    },
    {
      'id': 4,
      'enunciation': _enun[4],
      'response': _res[4],
      'propositions': [
        _pro[8],
        _pro[9]
      ]
    },
  ],
  _quiz = [
    {
      'id': 0,
      'tags': {'Algèbre'},
      'questions': [
        _ques[0],
        _ques[1]
      ],
      'note': 0,
      'visible': true,
      'creator': _profile,
      'creation_date': '2020-06-11 16:18',
    },
    {
      'id': 1,
      'tags': {'Algèbre'},
      'questions': [
        _ques[2],
        _ques[3]
      ],
      'note': 0,
      'visible': true,
      'creator': _profile,
      'creation_date': '2019-06-11 16:18',
    },
    {
      'id': 2,
      'tags': {'Algèbre'},
      'questions': [
        _ques[0],
        _ques[1]
      ],
      'note': 0,
      'visible': false,
      'creator': _profile,
      'creation_date': '2020-06-11 16:18',
    },
    {
      'id': 3,
      'tags': {'Algèbre'},
      'questions': [
        _ques[0],
        _ques[1]
      ],
      'note': 0,
      'visible': false,
      'creator': _profile,
      'creation_date': '2020-06-11 16:18',
    },
];

class Api {
  Api._();
  static final Api _instance = Api._();
  static Api get instance => _instance;
  static const String _API_URL = 'https://ixi-api.herokuapp.com/';
  static final session = Session.instance;

  Future<T> _sendRequest<T>(String method, String route, Map<String, dynamic> body, T Function(String) onOk, {Function onNotOk, addAuth = true}) async {
    var request = Request(method, Uri.parse(_API_URL+route));
    request.headers.addAll({'content-type': 'application/json'});
    if (addAuth && session.token != null)
      request.headers.addAll({'Authorization': 'Token ${session.token}'});
    request.body = jsonEncode(body);

    StreamedResponse response = await request.send();

    final contents = await response.stream.bytesToString();
    print(contents); // todo stack

    final data = contents.toString();

    if (response.statusCode == 200) {
      return onOk(data);
    } else {
      print(response.reasonPhrase);
      if (onNotOk != null)
        return onNotOk();
      return null;
    }
  }

  Future<Map<String, dynamic>> signup({@required String email, @required String password, @required String username, @required int levelId}) async {
    final body = {
      'user': {
        'email': email,
        'password': password,
        'username': username,
      },
      'level': levelId
    },
    method = 'POST',
    route = 'account/register';
    return _sendRequest(method, route, body, jsonDecode).then((data) =>  data as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> login({@required String username, @required String password}) async {
    final body = {'password': password, 'username': username},
    method = 'POST',
    route = 'account/login';
    return _sendRequest(method, route, body, jsonDecode).then((data) =>  jsonDecode(data) as Map<String, dynamic>);
  }

  Future<bool> logout() async {
    return _sendRequest('POST', 'account/logout', {}, (data) => true, onNotOk: () => false);
  }

  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> userData) async {
    return {
      'id': 0,
      'username': userData['username'],
      'email': userData['email'],
      'level': _levels[userData['level']]
    };
  }

  Future<List<Map<String, dynamic>>> searchFromTheme(String theme) async {
    return null;
  }

  Future<List<Map<String, dynamic>>> search(int catId, String theme) async {
    return null;
  }

  Future<Map<String, dynamic>> creatQuiz() async {
    // todo return _sendRequest('GET', 'quiz/tags', {}, (data) => (data as List<String>).toSet());
  }

  Future<Set<String>> get tags async {
    return _sendRequest('GET', 'quiz/tags', {}, (data) => Set.from(jsonDecode(data)));
  }

  Future<List<Map<String, dynamic>>> get levels async {
    final response = await (await HttpClient().getUrl(Uri.parse(_API_URL+ 'account/levels'))).close();
    if (response.statusCode == 200) {
      final contents = StringBuffer();
      await for (var data in response.transform(utf8.decoder)) {
        contents.write(data);
      }
      return _levels = (jsonDecode(contents.toString()) as List).map((datum) => datum as Map<String, dynamic>).toList(growable: false);
    } else {
      print(response.reasonPhrase);
      final contents = StringBuffer();
      await for (var data in response.transform(utf8.decoder)) {
        contents.write(data);
      }
      return null;
    }
  }

  Future<List> suggestions(int levelId) async {
    print('getting suggestions'); // todo stack
    return _sendRequest('GET', 'quiz', {'level': levelId}, (data) => jsonDecode(data));
  }

  Future<List> get userQuiz async {
    print('getting user quiz'); // todo stack
    return _sendRequest('GET', 'quiz/user', {}, (data) => jsonDecode(data));
  }

  Future<Map<String, dynamic>> get userStats async {
    print('getting user stats'); // todo stack
    return _sendRequest('GET', 'quiz/user/stats', {}, (data) => jsonDecode(data) as Map<String, dynamic>);
  }
}
