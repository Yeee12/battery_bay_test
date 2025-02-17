import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<Map<String, dynamic>> postRequest(String endpoint, Map<String, dynamic> data) async {
    final String url = '$baseUrl$endpoint';
    int retryCount = 0;
    final int maxRetries = 3;

    while (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          throw Exception('Failed with status code: ${response.statusCode} - ${response.body}');
        }
      } catch (e) {
        if (retryCount == maxRetries - 1) {
          throw Exception('Failed to connect after $maxRetries attempts: $e');
        }
        retryCount++;
        await Future.delayed(Duration(seconds: 2));  // Wait before retrying
      }
    }

    throw Exception('Unexpected failure');
  }
}
