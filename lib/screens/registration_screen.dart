import 'package:flutter/material.dart';
import '/services/auth_service.dart';
import '/widgets/registration_form.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: RegistrationForm(
          onSubmit: (String email, String password) async {
            try {
              await AuthService.register(email, password);
              Navigator.pushReplacementNamed(context, '/user_info');
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('회원가입에 실패했습니다.')),
              );
            }
          },
        ),
      ),
    );
  }
}