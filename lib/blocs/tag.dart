import 'package:rxdart/subjects.dart';

import 'api.dart';

class TagBloc {
  TagBloc._();
  static final TagBloc _instance = TagBloc._();
  static TagBloc get instance => _instance;
  static final _api = Api.instance;
  static final _subject = BehaviorSubject<Set<String>>();

  Stream<Set<String>> get all {
    _refreshTags;
    return _subject;
  }

  Future get _refreshTags async {
    final tags = await _api.tags;
    if (tags != null)
      _subject.add(tags);
  }
}