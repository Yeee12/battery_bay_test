import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomPhoneField({Key? key, required this.controller, this.validator}) : super(key: key);

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  String countryCode = "+234"; // Default to Nigeria 🇳🇬

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(59.29.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.w),

          // 🇳🇬 Country Flag (Placeholder Image)
          Image.asset("assets/images/Nigeria.png", width: 24.w, height: 24.h),

          SizedBox(width: 6.w),

          // Dropdown Icon (Tap to change country)
          GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                onSelect: (Country country) {
                  setState(() {
                    countryCode = "+${country.phoneCode}";
                  });
                },
              );
            },
            child: Icon(Icons.arrow_drop_down, size: 24.w),
          ),

          SizedBox(width: 5.w),

          // Divider Line
          Container(height: 30.h, width: 1.w, color: Colors.black),

          SizedBox(width: 12.w),

          // ✅ **Fix: Wrap phone number field with Expanded**
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.phone,
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: "Your Number",
                hintStyle: TextStyle(
                  fontSize: 13.8.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Colors.grey[400],
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15.81.w,
                  horizontal: 19.76.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
