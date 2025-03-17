import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_project/controllers/question_controller.dart';
import 'package:quiz_project/screens/main_page.dart';
import 'package:quiz_project/utils/fonts.dart';
import 'package:quiz_project/widgets/button_submit_widget.dart';

import '../theme/colors.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionController questionController = Get.find();
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Game Over',
                  style: AppFonts.mainTitleBule,
                ),
                Image(image: AssetImage('assets/logos/logoapp.png')),
                Text(
                  'You Got ',
                  style: AppFonts.subTitleFont,
                ),
                Obx(() {
                  return Text(
                    '${questionController.totalScore.value} : Score',
                    style: AppFonts.mainTitleBule,
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 150,
                  height:50,
                  child: ButtonSubmitWidget(
                    onPressed: () {
                      Get.to(MainPage());
                    },
                    text: 'Finish',
                    color: AppColor.introBk,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
