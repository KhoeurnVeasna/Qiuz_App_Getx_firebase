import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quiz_project/model/question.dart';
import 'package:uuid/uuid.dart';

class FirebaseQuestion {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addQuestionFirebase(String quizId, String questionText,
      List<dynamic> options, int correctAnswerIndex) async {
    if (questionText.isEmpty || options.any((opt) => opt.toString().isEmpty)) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }
    try {
      String questionId = Uuid().v4();
      await _firestore
          .collection('quizzes')
          .doc(quizId)
          .collection('questions')
          .doc(questionId)
          .set({
        "id": questionId,
        "question": questionText,
        "options": options,
        "correctAnswer": correctAnswerIndex,
        "createdAt": FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Question added successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to add question: $e");
    }
  }

Future<List<Question>> fetchQuestionsOnce(String quizId) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('quizzes') 
        .doc(quizId) 
        .collection('questions') 
        .get();

    log("Total questions fetched: ${querySnapshot.docs.length}");

    return querySnapshot.docs
        .map((doc) => Question.formJson(doc.data()))
        .toList();
  } catch (e) {
    log("Error fetching questions: $e");
    return [];
  }
}

}
