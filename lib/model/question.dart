import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String id;
  String question;
  List options;

  int correctAnswer;
  final DateTime createdAt;
  Question(
      {required this.id,
      required this.question,
      required this.options,
      required this.correctAnswer,
      required this.createdAt});
  factory Question.formJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'].toString(),
    question: json['question'].toString(),
    options: List<String>.from(json['options']), 
    correctAnswer: json['correctAnswer'] as int,
    createdAt: (json['createdAt'] as Timestamp).toDate(),
  );
}
  factory Question.empty(){
    return Question(id: '', question: '', options: [],correctAnswer: 0, createdAt: DateTime.now());
  }
}
