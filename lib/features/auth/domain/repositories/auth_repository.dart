import '../entities/user_credentials.dart';

abstract class AuthRepository {
  Future<bool> login(UserCredentials credentials);
  Future<void> logout();
  Future<bool> isLoggedIn();
}