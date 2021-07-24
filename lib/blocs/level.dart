import 'package:rxdart/subjects.dart';

import '/models/level.dart';
import 'api.dart';

class LevelBloc {
  LevelBloc._();
  static LevelBloc _instance = LevelBloc._();
  static LevelBloc get instance => _instance;
  static final _api = Api.instance;
  static final BehaviorSubject<List<Level>> _subject = BehaviorSubject();
  List<Level> _levels;

  Future<bool> initialize() async {
    return _refreshLevels;
  }

  Future<bool> get _refreshLevels async {
    _levels = await _api.levels.then((values) => values.map((level) => Level.fromJson(level)).toList(growable: false));
    if (_levels != null) {
      _subject.add(_levels);
      return true;
    }
    return false;
  }

  Stream<List<Level>> get stream => _subject;

  Stream<List<String>> get levelStream {
    _refreshLevels;
    return _subject.map((levels) => levels.map((level) => level.level).toSet().toList(growable: false));
  }

  Stream<List<String>> classYearStream(String lev) {
    _refreshLevels;
    return _subject.map((levels) => levels.where((element) => element.level == lev).map((level) => level.classYear).toSet().toList(growable: false));
  }

  Level find({level, classYear}) => _levels.firstWhere((lev) => lev.level == level && lev.classYear == classYear);
}
