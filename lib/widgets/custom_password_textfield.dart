import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator; // ✅ Add validator

  const CustomPasswordField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator, // ✅ Accept validator function
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true; // Initially hide password

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.88), // Gap between fields
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText, // Hide or show text
        validator: widget.validator, //  Use validator
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(fontSize: 13.8.sp, fontWeight: FontWeight.w500, fontFamily: "Poppins", color: Colors.grey[400]),
          filled: true,
          fillColor: Colors.grey[200], // ✅ Grey background
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText; // ✅ Toggle visibility
              });
            },
          ),
        ),
      ),
    );
  }
}
