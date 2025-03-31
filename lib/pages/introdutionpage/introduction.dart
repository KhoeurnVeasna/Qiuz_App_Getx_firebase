import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_project/pages/login_page.dart';
import 'package:quiz_project/services/servies_storage/service_storage.dart';
import 'package:quiz_project/theme/colors.dart';

import '../../widgets/widget.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.introBk,
                  AppColor.introBk2,
                  AppColor.introBk2,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logoHero',
                  child: Image.asset('assets/logos/logoapp.png', width: 300,)),
                Center(
                  child: Text(
                    'សួស្តី! សូមជ្រើសរើសភាសារបស់អ្នក',
                    style: GoogleFonts.koulen(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                chooselangue(
                    'ភាសាខ្មែរ', 'assets/logos/cambodiaflage.png', context, ()async{
                      await ServiceStorage().saveIntroductionPageStatus(true);
                      await ServiceStorage().saveSelectedLanguage('km');
                      Get.updateLocale(Locale('km')); 
                      Get.offAll(LoginPage());
                    }),
                SizedBox(
                  height: 20,
                ),
                chooselangue(
                    'English', 'assets/logos/englishflag.png', context,()async{
                      await ServiceStorage().saveIntroductionPageStatus(true);
                      await ServiceStorage().saveSelectedLanguage('en');
                      Get.updateLocale(Locale('en')); 
                      Get.offAll(LoginPage());
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


