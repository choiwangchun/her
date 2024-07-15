import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserService {
  static Future<bool> updateUserInfo(String gender, int age, String mbti) async {
    // TODO: Implement actual user info update logic with backend
    // For now, we'll just store the info locally
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userInfo = {
      'gender': gender,
      'age': age,
      'mbti': mbti,
    };
    await prefs.setString('user_info', json.encode(userInfo));
    return true;
  }

  static Future<Map<String, dynamic>?> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfoString = prefs.getString('user_info');
    if (userInfoString != null) {
      return json.decode(userInfoString) as Map<String, dynamic>;
    }
    return null;
  }
}