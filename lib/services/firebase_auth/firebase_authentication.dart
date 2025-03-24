// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_project/controllers/quiz_controller.dart';

import '../../model/user.dart';
import '../../widgets/widget.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.put(QuizController());
      return true;
    } on FirebaseAuthException catch (e) {
      log('Login failed: ${e.message}');
      return false;
    } catch (e) {
      log('Unexpected error: $e');
      return false;
    }
  }

  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  Future<bool> sigin(String email, String password, String username) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await saveUser(username, email);
      return true;
    } on FirebaseAuthException catch (e) {
      log('error sign ${e.message}');
      return false;
    } catch (e) {
      log('error sign $e');
      return false;
    }
  }

  Future<bool> changeUserName(String newUserName) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        log('Error: No user is logged in');
        return false;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'username': newUserName,
      });

      log('Username successfully updated to: $newUserName');
      return true;
    } catch (e) {
      log('Error changing username: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('somthing make logout wrong $e');
    }
  }

  Future<void> saveUser(String username, String email) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'uid': user.uid,
        });
      } else {
        log('User not authenticated');
      }
    } catch (e) {
      log('error save user $e');
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return userDoc.data() as Map<String, dynamic>?;
        }
      }
    } catch (e) {
      log('Error fetching current user: $e');
    }
    return null;
  }

  Future<List<UserModel>> fetchAllUser() async {
    try {
      final allUser = await _firestore.collection('users').get();

      if (allUser.docs.isEmpty) {
        log(' No users found in Firestore.');
        return [];
      }
      return allUser.docs
          .map((user) => UserModel.fromMap(user.data()))
          .toList();
    } catch (e) {
      log(' Error fetching all users: $e');
      return [];
    }
  }

  Future<int?> addScore(int score) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        debugPrint('No authenticated user');
        return null;
      }

      final userDocRef = _firestore.collection('users').doc(user.uid);
      int? newScore;

      await _firestore.runTransaction((transaction) async {
        final userDoc = await transaction.get(userDocRef);

        if (userDoc.exists) {
          final currentScore = userDoc.data()?['score'] ?? 0;
          newScore = currentScore + score;
          transaction.update(userDocRef, {'score': newScore});
        } else {
          newScore = score;
          transaction.set(userDocRef, {'score': newScore});
        }
      });

      return newScore; // ✅ Return updated score
    } catch (e) {
      debugPrint('Error updating score: $e');
      return null;
    }
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      );
      await _auth.sendPasswordResetEmail(email: email);

      showSnackbar(context, 'Email already sent', Colors.green);
    } catch (e) {
      log('error forgot password $e');
      showSnackbar(context, 'something wrong ', Colors.red);
    } finally {
      Navigator.pop(context);
    }
  }
}
