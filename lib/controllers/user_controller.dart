import 'package:cc/services/authentication_service.dart';

class UserController {
  final AuthenticationService _authService = AuthenticationService();

  Future<bool> login(String email, String password) async {
    try {
      await _authService.login(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
