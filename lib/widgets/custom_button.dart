import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF34C66E), //  Default Green Color
    this.width = 335, //  Default Width
    this.height = 61, //  Default Height
    this.borderRadius = 16, //  Default Border Radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // ✅ Fully Responsive
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunitoSans(
            fontSize: 22.sp,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
