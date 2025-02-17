import 'package:battery_bay_test/views/auth/login_screen.dart';
import 'package:battery_bay_test/views/home/password_screen.dart';
import 'package:flutter/material.dart';
import 'package:battery_bay_test/views/auth/register_screen.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
        case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
            case '/password':
              return MaterialPageRoute(builder: (_) => const PasswordScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
