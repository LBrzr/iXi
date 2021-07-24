import 'api.dart';

class TagBloc {
  TagBloc._();
  static final TagBloc _instance = TagBloc._();
  static TagBloc get instance => _instance;
  static final _api = Api.instance;

  Future<Set<String>> get all async {
    return _api.tags;
  }
}