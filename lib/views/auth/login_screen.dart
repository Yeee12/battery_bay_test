import 'dart:math';
import 'package:battery_bay_test/constant/colors.dart';
import 'package:battery_bay_test/controllers/login_provider.dart';
import 'package:battery_bay_test/widgets/custom_button.dart';
import 'package:battery_bay_test/widgets/custom_password_textfield.dart';
import 'package:battery_bay_test/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
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

          /// Top Left Larger Background Shape (Primary Color)
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

          /// Top Right Small Background Shape (Primary Color)
          Positioned(
            top: 200.h,
            left: 300.w,
            child: Transform.rotate(
              angle: 156 * pi / 100,
              child: ClipPath(
                clipper: CurvedClipper(),
                child: Container(
                  width: 137.56.w,
                  height: 151.14.h,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),


          /// Bottom Center Large Background Shape (Secondary Color)
          Positioned(
            top: 420.h,
            left: 130.w,
            child: Transform.rotate(
              angle: -148 * pi / 180,
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
            top: 385.h,
            left: 20.w,
            child: Text("Login", style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 32.sp)),
          ),
          Positioned(
            top: 450.h,
            left: 30.w,
            child: Row(
              children: [
                Text("Good to see you back!", style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14.sp)),
                SizedBox(width: 3.w),
                Icon(Icons.favorite_rounded, color: AppColors.blackColor, size: 15.93.sp),
              ],
            ),
          ),
          Positioned(
            top: 480.h,
            left: 20.w,
            right: 20.w,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(label: "Username", controller: loginProvider.usernameController, validator: loginProvider.validateUsername),
                  CustomPasswordField(label: "Password", controller: loginProvider.passwordController, validator: loginProvider.validatePassword),
                ],
              ),
            ),
          ),
          Positioned(
            top: 650.h,
            left: 12.5.w,
            right: 12.5.w,
            child: loginProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              text: "Next",
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  bool success = await loginProvider.login();
                  if (success) {
                    showToast("Successfully logged in!", Colors.green);
                    Navigator.pushNamed(context, '/password');
                  } else {
                    showToast(loginProvider.errorMessage ?? "Login failed!", Colors.red);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


/// Custom Clipper for Background Shapes
/// **Custom Clipper for Background Shape**
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.35, size.height * 0.7);
    path.cubicTo(size.width * 0.2, size.height * 0.5, size.width * 0.0, size.height * 0.1, size.width * 0.4, size.height * 0.1);
    path.cubicTo(size.width * 0.9, size.height * 0.15, size.width * 1.0, size.height * 0.5, size.width * 0.85, size.height * 0.8);
    path.cubicTo(size.width * 0.7, size.height * 1.1, size.width * 0.1, size.height * 1.1, size.width * 0.3, size.height * 0.6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// Toast Function
void showToast(String message, Color color) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.sp,
  );
}
