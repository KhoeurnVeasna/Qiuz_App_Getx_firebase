

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthStateController extends GetxController {
  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }
}