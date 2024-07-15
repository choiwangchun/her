import 'package:flutter/material.dart';
import '/services/user_service.dart';
import '/widgets/user_info_form.dart';

class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('추가 정보 입력')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: UserInfoForm(
          onSubmit: (String gender, int age, String mbti) async {
            try {
              await UserService.updateUserInfo(gender, age, mbti);
              Navigator.pushReplacementNamed(context, '/chat_list');
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('정보 저장에 실패했습니다.')),
              );
            }
          },
        ),
      ),
    );
  }
}