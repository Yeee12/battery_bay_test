import '../services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<bool> register(Map<String, dynamic> userData) async {
    final response = await _apiService.postRequest("create-account", {
      "server_key": dotenv.env['SERVER_KEY'],
      ...userData,  // Expands userData from the form
    });
    return response["status"] == "success";
  }

  Future<bool> login(String email, String password) async {
    final response = await _apiService.postRequest("auth", {
      "server_key": dotenv.env['SERVER_KEY'],
      "email": email,
      "password": password,
    });

    if (response["status"] == "success") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", response["token"]);  // Save token
      return true;
    }
    return false;
  }
}
