import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator; // ✅ Add validator

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator, // ✅ Accept validator function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.88), // Gap between fields
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator, //  Apply validation
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            fontSize: 13.8.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[300],
          ),
          filled: true,
          fillColor: Colors.grey[100], //  Grey background
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.81.w,
            horizontal: 19.76.h,
          ),
        ),
      ),
    );
  }
}
