import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz_project/controllers/quiz_controller.dart';
import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/utils/fonts.dart';
import 'package:quiz_project/widgets/button_submit_widget.dart';
import 'package:quiz_project/widgets/text_field_widget.dart';

import '../../controllers/question_controller.dart';
import '../../model/quiz.dart';


class AddQuestionScreen extends StatelessWidget {
  AddQuestionScreen({super.key, required this.index});
  final QuizController _quizController = Get.find();
  final QuestionController _addQuestionController =  Get.find();

  final int index;
  final _mainQuizController = TextEditingController();
  final _questionOne = TextEditingController();
  final _questionTwo = TextEditingController();
  final _questionTree = TextEditingController();
  final _questionFour = TextEditingController();
  final _currentAns = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Quiz quiz = _quizController.quizzes[index];

    return Scaffold(
      backgroundColor: AppColor.introBk,
      appBar: AppBar(
        backgroundColor: AppColor.introBk2,
        foregroundColor: AppColor.blueColor,
        title: Text(
          quiz.title,
          style: AppFonts.subTitleFont,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFieldWidget(
              controller: _mainQuizController,
              label: 'What is the Question?',
            ),
            TextFieldWidget(controller: _questionOne, label: "Question One"),
            TextFieldWidget(controller: _questionTwo, label: "Question Two"),
            TextFieldWidget(controller: _questionTree, label: "Question Three"),
            TextFieldWidget(controller: _questionFour, label: "Question Four"),
            TextFieldWidget(controller: _currentAns, label: "Answer",),
            const SizedBox(height: 16),
            Obx(() => _addQuestionController.isLoading.value
                ? CircularProgressIndicator()
                : ButtonSubmitWidget(
                    onPressed: () {
                      _addQuestionController.addQuestion(
                        quiz.id, 
                        _mainQuizController.text,
                        [
                          _questionOne.text,

                          _questionTwo.text,
                          _questionTree.text,
                          _questionFour.text
                        ],
                        int.parse(_currentAns.text.trim()),
                      );

                      _mainQuizController.clear();
                      _questionOne.clear();
                      _questionTwo.clear();
                      _questionTree.clear();
                      _questionFour.clear();
                      _currentAns.clear();
                    },
                    text: 'Add Question',
                    color: AppColor.introBk2,
                  )),
          ],
        ),
      ),
    );
  }
}
