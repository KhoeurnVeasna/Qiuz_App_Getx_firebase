import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_project/controllers/auth_state_controller.dart';
import 'package:quiz_project/screens/main_page.dart';

import 'login_page.dart';

class AuthState extends StatelessWidget {
  const AuthState({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthStateController authController = Get.find();
    return Obx(() {
      if (authController.user.value != null) {
        return const MainPage();
      } else {
        return LoginPage();
      }
    });
  }
}
