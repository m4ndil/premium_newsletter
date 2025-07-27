import '../entities/user_credentials.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(UserCredentials credentials) async {
    return await repository.login(credentials);
  }
}
