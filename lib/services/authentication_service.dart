class AuthenticationService {
  Future<void> login(String email, String password) async {
    print('유저가 로그인한 $email 그리고 비밀번호 확인 $password');
  }
}
