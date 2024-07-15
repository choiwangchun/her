import 'package:flutter/material.dart';
import '/services/chat_service.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('채팅 목록')),
      body: FutureBuilder(
        future: ChatService.getChatList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다.'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('채팅 내역이 없습니다.'));
          } else {
            List chatList = snapshot.data as List;
            return ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatList[index].name),
                  subtitle: Text(chatList[index].lastMessage),
                  onTap: () {
                    Navigator.pushNamed(context, '/chat', arguments: chatList[index].id);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/personality_selection');
        },
      ),
    );
  }
}