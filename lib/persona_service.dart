import 'package:flutter/services.dart' show rootBundle;

class PersonaService {
  static Future<String> getPersona() async {
    try {
      return await rootBundle.loadString('assets/persona/persona.md');
    } catch (e) {
      print('Error loading persona: $e');
      return '';
    }
  }
}