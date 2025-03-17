import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_project/controllers/quiz_controller.dart';
import 'package:quiz_project/model/quiz.dart';

import 'package:quiz_project/services/firebase_quiz.dart';
import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/utils/fonts.dart';
import 'package:quiz_project/widgets/button_submit_widget.dart';
import 'package:quiz_project/widgets/text_field_widget.dart';

import 'add_question_screen.dart';

class AddQuizPage extends StatefulWidget {
  const AddQuizPage({super.key});

  @override
  State<AddQuizPage> createState() => _AddQuizPageState();
}

class _AddQuizPageState extends State<AddQuizPage> {
  final _txtTile = TextEditingController();
  final _imageUrl = TextEditingController();
  bool isActive = false;
  final QuizController _quizController = Get.find();
  void toggleActive(bool value) {
    setState(() {
      isActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.introBk,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 600,
                    child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: _quizController.quizzes.length,
                        itemBuilder: (context, index) {
                          final Quiz quiz = _quizController.quizzes[index];
                          return Card(
                            color: AppColor.introBk2,
                            child: ListTile(
                              onTap: () {
                                Get.to(AddQuestionScreen(
                                  index: index,
                                ));
                              },
                              title: Text(
                                quiz.title,
                                style: AppFonts.subTitleFont,
                              ),
                              leading: Image.network(quiz.imageUrl),
                              trailing: IconButton(
                                  onPressed: () {
                                    _quizController.delectMainQuestion(quiz.id);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          );
                        }),
                  ),
                ),
                TextFieldWidget(label: 'Enter Tile ', controller: _txtTile),
                TextFieldWidget(label: 'Add ImageUrl ', controller: _imageUrl),
                Checkbox(
                    value: isActive,
                    fillColor: WidgetStateProperty.all(AppColor.introBk2),
                    onChanged: (value) {
                      toggleActive(value!);
                    }),
                SizedBox(
                    width: double.infinity,
                    child: ButtonSubmitWidget(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });

                        await FirebaseQuiz().addQuiz(_txtTile.text.trim(),
                            isActive, _imageUrl.text.trim());
                        
                        _txtTile.clear();
                        _imageUrl.clear();
                      },
                      text: 'Add Quiz',
                      color: AppColor.introBk2,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
