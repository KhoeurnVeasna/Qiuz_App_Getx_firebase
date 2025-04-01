import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleLoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        log('Google sign-in canceled');
        return null;  
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {

        await _saveUserToFirestore(user);
        return user;  
      } else {
        log('Error: User is null after sign-in');
        return null;
      }
    } catch (e) {
      log('Google Sign-In Error: $e');
      Get.snackbar("Error", "Google Sign-In failed: $e");
      return null;
    }
  }


  Future<void> _saveUserToFirestore(User user) async {
    final userRef = _firestore.collection('users').doc(user.uid);

    try {
      // Check if the user already exists in Firestore
      final userDoc = await userRef.get();
      if (!userDoc.exists) {
        
        await userRef.set({
          'uid': user.uid,
          'email': user.email,
          'username': user.displayName ?? "Unknown",
          'photoUrl': user.photoURL ?? "",
          'score': 0,  
          'createdAt': FieldValue.serverTimestamp(),
        });
        log('✅ User saved to Firestore: ${user.uid}');
      } else {
        log('🔹 User already exists in Firestore: ${user.uid}');
      }
    } catch (e) {
      log('Error saving user to Firestore: $e');
      Get.snackbar("Error", "Failed to save user to Firestore: $e");
    }
  }

  // 🔹 Sign out the user from Google and Firebase
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      log('User signed out from Google and Firebase');
    } catch (e) {
      log('Error signing out: $e');
      Get.snackbar("Error", "Sign-out failed: $e");
    }
  }
}
