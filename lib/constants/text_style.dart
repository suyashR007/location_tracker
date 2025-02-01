import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyTextStyle {
  static TextStyle subText = GoogleFonts.poppins(
    fontSize: 14.sp,
    color: Colors.grey[700],
    fontWeight: FontWeight.bold,
  );

  static TextStyle nameLabel = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle nameValue = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle labelText = GoogleFonts.poppins(
    fontSize: 14.sp,
    color: Colors.grey[700],
    fontWeight: FontWeight.w600,
  );

  static TextStyle valueText = GoogleFonts.poppins(
    fontSize: 14.sp,
    color: Colors.grey[700],
    fontWeight: FontWeight.bold,
  );

  static TextStyle buttonText = const TextStyle(
    color: Colors.black,
  );
}
