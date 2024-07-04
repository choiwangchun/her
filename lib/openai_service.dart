import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'persona_service.dart';

class OpenAIService {
  static Future<String> getResponse(String prompt) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    if (apiKey == null || apiKey.isEmpty) {
      return 'Error: OpenAI API key not found or empty';
    }

    try {
      final persona = await PersonaService.getPersona();
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o',
          'messages': [
            {'role': 'system', 'content': '당신은 다음 페르소나를 가진 이성친구 입니다. 사용자와 대화를 통해 교감하세요.\n$persona'},
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          return data['choices'][0]['message']['content'];
        } else {
          return 'Error: Unexpected response format';
        }
      } else {
        final errorBody = jsonDecode(utf8.decode(response.bodyBytes));
        return 'Error ${response.statusCode}: ${errorBody['error']['message']}';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}