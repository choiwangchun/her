import 'dart:math';
import '../models/chat.dart';

class ChatService {
  static List<Chat> _chats = [];
  static Random _random = Random();

  static Future<List<Chat>> getChatList() async {
    // TODO: Implement actual chat list fetching from backend
    // For now, we'll return a mock list
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _chats;
  }

  static Future<String> createNewChat(String mbti, String interest, String talkStyle, String age) async {
    // TODO: Implement actual chat creation logic with backend
    // For now, we'll just create a mock chat
    String chatId = 'chat_${_random.nextInt(10000)}';
    _chats.add(Chat(
      id: chatId,
      name: 'AI Friend',
      lastMessage: '안녕하세요! 대화를 시작해볼까요?',
      personality: {
        'mbti': mbti,
        'interest': interest,
        'talkStyle': talkStyle,
        'age': age,
      },
    ));
    return chatId;
  }

  static Future<List<Message>> getMessages(String chatId) async {
    // TODO: Implement actual message fetching from backend
    // For now, we'll return a mock list of messages
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      Message(content: '안녕하세요! 대화를 시작해볼까요?', isMe: false, timestamp: DateTime.now().subtract(Duration(minutes: 5))),
    ];
  }

  static Future<Message> sendMessage(String chatId, String content) async {
    // TODO: Implement actual message sending logic with backend
    // For now, we'll just create a mock response
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    Message userMessage = Message(content: content, isMe: true, timestamp: DateTime.now());

    // Generate a mock AI response
    String aiResponse = _generateMockAIResponse(content);
    Message aiMessage = Message(content: aiResponse, isMe: false, timestamp: DateTime.now().add(Duration(seconds: 2)));

    return aiMessage;
  }

  static String _generateMockAIResponse(String userMessage) {
    List<String> responses = [
      '그렇군요. 더 자세히 말씀해 주시겠어요?',
      '흥미로운 이야기네요. 어떻게 그렇게 생각하게 되셨나요?',
      '정말 재미있는 주제에요! 저도 그 부분에 대해 관심이 많아요.',
      '그 경험이 당신에게 어떤 영향을 미쳤나요?',
      '당신의 의견에 동의해요. 다른 측면에서는 어떻게 보시나요?',
    ];
    return responses[_random.nextInt(responses.length)];
  }
}