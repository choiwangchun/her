import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<bool> login(String email, String password) async {
    // TODO: Implement actual login logic with backend
    // For now, we'll just simulate a successful login
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    return true;
  }

  static Future<bool> register(String email, String password) async {
    // TODO: Implement actual registration logic with backend
    // For now, we'll just simulate a successful registration
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    return true;
  }

  static Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    return true;
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user_email');
  }

  static Future<String?> getCurrentUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }
}