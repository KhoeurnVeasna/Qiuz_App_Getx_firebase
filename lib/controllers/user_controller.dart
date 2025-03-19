import 'dart:developer';
import 'package:get/get.dart';
import '../model/user.dart';
import '../services/firebase_auth/firebase_authentication.dart';

class UserController extends GetxController {
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  UserModel? get currentUser => _currentUser.value;
  final _users = <UserModel>[].obs;
  final FirebaseAuthentication _firebaseAuthentication =
      FirebaseAuthentication();
  List<UserModel> get users => _users;
  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    try {
      final userData = await _firebaseAuthentication.getCurrentUser();
      if (userData != null) {
        _currentUser.value = UserModel.fromMap(userData);
      } else {
        log('No user found in Firestore.');
      }
    } catch (e) {
      log('Error fetching current user: $e');
    }
  }

  Future<void> addScoretoDB(int score) async {
    try {
      final bool success = await _firebaseAuthentication.addScore(score);
      if (success) {
        log('Score added successfully.');
      } else {
        log('Failed to add score.');
      }
    } catch (e) {
      log('Error adding score to DB: $e');
    }
  }

  Future<void> fetchAllUser() async {
    try {
      final allUsers = await _firebaseAuthentication.fetchAllUser();

      if (allUsers.isEmpty) {
        log('No users retrieved.');
      } else {
        log('Retrieved ${allUsers.length} users.');
      }
      allUsers.sort((a, b) => b.score.compareTo(a.score));
      _users.assignAll(allUsers);
    } catch (e) {
      log(' Error fetching all users in Controller: $e');
    }
  }
}
