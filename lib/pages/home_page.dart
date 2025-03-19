import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:quiz_project/controllers/quiz_controller.dart';
import 'package:quiz_project/pages/takequestion_page.dart'
    show TakequestionPage;

import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/utils/fonts.dart';
import '../model/quiz.dart';
import '../services/firebase_auth/firebase_authentication.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final QuizController _quizController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.introBk,
      appBar: AppBar(
        backgroundColor: AppColor.introBk2,
        foregroundColor: AppColor.whiteBk,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
          child: CircleAvatar(
            maxRadius: 25,
            backgroundImage:
                AssetImage('assets/images/6138607846787497697_99.jpg'),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: FaIcon(FontAwesomeIcons.magnifyingGlass)),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () async {
                await FirebaseAuthentication().logout();
              },
              icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Let\'s Start\nit is you have Fun!',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.introTxt),
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                itemCount: _quizController.quizzes.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final Quiz quiz = _quizController.quizzes[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        TakequestionPage(
                          index: index,
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      color: index == 0
                          ? Color(0xFFFE7747)
                          : index == 1
                              ? Color(0xFF182B88)
                              : index == 2
                                  ? Color(0xFF8F98FD)
                                  : index == 3
                                      ? Color(0xFFDB2855)
                                      : Colors.white,
                      margin: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.network(
                                quiz.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              quiz.title,
                              style: AppFonts.subTitleFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
