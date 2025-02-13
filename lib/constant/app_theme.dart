import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';  // Import the colors.dart file

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor, // Green primary color
  scaffoldBackgroundColor: AppColors.whiteColor, // White background color
  textTheme: TextTheme(
    displayLarge: GoogleFonts.raleway(
      fontSize: 52,
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 13.8,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(128, 128, 128, 0.6), // Using Color.fromRGBO for grey shade with opacity
    ),
    labelLarge: GoogleFonts.nunitoSans(
      fontSize: 22,
      fontWeight: FontWeight.w300,
      color: AppColors.whiteColor,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color.fromRGBO(128, 128, 128, 0.1), // Using Color.fromRGBO for light grey shade with opacity
    contentPadding: const EdgeInsets.symmetric(vertical: 15.81, horizontal: 19.76),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(59.29),
      borderSide: BorderSide.none,
    ),
  ),
);
