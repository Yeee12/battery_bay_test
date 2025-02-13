import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.88), // Gap between fields
        child: TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.poppins(
                fontSize: 13.8,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(59.29), // Rounded Border
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.81,
                horizontal: 19.76,
              ),
            ),
            ),
    );
    }
}