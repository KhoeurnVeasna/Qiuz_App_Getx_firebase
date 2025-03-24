import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme/colors.dart';

class Changelanguage extends StatelessWidget {
  const Changelanguage({super.key});

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
                    child: Image.asset(
                      'assets/logos/logoapp.png',
                      width: 300,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                changelanguage(
                    'ភាសាខ្មែរ', 'assets/logos/cambodiaflage.png', context),
                SizedBox(
                  height: 20,
                ),
                changelanguage(
                    'English', 'assets/logos/englishflag.png', context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
Widget changelanguage(String language,String image ,BuildContext context){
  return SizedBox(
    height: 60,
    width: 250,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(EdgeInsets.all(
          10,
        )),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))),
      ),
      onPressed: () async{
        Navigator.pop(context);
        
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(
            width: 40,
          ),
          Text(
            language,
            style: TextStyle(
                fontFamily: GoogleFonts.koulen().fontFamily,
                fontSize: 20,
                color: Colors.blue[300]),
          ),
        ],
      ),
    ),
  );
}