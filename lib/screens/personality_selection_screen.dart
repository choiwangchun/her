import 'package:flutter/material.dart';
import '/widgets/personality_selection_form.dart';
import '/services/chat_service.dart';

class PersonalitySelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('이성친구 성격 선택')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: PersonalitySelectionForm(
          onSubmit: (String mbti, String interest, String talkStyle, String age) async {
            try {
              String chatId = await ChatService.createNewChat(mbti, interest, talkStyle, age);
              Navigator.pushReplacementNamed(context, '/chat', arguments: chatId);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('채팅 생성에 실패했습니다.')),
              );
            }
          },
        ),
      ),
    );
  }
}