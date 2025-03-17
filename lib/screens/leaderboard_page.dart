import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_project/controllers/question_controller.dart';
import 'package:quiz_project/utils/fonts.dart';

import '../controllers/user_controller.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final UserController _userController = Get.find();
  final QuestionController _questionController = Get.find();

  @override
  void initState() {
    _userController.fetchAllUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Leaderboard',
                        style: AppFonts.mainTitleBule,
                      ),
                      
                      Text('Ponts ${_questionController.totalScore.value}'),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: _userController.users.length,
                  itemBuilder: (BuildContext ctx ,  index){
                    return ListTile(
                      title: Text(_userController.users[index].username),
                    );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
