import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz_project/controllers/quiz_controller.dart';
import 'package:quiz_project/controllers/question_controller.dart';
import 'package:quiz_project/model/quiz.dart';

import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/utils/fonts.dart';

class TakequestionPage extends StatefulWidget {
  const TakequestionPage({super.key, required this.index});
  final int index;

  @override
  State<TakequestionPage> createState() => _TakequestionPageState();
}

class _TakequestionPageState extends State<TakequestionPage> {
  final QuizController quizController = Get.find();
  final QuestionController questionController = Get.find();

  bool startAnimated = false;

  @override
  void initState() {
    super.initState();
    final quiz = quizController.quizzes[widget.index];

    questionController.fetchQuestionsOnce(quiz.id).then((_) {
      if (questionController.questions.isNotEmpty) {
        questionController.resetQuestion();
        questionController.startTime();

        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            startAnimated = true;
          });
        });
      }
    });
  }

  void resetAnimation() {
    setState(() {
      startAnimated = false;
    });

    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        startAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Quiz quiz = quizController.quizzes[widget.index];

    return Scaffold(
      backgroundColor: AppColor.introBk,
      appBar: AppBar(
        backgroundColor: AppColor.introBk2,
        foregroundColor: AppColor.whiteBk,
        title: Text(quiz.title, style: AppFonts.subTitleFont),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Score', style: AppFonts.subTitleFont),
              Obx(() {
                return Text(questionController.scorePerMatch.value.toString());
              })
            ],
          ),
        ),
        actions: [
          Obx(() {
            return Row(
              children: List.generate(
                questionController.health.value,
                (index) => Icon(Icons.favorite, color: Colors.red),
              ),
            );
          }),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.whiteBk,
              ),
              child: Obx(() {
                if (questionController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final questions = questionController.questions;
                if (questions.isEmpty) {
                  return const Center(child: Text('No Questions Found'));
                }

                final safeIndex =
                    (questionController.currentIndex.value < questions.length)
                        ? questionController.currentIndex.value
                        : 0;

                final question = questions[safeIndex];

                return Center(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    question.question,
                    style: AppFonts.titleBlue,
                  ),
                ));
              }),
            ),
          ),
          SizedBox(height: 30),
          Obx(() {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: LinearProgressIndicator(
                    value: questionController.timeleft.value / 30,
                    minHeight: 7,
                    backgroundColor: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Text(
                  questionController.timeleft.toString(),
                  style: AppFonts.subTitleFont,
                ),
              ],
            );
          }),
          SizedBox(height: 30),
          Obx(() {
            if (questionController.questions.isEmpty) {
              return const Center(child: Text("No Questions Available"));
            }

            final questionMain = questionController
                .questions[questionController.currentIndex.value];

            if (questionMain.options.isEmpty) {
              return const Center(child: Text("No Options Available"));
            }

            return Expanded(
              child: Obx(() {
                final questionMain = questionController
                    .questions[questionController.currentIndex.value];

                if (questionMain.options.isEmpty) {
                  return const Center(child: Text("No Options Available"));
                }
                return ListView.builder(
                  itemCount: questionMain.options.length,
                  itemBuilder: (ctx, index) {
                    return Obx(() {
                      return AnimatedOpacity(
                        duration: Duration(
                            milliseconds: 300), 
                        opacity:
                            questionController.isNewQuestion.value ? 0.0 : 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: questionController
                                      .selectAnswerColor
                                      .containsKey(questionMain.options[index])
                                  ? questionController.selectAnswerColor[
                                      questionMain.options[index]]
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(double.infinity,
                                  MediaQuery.of(context).size.height * 0.07),
                            ),
                            onPressed: () {
                              questionController.selectAnswerAndProceed(
                                  questionMain.options[index]);
                            },
                            child: Text(
                              questionMain.options[index],
                              style: AppFonts.titleBlue,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                );
              }),
            );
          })
        ],
      ),
    );
  }
}
