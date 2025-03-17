import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_project/theme/colors.dart';

class AppFonts {
  static var titleFont = GoogleFonts.robotoCondensed(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static var subTitleFont = GoogleFonts.robotoCondensed(
    fontSize: 18,
    color: AppColor.introTxt,
    fontWeight: FontWeight.bold,
  );
  static var titleBlue = GoogleFonts.koulen(
      fontSize: 20,
     color: Colors.blue[300]
  );
  static var mainTitleBule = GoogleFonts.koulen(
    fontSize: 35,
     color: Colors.blue[300]
  ) ;
  
}