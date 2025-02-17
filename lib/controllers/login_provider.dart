import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String _deviceType = "Unknown";

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get deviceType => _deviceType;

  Future<void> getDeviceType() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (kIsWeb) {
        _deviceType = "Web";
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceType = "Android (${androidInfo.model})";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceType = "iOS (${iosInfo.utsname.machine})";
      } else {
        _deviceType = "Unknown";
      }
      notifyListeners();
    } catch (e) {
      _deviceType = "Error: Unable to detect device";
      print("Error getting device type: $e");
    }
  }

  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await getDeviceType();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://boonbac.com/api/auth"),
      );

      request.fields.addAll({
        "server_key": "3fac1bb71fd9088c8365d8fc9bfa546544a903ea-c7ad5ccda5d17029ba77a0aa60c550c4-15271686",
        "username": usernameController.text.trim(),
        "password": passwordController.text.trim(),
        "device_type": _deviceType,
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      Map<String, dynamic> responseData = json.decode(response.body);

      print("API Response: ${response.body}");

      if (response.statusCode == 200 && responseData["api_status"] == 200) {
        String? userToken = responseData["access_token"];
        await _secureStorage.write(key: "user_token", value: userToken);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = responseData["errors"]?["error_text"] ?? "Login failed!";
        print("Login Error: $_errorMessage");
      }
    } catch (e) {
      _errorMessage = "Something went wrong. Check your internet connection.";
      print("Exception during login: $e");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// ✅ **FIXED: Add validation methods**
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    }
    if (value.length < 5) {
      return "Username must be at least 5 characters long";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Password must contain only numbers";
    }
    if (value.length < 8) {
      return "Password must be at least 8 digits long";
    }
    return null;
  }

  void clearErrors() {
    formKey.currentState?.reset();
    usernameController.clear();
    passwordController.clear();
    _errorMessage = null;
    notifyListeners();
  }
}
