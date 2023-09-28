abstract class AuthRepository {
  Future<bool> login(String username, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login(String username, String password) async {
    bool login = false;
    try {
      if (username == 'spisy10mobile' && password == 'spisy10mobile') {
        login = true;
      } else {
        throw Exception('Login gagal');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return login;
  }
}
