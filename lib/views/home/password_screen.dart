import 'dart:math';
import 'package:battery_bay_test/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String correctPassword = "";
  String enteredPassword = "";
  bool isWrongPassword = false;

  @override
  void initState() {
    super.initState();
    _getStoredPassword();
  }

  /// Fetch stored password from secure storage
  Future<void> _getStoredPassword() async {
    String? storedPassword = await secureStorage.read(key: "user_password");
    if (storedPassword != null) {
      setState(() {
        correctPassword = storedPassword;
      });
    }
  }

  /// Handle password input
  void _onNumberTap(String digit) {
    if (enteredPassword.length < 8) {
      setState(() {
        enteredPassword += digit;
      });

      if (enteredPassword.length == 8) {
        _verifyPassword();
      }
    }
  }

  /// Check password correctness
  void _verifyPassword() {
    if (enteredPassword == correctPassword) {
      showToast("Password Correct!", Colors.green);
    } else {
      showToast("Wrong Password! Try again.", Colors.red);
      setState(() {
        isWrongPassword = true;
        enteredPassword = ""; // Reset after error
      });
    }
  }
  // delete function
  void _onDeleteTap() {
    if (enteredPassword.isNotEmpty) {
      setState(() {
        enteredPassword = enteredPassword.substring(0, enteredPassword.length - 1);
      });
    }
  }
  /// Show toast messages
  void showToast(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0.sp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Shapes
          Positioned(
            top: -130.h,
            left: -90.w,
            child: Transform.rotate(
              angle: -158 * pi / 180,
              child: ClipPath(
                clipper: CurvedClipper(),
                child: Container(
                  width: 373.53.w,
                  height: 442.65.h,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
          Positioned(
            top: -190.h,
            left: -200.w,
            child: Transform.rotate(
              angle: 1 * pi / 270,
              child: ClipPath(
                clipper: CurvedClipper(),
                child: Container(
                  width: 402.87.w,
                  height: 442.65.h,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),

          /// Avatar
          Positioned(
            top: 130.h,
            left: 120.w,
            child: Container(
              width: 105.w,
              height: 105.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10.r,
                    spreadRadius: 5.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/image.png",
                  width: 85.w,
                  height: 85.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// Greeting Text
          Positioned(
            top: 250.h,
            left: 0.w,
            right: 0.w,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Hello, Dennis!!",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),

          /// Instruction Text
          Positioned(
            top: 300.h,
            left: 0.w,
            right: 0.w,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Type your password",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),

          /// Password Dots Indicator
          Positioned(
            top: 370.h,
            left: 0.w,
            right: 0.w,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(8, (index) {
                  Color dotColor = Colors.grey;

                  if (index < enteredPassword.length) {
                    dotColor = isWrongPassword ? Colors.red : Colors.green;
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    width: 15.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          ),

          /// Number Pad
          Positioned(
            top: 420.h,
            left: 50.w,
            right: 50.w,
            child: Column(
              children: [
                for (var row in ["123", "456", "789", "⌫0"]) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.split('').map((char) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            if (char == "⌫") {
                              _onDeleteTap();
                            } else {
                              _onNumberTap(char);
                            }
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8.r,
                                  spreadRadius: 2.r,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                char,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),

          /// "Forgot Password?" Message (If Wrong)
          if (isWrongPassword)
            Positioned(
              top: 400.h,
              left: 0.w,
              right: 0.w,
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () => (),
                  child:Text(
                    "Forgot your password?",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),

                ),
              ),
            ),

          /// "Not You?" Button
          Positioned(
            top: 740.h,
            left: 130.w,
            child: InkWell(
              onTap: () {
                // Handle "Not You?" button tap
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Not you?",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),

                  SizedBox(width: 5.w),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 16.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Custom Clipper for Background Shape
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at the bottom-left
    path.moveTo(size.width * 0.35, size.height * 0.73);

    // Top-left curve
    path.cubicTo(
      size.width * 0.2, size.height * 0.5, // Control Point 1
      size.width * 0.0, size.height * 0.1,  // Control Point 2
      size.width * 0.4, size.height * 0.1,  // End Point
    );

    // Top-right curve
    path.cubicTo(
      size.width * 0.9, size.height * 0.15,
      size.width * 1.0, size.height * 0.5,
      size.width * 0.85, size.height * 0.8,
    );

    // Bottom-right curve
    path.cubicTo(
      size.width * 0.7, size.height * 1.1,
      size.width * 0.1, size.height * 1.1,
      size.width * 0.3, size.height * 0.6,
    );

    path.close(); // Close the shape

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}