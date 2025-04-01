import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_project/changelanguage.dart';
import 'package:quiz_project/controllers/quiz_controller.dart';
import 'package:quiz_project/controllers/user_controller.dart';
import 'package:quiz_project/pages/takequestion_page.dart';
import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/utils/fonts.dart';
import '../model/quiz.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final QuizController _quizController = Get.find();
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.introBk,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: AppColor.introBk2,
          foregroundColor: AppColor.whiteBk,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            child: CircleAvatar(
              maxRadius: 25,
              child: Obx(
                () {
                  String username = _userController.username.value;
                  return Text(
                    username.isNotEmpty
                        ? username.substring(0, 1).toUpperCase()
                        : '?',
                  );
                },
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  Get.to(Changelanguage());
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logos/englishflag.png'),
                  backgroundColor: AppColor.introBk2,
                  maxRadius: 25,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _userController.googleSignOut();
                Get.offAllNamed('/login');
              },
            ),

          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Let\'s Start\nHave Fun!',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.introTxt,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (_quizController.isLoading.value) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); 
                }
                if (_quizController.quizzes.isEmpty) {
                  return const Center(
                      child: Text(
                          "No quizzes Right now.")); 
                }
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: _quizController.quizzes.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final Quiz quiz = _quizController.quizzes[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(TakequestionPage(index: index));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        color: _getQuizCardColor(index),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl: quiz.imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error,
                                          size: 50, color: Colors.red),
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Color _getQuizCardColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFE7747);
      case 1:
        return const Color(0xFF182B88);
      case 2:
        return const Color(0xFF8F98FD);
      case 3:
        return const Color(0xFFDB2855);
      default:
        return Colors.white;
    }
  }
}
