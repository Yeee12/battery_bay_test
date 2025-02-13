import 'package:battery_bay_test/constant/colors.dart';
import 'package:battery_bay_test/widgets/custom_button.dart';
import 'package:battery_bay_test/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Curved Shape
          Positioned(
            top: 0,
            left: 0,
            child: ClipPath(
              clipper: CurvedClipper(),
              child: Container(
                width: 170,
                height: 290,
                color: AppColors.secondaryColor,
              ),
            ),
          ),

          // Smaller Green Shape
          Positioned(
            top: 80,
            left: 300,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(80),
              ),
            ),
          ),

          // "Create Account" Text
          Positioned(
            top: 140,
            left: 30,
            child: Column(
              children: [
                Text(
                  "Create\nAccount",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Icon(Icons.camera_alt, size: 60, color: Colors.blue), // Profile Icon
                const SizedBox(height: 20),
                CustomTextField(label: "Email", controller: emailController),
                CustomTextField(label: "Password", controller: passwordController, isPassword: true),
                CustomTextField(label: "Phone Number", controller: phoneController, keyboardType: TextInputType.phone),
                const SizedBox(height: 30),
                CustomButton(text: "Done", onPressed: () {}),
                const SizedBox(height: 10),
                TextButton(onPressed: () {}, child: const Text("Cancel")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for Curved Shape
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height); // Start from bottom-left
    path.lineTo(size.width * 0.8, size.height); // Move right
    path.quadraticBezierTo(size.width, size.height * 0.5, size.width, size.height * 0.8); // Curve
    path.lineTo(size.width, 3); // Move to top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=>false;
}