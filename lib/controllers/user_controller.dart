import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  final username = ''.obs;
  final totalScore = 0.obs;

  void changeUsername(String newUsername) async {
    try {
      await _firebaseAuthentication.changeUserName(newUsername);
      username.value = newUsername;
    } catch (e) {
      log('error to change userName controller $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
    fetchAllUser();
  }

  void fetchCurrentUser() {
    final String? userId = _firebaseAuthentication.getCurrentUserId();

    if (userId == null) {
      log('No authenticated user found.');
      return;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          _currentUser.value = UserModel.fromMap(snapshot.data()!);
          username.value = _currentUser.value?.username ?? '';
          totalScore.value = _currentUser.value?.score ?? 0;
          log('User data updated from Firestore.');
        } else {
          log('User document does not exist.');
        }
      },
      onError: (e) {
        log('Error fetching user in real-time: $e');
      },
    );
  }

  Future<void> addScoretoDB(int score) async {
    try {
      final int? newScore = await _firebaseAuthentication.addScore(score);
      if (newScore != null) {
        log('Score updated successfully: $newScore');
        totalScore.value = newScore; 
      } else {
        log('Failed to add score.');
      }
    } catch (e) {
      log('Error adding score to DB: $e');
    }
  }

  void updateUserScore(int newScore) {
    if (_currentUser.value != null) {
      _currentUser.update((user) {
        user?.score = newScore;
      });
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
