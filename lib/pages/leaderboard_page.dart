import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_project/controllers/question_controller.dart';
import 'package:quiz_project/theme/colors.dart';
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
    return Scaffold(
      backgroundColor: AppColor.introBk2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Leaderboard',
          style: AppFonts.mainTitleBule,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(
            'Ponts ${_userController.currentUser?.score}',
            style: AppFonts.userText,
          )),
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _userController.users.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Card(
                    
                        color: _userController.users[index].id == FirebaseAuth.instance.currentUser?.uid ? Colors.green: AppColor.introBk,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            _userController.users[index].username,
                            style: AppFonts.userText,
                          ),
                          trailing: Text(
                            _userController.users[index].score.toString(),
                            style: AppFonts.subTitleFont,
                          ),
                          leading: Text(
                            '${(index + 1).toString()}.',
                            style: AppFonts.userText,
                          ),
                        ));
                  }),
            ],
          ),
        );
      }),
    );
  }
}
