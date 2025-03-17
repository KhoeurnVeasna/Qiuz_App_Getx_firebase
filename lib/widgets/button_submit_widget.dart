import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonSubmitWidget extends StatelessWidget {
  const ButtonSubmitWidget(
      {super.key, this.text, required this.onPressed, this.color, });
  final String? text;
  final VoidCallback? onPressed;
  final Color? color;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
            // AppColor.introBk
            color),
        padding: WidgetStateProperty.all(EdgeInsets.all(
          10,
        )),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        
      ),
      onPressed: onPressed,
      child: Text(
        text!,
        style: TextStyle(
            fontFamily: GoogleFonts.koulen().fontFamily,
            fontSize: 20,
            color: Colors.blue[300]),
      ),
    );
  }
}
