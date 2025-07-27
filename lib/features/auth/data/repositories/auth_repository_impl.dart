import '../../domain/entities/user_credentials.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<bool> login(UserCredentials credentials) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Demo login logic - accept demo@example.com with demo123
    if (credentials.email == 'demo@example.com' &&
        credentials.password == 'demo123') {
      await localDataSource.saveLoginStatus(true);
      return true;
    }

    return false;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearLoginData();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.getLoginStatus();
  }
}