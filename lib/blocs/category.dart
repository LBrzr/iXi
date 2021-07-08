import 'api.dart';

class CategoryBloc {
  CategoryBloc._();
  static final CategoryBloc _instance = CategoryBloc._();
  static CategoryBloc get instance => _instance;
  static final _api = Api.instance;

}