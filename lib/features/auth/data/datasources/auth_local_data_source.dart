import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveLoginStatus(bool isLoggedIn);
  Future<bool> getLoginStatus();
  Future<void> clearLoginData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _isLoggedInKey = 'is_logged_in';

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    await sharedPreferences.setBool(_isLoggedInKey, isLoggedIn);
  }

  @override
  Future<bool> getLoginStatus() async {
    return sharedPreferences.getBool(_isLoggedInKey) ?? false;
  }

  @override
  Future<void> clearLoginData() async {
    await sharedPreferences.remove(_isLoggedInKey);
  }
}