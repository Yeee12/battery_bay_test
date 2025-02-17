import 'dart:math';
import 'package:flutter/material.dart';
import 'package:battery_bay_test/constant/colors.dart';
import 'package:battery_bay_test/controllers/register_provider.dart';
import 'package:battery_bay_test/widgets/custom_button.dart';
import 'package:battery_bay_test/widgets/custom_password_textfield.dart';
import 'package:battery_bay_test/widgets/custom_phone_textfield.dart';
import 'package:battery_bay_test/widgets/custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:battery_bay_test/models/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _selectedGender = "Female";

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<RegisterProvider>(context, listen: false);

    UserModel user = UserModel(
      username: _usernameController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phone: _phoneNumController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      gender: _selectedGender,
      serverKey: "3fac1bb71fd9088c8365d8fc9bfa546544a903ea-c7ad5ccda5d17029ba77a0aa60c550c4-15271686",
    );

    bool success = await provider.register(user);

    if (success) {
      showToast("Registration successful!", Colors.green);
      Navigator.pushNamed(context, '/login');
    } else {
      showToast("Registration failed. Try again!", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Positioned(
            top: 122.h,
            left: 30.w,
            child: Text(
              "Create\nAccount",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          _buildProfilePicture(),
          _buildForm(provider),
          _buildRegisterButton(provider),
          _buildCancelButton(),
        ],
      ),
    );
  }

  /// **Profile Picture Upload**
  Widget _buildProfilePicture() {
    return Positioned(
      top: 280.h,
      left: 30.w,
      child: GestureDetector(
        onTap: () {}, // Add image upload logic
        child: Image.asset(
          "assets/images/Upload Photo.png",
          width: 90.w,
          height: 90.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// **Form Section**
  Widget _buildForm(RegisterProvider provider) {
    return Positioned(
      top: 380.h,
      left: 20.w,
      right: 20.w,
      child: SizedBox(
        height: 210.h,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  label: "Email",
                  controller: _emailController,
                  validator: provider.validateEmail,
                ),
                CustomPasswordField(
                  label: "Password",
                  controller: _passwordController,
                  validator: provider.validatePassword,
                ),
                CustomPhoneField(
                  controller: _phoneNumController,
                  validator: provider.validatePhone,
                ),
                CustomTextField(
                  label: "Username",
                  controller: _usernameController,
                  validator: provider.validateUsername,
                ),
                CustomTextField(
                  label: "First Name",
                  controller: _firstNameController,
                  validator: (value) => provider.validateName(value, "First name"),
                ),
                _buildGenderDropdown(),
                CustomTextField(
                  label: "Last Name",
                  controller: _lastNameController,
                  validator: (value) => provider.validateName(value, "Last name"),
                ),
                CustomPasswordField(
                  label: "Confirm Password",
                  controller: _confirmPasswordController,
                  validator: (value) => provider.validateConfirmPassword(value, _passwordController.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Gender Dropdown**
  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(labelText: "Gender"),
      items: ["Male", "Female"].map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedGender = value ?? "Female");
      },
      validator: (value) => value == null ? "Please select a gender" : null,
    );
  }

  /// **Register Button**
  Widget _buildRegisterButton(RegisterProvider provider) {
    return Positioned(
      top: 650.h,
      left: 10, // Remove left positioning
      right: 10, // Ensure it centers horizontally
      child: provider.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : CustomButton(
        text: "Done",
        onPressed: _register,
      ),
    );

  }

  /// **Cancel Button**
  Widget _buildCancelButton() {
    return Positioned(
      top: 710.h,
      left: 0, // Remove manual positioning
      right: 0, // Ensures it is centered
      child: Center(
        child: TextButton(
          onPressed: () {
            final provider = Provider.of<RegisterProvider>(context, listen: false);
            provider.clearErrors();
            Navigator.pushReplacementNamed(context, '/register');
          },
          child: const Text("Cancel"),
        ),
      ),
    );


  }

  /// **Background Decoration**
  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned(
          top: -130.h,
          left: -90.w,
          child: Transform.rotate(
            angle: -158 * pi / 180,
            child: ClipPath(
              clipper: CurvedClipper(),
              child: Container(
                width: 311.01.w,
                height: 367.3.h,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ),


        Positioned(
          top: 100.h,
          left: 305.w,
          child: Transform.rotate(
            angle: 90 * pi / 180,
            child: ClipPath(
              clipper: CurvedClipper(),
              child: Container(
                width: 243.63.w,
                height: 266.77.h,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),

      ],
    );
  }
}

/// **Flutter Toast Function**
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
