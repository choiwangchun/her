import 'package:flutter/material.dart';
import '/services/auth_service.dart';
import '/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(
          onSubmit: (String email, String password) async {
            try {
              await AuthService.login(email, password);
              Navigator.pushReplacementNamed(context, '/chat_list');
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('로그인에 실패했습니다.')),
              );
            }
          },
        ),
      ),
    );
  }
}