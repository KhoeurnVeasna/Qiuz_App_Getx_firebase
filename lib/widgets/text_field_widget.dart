import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String? label;
  final String? hint;
  final Color? color;
  final TextEditingController controller;
  final FocusNode? focusNode ; 
  final bool obscureText ;
  final Icon? icon;
  const TextFieldWidget(
      {super.key, this.hint, this.label, required this.controller, this.color,this.focusNode, this.obscureText = false, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.robotoCondensed(
            fontSize: 15, fontWeight: FontWeight.w800, color: AppColor.introBk),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 159, 188, 221),
        prefixIcon: icon,
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    ),
  );
  }
}
