import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:quiz_project/model/quiz.dart';
import 'package:uuid/uuid.dart';

class FirebaseQuiz {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addQuiz(String title, bool isActive,String imageUrl) async {
    try {
      String id = Uuid().v4();
      await _firestore.collection("quizzes").doc(id).set({
        'id': id,
        'title': title,
        'isActive': isActive,
        'createdAt': FieldValue.serverTimestamp(),
        'imageUrl':imageUrl
      });
    } catch (e) {
      log("error add quiz: $e");
    }
  }

  Stream<List<Quiz>> fetchQuizzes() {
    return _firestore.collection('quizzes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Quiz.fromJson(doc.data())).toList();
    });
  }
  Future deleteQuizzes(String id) async {
    try {
      await _firestore.collection('quizzes').doc(id).delete();
    } catch (e) {
      log('Error to delete from database $e');
    }
  }

  
}
