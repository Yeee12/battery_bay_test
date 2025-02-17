import 'package:battery_bay_test/models/user_model.dart';
import 'package:battery_bay_test/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(); //  Secure Storage

  bool _isLoading = false;
  String? _errorMessage;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ///  **Register User with API**
  Future<bool> register(UserModel user) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://boonbac.com/api/create-account"),
      );

      request.fields.addAll({
        "server_key": user.serverKey,
        "email": user.email,
        "password": user.password,
        if (user.username?.isNotEmpty == true) "username": user.username!,
        if (user.firstName?.isNotEmpty == true) "first_name": user.firstName!,
        if (user.lastName?.isNotEmpty == true) "last_name": user.lastName!,
        if (user.phone?.isNotEmpty == true) "phone_num": user.phone!,
        if (user.confirmPassword?.isNotEmpty == true) "confirm_password": user.confirmPassword!,
        if (user.gender?.isNotEmpty == true) "gender": user.gender!,
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        //  Store password securely
        await _secureStorage.write(key: 'user_password', value: user.password);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Registration failed. Try again!";
      }
    } catch (e) {
      _errorMessage = "Something went wrong. Please check your internet connection.";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }


  ///  **Retrieve stored password**
  Future<String?> getStoredPassword() async {
    return await _secureStorage.read(key: 'user_password');
  }

  ///  **Clear Secure Storage**
  Future<void> clearStoredPassword() async {
    await _secureStorage.delete(key: 'user_password');
  }

  ///  **Clear form errors & reset text fields**
  void clearErrors() {
    formKey.currentState?.reset();
    usernameController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _errorMessage = null;
    notifyListeners();
  }

  ///  **Validation Methods**
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    final emailRegex = RegExp(r'^[\w-]+@[a-zA-Z\d]+\.[a-zA-Z]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Password can contain only numbers";
    }
    if (value.length < 8) {
      return "Password must be at least 8 digits";
    }
    return null;
  }


  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number cannot be empty";
    }
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(value) || value.length < 10) {
      return "Enter a valid phone number";
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    }
    if (value.length < 5) {
      return "Username must be at least 5 characters long";
    }
    return null;
  }

  String? validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName cannot be empty";
    }
    if (value.length < 2) {
      return "$fieldName must be at least 2 characters long";
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm password cannot be empty";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }
}
