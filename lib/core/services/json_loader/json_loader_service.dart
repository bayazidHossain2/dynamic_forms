import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class JsonLoaderService {
  static Future<Map<String, dynamic>> load({required String fileName}) async {
    final String jsonString = await rootBundle.loadString(
      'assets/form_json/$fileName.json',
    );
    final Map<String, dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse;
  }
}
