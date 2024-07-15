class Chat {
  final String id;
  final String name;
  String lastMessage;
  final Map<String, String> personality;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.personality,
  });
}

class Message {
  final String content;
  final bool isMe;
  final DateTime timestamp;

  Message({
    required this.content,
    required this.isMe,
    required this.timestamp,
  });
}