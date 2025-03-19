import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_project/controllers/user_controller.dart';
import 'package:quiz_project/screens/result_page.dart';
import 'package:quiz_project/services/firebase_question.dart';
import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/utils/fonts.dart';
import 'package:quiz_project/widgets/button_submit_widget.dart';
import '../model/question.dart';

class QuestionController extends GetxController {
  final questions = <Question>[].obs;
  final FirebaseQuestion _firebaseQuestion = FirebaseQuestion();
  final isLoading = false.obs;
  final currentIndex = 0.obs;
  final selectAnswer = ''.obs;
  final errorMessage = ''.obs;
  final defaultColor = Colors.white.obs;
  final selectAnswerColor = <String, Color>{}.obs;
  final scorePerQuestion = 20.obs;
  final scorePerMatch = 0.obs;
  final totalScore = 0.obs;
  final health = 3.obs;
  Question get question => questions[currentIndex.value];
  String get correctAnswerText => question.options[question.correctAnswer];
  var timeleft = 10.obs;
  final isNavigating = false.obs;
  Timer? _time;
  var isNewQuestion = false.obs;

  Future<void> fetchQuestionsOnce(String quizId) async {
    isLoading(true);
    isNewQuestion.value = true; // Enable animation when fetching
    try {
      final questionList = await _firebaseQuestion.fetchQuestionsOnce(quizId);
      questions.assignAll(questionList);
      questions.shuffle();
    } catch (e) {
      errorMessage.value = 'Failed to fetch questions: $e';
    } finally {
      isLoading(false);
      Future.delayed(Duration(milliseconds: 300), () {
        isNewQuestion.value = false; // Delay to allow animation to show
      });
    }
  }
  // Future<void> addScore()async{
  //   try {
  //     final scoreAdd = await _firebaseQuestion
  //   } catch (e) {

  //   }
  // }

  void startTime() {
    _time?.cancel();
    timeleft.value = 30;

    _time = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeleft.value > 0) {
        timeleft.value -= 1;
      } else {
        timer.cancel();
        health.value -= 1;
        if (health.value <= 0) {
          showDiologEnd(Get.context!);
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            selectAnswerColor.clear();
            gotoNextQuestion(Get.context!);
          });
        }
      }
    });
  }

  void selectAnswerAndProceed(String answer) {
    if (isNavigating.value) return;
    isNavigating.value = true;

    selectAnswer.value = answer;
    _time?.cancel();

    selectAnswerColor.clear();
    if (answer == correctAnswerText) {
      selectAnswerColor[correctAnswerText] = Colors.green;
      scoreCalanterPerMatch();
    } else {
      selectAnswerColor[answer] = Colors.red;
      selectAnswerColor[correctAnswerText] = Colors.green;
      health.value -= 1;
    }

    if (health.value == 0) {
      Future.delayed(const Duration(seconds: 1), () {
        showDiologEnd(Get.context!);
        isNavigating.value = false;
      });
      return;
    }

    Future.delayed(const Duration(seconds: 1), () {
      selectAnswerColor.clear();
      gotoNextQuestion(Get.context!);
    });
  }

  void scoreCalanterPerMatch() {
    scorePerMatch.value += scorePerQuestion.value; 
  }
  

  void gotoNextQuestion(BuildContext context) {
    if (questions.isEmpty) return;

    if (currentIndex.value < questions.length - 1) {
      isNewQuestion.value = true; // Start animation
      currentIndex.value++;

      selectAnswer.value = '';
      defaultColor.value = Colors.white;
      Future.delayed(const Duration(milliseconds: 300), () {
        isNewQuestion.value = false;
      });

      startTime();
    } else {
      showDiologEnd(context);
      _time?.cancel();
    }
    isNavigating.value = false;
  }

  void addQuestion(String quizId, String questionText, List<dynamic> options,
      int correctAnswerIndex) async {
    isLoading(true);
    try {
      _firebaseQuestion.addQuestionFirebase(
          quizId, questionText, options, correctAnswerIndex);
      Get.snackbar("Add Successful", "Added Successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to add question: $e");
    } finally {
      isLoading(false);
    }
  }

  void resetQuestion() {
    currentIndex.value = 0;
    selectAnswer.value = '';
    defaultColor.value = Colors.white;
    timeleft.value = 30;
    health.value = 3;
    totalScore.value = 0;
    isNavigating.value = false;
    scorePerMatch.value= 0;
    isNewQuestion.value = true;

    Future.delayed(Duration(milliseconds: 300), () {
      isNewQuestion.value = false;
    });
  }

  void showDiologEnd(BuildContext context) {
    final UserController userController = Get.find();

    totalScore.value += scorePerMatch.value; // ✅ Accumulate score correctly

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColor.introBk2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return SizedBox(
              height: height * 0.2,
              width: width - 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'You still have a chance to continue',
                      style: AppFonts.subTitleFont,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.05,
                    child: ButtonSubmitWidget(
                      onPressed: () {
                        startTime();
                        resetQuestion();
                        Get.back();
                      },
                      text: 'Continue',
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.05,
                    child: ButtonSubmitWidget(
                      onPressed: () async {
                        await userController.addScoretoDB(totalScore.value);
                        Get.offAll(ResultPage());
                      
                      },
                      text: 'Finish',
                      color: AppColor.introBk,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
