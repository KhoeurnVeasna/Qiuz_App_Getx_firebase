import 'package:flutter/material.dart';
import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/utils/fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.introBk2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.introBk2,
        title: Text('Profile page',style: AppFonts.userText,),
      ),
    );
  }
}