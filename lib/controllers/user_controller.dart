import 'dart:developer';
import 'package:get/get.dart';
import 'package:quiz_project/pages/login_page.dart';
import 'package:quiz_project/pages/main_page.dart';
import '../model/user.dart';
import '../services/firebase_auth/firebase_authentication.dart';
import '../services/firebase_auth/google_login_service.dart';

class UserController extends GetxController {
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  UserModel? get currentUser => _currentUser.value;
  final _users = <UserModel>[].obs;
  final FirebaseAuthentication _firebaseAuthentication =
      FirebaseAuthentication();
  final GoogleLoginService _googleLoginService = GoogleLoginService();
  List<UserModel> get users => _users;
  final isLoading = false.obs;
  final isRegiser = false.obs;
  final username = ''.obs;
  final totalScore = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
    fetchAllUser();
  }

  void changeUsername(String newUsername) async {
    try {
      await _firebaseAuthentication.changeUserName(newUsername);
      username.value = newUsername;
    } catch (e) {
      log('error to change userName controller $e');
    }
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      bool seccuess = await _firebaseAuthentication.login(email, password);
      if (seccuess) {
        fetchCurrentUser();
        fetchAllUser();
        Get.offAll(MainPage());
        return true;
      } else {
        log('Login Filed');
        return false;
      }
    } catch (e) {
      log('error to login userController ');
      return false;
    }
  }

  Future<bool> sigin(String email, String password, String username) async {
    isRegiser.value = false;
    try {
      bool seccuess =
          await _firebaseAuthentication.sigin(email, password, username);
      if (seccuess) {
        await fetchAllUser();
        await fetchCurrentUser();
        Get.offAll(MainPage());
        return true;
      } else {
        log('error to sigin');
        return false;
      }
    } catch (e) {
      log('eorr to sigin $e');
      return false;
    }
  }

  void logout() async {
    isLoading.value = false;
    isRegiser.value = false;
    try {
      await _firebaseAuthentication.logout();
      _currentUser.value = null;
      username.value = '';
      totalScore.value = 0;
      _users.clear();
      Get.offAll(LoginPage());
    } catch (e) {
      log('error to Logout');
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      final userData = await _firebaseAuthentication.getCurrentUserByID();

      if (userData != null) {
        _currentUser.value = UserModel.fromMap(userData);
        username.value = _currentUser.value?.username ?? '';
        totalScore.value = _currentUser.value?.score ?? 0;
        log(' User data loaded successfully.');
      } else {
        log(' No user data found in Firestore.');
      }
    } catch (e) {
      log(' Error fetching current user: $e');
    }
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

  Future<void> googleSignIn() async {
    try {
      final user = await _googleLoginService.signInWithGoogle();
      if (user != null) {
        final userData = await _firebaseAuthentication.getCurrentUserByID();
        if (userData != null) {
          _currentUser.value = UserModel.fromMap(userData);
          username.value = _currentUser.value?.username ?? '';
          totalScore.value = _currentUser.value?.score ?? 0;
          Get.offAll(MainPage());
        } else {
          log('No user data found in Firestore.');
        }
      } else {
        log('Google sign-in failed.');
      }
    } catch (e) {
      log('Error during Google sign-in: $e');
    }
  }

  Future<void> googleSignOut() async {
    try {
      await _googleLoginService.signOut();
      _currentUser.value = null;
      Get.offAll(LoginPage());
    } catch (e) {
      log('Error signing out: $e');
    }
  }
}
