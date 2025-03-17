
import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String id;
  String title;
  String imageUrl;
  bool isActive;
  final DateTime createdAt;
  Quiz(
      {required this.id,
      required this.title,
      required this.isActive,
      required this.imageUrl,
      required this.createdAt});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'].toString(),
      title: json['title'].toString(),
      isActive: json['isActive'] as bool,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
       imageUrl: json['imageUrl'].toString(),
    );
  }
  factory Quiz.empty(){
    return Quiz(id: '', title: '', imageUrl: '' ,isActive: false, createdAt: DateTime.now());
  }
}
