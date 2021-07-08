class Api {
  Api._();
  static final Api _instance = Api._();
  static Api get instance => _instance;

  Future<Map<String, dynamic>?> login({required String email, required String password}) async {
    return null;
  }

  Future<bool> logout() async {
    return true;
  }

  Future<Map<String, dynamic>?> signup({required String email, required String password, required String pseudo, required int level}) async {
    return null;
  }

  /* todo
  Future<Map<String, dynamic>?> searchFromCategory(int catId) async {
    return null;
  }

  Future<Map<String, dynamic>?> searchFromTheme(String theme) async {
    return null;
  }
  */

  Future<Map<String, dynamic>?> search(int catId, String theme) async {
    return null;
  }

  Future creatQuiz() async {

  }

  Future creatCategory() async {

  }

  Future<List?> get categories async {

  }
}