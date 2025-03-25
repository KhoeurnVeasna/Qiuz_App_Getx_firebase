import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    _userController.fetchAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.introBk2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Leaderboard', style: AppFonts.mainTitleBule),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() => Text(
                  'Points: ${_userController.totalScore }',
                  style: AppFonts.userText,
                )),
          ),
        ],
      ),
      body: Obx(() {
        if (_userController.users.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: _userController.users.length,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemBuilder: (context, index) {
            final user = _userController.users[index];
            final isCurrentUser =
                user.id == FirebaseAuth.instance.currentUser?.uid;

            return Card(
              color: isCurrentUser ? Colors.green : AppColor.introBk,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: ListTile(
                leading: Text(
                  '${index + 1}.',
                  style: AppFonts.userText,
                ),
                title: Text(
                  user.username,
                  style: AppFonts.userText,
                ),
                trailing: Text(
                  user.score.toString(),
                  style: AppFonts.subTitleFont,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
